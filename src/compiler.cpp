#include "compiler.hpp"
#include "engine.hpp"
#include "llvm/ADT/APInt.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/BinaryFormat/Dwarf.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Utils.h"
#include <atomic>
#include <cstdarg>
#include <cstdio>
#include <cstring>
#include <llvm/IRReader/IRReader.h>
#include <map>
#include <string>
#include <unwind.h>
#include <vector>
#include "jit.h"

int CompilerVerbosity = 0;

#ifdef __APPLE__
typedef uint64_t _Unwind_Exception_Class;
#endif

namespace minou {

enum {
    EXCEPTION_NOT_THROWN_STATE = 0,
    EXCEPTION_THROWN_STATE,
    EXCEPTION_CAUGHT_STATE
};

template <typename T> T read_type(const uint8_t *&p) {
    T a;
    memcpy(&a, p, sizeof(T));
    p += sizeof(T);
    return a;
}

struct ExceptionType {
    int type = 0;
    Atom what;
};

struct BaseException {
    ExceptionType type = {0};
    _Unwind_Exception unwind_exception = {0};
};

static const unsigned char our_base_excp_class_chars[] = {'m', 'i', 'n', '\0',
                                                          'o', 'u', '!', '\0'};

static constexpr uint64_t gen_class(const unsigned char chars[], size_t size) {
    uint64_t ret = chars[0];

    for (unsigned i = 1; i < size; ++i) {
        ret <<= 8;
        ret += chars[i];
    }

    return ret;
}

static const auto base_exception_class = gen_class(our_base_excp_class_chars, sizeof(our_base_excp_class_chars));

struct ExceptionConfig {
    llvm::StructType *type_info_type;
    llvm::StructType *caught_result_type;
    llvm::StructType *exception_type;
    llvm::StructType *unwind_exception_type;
};

#define API __attribute__((visibility("default")))
extern "C" {
API int64_t env_set(Env *env, Atom sym, Atom value) {
    env->set(sym.symbol(), value);
    return sym.value;
}

API int64_t env_get(Env *env, Atom sym) {
    auto x = env->lookup(sym.symbol());
    if (x.has_value()) {
        return x.value().value;
    }
    return make_nil().value;
}

API void delete_exception(void *e) {
    if (!e) {
        return;
    }
    auto x = (BaseException *)((uintptr_t)e -
                               offsetof(BaseException, unwind_exception));

    delete x;
}

API void delete_exception_from_unwind(_Unwind_Reason_Code reason,
                                      _Unwind_Exception *e) {
    delete_exception(e);
}

API _Unwind_Exception *create_exception(void) {
    auto e = new BaseException;
    memset(e, 0, sizeof(BaseException));

    e->type.type = 0;
    e->unwind_exception.exception_class = base_exception_class;
    e->unwind_exception.exception_cleanup = delete_exception_from_unwind;

    return &e->unwind_exception;
}

API int64_t make_list(Engine *e, int64_t count, ...) {
    // TODO: if we compile this in reverse order we can avoid
    // the temporary list
    va_list args;
    va_start(args, count);

    std::vector<Atom> list;

    for (int i = 0; i < count; ++i) {
        Atom a = va_arg(args, Atom);
        list.push_back(a);
    }
    va_end(args);

    return make_cons(e->get_memory().make_list(list)).value;
}

API int64_t equalsp_ex(int count, ...) {
    va_list args;
    va_start(args, count);

    if (count <= 0) {
        return make_boolean(false).value;
    }

    auto a = va_arg(args, Atom);

    for (int i = 1; i < count; ++i) {
        auto b = va_arg(args, Atom);
        if (!equalsp(a, b)) {
            return make_boolean(false).value;
        }
    }
    return make_boolean(true).value;
}

API int64_t display(Atom a) {
    fmt::print("{}", a);
    return make_nil().value;
}

API int64_t builtin_cons(Engine *e, Atom value, Atom list) {
    return make_cons(e->get_memory().alloc_cons(value, list.cons())).value;
}

API int64_t builtin_append(int count, ...) {
    va_list args;
    va_start(args, count);

    assert(count > 1);

    Cons *initial = va_arg(args, Cons *);
    Cons *tail = initial->tail();
    for (int i = 1; i < count; ++i) {
        auto a = va_arg(args, Atom);
        tail->cdr = a.cons();
        if (a.is_nil())
            break;
        tail = a.cons()->tail();
    }

    return (int64_t)initial;
}

// Shamelessy ripped from the llvm exception demo
static uintptr_t read_uleb128(const uint8_t **data) {
    uintptr_t result = 0;
    uintptr_t shift = 0;
    unsigned char byte;
    const uint8_t *p = *data;

    do {
        byte = *p++;
        result |= (byte & 0x7f) << shift;
        shift += 7;
    } while (byte & 0x80);

    *data = p;

    return result;
}

static uintptr_t readSLEB128(const uint8_t **data) {
    uintptr_t result = 0;
    uintptr_t shift = 0;
    unsigned char byte;
    const uint8_t *p = *data;

    do {
        byte = *p++;
        result |= (byte & 0x7f) << shift;
        shift += 7;
    } while (byte & 0x80);

    *data = p;

    if ((byte & 0x40) && (shift < (sizeof(result) << 3))) {
        result |= (~0 << shift);
    }

    return result;
}

static unsigned getEncodingSize(uint8_t Encoding) {
    if (Encoding == llvm::dwarf::DW_EH_PE_omit)
        return 0;

    switch (Encoding & 0x0F) {
    case llvm::dwarf::DW_EH_PE_absptr:
        return sizeof(uintptr_t);
    case llvm::dwarf::DW_EH_PE_udata2:
        return sizeof(uint16_t);
    case llvm::dwarf::DW_EH_PE_udata4:
        return sizeof(uint32_t);
    case llvm::dwarf::DW_EH_PE_udata8:
        return sizeof(uint64_t);
    case llvm::dwarf::DW_EH_PE_sdata2:
        return sizeof(int16_t);
    case llvm::dwarf::DW_EH_PE_sdata4:
        return sizeof(int32_t);
    case llvm::dwarf::DW_EH_PE_sdata8:
        return sizeof(int64_t);
    default:
        // not supported
        abort();
    }
}

static uintptr_t read_encoded_pointer(const uint8_t **data, uint8_t encoding);
static bool handleActionValue(int64_t *resultAction, uint8_t TTypeEncoding,
                              const uint8_t *ClassInfo, uintptr_t actionEntry,
                              uint64_t exceptionClass,
                              struct _Unwind_Exception *exceptionObject) {
    bool ret = false;

    if (!resultAction || !exceptionObject ||
        (exceptionClass != base_exception_class))
        return (ret);

    struct BaseException *excp =
        (struct BaseException *)(((char *)exceptionObject) +
                                 offsetof(BaseException, unwind_exception));
    struct ExceptionType *excpType = &(excp->type);
    int type = excpType->type;

#ifdef DEBUG
    fprintf(stderr,
            "handleActionValue(...): exceptionObject = <%p>, "
            "excp = <%p>.\n",
            (void *)exceptionObject, (void *)excp);
#endif

    const uint8_t *actionPos = (uint8_t *)actionEntry, *tempActionPos;
    int64_t typeOffset = 0, actionOffset;

    for (int i = 0; true; ++i) {
        // Each emitted dwarf action corresponds to a 2 tuple of
        // type info address offset, and action offset to the next
        // emitted action.
        typeOffset = readSLEB128(&actionPos);
        tempActionPos = actionPos;
        actionOffset = readSLEB128(&tempActionPos);

#ifdef DEBUG
        fprintf(stderr,
                "handleActionValue(...):typeOffset: <%" PRIi64 ">, "
                "actionOffset: <%" PRIi64 ">.\n",
                typeOffset, actionOffset);
#endif
        assert((typeOffset >= 0) &&
               "handleActionValue(...):filters are not supported.");

        // Note: A typeOffset == 0 implies that a cleanup llvm.eh.selector
        //       argument has been matched.
        if (typeOffset > 0) {
#ifdef DEBUG
            fprintf(stderr, "handleActionValue(...):actionValue <%d> found.\n",
                    i);
#endif
            unsigned EncSize = getEncodingSize(TTypeEncoding);
            const uint8_t *EntryP = ClassInfo - typeOffset * EncSize;
            uintptr_t P = read_encoded_pointer(&EntryP, TTypeEncoding);
            struct ExceptionType *ThisClassInfo =
                reinterpret_cast<struct ExceptionType *>(P);
            if (ThisClassInfo->type == type) {
                *resultAction = i + 1;
                ret = true;
                break;
            }
        }

#ifdef DEBUG
        fprintf(stderr, "handleActionValue(...):actionValue not found.\n");
#endif
        if (!actionOffset)
            break;

        actionPos += actionOffset;
    }

    return (ret);
}

static uintptr_t read_encoded_pointer(const uint8_t **data, uint8_t encoding) {
    assert(data);
    if (encoding == llvm::dwarf::DW_EH_PE_omit) {
        return 0;
    }
    uintptr_t result{0};
    const uint8_t *p = *data;

    switch (encoding & 0xf) {
    case llvm::dwarf::DW_EH_PE_absptr:
        result = read_type<uintptr_t>(p);
        break;
    case llvm::dwarf::DW_EH_PE_uleb128:
        result = read_uleb128(&p);
        break;
    default:
        abort();
    }

    switch (encoding & 0x70) {
    case llvm::dwarf::DW_EH_PE_absptr:
        break;
    case llvm::dwarf::DW_EH_PE_pcrel:
        result += (uintptr_t)(*data);
        break;
    default:
        abort();
    }
    if (encoding & llvm::dwarf::DW_EH_PE_indirect) {
        result = *((uintptr_t *)result);
    }

    *data = p;

    return result;
}

API _Unwind_Reason_Code
my_personality(int version, _Unwind_Action actions,
               _Unwind_Exception_Class exception_class,
               struct _Unwind_Exception *exception_object,
               struct _Unwind_Context *context) {

    auto lsda = reinterpret_cast<const uint8_t *>(
        _Unwind_GetLanguageSpecificData(context));

    auto ret = _URC_CONTINUE_UNWIND;

    if (!lsda) {
        return ret;
    }

    auto pc = _Unwind_GetIP(context) - 1;

    auto func_start = _Unwind_GetRegionStart(context);
    auto pc_offset = pc - func_start;

    const uint8_t *class_info = nullptr;

    auto lp_start_encoding = *lsda++;

    if (lp_start_encoding != llvm::dwarf::DW_EH_PE_omit) {
        read_encoded_pointer(&lsda, lp_start_encoding);
    }

    auto ttype_encoding = *lsda++;
    uintptr_t class_info_offset;
    if (ttype_encoding != llvm::dwarf::DW_EH_PE_omit) {
        class_info_offset = read_uleb128(&lsda);
        class_info = lsda + class_info_offset;
    }

    auto call_site_encoding = *lsda++;
    auto call_site_table_length = read_uleb128(&lsda);
    const auto *call_site_table_start = lsda;
    const auto *call_site_table_end =
        call_site_table_start + call_site_table_length;
    const auto *action_table_start = call_site_table_end;
    const auto *call_site_ptr = call_site_table_start;

    while (call_site_ptr < call_site_table_end) {
        auto start = read_encoded_pointer(&call_site_ptr, call_site_encoding);
        auto length = read_encoded_pointer(&call_site_ptr, call_site_encoding);
        auto landingpad =
            read_encoded_pointer(&call_site_ptr, call_site_encoding);

        auto actionEntry = read_uleb128(&call_site_ptr);

        if (exception_class != base_exception_class) {
            actionEntry = 0;
        }

        if (landingpad == 0) {
            continue;
        }

        if (actionEntry) {
            actionEntry += ((uintptr_t)action_table_start) - 1;
        }

        auto exception_matched = false;

        if ((start <= pc_offset) && (pc_offset < (start + length))) {

            int64_t action_value = 0;
            if (actionEntry) {
                // handle_action_value
                exception_matched = handleActionValue(
                    &action_value, ttype_encoding, class_info, actionEntry,
                    exception_class, exception_object);
            }

            if (!(actions & _UA_SEARCH_PHASE)) {
                _Unwind_SetGR(context, __builtin_eh_return_data_regno(0),
                              (uintptr_t)exception_object);
                if (!actionEntry || !exception_matched) {
                    assert(false);
                    _Unwind_SetGR(context, __builtin_eh_return_data_regno(1),
                                  0);
                } else {
                    _Unwind_SetGR(context, __builtin_eh_return_data_regno(1),
                                  action_value);
                }

                _Unwind_SetIP(context, func_start + landingpad);
                ret = _URC_INSTALL_CONTEXT;
            } else if (exception_matched) {
                ret = _URC_HANDLER_FOUND;
            }
            break;
        }
    }

    return ret;
}
}


static std::string lambda_unique_name() {
    static std::atomic<int> lambda_counter = 0;

    auto n = lambda_counter.fetch_add(1);

    return fmt::format("lambda_{}", n);
}
static std::string expression_unique_name() {
    static std::atomic<int> lambda_counter = 0;

    auto n = lambda_counter.fetch_add(1);

    return fmt::format("expression_{}", n);
}

class CompilerContext {
  public:
    CompilerContext(llvm::LLVMContext &ctx, llvm::IRBuilder<> &builder,
                    llvm::Module *module, Engine *engine, Env *env,
                    NativeEngine *ne, ExceptionConfig expConfig)
        : builder(builder), context(ctx), module(module), engine(engine),
          env(env), native_engine(ne), expConfig(expConfig) {}

    llvm::Function *getFunction(const std::string &name) {
        return module->getFunction(name);
    }

    Result<llvm::Value *> compile_if(Atom a, llvm::BasicBlock *normalBlock,
                                     llvm::BasicBlock *exceptionBlock) {
        auto pred = compile(a.cons()->cdr->car, normalBlock, exceptionBlock);
        if (is_error(pred)) {
            return pred;
        }
        auto is_boolean = builder.CreateICmpNE(
            get_value(pred), constant_atom(make_boolean(false)), "ifcond");

        auto theFunc = builder.GetInsertBlock()->getParent();
        auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

        auto elseBB = llvm::BasicBlock::Create(context, "else");
        auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");
        builder.CreateCondBr(is_boolean, thenBB, elseBB);

        builder.SetInsertPoint(thenBB);

        auto then =
            compile(a.cons()->cdr->cdr->car, normalBlock, exceptionBlock);
        if (is_error(then)) {
            return then;
        }

        builder.CreateBr(mergeBB);

        thenBB = builder.GetInsertBlock();

        theFunc->getBasicBlockList().push_back(elseBB);
        builder.SetInsertPoint(elseBB);

        auto elseV =
            compile(a.cons()->cdr->cdr->cdr->car, normalBlock, exceptionBlock);
        if (is_error(elseV)) {
            return elseV;
        }

        builder.CreateBr(mergeBB);
        elseBB = builder.GetInsertBlock();

        theFunc->getBasicBlockList().push_back(mergeBB);
        builder.SetInsertPoint(mergeBB);

        auto pn = builder.CreatePHI(atom_type(), 2, "iftmp");

        pn->addIncoming(get_value(then), thenBB);
        pn->addIncoming(get_value(elseV), elseBB);

        return pn;
    }

    Result<llvm::Value *> raise(Atom a, llvm::BasicBlock *normal,
                                llvm::BasicBlock *e) {
        auto v = compile(a, normal, e);
        if (is_error(v)) {
            return v;
        }

        auto cx = getFunction("create_exception");
        auto raise = getFunction("_Unwind_RaiseException");

        auto ex = builder.CreateCall(cx);
        auto r = builder.CreateCall(raise, ex);
        r->setDoesNotReturn();
        return builder.CreateUnreachable();
    }

    Result<llvm::Value *> compile(Atom a, llvm::BasicBlock *normalBlock,
                                  llvm::BasicBlock *exceptionBlock) {
        switch (a.get_type()) {
        case AtomType::Cons:
            if (!a.cons()) {
                return ("invalid list application\n");
            }
            if (a.cons()->car.get_type() == AtomType::Symbol) {
                auto sym = a.cons()->car.symbol();

                if (sym == "if") {
                    return compile_if(a, normalBlock, exceptionBlock);
                } else if (sym == "throw") {
                    auto v = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);

                    if (is_error(v))
                        return v;

                    auto cx = getFunction(
                        "create_exception"); // auto f =
                                             // getFunction("__cxa_allocate_exception");
                    auto raise = getFunction("_Unwind_RaiseException");

                    auto ex = builder.CreateCall(cx);
                    auto r = builder.CreateCall(raise, ex);
                    r->setDoesNotReturn();
                    return builder.CreateUnreachable();
                } else if (sym == "try") {
                    auto entryBlock = builder.GetInsertBlock();
                    auto normalBlock = llvm::BasicBlock::Create(
                        context, "normal", entryBlock->getParent());
                    auto exceptionBlock = llvm::BasicBlock::Create(
                        context, "exception", entryBlock->getParent());
                    auto exceptionRouteBlock = llvm::BasicBlock::Create(
                        context, "route", entryBlock->getParent());
                    auto resumeBlock = llvm::BasicBlock::Create(
                        context, "resume", entryBlock->getParent());

                    auto exceptionCaughtFlag = create_entry_block_alloca(
                        "exceptionCaught", builder.getInt8Ty(),
                        builder.getInt8(EXCEPTION_THROWN_STATE));

                    auto exceptionStorage = create_entry_block_alloca(
                        "exceptionStorage", builder.getInt8PtrTy(),
                        llvm::ConstantPointerNull::get(builder.getInt8PtrTy()));

                    auto caughtResultStorage = create_entry_block_alloca(
                        "caughtResultStorage", expConfig.caught_result_type,
                        llvm::ConstantAggregateZero::get(
                            expConfig.caught_result_type));

                    auto retStorage = create_entry_block_alloca(
                        "returnValue", builder.getInt64Ty());

                    auto finally = llvm::BasicBlock::Create(
                        context, "finally",
                        builder.GetInsertBlock()->getParent());

                    builder.SetInsertPoint(finally);
                    auto retValue = builder.CreateLoad(retStorage);

                    // auto sw =
                    // builder.CreateSwitch(builder.CreateLoad(exceptionCaughtFlag),
                    //                                endBlock, 2);

                    // sw->addCase(our_exception_caught_state, endBlock);
                    // sw->addCase(our_exception_thrown_state, resumeBlock);

                    auto catchBlock = llvm::BasicBlock::Create(
                        context, "catch",
                        builder.GetInsertBlock()->getParent());
                    // CATCH BLOCK
                    builder.SetInsertPoint(catchBlock);

                    auto tail = a.cons()->tail()->car.cons();

                    if (!(tail->car == symbol("catch"))) {
                        return "last expression should be a catch";
                    }

                    auto catch_body = tail->cdr->cdr;

                    Cons *body = engine->get_memory().alloc_cons(
                        make_symbol(Symbol::from("begin")), catch_body);

                    auto compiled_catch_body =
                        compile(make_cons(body), nullptr, nullptr);

                    builder.CreateStore(builder.getInt8(EXCEPTION_CAUGHT_STATE),
                                        exceptionCaughtFlag);
                    builder.CreateStore(get_value(compiled_catch_body),
                                        retStorage);
                    builder.CreateBr(finally);

                    // ENTRY BLOCK
                    builder.SetInsertPoint(entryBlock);

                    auto call = compile(a.cons()->cdr->car, normalBlock,
                                        exceptionBlock);
                    if (is_error(call)) {
                        return call;
                    }

                    auto callv = get_value(call);

                    builder.SetInsertPoint(normalBlock);
                    builder.CreateStore(callv, retStorage);
                    builder.CreateBr(finally);

                    builder.SetInsertPoint(resumeBlock);
                    builder.CreateResume(
                        builder.CreateLoad(caughtResultStorage));

                    builder.SetInsertPoint(exceptionBlock);
                    auto caughtResult = builder.CreateLandingPad(
                        expConfig.caught_result_type, 1, "landingpad");

                    caughtResult->setCleanup(true);
                    auto clause = module->getGlobalVariable("my_exception");

                    caughtResult->addClause(clause);

                    auto unwindException = builder.CreateExtractValue(
                        caughtResult, 0, "unwindException");
                    auto reTypeInfoIndex = builder.CreateExtractValue(
                        caughtResult, 1, "retTypeInfoIndex");

                    builder.CreateStore(caughtResult, caughtResultStorage);
                    builder.CreateStore(unwindException, exceptionStorage);
                    builder.CreateStore(builder.getInt8(EXCEPTION_THROWN_STATE),
                                        exceptionCaughtFlag);

                    auto unwindExceptionClass = builder.CreateLoad(
                        builder.CreateStructGEP(
                            expConfig.unwind_exception_type,
                            builder.CreatePointerCast(
                                unwindException,
                                expConfig.unwind_exception_type->getPointerTo()),
                            0),
                        "unwindExceptionClass");

                    builder.CreateBr(exceptionRouteBlock);

                    builder.SetInsertPoint(exceptionRouteBlock);

                    auto typeInfoThrown = builder.CreatePointerCast(
                        builder.CreateConstGEP1_64(
                            unwindException,
                            offsetof(BaseException, unwind_exception)),
                        expConfig.exception_type->getPointerTo());

                    typeInfoThrown = builder.CreateStructGEP(expConfig.exception_type,
                                                             typeInfoThrown, 0);

                    auto typeInfoThrownType =
                        builder.CreateStructGEP(typeInfoThrown, 0);

                    auto catchSwitch =
                        builder.CreateSwitch(reTypeInfoIndex, resumeBlock, 1);

                    catchSwitch->addCase(
                        llvm::ConstantInt::get(builder.getInt32Ty(), 1),
                        catchBlock);

                    builder.SetInsertPoint(finally);
                    auto del = getFunction("delete_exception");
                    builder.CreateCall(del,
                                       builder.CreateLoad(exceptionStorage));

                    return builder.CreateRet(retValue);
                } else if (sym == "car") {
                    auto f = getFunction("builtin_car");
                    auto r = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(r))
                        return r;
                    auto x = builder.CreateCall(f, get_value(r));
                    x->setCallingConv(llvm::CallingConv::Fast);
                    return x;
                } else if (sym == "cdr") {
                    auto f = getFunction("builtin_cdr");
                    auto r = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(r))
                        return r;
                    auto x = builder.CreateCall(f, get_value(r));
                    x->setCallingConv(llvm::CallingConv::Fast);
                    return x;
                } else if (sym == "not") {
                    auto f = getFunction("builtin_not");
                    auto r = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(r))
                        return r;

                    auto x = builder.CreateCall(f, get_value(r));
                    x->setCallingConv(llvm::CallingConv::Fast);
                    return x;
                } else if (sym == "pair?") {
                    auto f = getFunction("builtin_pair_p");
                    assert(f);

                    auto r = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(r))
                        return r;

                    auto x = builder.CreateCall(f, get_value(r));
                    x->setCallingConv(llvm::CallingConv::Fast);
                    return x;
                } else if (sym == "display") {
                    auto f = getFunction("display");
                    assert(f);
                    auto r = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(r)) {
                        return r;
                    }

                    auto x = builder.CreateCall(f, get_value(r));

                    return x;
                } else if (sym == "append") {
                    auto f = getFunction("builtin_append");

                    std::vector<llvm::Value *> args;

                    args.push_back(llvm::ConstantInt::get(
                        context, llvm::APInt(64, a.cons()->cdr->length())));
                    for (auto c : *a.cons()->cdr) {
                        auto a0 = compile(c->car, normalBlock, exceptionBlock);
                        if (is_error(a0))
                            return a0;
                        args.push_back(get_value(a0));
                    }
                    return builder.CreateCall(f, args);
                } else if (sym == "list") {
                    auto f = this->getFunction("make_list");

                    std::vector<llvm::Value *> args;
                    args.push_back(llvm::ConstantInt::get(
                        context, llvm::APInt(64, (uintptr_t)engine)));
                    args.push_back(llvm::ConstantInt::get(
                        context, llvm::APInt(64, a.cons()->cdr->length())));

                    for (auto c : *a.cons()->cdr) {
                        auto aa = compile(c->car, normalBlock, exceptionBlock);
                        if (is_error(aa))
                            return aa;
                        args.push_back(get_value(aa));
                    }
                    auto x = builder.CreateCall(f, args);

                    return x;
                } else if (sym == "cons") {
                    auto f = getFunction("builtin_cons");
                    std::vector<llvm::Value *> args;
                    args.push_back(llvm::ConstantInt::get(
                        context, llvm::APInt(64, (uintptr_t)engine)));

                    if (a.cons()->cdr->length() != 2) {
                        return "mismatched arity for cons";
                    }

                    auto a0 = compile(a.cons()->cdr->car, normalBlock,
                                      exceptionBlock);
                    if (is_error(a0))
                        return a0;
                    auto a1 = compile(a.cons()->cdr->cdr->car, normalBlock,
                                      exceptionBlock);
                    if (is_error(a1))
                        return a1;

                    args.push_back(get_value(a0));
                    args.push_back(get_value(a1));

                    return builder.CreateCall(f, args);
                } else if (sym == "equals") {
                    auto f = getFunction("equalsp_ex");
                    std::vector<llvm::Value *> args;

                    args.push_back(llvm::ConstantInt::get(
                        context, llvm::APInt(64, a.cons()->cdr->length())));

                    for (auto c : *a.cons()->cdr) {
                        auto aa = compile(c->car, normalBlock, exceptionBlock);
                        if (is_error(aa))
                            return aa;
                        args.push_back(get_value(aa));
                    }
                    return builder.CreateCall(f, args);
                } else if (sym == "macro") {
                    return compile_macro(a, normalBlock, exceptionBlock);
                } else if (sym == "define-macro") {
                    auto macro_func = engine->get_memory().alloc_cons(
                        symbol("macro"), a.cons()->cdr->cdr);
                    auto func = native_engine->execute(make_cons(macro_func));
                    if (is_error(func))
                        return get_error(func);

                    env->set(a.cons()->cdr->car.symbol(), get_value(func));

                    return constant_atom(a.cons()->cdr->car);
                } else if (sym == "=") {
                    auto x = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    auto y = compile(a.cons()->cdr->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(x)) {
                        return x;
                    }
                    if (is_error(y)) {
                        return y;
                    }

                    auto v =
                        builder.CreateICmpEQ(get_value(x), get_value(y), "=");

                    auto theFunc = builder.GetInsertBlock()->getParent();
                    auto thenBB =
                        llvm::BasicBlock::Create(context, "then", theFunc);

                    auto elseBB = llvm::BasicBlock::Create(context, "else");
                    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");

                    builder.CreateCondBr(v, thenBB, elseBB);

                    builder.SetInsertPoint(thenBB);

                    auto then = constant_atom(make_boolean(true));
                    builder.CreateBr(mergeBB);

                    thenBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(elseBB);
                    builder.SetInsertPoint(elseBB);

                    auto elseV = constant_atom(make_boolean(false));

                    builder.CreateBr(mergeBB);
                    elseBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(mergeBB);
                    builder.SetInsertPoint(mergeBB);

                    auto pn = builder.CreatePHI(atom_type(), 2, "iftmp");

                    pn->addIncoming(then, thenBB);
                    pn->addIncoming(elseV, elseBB);

                    return pn;
                } else if (sym == "+") {
                    auto x = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    auto y = compile(a.cons()->cdr->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(x))
                        return x;
                    if (is_error(y))
                        return y;

                    auto f = getFunction("atom_to_integer");

                    if (!f) {
                        return "can't find atom_to_integer";
                    }

                    auto xx = builder.CreateCall(f, get_value(x));
                    xx->setCallingConv(llvm::CallingConv::Fast);
                    auto yy = builder.CreateCall(f, get_value(y));
                    yy->setCallingConv(llvm::CallingConv::Fast);
                    auto v = builder.CreateAdd(xx, yy);
                    auto vv = builder.CreateShl(
                        v, llvm::ConstantInt::get(context, llvm::APInt(64, 3)));
                    auto vvv = builder.CreateOr(
                        vv, llvm::ConstantInt::get(context,
                                                   llvm::APInt(64, INTEGER)));

                    return vvv;
                } else if (sym == "-") {
                    if (a.cons()->cdr->length() == 1) {
                        auto x = compile(a.cons()->cdr->car, normalBlock,
                                         exceptionBlock);
                        if (is_error(x)) {
                            return x;
                        }

                        auto f = getFunction("atom_to_integer");

                        auto xx = builder.CreateCall(f, get_value(x));
                        xx->setCallingConv(llvm::CallingConv::Fast);
                        auto v = builder.CreateNeg(xx);
                        auto vv = builder.CreateShl(
                            v, llvm::ConstantInt::get(context,
                                                      llvm::APInt(64, 3)));
                        auto vvv = builder.CreateOr(
                            vv, llvm::ConstantInt::get(
                                    context, llvm::APInt(64, INTEGER)));
                        return vvv;
                    } else {
                        auto x = compile(a.cons()->cdr->car, normalBlock,
                                         exceptionBlock);
                        auto y = compile(a.cons()->cdr->cdr->car, normalBlock,
                                         exceptionBlock);
                        if (is_error(x))
                            return x;
                        if (is_error(y))
                            return y;

                        auto f = getFunction("atom_to_integer");
                        if (!f) {
                            return "can't find atom_to_integer";
                        }
                        f->setCallingConv(llvm::CallingConv::Fast);

                        auto xx = builder.CreateCall(f, get_value(x));
                        xx->setCallingConv(llvm::CallingConv::Fast);
                        auto yy = builder.CreateCall(f, get_value(y));
                        yy->setCallingConv(llvm::CallingConv::Fast);
                        auto v = builder.CreateSub(xx, yy);
                        auto vv = builder.CreateShl(
                            v, llvm::ConstantInt::get(context,
                                                      llvm::APInt(64, 3)));
                        auto vvv = builder.CreateOr(
                            vv, llvm::ConstantInt::get(
                                    context, llvm::APInt(64, INTEGER)));

                        return vvv;
                    }
                } else if (sym == "quote") {
                    if (a.cons()->length() != 2) {
                        return "invalid quote length";
                    }
                    return constant_atom(a.cons()->cdr->car);
                } else if (sym == ">") {
                    auto x = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    auto y = compile(a.cons()->cdr->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(x)) {
                        return x;
                    }
                    if (is_error(y)) {
                        return y;
                    }

                    auto v =
                        builder.CreateICmpSGT(get_value(x), get_value(y), ">");
                    return ternary(v, constant_atom(make_boolean(true)),
                                   constant_atom(make_boolean(false)));
                } else if (sym == ">=") {
                    auto x = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    auto y = compile(a.cons()->cdr->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(x)) {
                        return x;
                    }
                    if (is_error(y)) {
                        return y;
                    }

                    auto v =
                        builder.CreateICmpSGE(get_value(x), get_value(y), ">");
                    return ternary(v, constant_atom(make_boolean(true)),
                                   constant_atom(make_boolean(false)));
                } else if (sym == "<=") {
                    auto x = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    auto y = compile(a.cons()->cdr->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(x)) {
                        return x;
                    }
                    if (is_error(y)) {
                        return y;
                    }

                    auto v =
                        builder.CreateICmpSLE(get_value(x), get_value(y), ">");
                    return ternary(v, constant_atom(make_boolean(true)),
                                   constant_atom(make_boolean(false)));
                } else if (sym == "<") {
                    auto x = compile(a.cons()->cdr->car, normalBlock,
                                     exceptionBlock);
                    auto y = compile(a.cons()->cdr->cdr->car, normalBlock,
                                     exceptionBlock);
                    if (is_error(x)) {
                        return x;
                    }
                    if (is_error(y)) {
                        return y;
                    }

                    auto v =
                        builder.CreateICmpSLT(get_value(x), get_value(y), ">");
                    return ternary(v, constant_atom(make_boolean(true)),
                                   constant_atom(make_boolean(false)));

                } else if (sym == "define" || sym == "set!") {
                    auto sym = a.cons()->cdr->car;

                    auto value = compile(a.cons()->cdr->cdr->car, normalBlock,
                                         exceptionBlock);
                    if (is_error(value))
                        return value;

                    auto f = module->getFunction("env_set");

                    return builder.CreateCall(
                        f, {get_env(), constant_atom(sym), get_value(value)});
                } else if (sym == "begin") {
                    for (auto c : *a.cons()->cdr) {
                        auto v = compile(c->car, normalBlock, exceptionBlock);
                        if (is_error(v))
                            return v;
                        if (!c->cdr) {
                            return v;
                        }
                    }
                    return constant_atom(make_nil());
                } else if (sym == "lambda") {
                    return compile_lambda(a, normalBlock, exceptionBlock);
                } else {
                    return compile_application(a, normalBlock, exceptionBlock);
                }
            } else {
                return compile_application(a, normalBlock, exceptionBlock);
            }
            break;
        default:
            if (a.get_type() == AtomType::Symbol) {
                bool is_closure = true;

                auto f = builder.GetInsertBlock()->getParent();
                if (lambda) {
                    for (auto &arg : *lambda->arguments) {
                        if (arg.symbol == a.symbol()) {
                            is_closure = arg.is_closed_over;
                            break;
                        }
                    }
                }
                if (!f) {
                    return "null parent function";
                }

                if (is_closure) {
                    auto lookupFunc = module->getFunction("env_get");
                    // lookupFunc->setOnlyReadsMemory();
                    if (!lookupFunc) {
                        return "can't find env_get";
                    }
                    return builder.CreateCall(
                        lookupFunc, {f->args().begin(), constant_atom(a)});
                } else {
                    for (auto &[k, v] : named_values) {
                        if (k == a.symbol().string()) {
                            return v;
                        }
                    }
                    for (auto &arg : f->args()) {
                        if (arg.getName() == a.symbol().string()) {
                            return &arg;
                        }
                    }
                    return "can't find the function argument :(";
                }
            }
            return constant_atom(a);
        }
        return "shouldn't get here";
    }

    Result<llvm::Value *> ternary(llvm::Value *pred, llvm::Value *x,
                                  llvm::Value *y) {
        auto theFunc = builder.GetInsertBlock()->getParent();
        auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

        auto elseBB = llvm::BasicBlock::Create(context, "else");
        auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");

        builder.CreateCondBr(pred, thenBB, elseBB);

        builder.SetInsertPoint(thenBB);

        builder.CreateBr(mergeBB);

        thenBB = builder.GetInsertBlock();

        theFunc->getBasicBlockList().push_back(elseBB);
        builder.SetInsertPoint(elseBB);

        builder.CreateBr(mergeBB);
        elseBB = builder.GetInsertBlock();

        theFunc->getBasicBlockList().push_back(mergeBB);
        builder.SetInsertPoint(mergeBB);

        auto pn = builder.CreatePHI(atom_type(), 2, "iftmp");

        pn->addIncoming(x, thenBB);
        pn->addIncoming(y, elseBB);

        return pn;
    }

    Result<llvm::Value *> compile_macro(Atom a, llvm::BasicBlock *normalBlock,
                                        llvm::BasicBlock *exceptionBlock) {
        auto name = lambda_unique_name();

        std::vector<llvm::Type *> args(a.cons()->cdr->car.cons()->length(),
                                       llvm::Type::getInt64Ty(context));
        args.push_back(atom_type());

        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context), args,
                                          false);
        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                        name, module);

        f->setCallingConv(llvm::CallingConv::Fast);

        auto bb = llvm::BasicBlock::Create(context, "entry", f);
        llvm::IRBuilder cbuilder(context);

        cbuilder.SetInsertPoint(bb);

        auto e = engine->get_memory().alloc_env(env);

        auto l = engine->get_memory().alloc_lambda(a.cons()->cdr->car.cons(),
                                                   a.cons()->cdr->cdr, e);
        l->native_name = new std::string(name);
        l->is_macro = true;

        CompilerContext compiler(context, cbuilder, module, engine, e,
                                 native_engine, expConfig);
        compiler.lambda = l;

        Cons *body = engine->get_memory().alloc_cons(
            make_symbol(Symbol::from("begin")), a.cons()->cdr->cdr);

        Cons *c = a.cons()->cdr->car.cons();

        auto it = f->args().begin();
        it->setName("env");

        auto envValue = it++;

        for (; it != f->args().end(); ++it) {
            it->setName(c->car.symbol().string());
            c = c->cdr;
        }

        auto v = compiler.compile(make_cons(body), normalBlock, exceptionBlock);
        if (is_error(v))
            return v;

        cbuilder.CreateRet(get_value(v));

        if (llvm::verifyFunction(*f, &llvm::outs())) {
            return "error in lambda verify";
        }

        for (auto [key, value] : compiler.get_lambdas()) {
            lambdas[key] = value;
        }

        lambdas[name] = l;

        return constant_atom(make_lambda(l));
    }

    Result<llvm::Value *> compile_lambda(Atom a, llvm::BasicBlock *normalBlock,
                                         llvm::BasicBlock *exceptionBlock) {
        auto name = lambda_unique_name();
        std::vector<llvm::Type *> args(a.cons()->cdr->car.cons()->length(),
                                       llvm::Type::getInt64Ty(context));
        args.push_back(atom_type());

        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context), args,
                                          false);
        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                        name, module);

        f->setCallingConv(llvm::CallingConv::Fast);
        auto mf = getFunction("my_personality");
        assert(mf);

        f->setPersonalityFn(mf);

        auto bb = llvm::BasicBlock::Create(context, "entry", f);
        llvm::IRBuilder<> cbuilder(context);

        cbuilder.SetInsertPoint(bb);

        auto e = engine->get_memory().alloc_env(env);

        Cons *body = engine->get_memory().alloc_cons(
            make_symbol(Symbol::from("begin")), a.cons()->cdr->cdr);

        auto l = engine->get_memory().alloc_lambda(a.cons()->cdr->car.cons(),
                                                   body, e);
        l->native_name = new std::string(name);

        CompilerContext compiler(context, cbuilder, module, engine, e,
                                 native_engine, expConfig);
        compiler.lambda = l;

        auto syms = extract_symbols(make_cons(body), *l->arguments);
        for (auto s : syms) {
            for (auto &a : *l->arguments) {
                if (a.symbol == s) {
                    a.is_closed_over = true;
                    break;
                }
            }
        }
        Cons *c = a.cons()->cdr->car.cons();

        auto it = f->args().begin();
        it->setName("env");

        auto envValue = it++;

        for (; it != f->args().end(); ++it) {
            it->setName(c->car.symbol().string());
            for (auto &arg : *l->arguments) {
                if (arg.symbol == c->car.symbol() && arg.is_closed_over) {
                    cbuilder.CreateCall(module->getFunction("env_set"),
                                        {envValue, constant_atom(c->car), it});
                }
            }
            c = c->cdr;
        }

        auto v = compiler.compile(make_cons(body), normalBlock, exceptionBlock);
        if (is_error(v))
            return v;

        auto vv = get_value(v);

        if (vv->getType() == builder.getInt64Ty()) {
            cbuilder.CreateRet(get_value(v));
        }

        if (llvm::verifyFunction(*f, &llvm::outs())) {
            return "error in lambda verify";
        }

        for (auto [key, value] : compiler.get_lambdas()) {
            lambdas[key] = value;
        }

        lambdas[name] = l;

        return constant_atom(make_lambda(l));
    }

    // TODO: optimize this >.>
    std::vector<Symbol> extract_symbols(Atom a, std::vector<Argument> &args) {
        std::vector<Symbol> syms;

        switch (a.get_type()) {
        case AtomType::Cons:
            if (a.cons()->length() == 0) {
                return syms;
            }

            if (a.cons()->car == make_symbol(Symbol::from("lambda"))) {
                auto newArgs = make_arguments(a.cons()->cdr->car.cons());

                auto e =
                    extract_symbols(make_cons(a.cons()->cdr->cdr), *newArgs);
                for (auto x : e) {
                    syms.push_back(x);
                }
                delete newArgs;
            } else {
                for (auto c : *a.cons()) {
                    auto e = extract_symbols(c->car, args);
                    for (auto x : e) {
                        syms.push_back(x);
                    }
                }
            }
            break;
        case AtomType::Symbol: {
            bool found = false;
            for (auto &arg : args) {
                if (arg.symbol == a.symbol()) {
                    found = true;
                    break;
                }
            }
            if (!found)
                syms.push_back(a.symbol());
        } break;
        default:
            break;
        }
        return syms;
    }

    Result<llvm::Value *>
    compile_application(Atom a, llvm::BasicBlock *normalBlock,
                        llvm::BasicBlock *exceptionBlock) {
        std::vector<llvm::Value *> args;
        std::vector<llvm::Type *> funcArgs;

        if (a.get_type() == AtomType::Symbol) {
            auto x = env->lookup(a.symbol());
            if (x.has_value()) {
                auto xx = x.value();

                if (xx.get_type() == AtomType::Lambda) {
                    auto l = xx.lambda();

                    if (l->is_macro) {
                        switch (l->arguments->size()) {
                        case 0: {
                            Atom (*FP)(Env *) =
                                (Atom(*)(Env *))(intptr_t)l->function_pointer;
                            auto a = FP(env);
                            return compile(a, normalBlock, exceptionBlock);
                        } break;
                        case 1: {
                            Atom (*FP)(Env *, Atom x) = (Atom(*)(
                                Env *, Atom))(intptr_t)l->function_pointer;
                            Atom m = FP(env, a.cons()->cdr->car);
                            return compile(m, normalBlock, exceptionBlock);
                        } break;
                        case 2: {
                            Atom (*FP)(Env *, Atom x, Atom y) =
                                (Atom(*)(Env *, Atom, Atom))(
                                    intptr_t)l->function_pointer;
                            Atom m = FP(env, a.cons()->cdr->car,
                                        a.cons()->cdr->cdr->car);
                            return compile(m, normalBlock, exceptionBlock);
                        } break;
                        default:
                            return "I'm terrible and didn't do this past 3 "
                                   "arguments";
                        }
                    }
                }
            }
        }

        auto l = compile(a.cons()->car, normalBlock, exceptionBlock);
        if (is_error(l))
            return l;

        auto f = module->getFunction("lambda_get_function_pointer");
        auto fp = builder.CreateCall(f, get_value(l));
        fp->setCallingConv(llvm::CallingConv::Fast);

        auto ep = module->getFunction("lambda_get_env_pointer");
        auto fenv = builder.CreateCall(ep, get_value(l));
        fenv->setCallingConv(llvm::CallingConv::Fast);

        args.push_back(fenv);
        funcArgs.push_back(atom_type());

        for (auto c : *a.cons()->cdr) {
            auto v = compile(c->car, normalBlock, exceptionBlock);
            if (is_error(v)) {
                return v;
            }
            args.push_back(get_value(v));
            funcArgs.push_back(llvm::Type::getInt64Ty(context));
        }

        if (normalBlock) {
            assert(exceptionBlock);
            auto ll = builder.CreateIntToPtr(
                fp, llvm::FunctionType::get(llvm::Type::getInt64Ty(context),

                                            funcArgs, false)
                        ->getPointerTo());

            auto v =
                builder.CreateInvoke(ll, normalBlock, exceptionBlock, args);
            v->setCallingConv(llvm::CallingConv::Fast);

            // ll->setPersonalityFn( getFunction("my_personality"));

            return v;
        } else {
            assert(!exceptionBlock);
            auto ll = builder.CreateIntToPtr(
                fp, llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                            funcArgs, false)
                        ->getPointerTo());
            auto v = builder.CreateCall(ll, args);
            v->setCallingConv(llvm::CallingConv::Fast);

            return v;
        }
    }

    llvm::Value *get_env() {
        return builder.GetInsertBlock()->getParent()->args().begin();
    }

    llvm::Type *atom_type() { return llvm::Type::getInt64Ty(context); }

    llvm::Value *constant_atom(Atom a) {
        return llvm::ConstantInt::get(context, llvm::APInt(64, a.value));
    }

    std::map<std::string, Lambda *> &get_lambdas() { return lambdas; }

    llvm::AllocaInst *create_entry_block_alloca(const std::string &name,
                                                llvm::Type *type,
                                                llvm::Constant *init = 0) {
        auto &block = builder.GetInsertBlock()->getParent()->getEntryBlock();
        llvm::IRBuilder<> tmp(&block, block.begin());

        auto ret = tmp.CreateAlloca(type, 0, name);
        if (init)
            tmp.CreateStore(init, ret);

        return ret;
    }

  private:
    ExceptionConfig expConfig;
    Lambda *lambda = nullptr;
    CompilerContext *parent;
    Env *env;
    Engine *engine;
    llvm::IRBuilder<> &builder;
    llvm::LLVMContext &context;
    llvm::Module *module;
    std::map<std::string, Lambda *> lambdas;
    std::map<std::string, llvm::Value *> named_values;
    NativeEngine *native_engine;
};

static llvm::Function *get_function_pointer(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "lambda_get_function_pointer", m);

    f->setCallingConv(llvm::CallingConv::Fast);
    llvm::IRBuilder<> builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto i = builder.CreateAdd(
        f->args().begin(),
        llvm::ConstantInt::get(
            m->getContext(),
            llvm::APInt(64, offsetof(Lambda, function_pointer))));

    auto ii =
        builder.CreateIntToPtr(i, llvm::Type::getInt64PtrTy(m->getContext()));

    auto iii = builder.CreateLoad(ii);

    builder.CreateRet(iii);

    return f;
}

static llvm::Function *builtin_car(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "builtin_car", m);

    f->setCallingConv(llvm::CallingConv::Fast);
    llvm::IRBuilder builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto p = builder.CreateIntToPtr(
        f->args().begin(),
        llvm::Type::getInt64Ty(m->getContext())->getPointerTo());

    auto pp = builder.CreateLoad(p);

    builder.CreateRet(pp);

    return f;
}

static llvm::Function *builtin_cdr(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "builtin_cdr", m);

    f->setCallingConv(llvm::CallingConv::Fast);
    llvm::IRBuilder builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto a = builder.CreateAdd(
        f->args().begin(),
        llvm::ConstantInt::get(m->getContext(),
                               llvm::APInt(64, offsetof(Cons, cdr))));

    auto p = builder.CreateIntToPtr(
        a, llvm::Type::getInt64Ty(m->getContext())->getPointerTo());

    auto pp = builder.CreateLoad(p);

    auto is_nil = builder.CreateICmpEQ(
        pp, llvm::ConstantInt::get(m->getContext(), llvm::APInt(64, 0)));

    auto theFunc = builder.GetInsertBlock()->getParent();
    auto &context = m->getContext();
    auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

    auto elseBB = llvm::BasicBlock::Create(context, "else");
    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");
    builder.CreateCondBr(is_nil, thenBB, elseBB);

    builder.SetInsertPoint(thenBB);

    auto then =
        llvm::ConstantInt::get(context, llvm::APInt(64, make_nil().value));
    builder.CreateBr(mergeBB);

    thenBB = builder.GetInsertBlock();

    theFunc->getBasicBlockList().push_back(elseBB);
    builder.SetInsertPoint(elseBB);

    auto elseV = pp;

    builder.CreateBr(mergeBB);
    elseBB = builder.GetInsertBlock();

    theFunc->getBasicBlockList().push_back(mergeBB);
    builder.SetInsertPoint(mergeBB);

    auto pn = builder.CreatePHI(llvm::Type::getInt64Ty(context), 2, "iftmp");

    pn->addIncoming(then, thenBB);
    pn->addIncoming(elseV, elseBB);

    builder.CreateRet(pn);

    return f;
}
static llvm::Function *builtin_not(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "builtin_not", m);

    f->setCallingConv(llvm::CallingConv::Fast);
    llvm::IRBuilder builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto is_list = builder.CreateICmpEQ(
        f->args().begin(),
        llvm::ConstantInt::get(
            m->getContext(), llvm::APInt(64, (int)make_boolean(false).value)));

    auto theFunc = builder.GetInsertBlock()->getParent();
    auto &context = m->getContext();
    auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

    auto elseBB = llvm::BasicBlock::Create(context, "else");
    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");
    builder.CreateCondBr(is_list, thenBB, elseBB);

    builder.SetInsertPoint(thenBB);

    auto then = llvm::ConstantInt::get(
        context, llvm::APInt(64, make_boolean(true).value));
    builder.CreateBr(mergeBB);

    thenBB = builder.GetInsertBlock();

    theFunc->getBasicBlockList().push_back(elseBB);
    builder.SetInsertPoint(elseBB);

    auto elseV = llvm::ConstantInt::get(
        context, llvm::APInt(64, make_boolean(false).value));

    builder.CreateBr(mergeBB);
    elseBB = builder.GetInsertBlock();

    theFunc->getBasicBlockList().push_back(mergeBB);
    builder.SetInsertPoint(mergeBB);

    auto pn = builder.CreatePHI(llvm::Type::getInt64Ty(context), 2, "iftmp");

    pn->addIncoming(then, thenBB);
    pn->addIncoming(elseV, elseBB);

    builder.CreateRet(pn);

    return f;
}

static llvm::Function *builtin_pair_p(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "builtin_pair_p", m);

    f->setCallingConv(llvm::CallingConv::Fast);
    llvm::IRBuilder builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto ff = m->getFunction("atom_to_type");

    auto t = builder.CreateCall(ff, f->args().begin());

    auto tt = builder.CreateIntCast(t, llvm::Type::getInt64Ty(m->getContext()),
                                    false);

    auto is_list = builder.CreateICmpEQ(
        tt, llvm::ConstantInt::get(m->getContext(),
                                   llvm::APInt(64, (int)AtomType::Cons)));

    auto theFunc = builder.GetInsertBlock()->getParent();
    auto &context = m->getContext();
    auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

    auto elseBB = llvm::BasicBlock::Create(context, "else");
    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");
    builder.CreateCondBr(is_list, thenBB, elseBB);

    builder.SetInsertPoint(thenBB);

    auto then = llvm::ConstantInt::get(
        context, llvm::APInt(64, make_boolean(true).value));
    builder.CreateBr(mergeBB);

    thenBB = builder.GetInsertBlock();

    theFunc->getBasicBlockList().push_back(elseBB);
    builder.SetInsertPoint(elseBB);

    auto elseV = llvm::ConstantInt::get(
        context, llvm::APInt(64, make_boolean(false).value));

    builder.CreateBr(mergeBB);
    elseBB = builder.GetInsertBlock();

    theFunc->getBasicBlockList().push_back(mergeBB);
    builder.SetInsertPoint(mergeBB);

    auto pn = builder.CreatePHI(llvm::Type::getInt64Ty(context), 2, "iftmp");

    pn->addIncoming(then, thenBB);
    pn->addIncoming(elseV, elseBB);

    builder.CreateRet(pn);

    return f;
}

static llvm::Function *llvm_equalsp(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), true);

    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "equalsp_ex", m);

    return f;
}

static llvm::Function *lambda_get_env_pointer(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "lambda_get_env_pointer", m);

    f->setCallingConv(llvm::CallingConv::Fast);
    llvm::IRBuilder<> builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto i = builder.CreateAdd(
        f->args().begin(),
        llvm::ConstantInt::get(m->getContext(),
                               llvm::APInt(64, offsetof(Lambda, env))));

    auto ii =
        builder.CreateIntToPtr(i, llvm::Type::getInt64PtrTy(m->getContext()));

    auto iii = builder.CreateLoad(ii);

    builder.CreateRet(iii);

    return f;
}

static llvm::Function *make_list_func(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(
        llvm::Type::getInt64Ty(context),
        {llvm::Type::getInt64Ty(context), llvm::Type::getInt64Ty(context)},
        true);
    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "make_list", m);
    return f;
}

static llvm::Function *make_append_func(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(
        llvm::Type::getInt64Ty(context),
        {llvm::Type::getInt64Ty(context), llvm::Type::getInt64Ty(context)},
        true);
    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "builtin_append", m);
    return f;
}

static llvm::Function *make_cons_func(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                      {llvm::Type::getInt64Ty(context),
                                       llvm::Type::getInt64Ty(context),
                                       llvm::Type::getInt64Ty(context)},
                                      false);
    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "builtin_cons", m);
    return f;
}

static llvm::Function *env_get(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(
        llvm::Type::getInt64Ty(context),
        {llvm::Type::getInt64Ty(context), llvm::Type::getInt64Ty(context)},
        false);

    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "env_get", m);
    f->setOnlyReadsMemory();

    return f;
}

static llvm::Function *env_set(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                      {llvm::Type::getInt64Ty(context),
                                       llvm::Type::getInt64Ty(context),
                                       llvm::Type::getInt64Ty(context)},
                                      false);

    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "env_set", m);

    return f;
}
static llvm::Function *atom_to_type(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(llvm::Type::getInt8Ty(context),
                                      {llvm::Type::getInt64Ty(context)}, false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "atom_to_type", m);

    // f->setCallingConv(llvm::CallingConv::Fast);
    auto bb = llvm::BasicBlock::Create(context, "entry", f);

    llvm::IRBuilder<> builder(context);
    builder.SetInsertPoint(bb);
    llvm::Value *arg = &*f->args().begin();

    auto masked = builder.CreateAnd(
        arg, llvm::ConstantInt::get(context, llvm::APInt(64, 3)));

    auto defCase = llvm::BasicBlock::Create(context, "default", f);
    builder.SetInsertPoint(defCase);

    // point to the heapnode start
    auto pHn = builder.CreateSub(
        arg,
        llvm::ConstantInt::get(context,
                               llvm::APInt(64, offsetof(HeapNode, buff))),
        "-> heap node address");
    auto pType = builder.CreateIntToPtr(
        pHn, llvm::Type::getInt64Ty(context)->getPointerTo(), "(HeapNode*)");
    auto hn = builder.CreateLoad(pType, "heap node load");
    auto tt = builder.CreateAnd(
        hn, llvm::ConstantInt::get(context, llvm::APInt(64, 255)),
        "and for the type");
    auto casted = builder.CreateIntCast(tt, llvm::Type::getInt8Ty(context),
                                        false, "casted type");
    builder.CreateRet(casted);

    builder.SetInsertPoint(bb);
    auto sw = builder.CreateSwitch(masked, defCase);

    auto intBB = llvm::BasicBlock::Create(context, "int", f);
    builder.SetInsertPoint(intBB);
    builder.CreateRet(
        llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Number)));

    auto boolBB = llvm::BasicBlock::Create(context, "boolean", f);
    builder.SetInsertPoint(boolBB);
    builder.CreateRet(llvm::ConstantInt::get(
        context, llvm::APInt(8, (int)AtomType::Boolean)));

    auto nilBB = llvm::BasicBlock::Create(context, "nil", f);
    builder.SetInsertPoint(nilBB);
    builder.CreateRet(
        llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Nil)));

    auto symBB = llvm::BasicBlock::Create(context, "symbol", f);
    builder.SetInsertPoint(symBB);
    builder.CreateRet(
        llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Symbol)));

    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, INTEGER)),
                intBB);
    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, BOOL)), boolBB);
    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, NIL)), nilBB);
    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, SYMBOL)),
                symBB);

    return f;
}

static llvm::Function *atom_to_integer(llvm::Module *module) {
    auto &context = module->getContext();
    auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                      llvm::Type::getInt64Ty(context), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "atom_to_integer", module);
    auto bb = llvm::BasicBlock::Create(context, "entry", f);

    f->setCallingConv(llvm::CallingConv::Fast);

    llvm::IRBuilder<> builder(context);
    builder.SetInsertPoint(bb);

    llvm::Value *out = f->args().begin();
    builder.CreateRet(builder.CreateLShr(
        out, llvm::ConstantInt::get(context, llvm::APInt(64, 3))));

    return f;
}

static llvm::Function *unwind_raise(llvm::Module *m) {
    auto &context = m->getContext();

    auto f = llvm::Function::Create(
        llvm::FunctionType::get(llvm::Type::getInt32Ty(context),
                                llvm::Type::getInt8Ty(context)->getPointerTo(),
                                false),
        llvm::Function::ExternalLinkage, "_Unwind_RaiseException", m);

    f->setDoesNotReturn();
    return f;
}

static llvm::Function *unwind_resume(llvm::Module *m) {
    auto &context = m->getContext();

    auto f = llvm::Function::Create(
        llvm::FunctionType::get(llvm::Type::getInt32Ty(context),
                                llvm::Type::getInt8Ty(context)->getPointerTo(),
                                false),
        llvm::Function::ExternalLinkage, "_Unwind_Resume", m);

    f->setDoesNotReturn();
    return f;
}

static llvm::Function *my_personality_func(llvm::Module *m) {
    auto &context = m->getContext();

    auto f = llvm::Function::Create(
        llvm::FunctionType::get(
            llvm::Type::getInt32Ty(context),
            {llvm::Type::getInt32Ty(context), llvm::Type::getInt32Ty(context),
             llvm::Type::getInt64Ty(context), llvm::Type::getInt8PtrTy(context),
             llvm::Type::getInt8PtrTy(context)},
            false),
        llvm::Function::ExternalLinkage, "my_personality", m);

    return f;
}

static llvm::Function *display_func(llvm::Module *m) {
    auto &context = m->getContext();

    auto f = llvm::Function::Create(
        llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                llvm::Type::getInt64Ty(context), false),
        llvm::Function::ExternalLinkage, "display", m);
    return f;
}

static llvm::Function *create_exception_func(llvm::Module *m) {
    auto &context = m->getContext();

    auto f = llvm::Function::Create(
        llvm::FunctionType::get(llvm::Type::getInt8PtrTy(context), false),
        llvm::Function::ExternalLinkage, "create_exception", m);

    return f;
}

static llvm::Function *delete_exception_func(llvm::Module *m) {
    auto &context = m->getContext();

    auto f = llvm::Function::Create(
        llvm::FunctionType::get(llvm::Type::getVoidTy(context),
                                llvm::Type::getInt8PtrTy(context), false),
        llvm::Function::ExternalLinkage, "delete_exception", m);

    return f;
}

Result<Atom> NativeEngine::execute(Atom a) {
    auto name = expression_unique_name();
    auto module = std::make_unique<llvm::Module>("anon", jit->getContext());
    module->setDataLayout(jit->getDataLayout());
    auto& context = getContext();

    llvm::legacy::PassManager mpm;
    llvm::PassManagerBuilder pmBuilder;

    pmBuilder.Inliner = llvm::createFunctionInliningPass();
    pmBuilder.OptLevel = 3;
    pmBuilder.populateModulePassManager(mpm);

    auto fpm =
        std::make_unique<llvm::legacy::FunctionPassManager>(module.get());
    fpm->add(llvm::createTailCallEliminationPass());
    fpm->add(llvm::createPromoteMemoryToRegisterPass());
    fpm->add(llvm::createInstructionCombiningPass());
    fpm->add(llvm::createReassociatePass());
    fpm->add(llvm::createGVNPass());
    fpm->add(llvm::createCFGSimplificationPass());
    fpm->doInitialization();

    std::vector<llvm::Function *> builtins;
    builtins.push_back(atom_to_integer(module.get()));
    builtins.push_back(atom_to_type(module.get()));
    builtins.push_back(get_function_pointer(module.get()));
    builtins.push_back(env_set(module.get()));
    builtins.push_back(env_get(module.get()));
    builtins.push_back(lambda_get_env_pointer(module.get()));
    builtins.push_back(make_list_func(module.get()));
    builtins.push_back(llvm_equalsp(module.get()));
    builtins.push_back(make_cons_func(module.get()));
    builtins.push_back(make_append_func(module.get()));
    builtins.push_back(builtin_pair_p(module.get()));
    builtins.push_back(builtin_not(module.get()));
    builtins.push_back(builtin_car(module.get()));
    builtins.push_back(builtin_cdr(module.get()));
    builtins.push_back(unwind_raise(module.get()));
    builtins.push_back(unwind_resume(module.get()));
    builtins.push_back(my_personality_func(module.get()));
    builtins.push_back(delete_exception_func(module.get()));
    builtins.push_back(create_exception_func(module.get()));
    builtins.push_back(display_func(module.get()));

    for (auto f : builtins) {
        if (llvm::verifyFunction(*f, &llvm::outs())) {
            assert(false);
        }
    }

    auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                      {llvm::Type::getInt64Ty(context)}, false);
    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    name, module.get());
    auto bb = llvm::BasicBlock::Create(context, "entry", f);

    llvm::IRBuilder<> builder(context);
    builder.SetInsertPoint(bb);

    ExceptionConfig expConfig;

    using TypeArray = llvm::ArrayRef<llvm::Type *>;

    expConfig.type_info_type =
        llvm::StructType::get(context, TypeArray(builder.getInt32Ty()));

    llvm::Type *caughtTypes[] = {builder.getInt8PtrTy(), builder.getInt32Ty()};

    expConfig.caught_result_type =
        llvm::StructType::get(context, TypeArray(caughtTypes));

    expConfig.exception_type = llvm::StructType::get(context, TypeArray(expConfig.type_info_type));

    expConfig.unwind_exception_type = llvm::StructType::get(context, TypeArray(builder.getInt64Ty()));

    auto st = llvm::ConstantStruct::get(
        expConfig.type_info_type, {llvm::ConstantInt::get(builder.getInt32Ty(), 0)});

    if (!my_exception) {
        my_exception = new llvm::GlobalVariable(
            *module.get(), expConfig.type_info_type, true,
            llvm::GlobalValue::ExternalLinkage, st, "my_exception");
    }

    CompilerContext compiler(context, builder, module.get(), engine, env, this,
                             expConfig);
    auto v = compiler.compile(a, nullptr, nullptr);
    if (is_error(v)) {
        return get_error(v);
    }
    builder.CreateRet(get_value(v));

    fpm->run(*f);

    for (auto &F : *module.get()) {
        fpm->run(F);
    }

    mpm.run(*module.get());

    if (CompilerVerbosity) {
        for (auto &F : *module) {
            F.print(llvm::outs());
        }
    }

    if (CompilerVerbosity) {
        // llvm::legacy::PassManager pm;
        // auto out_file = llvm::raw_fd_ostream(0, false);
        // if (jit->getTargetMachine().addPassesToEmitFile(
        //         pm, out_file, &out_file,
        //         llvm::TargetMachine::CGFT_AssemblyFile)) {
        //     llvm::outs().flush();
        // } else {
        //     pm.run(*module.get());
        // }
    }

    if (llvm::verifyFunction(*f, &llvm::outs())) {
        return "function didn't pass verify";
    }

    if (llvm::verifyModule(*module.get(), &llvm::outs())) {
        return "module didn't pass verification";
    }

    if(auto err =jit->addModule(std::move(module)) ) {
        llvm::errs() << "ERR: "<< err;
        return "add module failed!";
    }

    auto addr = jit->lookup(name);

    if (auto err = addr.takeError()) {
        llvm::logAllUnhandledErrors(std::move(err), llvm::outs(), "error");
        return "error finding expression symbol";
    }
    for (auto &[key, value] : compiler.get_lambdas()) {
        auto x = jit->lookup(*value->native_name);
        if (auto err = x.takeError()) {
            return "error in finding symbol";
        }
        value->function_pointer = reinterpret_cast<void *>(x->getAddress());
    }

    Atom (*FP)(Env *) = (Atom(*)(Env *))(intptr_t)addr->getAddress();

    auto x = FP(env);

    return x;
}

} // namespace minou
