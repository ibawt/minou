; ModuleID = 'src/builtins.cpp'
source_filename = "src/builtins.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"struct.std::piecewise_construct_t" = type { i8 }
%"struct.std::in_place_t" = type { i8 }
%"class.minou::Env" = type { %"class.std::map", %"class.minou::Env"* }
%"class.std::map" = type { %"class.std::_Rb_tree" }
%"class.std::_Rb_tree" = type { %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl" }
%"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl" = type { %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_header" }
%"struct.std::_Rb_tree_key_compare" = type { %"struct.std::less" }
%"struct.std::less" = type { i8 }
%"struct.std::_Rb_tree_header" = type { %"struct.std::_Rb_tree_node_base", i64 }
%"struct.std::_Rb_tree_node_base" = type { i32, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }
%"struct.minou::Atom" = type { i64 }
%"struct.minou::Symbol" = type { i32 }
%"class.std::optional" = type { %"class.std::_Optional_base" }
%"class.std::_Optional_base" = type { %"struct.std::_Optional_payload" }
%"struct.std::_Optional_payload" = type <{ %union.anon, i8, [7 x i8] }>
%union.anon = type { %"struct.minou::Atom" }
%"struct.std::_Rb_tree_iterator" = type { %"struct.std::_Rb_tree_node_base"* }
%"struct.std::pair.283" = type { i32, %"struct.minou::Atom" }
%"class.minou::Engine" = type { %"class.minou::SymbolInterner", %"class.minou::Memory", %"class.minou::Env"*, %"class.minou::NativeEngine" }
%"class.minou::SymbolInterner" = type { %"class.std::vector", %"class.std::unordered_map" }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > >::_Vector_impl" }
%"struct.std::_Vector_base<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > >::_Vector_impl" = type { %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"* }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider", i64, %union.anon.6 }
%"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%union.anon.6 = type { i64, [8 x i8] }
%"class.std::unordered_map" = type { %"class.std::_Hashtable" }
%"class.std::_Hashtable" = type { %"struct.std::__detail::_Hash_node_base"**, i64, %"struct.std::__detail::_Hash_node_base", i64, %"struct.std::__detail::_Prime_rehash_policy", %"struct.std::__detail::_Hash_node_base"* }
%"struct.std::__detail::_Hash_node_base" = type { %"struct.std::__detail::_Hash_node_base"* }
%"struct.std::__detail::_Prime_rehash_policy" = type { float, i64 }
%"class.minou::Memory" = type { i32, i32, %"class.std::__cxx11::list", %"class.std::mutex" }
%"class.std::__cxx11::list" = type { %"class.std::__cxx11::_List_base" }
%"class.std::__cxx11::_List_base" = type { %"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl" }
%"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl" = type { %"struct.std::_List_node" }
%"struct.std::_List_node" = type { %"struct.std::__detail::_List_node_base", %"struct.__gnu_cxx::__aligned_membuf" }
%"struct.std::__detail::_List_node_base" = type { %"struct.std::__detail::_List_node_base"*, %"struct.std::__detail::_List_node_base"* }
%"struct.__gnu_cxx::__aligned_membuf" = type { [8 x i8] }
%"class.std::mutex" = type { %"class.std::__mutex_base" }
%"class.std::__mutex_base" = type { %union.pthread_mutex_t }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.minou::NativeEngine" = type { %"class.llvm::LLVMContext", %"class.std::unique_ptr", %"class.minou::Engine"*, %"class.minou::Env"* }
%"class.llvm::LLVMContext" = type { %"class.llvm::LLVMContextImpl"* }
%"class.llvm::LLVMContextImpl" = type opaque
%"class.std::unique_ptr" = type { %"class.std::__uniq_ptr_impl" }
%"class.std::__uniq_ptr_impl" = type { %"class.std::tuple" }
%"class.std::tuple" = type { %"struct.std::_Tuple_impl" }
%"struct.std::_Tuple_impl" = type { %"struct.std::_Head_base.19" }
%"struct.std::_Head_base.19" = type { %"class.llvm::orc::KaleidoscopeJIT"* }
%"class.llvm::orc::KaleidoscopeJIT" = type { %"class.llvm::orc::ExecutionSession", %"class.std::shared_ptr.71", %"class.std::unique_ptr.74", %"class.llvm::DataLayout", %"class.llvm::orc::LegacyRTDyldObjectLinkingLayer", %"class.llvm::orc::LegacyIRCompileLayer", %"class.std::vector.229" }
%"class.llvm::orc::ExecutionSession" = type { %"class.std::recursive_mutex", %"class.std::shared_ptr", i64, %"class.std::function", %"class.std::function.20", %"class.std::vector.59", %"class.std::recursive_mutex", %"class.std::vector.65" }
%"class.std::shared_ptr" = type { %"class.std::__shared_ptr" }
%"class.std::__shared_ptr" = type { %"class.llvm::orc::SymbolStringPool"*, %"class.std::__shared_count" }
%"class.llvm::orc::SymbolStringPool" = type { %"class.std::mutex", %"class.llvm::StringMap" }
%"class.llvm::StringMap" = type <{ %"class.llvm::StringMapImpl", %"class.llvm::MallocAllocator", [7 x i8] }>
%"class.llvm::StringMapImpl" = type { %"class.llvm::StringMapEntryBase"**, i32, i32, i32, i32 }
%"class.llvm::StringMapEntryBase" = type { i64 }
%"class.llvm::MallocAllocator" = type { i8 }
%"class.std::__shared_count" = type { %"class.std::_Sp_counted_base"* }
%"class.std::_Sp_counted_base" = type { i32 (...)**, i32, i32 }
%"class.std::function" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*, %"class.llvm::Error"*)* }
%"class.std::_Function_base" = type { %"union.std::_Any_data", i1 (%"union.std::_Any_data"*, %"union.std::_Any_data"*, i32)* }
%"union.std::_Any_data" = type { %"union.std::_Nocopy_types" }
%"union.std::_Nocopy_types" = type { { i64, i64 } }
%"class.llvm::Error" = type { %"class.llvm::ErrorInfoBase"* }
%"class.llvm::ErrorInfoBase" = type { i32 (...)** }
%"class.std::function.20" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*, %"class.llvm::orc::JITDylib"*, %"class.std::unique_ptr.43"*)* }
%"class.llvm::orc::JITDylib" = type { %"class.llvm::orc::ExecutionSession"*, %"class.std::__cxx11::basic_string", %"class.llvm::DenseMap", %"class.llvm::DenseMap.23", %"class.llvm::DenseMap.27", %"class.std::function.31", %"class.std::vector.37" }
%"class.llvm::DenseMap" = type <{ %"struct.llvm::detail::DenseMapPair"*, i32, i32, i32, [4 x i8] }>
%"struct.llvm::detail::DenseMapPair" = type { %"struct.std::pair" }
%"struct.std::pair" = type { %"class.llvm::orc::SymbolStringPtr", %"class.llvm::JITEvaluatedSymbol" }
%"class.llvm::orc::SymbolStringPtr" = type { %"class.llvm::StringMapEntry"* }
%"class.llvm::StringMapEntry" = type { %"class.llvm::StringMapEntryBase", %"struct.std::atomic" }
%"struct.std::atomic" = type { %"struct.std::__atomic_base" }
%"struct.std::__atomic_base" = type { i64 }
%"class.llvm::JITEvaluatedSymbol" = type { i64, %"class.llvm::JITSymbolFlags" }
%"class.llvm::JITSymbolFlags" = type { i8, i64 }
%"class.llvm::DenseMap.23" = type <{ %"struct.llvm::detail::DenseMapPair.25"*, i32, i32, i32, [4 x i8] }>
%"struct.llvm::detail::DenseMapPair.25" = type { %"struct.std::pair.247" }
%"struct.std::pair.247" = type { %"class.llvm::orc::SymbolStringPtr", %"class.std::shared_ptr.250" }
%"class.std::shared_ptr.250" = type { %"class.std::__shared_ptr.251" }
%"class.std::__shared_ptr.251" = type { %"struct.llvm::orc::JITDylib::UnmaterializedInfo"*, %"class.std::__shared_count" }
%"struct.llvm::orc::JITDylib::UnmaterializedInfo" = type { %"class.std::unique_ptr.43" }
%"class.std::unique_ptr.43" = type { %"class.std::__uniq_ptr_impl.44" }
%"class.std::__uniq_ptr_impl.44" = type { %"class.std::tuple.45" }
%"class.std::tuple.45" = type { %"struct.std::_Tuple_impl.46" }
%"struct.std::_Tuple_impl.46" = type { %"struct.std::_Head_base.51" }
%"struct.std::_Head_base.51" = type { %"class.llvm::orc::MaterializationUnit"* }
%"class.llvm::orc::MaterializationUnit" = type { i32 (...)**, %"class.llvm::DenseMap.52", i64 }
%"class.llvm::DenseMap.52" = type <{ %"struct.llvm::detail::DenseMapPair.54"*, i32, i32, i32, [4 x i8] }>
%"struct.llvm::detail::DenseMapPair.54" = type { %"struct.std::pair.55" }
%"struct.std::pair.55" = type { %"class.llvm::orc::SymbolStringPtr", %"class.llvm::JITSymbolFlags" }
%"class.llvm::DenseMap.27" = type <{ %"struct.llvm::detail::DenseMapPair.29"*, i32, i32, i32, [4 x i8] }>
%"struct.llvm::detail::DenseMapPair.29" = type { %"struct.std::pair.253" }
%"struct.std::pair.253" = type { %"class.llvm::orc::SymbolStringPtr", %"struct.llvm::orc::JITDylib::MaterializingInfo" }
%"struct.llvm::orc::JITDylib::MaterializingInfo" = type <{ %"class.std::vector.256", %"class.llvm::DenseMap.272", %"class.llvm::DenseMap.272", i8, [7 x i8] }>
%"class.std::vector.256" = type { %"struct.std::_Vector_base.257" }
%"struct.std::_Vector_base.257" = type { %"struct.std::_Vector_base<std::shared_ptr<llvm::orc::AsynchronousSymbolQuery>, std::allocator<std::shared_ptr<llvm::orc::AsynchronousSymbolQuery> > >::_Vector_impl" }
%"struct.std::_Vector_base<std::shared_ptr<llvm::orc::AsynchronousSymbolQuery>, std::allocator<std::shared_ptr<llvm::orc::AsynchronousSymbolQuery> > >::_Vector_impl" = type { %"class.std::shared_ptr.261"*, %"class.std::shared_ptr.261"*, %"class.std::shared_ptr.261"* }
%"class.std::shared_ptr.261" = type { %"class.std::__shared_ptr.262" }
%"class.std::__shared_ptr.262" = type { %"class.llvm::orc::AsynchronousSymbolQuery"*, %"class.std::__shared_count" }
%"class.llvm::orc::AsynchronousSymbolQuery" = type { %"class.std::function.264", %"class.std::function", %"class.llvm::DenseMap.272", %"class.llvm::DenseMap", i64, i64 }
%"class.std::function.264" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*, %"class.llvm::Expected"*)* }
%"class.llvm::Expected" = type { %union.anon.267, i8, [7 x i8] }
%union.anon.267 = type { %"struct.llvm::AlignedCharArrayUnion.268" }
%"struct.llvm::AlignedCharArrayUnion.268" = type { %"struct.llvm::AlignedCharArray.269" }
%"struct.llvm::AlignedCharArray.269" = type { [24 x i8] }
%"class.llvm::DenseMap.272" = type <{ %"struct.llvm::detail::DenseMapPair.274"*, i32, i32, i32, [4 x i8] }>
%"struct.llvm::detail::DenseMapPair.274" = type { %"struct.std::pair.275" }
%"struct.std::pair.275" = type { %"class.llvm::orc::JITDylib"*, %"class.llvm::DenseSet" }
%"class.llvm::DenseSet" = type { %"class.llvm::detail::DenseSetImpl" }
%"class.llvm::detail::DenseSetImpl" = type { %"class.llvm::DenseMap.34" }
%"class.llvm::DenseMap.34" = type <{ %"class.llvm::detail::DenseSetPair"*, i32, i32, i32, [4 x i8] }>
%"class.llvm::detail::DenseSetPair" = type { %"class.llvm::orc::SymbolStringPtr" }
%"class.std::function.31" = type { %"class.std::_Function_base", void (%"class.llvm::DenseSet"*, %"union.std::_Any_data"*, %"class.llvm::orc::JITDylib"*, %"class.llvm::DenseSet"*)* }
%"class.std::vector.37" = type { %"struct.std::_Vector_base.38" }
%"struct.std::_Vector_base.38" = type { %"struct.std::_Vector_base<std::pair<llvm::orc::JITDylib *, bool>, std::allocator<std::pair<llvm::orc::JITDylib *, bool> > >::_Vector_impl" }
%"struct.std::_Vector_base<std::pair<llvm::orc::JITDylib *, bool>, std::allocator<std::pair<llvm::orc::JITDylib *, bool> > >::_Vector_impl" = type { %"struct.std::pair.42"*, %"struct.std::pair.42"*, %"struct.std::pair.42"* }
%"struct.std::pair.42" = type <{ %"class.llvm::orc::JITDylib"*, i8, [7 x i8] }>
%"class.std::vector.59" = type { %"struct.std::_Vector_base.60" }
%"struct.std::_Vector_base.60" = type { %"struct.std::_Vector_base<std::unique_ptr<llvm::orc::JITDylib, std::default_delete<llvm::orc::JITDylib> >, std::allocator<std::unique_ptr<llvm::orc::JITDylib, std::default_delete<llvm::orc::JITDylib> > > >::_Vector_impl" }
%"struct.std::_Vector_base<std::unique_ptr<llvm::orc::JITDylib, std::default_delete<llvm::orc::JITDylib> >, std::allocator<std::unique_ptr<llvm::orc::JITDylib, std::default_delete<llvm::orc::JITDylib> > > >::_Vector_impl" = type { %"class.std::unique_ptr.64"*, %"class.std::unique_ptr.64"*, %"class.std::unique_ptr.64"* }
%"class.std::unique_ptr.64" = type { %"class.std::__uniq_ptr_impl.239" }
%"class.std::__uniq_ptr_impl.239" = type { %"class.std::tuple.240" }
%"class.std::tuple.240" = type { %"struct.std::_Tuple_impl.241" }
%"struct.std::_Tuple_impl.241" = type { %"struct.std::_Head_base.246" }
%"struct.std::_Head_base.246" = type { %"class.llvm::orc::JITDylib"* }
%"class.std::recursive_mutex" = type { %"class.std::__recursive_mutex_base" }
%"class.std::__recursive_mutex_base" = type { %union.pthread_mutex_t }
%"class.std::vector.65" = type { %"struct.std::_Vector_base.66" }
%"struct.std::_Vector_base.66" = type { %"struct.std::_Vector_base<std::pair<llvm::orc::JITDylib *, std::unique_ptr<llvm::orc::MaterializationUnit, std::default_delete<llvm::orc::MaterializationUnit> > >, std::allocator<std::pair<llvm::orc::JITDylib *, std::unique_ptr<llvm::orc::MaterializationUnit, std::default_delete<llvm::orc::MaterializationUnit> > > > >::_Vector_impl" }
%"struct.std::_Vector_base<std::pair<llvm::orc::JITDylib *, std::unique_ptr<llvm::orc::MaterializationUnit, std::default_delete<llvm::orc::MaterializationUnit> > >, std::allocator<std::pair<llvm::orc::JITDylib *, std::unique_ptr<llvm::orc::MaterializationUnit, std::default_delete<llvm::orc::MaterializationUnit> > > > >::_Vector_impl" = type { %"struct.std::pair.70"*, %"struct.std::pair.70"*, %"struct.std::pair.70"* }
%"struct.std::pair.70" = type { %"class.llvm::orc::JITDylib"*, %"class.std::unique_ptr.43" }
%"class.std::shared_ptr.71" = type { %"class.std::__shared_ptr.72" }
%"class.std::__shared_ptr.72" = type { %"class.llvm::orc::SymbolResolver"*, %"class.std::__shared_count" }
%"class.llvm::orc::SymbolResolver" = type { i32 (...)** }
%"class.std::unique_ptr.74" = type { %"class.std::__uniq_ptr_impl.75" }
%"class.std::__uniq_ptr_impl.75" = type { %"class.std::tuple.76" }
%"class.std::tuple.76" = type { %"struct.std::_Tuple_impl.77" }
%"struct.std::_Tuple_impl.77" = type { %"struct.std::_Head_base.82" }
%"struct.std::_Head_base.82" = type { %"class.llvm::TargetMachine"* }
%"class.llvm::TargetMachine" = type { i32 (...)**, %"class.llvm::Target"*, %"class.llvm::DataLayout", %"class.llvm::Triple", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", i32, i32, i32, %"class.std::unique_ptr.104", %"class.std::unique_ptr.113", %"class.std::unique_ptr.122", %"class.std::unique_ptr.131", i8, %"class.llvm::TargetOptions", %"class.llvm::TargetOptions" }
%"class.llvm::Target" = type opaque
%"class.llvm::Triple" = type { %"class.std::__cxx11::basic_string", i32, i32, i32, i32, i32, i32 }
%"class.std::unique_ptr.104" = type { %"class.std::__uniq_ptr_impl.105" }
%"class.std::__uniq_ptr_impl.105" = type { %"class.std::tuple.106" }
%"class.std::tuple.106" = type { %"struct.std::_Tuple_impl.107" }
%"struct.std::_Tuple_impl.107" = type { %"struct.std::_Head_base.112" }
%"struct.std::_Head_base.112" = type { %"class.llvm::MCAsmInfo"* }
%"class.llvm::MCAsmInfo" = type opaque
%"class.std::unique_ptr.113" = type { %"class.std::__uniq_ptr_impl.114" }
%"class.std::__uniq_ptr_impl.114" = type { %"class.std::tuple.115" }
%"class.std::tuple.115" = type { %"struct.std::_Tuple_impl.116" }
%"struct.std::_Tuple_impl.116" = type { %"struct.std::_Head_base.121" }
%"struct.std::_Head_base.121" = type { %"class.llvm::MCRegisterInfo"* }
%"class.llvm::MCRegisterInfo" = type opaque
%"class.std::unique_ptr.122" = type { %"class.std::__uniq_ptr_impl.123" }
%"class.std::__uniq_ptr_impl.123" = type { %"class.std::tuple.124" }
%"class.std::tuple.124" = type { %"struct.std::_Tuple_impl.125" }
%"struct.std::_Tuple_impl.125" = type { %"struct.std::_Head_base.130" }
%"struct.std::_Head_base.130" = type { %"class.llvm::MCInstrInfo"* }
%"class.llvm::MCInstrInfo" = type opaque
%"class.std::unique_ptr.131" = type { %"class.std::__uniq_ptr_impl.132" }
%"class.std::__uniq_ptr_impl.132" = type { %"class.std::tuple.133" }
%"class.std::tuple.133" = type { %"struct.std::_Tuple_impl.134" }
%"struct.std::_Tuple_impl.134" = type { %"struct.std::_Head_base.139" }
%"struct.std::_Head_base.139" = type { %"class.llvm::MCSubtargetInfo"* }
%"class.llvm::MCSubtargetInfo" = type opaque
%"class.llvm::TargetOptions" = type { i16, i32, i8, i32, i8, i32, i16, i32, i32, i32, i32, i32, i32, i32, %"class.llvm::MCTargetOptions" }
%"class.llvm::MCTargetOptions" = type { i16, i32, %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::vector" }
%"class.llvm::DataLayout" = type { i8, i32, i32, i32, i32, %"class.llvm::SmallVector", %"class.llvm::SmallVector.83", %"class.std::__cxx11::basic_string", %"class.llvm::SmallVector.90", i8*, %"class.llvm::SmallVector.97" }
%"class.llvm::SmallVector" = type { %"class.llvm::SmallVectorImpl", %"struct.llvm::SmallVectorStorage" }
%"class.llvm::SmallVectorImpl" = type { %"class.llvm::SmallVectorTemplateBase" }
%"class.llvm::SmallVectorTemplateBase" = type { %"class.llvm::SmallVectorTemplateCommon" }
%"class.llvm::SmallVectorTemplateCommon" = type { %"class.llvm::SmallVectorBase" }
%"class.llvm::SmallVectorBase" = type { i8*, i32, i32 }
%"struct.llvm::SmallVectorStorage" = type { [8 x %"struct.llvm::AlignedCharArrayUnion"] }
%"struct.llvm::AlignedCharArrayUnion" = type { %"struct.llvm::AlignedCharArray" }
%"struct.llvm::AlignedCharArray" = type { [1 x i8] }
%"class.llvm::SmallVector.83" = type { %"class.llvm::SmallVectorImpl.84", %"struct.llvm::SmallVectorStorage.87" }
%"class.llvm::SmallVectorImpl.84" = type { %"class.llvm::SmallVectorTemplateBase.85" }
%"class.llvm::SmallVectorTemplateBase.85" = type { %"class.llvm::SmallVectorTemplateCommon.86" }
%"class.llvm::SmallVectorTemplateCommon.86" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.87" = type { [16 x %"struct.llvm::AlignedCharArrayUnion.88"] }
%"struct.llvm::AlignedCharArrayUnion.88" = type { %"struct.llvm::AlignedCharArray.89" }
%"struct.llvm::AlignedCharArray.89" = type { [8 x i8] }
%"class.llvm::SmallVector.90" = type { %"class.llvm::SmallVectorImpl.91", %"struct.llvm::SmallVectorStorage.94" }
%"class.llvm::SmallVectorImpl.91" = type { %"class.llvm::SmallVectorTemplateBase.92" }
%"class.llvm::SmallVectorTemplateBase.92" = type { %"class.llvm::SmallVectorTemplateCommon.93" }
%"class.llvm::SmallVectorTemplateCommon.93" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.94" = type { [8 x %"struct.llvm::AlignedCharArrayUnion.95"] }
%"struct.llvm::AlignedCharArrayUnion.95" = type { %"struct.llvm::AlignedCharArray.96" }
%"struct.llvm::AlignedCharArray.96" = type { [20 x i8] }
%"class.llvm::SmallVector.97" = type { %"class.llvm::SmallVectorImpl.98", %"struct.llvm::SmallVectorStorage.101" }
%"class.llvm::SmallVectorImpl.98" = type { %"class.llvm::SmallVectorTemplateBase.99" }
%"class.llvm::SmallVectorTemplateBase.99" = type { %"class.llvm::SmallVectorTemplateCommon.100" }
%"class.llvm::SmallVectorTemplateCommon.100" = type { %"class.llvm::SmallVectorBase" }
%"struct.llvm::SmallVectorStorage.101" = type { [8 x %"struct.llvm::AlignedCharArrayUnion.102"] }
%"struct.llvm::AlignedCharArrayUnion.102" = type { %"struct.llvm::AlignedCharArray.103" }
%"struct.llvm::AlignedCharArray.103" = type { [4 x i8] }
%"class.llvm::orc::LegacyRTDyldObjectLinkingLayer" = type <{ %"class.llvm::orc::ExecutionSession"*, %"class.std::function.140", %"class.std::function.146", %"class.std::function.146", %"class.std::function.156", %"class.std::map.159", i8, [7 x i8] }>
%"class.std::function.140" = type { %"class.std::_Function_base", void (%"struct.llvm::orc::LegacyRTDyldObjectLinkingLayer::Resources"*, %"union.std::_Any_data"*, i64*)* }
%"struct.llvm::orc::LegacyRTDyldObjectLinkingLayer::Resources" = type { %"class.std::shared_ptr.143", %"class.std::shared_ptr.71" }
%"class.std::shared_ptr.143" = type { %"class.std::__shared_ptr.144" }
%"class.std::__shared_ptr.144" = type { %"class.llvm::RuntimeDyld::MemoryManager"*, %"class.std::__shared_count" }
%"class.llvm::RuntimeDyld::MemoryManager" = type <{ i32 (...)**, i8, [7 x i8] }>
%"class.std::function.146" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*, i64*, %"class.llvm::object::ObjectFile"*, %"class.llvm::RuntimeDyld::LoadedObjectInfo"*)* }
%"class.llvm::object::ObjectFile" = type { %"class.llvm::object::SymbolicFile" }
%"class.llvm::object::SymbolicFile" = type { %"class.llvm::object::Binary" }
%"class.llvm::object::Binary" = type { i32 (...)**, i32, %"class.llvm::MemoryBufferRef" }
%"class.llvm::MemoryBufferRef" = type { %"class.llvm::StringRef", %"class.llvm::StringRef" }
%"class.llvm::StringRef" = type { i8*, i64 }
%"class.llvm::RuntimeDyld::LoadedObjectInfo" = type { %"class.llvm::LoadedObjectInfo", %"class.llvm::RuntimeDyldImpl"*, %"class.std::map.148" }
%"class.llvm::LoadedObjectInfo" = type { i32 (...)** }
%"class.llvm::RuntimeDyldImpl" = type opaque
%"class.std::map.148" = type { %"class.std::_Rb_tree.149" }
%"class.std::_Rb_tree.149" = type { %"struct.std::_Rb_tree<llvm::object::SectionRef, std::pair<const llvm::object::SectionRef, unsigned int>, std::_Select1st<std::pair<const llvm::object::SectionRef, unsigned int> >, std::less<llvm::object::SectionRef>, std::allocator<std::pair<const llvm::object::SectionRef, unsigned int> > >::_Rb_tree_impl" }
%"struct.std::_Rb_tree<llvm::object::SectionRef, std::pair<const llvm::object::SectionRef, unsigned int>, std::_Select1st<std::pair<const llvm::object::SectionRef, unsigned int> >, std::less<llvm::object::SectionRef>, std::allocator<std::pair<const llvm::object::SectionRef, unsigned int> > >::_Rb_tree_impl" = type { %"struct.std::_Rb_tree_key_compare.153", %"struct.std::_Rb_tree_header" }
%"struct.std::_Rb_tree_key_compare.153" = type { %"struct.std::less.154" }
%"struct.std::less.154" = type { i8 }
%"class.std::function.156" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*, i64*, %"class.llvm::object::ObjectFile"*)* }
%"class.std::map.159" = type { %"class.std::_Rb_tree.160" }
%"class.std::_Rb_tree.160" = type { %"struct.std::_Rb_tree<unsigned long, std::pair<const unsigned long, std::unique_ptr<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject, std::default_delete<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject> > >, std::_Select1st<std::pair<const unsigned long, std::unique_ptr<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject, std::default_delete<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject> > > >, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, std::unique_ptr<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject, std::default_delete<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject> > > > >::_Rb_tree_impl" }
%"struct.std::_Rb_tree<unsigned long, std::pair<const unsigned long, std::unique_ptr<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject, std::default_delete<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject> > >, std::_Select1st<std::pair<const unsigned long, std::unique_ptr<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject, std::default_delete<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject> > > >, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, std::unique_ptr<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject, std::default_delete<llvm::orc::LegacyRTDyldObjectLinkingLayerBase::LinkedObject> > > > >::_Rb_tree_impl" = type { %"struct.std::_Rb_tree_key_compare.164", %"struct.std::_Rb_tree_header" }
%"struct.std::_Rb_tree_key_compare.164" = type { %"struct.std::less.165" }
%"struct.std::less.165" = type { i8 }
%"class.llvm::orc::LegacyIRCompileLayer" = type { %"class.llvm::orc::LegacyRTDyldObjectLinkingLayer"*, %"class.llvm::orc::SimpleCompiler", %"class.std::function.167" }
%"class.llvm::orc::SimpleCompiler" = type { %"class.llvm::TargetMachine"*, %"class.llvm::ObjectCache"* }
%"class.llvm::ObjectCache" = type { i32 (...)** }
%"class.std::function.167" = type { %"class.std::_Function_base", void (%"union.std::_Any_data"*, i64*, %"class.std::unique_ptr.170"*)* }
%"class.std::unique_ptr.170" = type { %"class.std::__uniq_ptr_impl.171" }
%"class.std::__uniq_ptr_impl.171" = type { %"class.std::tuple.172" }
%"class.std::tuple.172" = type { %"struct.std::_Tuple_impl.173" }
%"struct.std::_Tuple_impl.173" = type { %"struct.std::_Head_base.178" }
%"struct.std::_Head_base.178" = type { %"class.llvm::Module"* }
%"class.llvm::Module" = type { %"class.llvm::LLVMContext"*, %"class.llvm::SymbolTableList", %"class.llvm::SymbolTableList.179", %"class.llvm::SymbolTableList.187", %"class.llvm::SymbolTableList.195", %"class.llvm::iplist", %"class.std::__cxx11::basic_string", %"class.llvm::ValueSymbolTable"*, %"class.llvm::StringMap.209", %"class.std::unique_ptr.211", %"class.std::unique_ptr.220", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", i8*, %"class.llvm::DataLayout" }
%"class.llvm::SymbolTableList" = type { %"class.llvm::iplist_impl" }
%"class.llvm::iplist_impl" = type { %"class.llvm::simple_ilist" }
%"class.llvm::simple_ilist" = type { %"class.llvm::ilist_sentinel" }
%"class.llvm::ilist_sentinel" = type { %"class.llvm::ilist_node_impl" }
%"class.llvm::ilist_node_impl" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::ilist_node_base" = type { %"class.llvm::ilist_node_base"*, %"class.llvm::ilist_node_base"* }
%"class.llvm::SymbolTableList.179" = type { %"class.llvm::iplist_impl.180" }
%"class.llvm::iplist_impl.180" = type { %"class.llvm::simple_ilist.183" }
%"class.llvm::simple_ilist.183" = type { %"class.llvm::ilist_sentinel.185" }
%"class.llvm::ilist_sentinel.185" = type { %"class.llvm::ilist_node_impl.186" }
%"class.llvm::ilist_node_impl.186" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::SymbolTableList.187" = type { %"class.llvm::iplist_impl.188" }
%"class.llvm::iplist_impl.188" = type { %"class.llvm::simple_ilist.191" }
%"class.llvm::simple_ilist.191" = type { %"class.llvm::ilist_sentinel.193" }
%"class.llvm::ilist_sentinel.193" = type { %"class.llvm::ilist_node_impl.194" }
%"class.llvm::ilist_node_impl.194" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::SymbolTableList.195" = type { %"class.llvm::iplist_impl.196" }
%"class.llvm::iplist_impl.196" = type { %"class.llvm::simple_ilist.199" }
%"class.llvm::simple_ilist.199" = type { %"class.llvm::ilist_sentinel.201" }
%"class.llvm::ilist_sentinel.201" = type { %"class.llvm::ilist_node_impl.202" }
%"class.llvm::ilist_node_impl.202" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::iplist" = type { %"class.llvm::iplist_impl.203" }
%"class.llvm::iplist_impl.203" = type { %"class.llvm::simple_ilist.205" }
%"class.llvm::simple_ilist.205" = type { %"class.llvm::ilist_sentinel.207" }
%"class.llvm::ilist_sentinel.207" = type { %"class.llvm::ilist_node_impl.208" }
%"class.llvm::ilist_node_impl.208" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::ValueSymbolTable" = type opaque
%"class.llvm::StringMap.209" = type <{ %"class.llvm::StringMapImpl", %"class.llvm::MallocAllocator", [7 x i8] }>
%"class.std::unique_ptr.211" = type { %"class.std::__uniq_ptr_impl.212" }
%"class.std::__uniq_ptr_impl.212" = type { %"class.std::tuple.213" }
%"class.std::tuple.213" = type { %"struct.std::_Tuple_impl.214" }
%"struct.std::_Tuple_impl.214" = type { %"struct.std::_Head_base.219" }
%"struct.std::_Head_base.219" = type { %"class.llvm::MemoryBuffer"* }
%"class.llvm::MemoryBuffer" = type { i32 (...)**, i8*, i8* }
%"class.std::unique_ptr.220" = type { %"class.std::__uniq_ptr_impl.221" }
%"class.std::__uniq_ptr_impl.221" = type { %"class.std::tuple.222" }
%"class.std::tuple.222" = type { %"struct.std::_Tuple_impl.223" }
%"struct.std::_Tuple_impl.223" = type { %"struct.std::_Head_base.228" }
%"struct.std::_Head_base.228" = type { %"class.llvm::GVMaterializer"* }
%"class.llvm::GVMaterializer" = type opaque
%"class.std::vector.229" = type { %"struct.std::_Vector_base.230" }
%"struct.std::_Vector_base.230" = type { %"struct.std::_Vector_base<unsigned long, std::allocator<unsigned long> >::_Vector_impl" }
%"struct.std::_Vector_base<unsigned long, std::allocator<unsigned long> >::_Vector_impl" = type { i64*, i64*, i64* }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%"class.std::vector.234" = type { %"struct.std::_Vector_base.235" }
%"struct.std::_Vector_base.235" = type { %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl" }
%"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl" = type { %"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"* }
%"struct.minou::Cons" = type { %"struct.minou::Atom", %"struct.minou::Cons"* }
%"class.__gnu_cxx::__normal_iterator.298" = type { %"struct.minou::Atom"* }
%"class.std::allocator.236" = type { i8 }
%"class.__gnu_cxx::__normal_iterator" = type { %"struct.minou::Atom"* }
%"struct.minou::HeapNode" = type { i64, [0 x i8] }
%"class.minou::Cons::iterator" = type { %"struct.minou::Cons"* }
%"struct.std::_Rb_tree_const_iterator" = type { %"struct.std::_Rb_tree_node_base"* }
%"class.std::tuple.286" = type { %"struct.std::_Tuple_impl.287" }
%"struct.std::_Tuple_impl.287" = type { %"struct.std::_Head_base.288" }
%"struct.std::_Head_base.288" = type { i32* }
%"class.std::tuple.289" = type { i8 }
%"struct.std::_Rb_tree_node" = type { %"struct.std::_Rb_tree_node_base", %"struct.__gnu_cxx::__aligned_membuf.290" }
%"struct.__gnu_cxx::__aligned_membuf.290" = type { [16 x i8] }
%"struct.std::pair.292" = type { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }
%"struct.std::_Select1st" = type { i8 }
%"class.std::allocator" = type { i8 }
%"class.__gnu_cxx::new_allocator" = type { i8 }
%"struct.std::_Index_tuple" = type { i8 }
%"struct.std::_Index_tuple.295" = type { i8 }
%"class.std::__pair_base.284" = type { i8 }
%"class.std::__pair_base.293" = type { i8 }
%"struct.std::_Enable_copy_move" = type { i8 }
%"struct.std::_Optional_payload<minou::Atom, true, true>::_Empty_byte" = type { i8 }
%"class.std::bad_optional_access" = type { %"class.std::exception" }
%"class.std::exception" = type { i32 (...)** }
%"class.std::scoped_lock" = type { %"class.std::mutex"* }
%"struct.std::_List_iterator" = type { %"struct.std::__detail::_List_node_base"* }
%"struct.std::_List_node.296" = type { %"struct.std::__detail::_List_node_base", %"struct.__gnu_cxx::__aligned_membuf.297" }
%"struct.__gnu_cxx::__aligned_membuf.297" = type { [8 x i8] }
%"class.std::allocator.15" = type { i8 }
%"struct.std::__allocated_ptr" = type { %"class.std::allocator.15"*, %"struct.std::_List_node.296"* }
%"class.__gnu_cxx::new_allocator.16" = type { i8 }
%"class.__gnu_cxx::new_allocator.237" = type { i8 }
%"class.std::move_iterator" = type { %"struct.minou::Atom"* }

$_ZN5minou3Env3setERKNS_6SymbolENS_4AtomE = comdat any

$_ZNK5minou4Atom6symbolEv = comdat any

$_ZN5minou3Env6lookupERKNS_6SymbolE = comdat any

$_ZNKSt8optionalIN5minou4AtomEE9has_valueEv = comdat any

$_ZNRSt8optionalIN5minou4AtomEE5valueEv = comdat any

$_ZN5minou8make_nilEv = comdat any

$_ZNSt6vectorIN5minou4AtomESaIS1_EEC2Ev = comdat any

$_ZNSt6vectorIN5minou4AtomESaIS1_EE9push_backERKS1_ = comdat any

$_ZN5minou9make_consEPKNS_4ConsE = comdat any

$_ZN5minou6Engine10get_memoryEv = comdat any

$_ZN5minou6Memory9make_listERKSt6vectorINS_4AtomESaIS2_EE = comdat any

$_ZNSt6vectorIN5minou4AtomESaIS1_EED2Ev = comdat any

$_ZN5minou12make_booleanEb = comdat any

$_ZN5minou6Memory10alloc_consENS_4AtomEPNS_4ConsE = comdat any

$_ZNK5minou4Atom4consEv = comdat any

$_ZN5minou4Cons4tailEv = comdat any

$_ZNK5minou4Atom6is_nilEv = comdat any

$_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEEixERS5_ = comdat any

$_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE11lower_boundERS5_ = comdat any

$_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEeqERKS5_ = comdat any

$_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE3endEv = comdat any

$_ZNKSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE8key_compEv = comdat any

$_ZNKSt4lessIiEclERKiS2_ = comdat any

$_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEdeEv = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEESt17_Rb_tree_iteratorIS4_ESt23_Rb_tree_const_iteratorIS4_EDpOT_ = comdat any

$_ZNSt23_Rb_tree_const_iteratorISt4pairIKiN5minou4AtomEEEC2ERKSt17_Rb_tree_iteratorIS4_E = comdat any

$_ZNSt5tupleIJRKiEEC2IvLb1EEES1_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11lower_boundERS1_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_lower_boundEPSt13_Rb_tree_nodeIS4_EPSt18_Rb_tree_node_baseRS1_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_M_beginEv = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_M_endEv = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt13_Rb_tree_nodeIS4_E = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE7_S_leftEPSt18_Rb_tree_node_base = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_rightEPSt18_Rb_tree_node_base = comdat any

$_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base = comdat any

$_ZNKSt10_Select1stISt4pairIKiN5minou4AtomEEEclERKS4_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_valueEPKSt13_Rb_tree_nodeIS4_E = comdat any

$_ZNKSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv = comdat any

$_ZNK9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE6_M_ptrEv = comdat any

$_ZNK9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE7_M_addrEv = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE3endEv = comdat any

$_ZNKSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8key_compEv = comdat any

$_ZNSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv = comdat any

$__clang_call_terminate = comdat any

$_ZN9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE6_M_ptrEv = comdat any

$_ZN9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE7_M_addrEv = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_create_nodeIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEEPSt13_Rb_tree_nodeIS4_EDpOT_ = comdat any

$_ZSt7forwardIRKSt21piecewise_construct_tEOT_RNSt16remove_referenceIS3_E4typeE = comdat any

$_ZSt7forwardISt5tupleIJRKiEEEOT_RNSt16remove_referenceIS4_E4typeE = comdat any

$_ZSt7forwardISt5tupleIJEEEOT_RNSt16remove_referenceIS2_E4typeE = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE29_M_get_insert_hint_unique_posESt23_Rb_tree_const_iteratorIS4_ERS1_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_insert_nodeEPSt18_Rb_tree_node_baseSC_PSt13_Rb_tree_nodeIS4_E = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_drop_nodeEPSt13_Rb_tree_nodeIS4_E = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_get_nodeEv = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE17_M_construct_nodeIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEEvPSt13_Rb_tree_nodeIS4_EDpOT_ = comdat any

$_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE8allocateERS7_m = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE21_M_get_Node_allocatorEv = comdat any

$_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE8allocateEmPKv = comdat any

$_ZNK9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE8max_sizeEv = comdat any

$_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE9constructIS5_JRKSt21piecewise_construct_tSt5tupleIJRS2_EESD_IJEEEEEvRS7_PT_DpOT0_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_put_nodeEPSt13_Rb_tree_nodeIS4_E = comdat any

$_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE9constructIS6_JRKSt21piecewise_construct_tSt5tupleIJRS3_EESD_IJEEEEEvPT_DpOT0_ = comdat any

$_ZNSt5tupleIJRKiEEC2EOS2_ = comdat any

$_ZNSt4pairIKiN5minou4AtomEEC2IJRS0_EJEEESt21piecewise_construct_tSt5tupleIJDpT_EES7_IJDpT0_EE = comdat any

$_ZNSt11_Tuple_implILm0EJRKiEEC2EOS2_ = comdat any

$_ZSt7forwardIRKiEOT_RNSt16remove_referenceIS2_E4typeE = comdat any

$_ZNSt11_Tuple_implILm0EJRKiEE7_M_headERS2_ = comdat any

$_ZNSt10_Head_baseILm0ERKiLb0EEC2ES1_ = comdat any

$_ZNSt10_Head_baseILm0ERKiLb0EE7_M_headERS2_ = comdat any

$_ZNSt4pairIKiN5minou4AtomEEC2IJRS0_EJLm0EEJEJEEERSt5tupleIJDpT_EERS6_IJDpT1_EESt12_Index_tupleIJXspT0_EEESF_IJXspT2_EEE = comdat any

$_ZSt3getILm0EJRKiEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS6_ = comdat any

$_ZSt12__get_helperILm0ERKiJEERT0_RSt11_Tuple_implIXT_EJS2_DpT1_EE = comdat any

$_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE10deallocateERS7_PS6_m = comdat any

$_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE10deallocateEPS7_m = comdat any

$_ZNKSt23_Rb_tree_const_iteratorISt4pairIKiN5minou4AtomEEE13_M_const_castEv = comdat any

$_ZNKSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE4sizeEv = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_rightmostEv = comdat any

$_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEERKS1_OT_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE24_M_get_insert_unique_posERS1_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_leftmostEv = comdat any

$_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_S4_Lb1EEEOT_OT0_ = comdat any

$_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEmmEv = comdat any

$_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEppEv = comdat any

$_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEEOT_RKS1_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_valueEPKSt18_Rb_tree_node_base = comdat any

$_ZSt7forwardIRPSt18_Rb_tree_node_baseEOT_RNSt16remove_referenceIS3_E4typeE = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE5beginEv = comdat any

$_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRPSt13_Rb_tree_nodeIS_IKiN5minou4AtomEEERS1_Lb1EEEOT_OT0_ = comdat any

$_ZSt7forwardIRPSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEOT_RNSt16remove_referenceIS9_E4typeE = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE15_M_destroy_nodeEPSt13_Rb_tree_nodeIS4_E = comdat any

$_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE7destroyIS5_EEvRS7_PT_ = comdat any

$_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE7destroyIS6_EEvPT_ = comdat any

$_ZNSt11_Tuple_implILm0EJRKiEEC2ES1_ = comdat any

$_ZNK5minou4Atom8get_typeEv = comdat any

$_ZN5minou6Symbol4fromEi = comdat any

$_ZNK5minou8HeapNode4typeEv = comdat any

$_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE4findERS5_ = comdat any

$_ZNSt8optionalIN5minou4AtomEEC2Ev = comdat any

$_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEptEv = comdat any

$_ZNSt8optionalIN5minou4AtomEEC2IRS1_Lb1EEEOT_ = comdat any

$_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE4findERS1_ = comdat any

$_ZNSt14_Optional_baseIN5minou4AtomEEC2Ev = comdat any

$_ZNSt17_Optional_payloadIN5minou4AtomELb1ELb1EEC2Ev = comdat any

$_ZSt7forwardIRN5minou4AtomEEOT_RNSt16remove_referenceIS3_E4typeE = comdat any

$_ZNSt14_Optional_baseIN5minou4AtomEEC2IJRS1_ELb0EEESt10in_place_tDpOT_ = comdat any

$_ZNSt17_Optional_payloadIN5minou4AtomELb1ELb1EEC2IJRS1_EEESt10in_place_tDpOT_ = comdat any

$_ZNKSt14_Optional_baseIN5minou4AtomEE13_M_is_engagedEv = comdat any

$_ZNSt14_Optional_baseIN5minou4AtomEE6_M_getEv = comdat any

$_ZSt27__throw_bad_optional_accessv = comdat any

$_ZNSt19bad_optional_accessC2Ev = comdat any

$_ZNSt19bad_optional_accessD2Ev = comdat any

$_ZNSt9exceptionC2Ev = comdat any

$_ZNSt19bad_optional_accessD0Ev = comdat any

$_ZNKSt19bad_optional_access4whatEv = comdat any

$_ZNKSt6vectorIN5minou4AtomESaIS1_EE5beginEv = comdat any

$_ZNKSt6vectorIN5minou4AtomESaIS1_EE3endEv = comdat any

$_ZN9__gnu_cxxneIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEEbRKNS_17__normal_iteratorIT_T0_EESD_ = comdat any

$_ZNK9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEdeEv = comdat any

$_ZN9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEppEv = comdat any

$_ZN9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS4_ = comdat any

$_ZNK9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv = comdat any

$_ZN5minou6Memory5allocINS_4ConsEEEPNS_8HeapNodeEv = comdat any

$_ZN5minou8HeapNode8set_typeENS_8AtomTypeE = comdat any

$_ZN5minou8HeapNode8set_sizeEi = comdat any

$_ZN5minou6Memory16add_to_free_listEPNS_8HeapNodeE = comdat any

$_ZNSt11scoped_lockIJSt5mutexEEC2ERS0_ = comdat any

$_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE10push_frontERKS3_ = comdat any

$_ZNSt11scoped_lockIJSt5mutexEED2Ev = comdat any

$_ZNSt5mutex4lockEv = comdat any

$_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE9_M_insertIJRKS3_EEEvSt14_List_iteratorIS3_EDpOT_ = comdat any

$_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE5beginEv = comdat any

$_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE14_M_create_nodeIJRKS3_EEEPSt10_List_nodeIS3_EDpOT_ = comdat any

$_ZSt7forwardIRKPN5minou8HeapNodeEEOT_RNSt16remove_referenceIS5_E4typeE = comdat any

$_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE11_M_inc_sizeEm = comdat any

$_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE11_M_get_nodeEv = comdat any

$_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE21_M_get_Node_allocatorEv = comdat any

$_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEEC2ERS5_PS4_ = comdat any

$_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE9constructIS3_JRKS3_EEEvRS5_PT_DpOT0_ = comdat any

$_ZNSt10_List_nodeIPN5minou8HeapNodeEE9_M_valptrEv = comdat any

$_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEEaSEDn = comdat any

$_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEED2Ev = comdat any

$_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE8allocateERS5_m = comdat any

$_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE8allocateEmPKv = comdat any

$_ZNK9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE8max_sizeEv = comdat any

$_ZSt11__addressofISaISt10_List_nodeIPN5minou8HeapNodeEEEEPT_RS6_ = comdat any

$_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE9constructIS4_JRKS4_EEEvPT_DpOT0_ = comdat any

$_ZN9__gnu_cxx16__aligned_membufIPN5minou8HeapNodeEE6_M_ptrEv = comdat any

$_ZN9__gnu_cxx16__aligned_membufIPN5minou8HeapNodeEE7_M_addrEv = comdat any

$_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE10deallocateERS5_PS4_m = comdat any

$_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE10deallocateEPS5_m = comdat any

$_ZNSt10_List_nodeImE9_M_valptrEv = comdat any

$_ZN9__gnu_cxx16__aligned_membufImE6_M_ptrEv = comdat any

$_ZN9__gnu_cxx16__aligned_membufImE7_M_addrEv = comdat any

$_ZNSt14_List_iteratorIPN5minou8HeapNodeEEC2EPNSt8__detail15_List_node_baseE = comdat any

$_ZNSt5mutex6unlockEv = comdat any

$_ZN5minou4Cons5beginEv = comdat any

$_ZN5minou4Cons3endEv = comdat any

$_ZNK5minou4Cons8iteratorneES1_ = comdat any

$_ZN5minou4Cons8iteratordeEv = comdat any

$_ZN5minou4Cons8iteratorppEv = comdat any

$_ZN5minou4Cons8iteratorC2EPS0_ = comdat any

$_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EEC2Ev = comdat any

$_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE12_Vector_implC2Ev = comdat any

$_ZNSaIN5minou4AtomEEC2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEEC2Ev = comdat any

$_ZSt8_DestroyIPN5minou4AtomES1_EvT_S3_RSaIT0_E = comdat any

$_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv = comdat any

$_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EED2Ev = comdat any

$_ZSt8_DestroyIPN5minou4AtomEEvT_S3_ = comdat any

$_ZNSt12_Destroy_auxILb1EE9__destroyIPN5minou4AtomEEEvT_S5_ = comdat any

$_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE13_M_deallocateEPS1_m = comdat any

$_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE12_Vector_implD2Ev = comdat any

$_ZNSt16allocator_traitsISaIN5minou4AtomEEE10deallocateERS2_PS1_m = comdat any

$_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE10deallocateEPS2_m = comdat any

$_ZNSaIN5minou4AtomEED2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEED2Ev = comdat any

$_ZNSt16allocator_traitsISaIN5minou4AtomEEE9constructIS1_JRKS1_EEEvRS2_PT_DpOT0_ = comdat any

$_ZNSt6vectorIN5minou4AtomESaIS1_EE17_M_realloc_insertIJRKS1_EEEvN9__gnu_cxx17__normal_iteratorIPS1_S3_EEDpOT_ = comdat any

$_ZNSt6vectorIN5minou4AtomESaIS1_EE3endEv = comdat any

$_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE9constructIS2_JRKS2_EEEvPT_DpOT0_ = comdat any

$_ZSt7forwardIRKN5minou4AtomEEOT_RNSt16remove_referenceIS4_E4typeE = comdat any

$_ZNKSt6vectorIN5minou4AtomESaIS1_EE12_M_check_lenEmPKc = comdat any

$_ZN9__gnu_cxxmiIPN5minou4AtomESt6vectorIS2_SaIS2_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSA_SD_ = comdat any

$_ZNSt6vectorIN5minou4AtomESaIS1_EE5beginEv = comdat any

$_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE11_M_allocateEm = comdat any

$_ZSt34__uninitialized_move_if_noexcept_aIPN5minou4AtomES2_SaIS1_EET0_T_S5_S4_RT1_ = comdat any

$_ZNK9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv = comdat any

$_ZNSt16allocator_traitsISaIN5minou4AtomEEE7destroyIS1_EEvRS2_PT_ = comdat any

$_ZNKSt6vectorIN5minou4AtomESaIS1_EE8max_sizeEv = comdat any

$_ZNKSt6vectorIN5minou4AtomESaIS1_EE4sizeEv = comdat any

$_ZSt3maxImERKT_S2_S2_ = comdat any

$_ZNSt16allocator_traitsISaIN5minou4AtomEEE8max_sizeERKS2_ = comdat any

$_ZNKSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv = comdat any

$_ZNK9__gnu_cxx13new_allocatorIN5minou4AtomEE8max_sizeEv = comdat any

$_ZN9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS3_ = comdat any

$_ZNSt16allocator_traitsISaIN5minou4AtomEEE8allocateERS2_m = comdat any

$_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE8allocateEmPKv = comdat any

$_ZSt22__uninitialized_copy_aISt13move_iteratorIPN5minou4AtomEES3_S2_ET0_T_S6_S5_RSaIT1_E = comdat any

$_ZSt32__make_move_if_noexcept_iteratorIN5minou4AtomESt13move_iteratorIPS1_EET0_PT_ = comdat any

$_ZSt18uninitialized_copyISt13move_iteratorIPN5minou4AtomEES3_ET0_T_S6_S5_ = comdat any

$_ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPN5minou4AtomEES5_EET0_T_S8_S7_ = comdat any

$_ZSt4copyISt13move_iteratorIPN5minou4AtomEES3_ET0_T_S6_S5_ = comdat any

$_ZSt14__copy_move_a2ILb1EPN5minou4AtomES2_ET1_T0_S4_S3_ = comdat any

$_ZSt12__miter_baseIPN5minou4AtomEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E = comdat any

$_ZSt13__copy_move_aILb1EPN5minou4AtomES2_ET1_T0_S4_S3_ = comdat any

$_ZSt12__niter_baseIPN5minou4AtomEET_S3_ = comdat any

$_ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIN5minou4AtomEEEPT_PKS5_S8_S6_ = comdat any

$_ZSt12__miter_baseIPN5minou4AtomEET_S3_ = comdat any

$_ZNKSt13move_iteratorIPN5minou4AtomEE4baseEv = comdat any

$_ZNSt13move_iteratorIPN5minou4AtomEEC2ES2_ = comdat any

$_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE7destroyIS2_EEvPT_ = comdat any

$_ZSt19piecewise_construct = comdat any

$_ZSt8in_place = comdat any

$_ZTSSt19bad_optional_access = comdat any

$_ZTISt19bad_optional_access = comdat any

$_ZTVSt19bad_optional_access = comdat any

@_ZN4llvm24DisableABIBreakingChecksE = external global i32, align 4
@_ZN4llvm30VerifyDisableABIBreakingChecksE = weak hidden global i32* @_ZN4llvm24DisableABIBreakingChecksE, align 8
@.str = private unnamed_addr constant [10 x i8] c"count > 1\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"src/builtins.cpp\00", align 1
@__PRETTY_FUNCTION__.builtin_append = private unnamed_addr constant [33 x i8] c"int64_t builtin_append(int, ...)\00", align 1
@_ZSt19piecewise_construct = linkonce_odr constant %"struct.std::piecewise_construct_t" undef, comdat, align 1
@.str.2 = private unnamed_addr constant [31 x i8] c"get_type() == AtomType::Symbol\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"src/types.hpp\00", align 1
@__PRETTY_FUNCTION__._ZNK5minou4Atom6symbolEv = private unnamed_addr constant [42 x i8] c"minou::Symbol minou::Atom::symbol() const\00", align 1
@_ZSt8in_place = linkonce_odr constant %"struct.std::in_place_t" zeroinitializer, comdat, align 1
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTSSt19bad_optional_access = linkonce_odr constant [24 x i8] c"St19bad_optional_access\00", comdat
@_ZTISt9exception = external constant i8*
@_ZTISt19bad_optional_access = linkonce_odr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @_ZTSSt19bad_optional_access, i32 0, i32 0), i8* bitcast (i8** @_ZTISt9exception to i8*) }, comdat
@_ZTVSt19bad_optional_access = linkonce_odr unnamed_addr constant { [5 x i8*] } { [5 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTISt19bad_optional_access to i8*), i8* bitcast (void (%"class.std::bad_optional_access"*)* @_ZNSt19bad_optional_accessD2Ev to i8*), i8* bitcast (void (%"class.std::bad_optional_access"*)* @_ZNSt19bad_optional_accessD0Ev to i8*), i8* bitcast (i8* (%"class.std::bad_optional_access"*)* @_ZNKSt19bad_optional_access4whatEv to i8*)] }, comdat, align 8
@_ZTVSt9exception = external unnamed_addr constant { [5 x i8*] }
@.str.4 = private unnamed_addr constant [20 x i8] c"bad optional access\00", align 1
@.str.5 = private unnamed_addr constant [56 x i8] c"(reinterpret_cast<uintptr_t>(hn->buff) & TAG_MASK) == 0\00", align 1
@.str.6 = private unnamed_addr constant [15 x i8] c"src/memory.hpp\00", align 1
@__PRETTY_FUNCTION__._ZN5minou6Memory5allocINS_4ConsEEEPNS_8HeapNodeEv = private unnamed_addr constant [58 x i8] c"minou::HeapNode *minou::Memory::alloc() [T = minou::Cons]\00", align 1
@_ZZL18__gthread_active_pvE20__gthread_active_ptr = internal constant i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), align 8
@.str.7 = private unnamed_addr constant [29 x i8] c"get_type() == AtomType::Cons\00", align 1
@__PRETTY_FUNCTION__._ZNK5minou4Atom4consEv = private unnamed_addr constant [39 x i8] c"minou::Cons *minou::Atom::cons() const\00", align 1
@.str.8 = private unnamed_addr constant [26 x i8] c"vector::_M_realloc_insert\00", align 1

; Function Attrs: noinline optnone uwtable
define i64 @env_set(%"class.minou::Env"*, i64, i64) #0 {
  %4 = alloca %"struct.minou::Atom", align 8
  %5 = alloca %"struct.minou::Atom", align 8
  %6 = alloca %"class.minou::Env"*, align 8
  %7 = alloca %"struct.minou::Symbol", align 4
  %8 = alloca %"struct.minou::Atom", align 8
  %9 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  store i64 %1, i64* %9, align 8
  %10 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %5, i32 0, i32 0
  store i64 %2, i64* %10, align 8
  store %"class.minou::Env"* %0, %"class.minou::Env"** %6, align 8
  %11 = load %"class.minou::Env"*, %"class.minou::Env"** %6, align 8
  %12 = call i32 @_ZNK5minou4Atom6symbolEv(%"struct.minou::Atom"* %4)
  %13 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %7, i32 0, i32 0
  store i32 %12, i32* %13, align 4
  %14 = bitcast %"struct.minou::Atom"* %8 to i8*
  %15 = bitcast %"struct.minou::Atom"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %14, i8* %15, i64 8, i32 8, i1 false)
  %16 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %8, i32 0, i32 0
  %17 = load i64, i64* %16, align 8
  call void @_ZN5minou3Env3setERKNS_6SymbolENS_4AtomE(%"class.minou::Env"* %11, %"struct.minou::Symbol"* dereferenceable(4) %7, i64 %17)
  %18 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  %19 = load i64, i64* %18, align 8
  ret i64 %19
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN5minou3Env3setERKNS_6SymbolENS_4AtomE(%"class.minou::Env"*, %"struct.minou::Symbol"* dereferenceable(4), i64) #0 comdat align 2 {
  %4 = alloca %"struct.minou::Atom", align 8
  %5 = alloca %"class.minou::Env"*, align 8
  %6 = alloca %"struct.minou::Symbol"*, align 8
  %7 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  store i64 %2, i64* %7, align 8
  store %"class.minou::Env"* %0, %"class.minou::Env"** %5, align 8
  store %"struct.minou::Symbol"* %1, %"struct.minou::Symbol"** %6, align 8
  %8 = load %"class.minou::Env"*, %"class.minou::Env"** %5, align 8
  %9 = getelementptr inbounds %"class.minou::Env", %"class.minou::Env"* %8, i32 0, i32 0
  %10 = load %"struct.minou::Symbol"*, %"struct.minou::Symbol"** %6, align 8
  %11 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %10, i32 0, i32 0
  %12 = call dereferenceable(8) %"struct.minou::Atom"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEEixERS5_(%"class.std::map"* %9, i32* dereferenceable(4) %11)
  %13 = bitcast %"struct.minou::Atom"* %12 to i8*
  %14 = bitcast %"struct.minou::Atom"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* %14, i64 8, i32 8, i1 false)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr i32 @_ZNK5minou4Atom6symbolEv(%"struct.minou::Atom"*) #0 comdat align 2 {
  %2 = alloca %"struct.minou::Symbol", align 4
  %3 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %3, align 8
  %4 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %3, align 8
  %5 = call zeroext i8 @_ZNK5minou4Atom8get_typeEv(%"struct.minou::Atom"* %4)
  %6 = icmp eq i8 %5, 2
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %1
  br label %10

; <label>:8:                                      ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i32 0, i32 0), i32 213, i8* getelementptr inbounds ([42 x i8], [42 x i8]* @__PRETTY_FUNCTION__._ZNK5minou4Atom6symbolEv, i32 0, i32 0)) #7
  unreachable
                                                  ; No predecessors!
  br label %10

; <label>:10:                                     ; preds = %9, %7
  %11 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  %12 = load i64, i64* %11, align 8
  %13 = lshr i64 %12, 3
  %14 = trunc i64 %13 to i32
  %15 = call i32 @_ZN5minou6Symbol4fromEi(i32 %14)
  %16 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %2, i32 0, i32 0
  store i32 %15, i32* %16, align 4
  %17 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %2, i32 0, i32 0
  %18 = load i32, i32* %17, align 4
  ret i32 %18
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: noinline optnone uwtable
define i64 @env_get(%"class.minou::Env"*, i64) #0 {
  %3 = alloca i64, align 8
  %4 = alloca %"struct.minou::Atom", align 8
  %5 = alloca %"class.minou::Env"*, align 8
  %6 = alloca %"class.std::optional", align 8
  %7 = alloca %"struct.minou::Symbol", align 4
  %8 = alloca %"struct.minou::Atom", align 8
  %9 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  store i64 %1, i64* %9, align 8
  store %"class.minou::Env"* %0, %"class.minou::Env"** %5, align 8
  %10 = load %"class.minou::Env"*, %"class.minou::Env"** %5, align 8
  %11 = call i32 @_ZNK5minou4Atom6symbolEv(%"struct.minou::Atom"* %4)
  %12 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %7, i32 0, i32 0
  store i32 %11, i32* %12, align 4
  call void @_ZN5minou3Env6lookupERKNS_6SymbolE(%"class.std::optional"* sret %6, %"class.minou::Env"* %10, %"struct.minou::Symbol"* dereferenceable(4) %7)
  %13 = call zeroext i1 @_ZNKSt8optionalIN5minou4AtomEE9has_valueEv(%"class.std::optional"* %6) #3
  br i1 %13, label %14, label %18

; <label>:14:                                     ; preds = %2
  %15 = call dereferenceable(8) %"struct.minou::Atom"* @_ZNRSt8optionalIN5minou4AtomEE5valueEv(%"class.std::optional"* %6)
  %16 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %15, i32 0, i32 0
  %17 = load i64, i64* %16, align 8
  store i64 %17, i64* %3, align 8
  br label %23

; <label>:18:                                     ; preds = %2
  %19 = call i64 @_ZN5minou8make_nilEv()
  %20 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %8, i32 0, i32 0
  store i64 %19, i64* %20, align 8
  %21 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %8, i32 0, i32 0
  %22 = load i64, i64* %21, align 8
  store i64 %22, i64* %3, align 8
  br label %23

; <label>:23:                                     ; preds = %18, %14
  %24 = load i64, i64* %3, align 8
  ret i64 %24
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN5minou3Env6lookupERKNS_6SymbolE(%"class.std::optional"* noalias sret, %"class.minou::Env"*, %"struct.minou::Symbol"* dereferenceable(4)) #0 comdat align 2 {
  %4 = alloca %"class.minou::Env"*, align 8
  %5 = alloca %"struct.minou::Symbol"*, align 8
  %6 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %7 = alloca %"struct.std::_Rb_tree_iterator", align 8
  store %"class.minou::Env"* %1, %"class.minou::Env"** %4, align 8
  store %"struct.minou::Symbol"* %2, %"struct.minou::Symbol"** %5, align 8
  %8 = load %"class.minou::Env"*, %"class.minou::Env"** %4, align 8
  %9 = getelementptr inbounds %"class.minou::Env", %"class.minou::Env"* %8, i32 0, i32 0
  %10 = load %"struct.minou::Symbol"*, %"struct.minou::Symbol"** %5, align 8
  %11 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %10, i32 0, i32 0
  %12 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE4findERS5_(%"class.std::map"* %9, i32* dereferenceable(4) %11)
  %13 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %6, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %12, %"struct.std::_Rb_tree_node_base"** %13, align 8
  %14 = getelementptr inbounds %"class.minou::Env", %"class.minou::Env"* %8, i32 0, i32 0
  %15 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE3endEv(%"class.std::map"* %14) #3
  %16 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %7, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %15, %"struct.std::_Rb_tree_node_base"** %16, align 8
  %17 = call zeroext i1 @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEeqERKS5_(%"struct.std::_Rb_tree_iterator"* %6, %"struct.std::_Rb_tree_iterator"* dereferenceable(8) %7) #3
  br i1 %17, label %18, label %28

; <label>:18:                                     ; preds = %3
  %19 = getelementptr inbounds %"class.minou::Env", %"class.minou::Env"* %8, i32 0, i32 1
  %20 = load %"class.minou::Env"*, %"class.minou::Env"** %19, align 8
  %21 = icmp ne %"class.minou::Env"* %20, null
  br i1 %21, label %22, label %26

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds %"class.minou::Env", %"class.minou::Env"* %8, i32 0, i32 1
  %24 = load %"class.minou::Env"*, %"class.minou::Env"** %23, align 8
  %25 = load %"struct.minou::Symbol"*, %"struct.minou::Symbol"** %5, align 8
  call void @_ZN5minou3Env6lookupERKNS_6SymbolE(%"class.std::optional"* sret %0, %"class.minou::Env"* %24, %"struct.minou::Symbol"* dereferenceable(4) %25)
  br label %31

; <label>:26:                                     ; preds = %18
  %27 = bitcast %"class.std::optional"* %0 to i8*
  call void @llvm.memset.p0i8.i64(i8* %27, i8 0, i64 16, i32 8, i1 false)
  call void @_ZNSt8optionalIN5minou4AtomEEC2Ev(%"class.std::optional"* %0) #3
  br label %31

; <label>:28:                                     ; preds = %3
  %29 = call %"struct.std::pair.283"* @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEptEv(%"struct.std::_Rb_tree_iterator"* %6) #3
  %30 = getelementptr inbounds %"struct.std::pair.283", %"struct.std::pair.283"* %29, i32 0, i32 1
  call void @_ZNSt8optionalIN5minou4AtomEEC2IRS1_Lb1EEEOT_(%"class.std::optional"* %0, %"struct.minou::Atom"* dereferenceable(8) %30)
  br label %31

; <label>:31:                                     ; preds = %28, %26, %22
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNKSt8optionalIN5minou4AtomEE9has_valueEv(%"class.std::optional"*) #2 comdat align 2 {
  %2 = alloca %"class.std::optional"*, align 8
  store %"class.std::optional"* %0, %"class.std::optional"** %2, align 8
  %3 = load %"class.std::optional"*, %"class.std::optional"** %2, align 8
  %4 = bitcast %"class.std::optional"* %3 to %"class.std::_Optional_base"*
  %5 = call zeroext i1 @_ZNKSt14_Optional_baseIN5minou4AtomEE13_M_is_engagedEv(%"class.std::_Optional_base"* %4) #3
  ret i1 %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"* @_ZNRSt8optionalIN5minou4AtomEE5valueEv(%"class.std::optional"*) #0 comdat align 2 {
  %2 = alloca %"class.std::optional"*, align 8
  store %"class.std::optional"* %0, %"class.std::optional"** %2, align 8
  %3 = load %"class.std::optional"*, %"class.std::optional"** %2, align 8
  %4 = bitcast %"class.std::optional"* %3 to %"class.std::_Optional_base"*
  %5 = call zeroext i1 @_ZNKSt14_Optional_baseIN5minou4AtomEE13_M_is_engagedEv(%"class.std::_Optional_base"* %4) #3
  br i1 %5, label %6, label %9

; <label>:6:                                      ; preds = %1
  %7 = bitcast %"class.std::optional"* %3 to %"class.std::_Optional_base"*
  %8 = call dereferenceable(8) %"struct.minou::Atom"* @_ZNSt14_Optional_baseIN5minou4AtomEE6_M_getEv(%"class.std::_Optional_base"* %7) #3
  br label %13

; <label>:9:                                      ; preds = %1
  call void @_ZSt27__throw_bad_optional_accessv() #14
  unreachable
                                                  ; No predecessors!
  %11 = bitcast %"class.std::optional"* %3 to %"class.std::_Optional_base"*
  %12 = call dereferenceable(8) %"struct.minou::Atom"* @_ZNSt14_Optional_baseIN5minou4AtomEE6_M_getEv(%"class.std::_Optional_base"* %11) #3
  br label %13

; <label>:13:                                     ; preds = %10, %6
  %14 = phi %"struct.minou::Atom"* [ %8, %6 ], [ %12, %10 ]
  ret %"struct.minou::Atom"* %14
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZN5minou8make_nilEv() #2 comdat {
  %1 = alloca %"struct.minou::Atom", align 8
  %2 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %1, i32 0, i32 0
  store i64 3, i64* %2, align 8
  %3 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %1, i32 0, i32 0
  %4 = load i64, i64* %3, align 8
  ret i64 %4
}

; Function Attrs: noinline optnone uwtable
define i64 @make_list(%"class.minou::Engine"*, i64, ...) #0 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.minou::Engine"*, align 8
  %4 = alloca i64, align 8
  %5 = alloca [1 x %struct.__va_list_tag], align 16
  %6 = alloca %"class.std::vector.234", align 8
  %7 = alloca i32, align 4
  %8 = alloca %"struct.minou::Atom", align 8
  %9 = alloca i8*
  %10 = alloca i32
  %11 = alloca %"struct.minou::Atom", align 8
  store %"class.minou::Engine"* %0, %"class.minou::Engine"** %3, align 8
  store i64 %1, i64* %4, align 8
  %12 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %5, i32 0, i32 0
  %13 = bitcast %struct.__va_list_tag* %12 to i8*
  call void @llvm.va_start(i8* %13)
  call void @_ZNSt6vectorIN5minou4AtomESaIS1_EEC2Ev(%"class.std::vector.234"* %6) #3
  store i32 0, i32* %7, align 4
  br label %14

; <label>:14:                                     ; preds = %40, %2
  %15 = load i32, i32* %7, align 4
  %16 = sext i32 %15 to i64
  %17 = load i64, i64* %4, align 8
  %18 = icmp slt i64 %16, %17
  br i1 %18, label %19, label %47

; <label>:19:                                     ; preds = %14
  %20 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %5, i32 0, i32 0
  %21 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %20, i32 0, i32 0
  %22 = load i32, i32* %21, align 16
  %23 = icmp ule i32 %22, 40
  br i1 %23, label %24, label %30

; <label>:24:                                     ; preds = %19
  %25 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %20, i32 0, i32 3
  %26 = load i8*, i8** %25, align 16
  %27 = getelementptr i8, i8* %26, i32 %22
  %28 = bitcast i8* %27 to %"struct.minou::Atom"*
  %29 = add i32 %22, 8
  store i32 %29, i32* %21, align 16
  br label %35

; <label>:30:                                     ; preds = %19
  %31 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %20, i32 0, i32 2
  %32 = load i8*, i8** %31, align 8
  %33 = bitcast i8* %32 to %"struct.minou::Atom"*
  %34 = getelementptr i8, i8* %32, i32 8
  store i8* %34, i8** %31, align 8
  br label %35

; <label>:35:                                     ; preds = %30, %24
  %36 = phi %"struct.minou::Atom"* [ %28, %24 ], [ %33, %30 ]
  %37 = bitcast %"struct.minou::Atom"* %8 to i8*
  %38 = bitcast %"struct.minou::Atom"* %36 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %37, i8* %38, i64 8, i32 8, i1 false)
  invoke void @_ZNSt6vectorIN5minou4AtomESaIS1_EE9push_backERKS1_(%"class.std::vector.234"* %6, %"struct.minou::Atom"* dereferenceable(8) %8)
          to label %39 unwind label %43

; <label>:39:                                     ; preds = %35
  br label %40

; <label>:40:                                     ; preds = %39
  %41 = load i32, i32* %7, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %7, align 4
  br label %14

; <label>:43:                                     ; preds = %54, %52, %47, %35
  %44 = landingpad { i8*, i32 }
          cleanup
  %45 = extractvalue { i8*, i32 } %44, 0
  store i8* %45, i8** %9, align 8
  %46 = extractvalue { i8*, i32 } %44, 1
  store i32 %46, i32* %10, align 4
  call void @_ZNSt6vectorIN5minou4AtomESaIS1_EED2Ev(%"class.std::vector.234"* %6) #3
  br label %60

; <label>:47:                                     ; preds = %14
  %48 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %5, i32 0, i32 0
  %49 = bitcast %struct.__va_list_tag* %48 to i8*
  call void @llvm.va_end(i8* %49)
  %50 = load %"class.minou::Engine"*, %"class.minou::Engine"** %3, align 8
  %51 = invoke dereferenceable(72) %"class.minou::Memory"* @_ZN5minou6Engine10get_memoryEv(%"class.minou::Engine"* %50)
          to label %52 unwind label %43

; <label>:52:                                     ; preds = %47
  %53 = invoke %"struct.minou::Cons"* @_ZN5minou6Memory9make_listERKSt6vectorINS_4AtomESaIS2_EE(%"class.minou::Memory"* %51, %"class.std::vector.234"* dereferenceable(24) %6)
          to label %54 unwind label %43

; <label>:54:                                     ; preds = %52
  %55 = invoke i64 @_ZN5minou9make_consEPKNS_4ConsE(%"struct.minou::Cons"* %53)
          to label %56 unwind label %43

; <label>:56:                                     ; preds = %54
  %57 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %11, i32 0, i32 0
  store i64 %55, i64* %57, align 8
  %58 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %11, i32 0, i32 0
  %59 = load i64, i64* %58, align 8
  call void @_ZNSt6vectorIN5minou4AtomESaIS1_EED2Ev(%"class.std::vector.234"* %6) #3
  ret i64 %59

; <label>:60:                                     ; preds = %43
  %61 = load i8*, i8** %9, align 8
  %62 = load i32, i32* %10, align 4
  %63 = insertvalue { i8*, i32 } undef, i8* %61, 0
  %64 = insertvalue { i8*, i32 } %63, i32 %62, 1
  resume { i8*, i32 } %64
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt6vectorIN5minou4AtomESaIS1_EEC2Ev(%"class.std::vector.234"*) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::vector.234"*, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %2, align 8
  %3 = load %"class.std::vector.234"*, %"class.std::vector.234"** %2, align 8
  %4 = bitcast %"class.std::vector.234"* %3 to %"struct.std::_Vector_base.235"*
  invoke void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EEC2Ev(%"struct.std::_Vector_base.235"* %4)
          to label %5 unwind label %6

; <label>:5:                                      ; preds = %1
  ret void

; <label>:6:                                      ; preds = %1
  %7 = landingpad { i8*, i32 }
          catch i8* null
  %8 = extractvalue { i8*, i32 } %7, 0
  call void @__clang_call_terminate(i8* %8) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt6vectorIN5minou4AtomESaIS1_EE9push_backERKS1_(%"class.std::vector.234"*, %"struct.minou::Atom"* dereferenceable(8)) #0 comdat align 2 {
  %3 = alloca %"class.std::vector.234"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  %5 = alloca %"class.__gnu_cxx::__normal_iterator.298", align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %3, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %4, align 8
  %6 = load %"class.std::vector.234"*, %"class.std::vector.234"** %3, align 8
  %7 = bitcast %"class.std::vector.234"* %6 to %"struct.std::_Vector_base.235"*
  %8 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %7, i32 0, i32 0
  %9 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %8, i32 0, i32 1
  %10 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %9, align 8
  %11 = bitcast %"class.std::vector.234"* %6 to %"struct.std::_Vector_base.235"*
  %12 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %11, i32 0, i32 0
  %13 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %12, i32 0, i32 2
  %14 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %13, align 8
  %15 = icmp ne %"struct.minou::Atom"* %10, %14
  br i1 %15, label %16, label %30

; <label>:16:                                     ; preds = %2
  %17 = bitcast %"class.std::vector.234"* %6 to %"struct.std::_Vector_base.235"*
  %18 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %17, i32 0, i32 0
  %19 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %18 to %"class.std::allocator.236"*
  %20 = bitcast %"class.std::vector.234"* %6 to %"struct.std::_Vector_base.235"*
  %21 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %20, i32 0, i32 0
  %22 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %21, i32 0, i32 1
  %23 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %22, align 8
  %24 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  call void @_ZNSt16allocator_traitsISaIN5minou4AtomEEE9constructIS1_JRKS1_EEEvRS2_PT_DpOT0_(%"class.std::allocator.236"* dereferenceable(1) %19, %"struct.minou::Atom"* %23, %"struct.minou::Atom"* dereferenceable(8) %24)
  %25 = bitcast %"class.std::vector.234"* %6 to %"struct.std::_Vector_base.235"*
  %26 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %25, i32 0, i32 0
  %27 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %26, i32 0, i32 1
  %28 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %27, align 8
  %29 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %28, i32 1
  store %"struct.minou::Atom"* %29, %"struct.minou::Atom"** %27, align 8
  br label %36

; <label>:30:                                     ; preds = %2
  %31 = call %"struct.minou::Atom"* @_ZNSt6vectorIN5minou4AtomESaIS1_EE3endEv(%"class.std::vector.234"* %6) #3
  %32 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %5, i32 0, i32 0
  store %"struct.minou::Atom"* %31, %"struct.minou::Atom"** %32, align 8
  %33 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %34 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %5, i32 0, i32 0
  %35 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %34, align 8
  call void @_ZNSt6vectorIN5minou4AtomESaIS1_EE17_M_realloc_insertIJRKS1_EEEvN9__gnu_cxx17__normal_iteratorIPS1_S3_EEDpOT_(%"class.std::vector.234"* %6, %"struct.minou::Atom"* %35, %"struct.minou::Atom"* dereferenceable(8) %33)
  br label %36

; <label>:36:                                     ; preds = %30, %16
  ret void
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZN5minou9make_consEPKNS_4ConsE(%"struct.minou::Cons"*) #2 comdat {
  %2 = alloca %"struct.minou::Atom", align 8
  %3 = alloca %"struct.minou::Cons"*, align 8
  store %"struct.minou::Cons"* %0, %"struct.minou::Cons"** %3, align 8
  %4 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %3, align 8
  %5 = icmp ne %"struct.minou::Cons"* %4, null
  br i1 %5, label %9, label %6

; <label>:6:                                      ; preds = %1
  %7 = call i64 @_ZN5minou8make_nilEv()
  %8 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %2, i32 0, i32 0
  store i64 %7, i64* %8, align 8
  br label %13

; <label>:9:                                      ; preds = %1
  %10 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %2, i32 0, i32 0
  %11 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %3, align 8
  %12 = ptrtoint %"struct.minou::Cons"* %11 to i64
  store i64 %12, i64* %10, align 8
  br label %13

; <label>:13:                                     ; preds = %9, %6
  %14 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %2, i32 0, i32 0
  %15 = load i64, i64* %14, align 8
  ret i64 %15
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(72) %"class.minou::Memory"* @_ZN5minou6Engine10get_memoryEv(%"class.minou::Engine"*) #2 comdat align 2 {
  %2 = alloca %"class.minou::Engine"*, align 8
  store %"class.minou::Engine"* %0, %"class.minou::Engine"** %2, align 8
  %3 = load %"class.minou::Engine"*, %"class.minou::Engine"** %2, align 8
  %4 = getelementptr inbounds %"class.minou::Engine", %"class.minou::Engine"* %3, i32 0, i32 1
  ret %"class.minou::Memory"* %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Cons"* @_ZN5minou6Memory9make_listERKSt6vectorINS_4AtomESaIS2_EE(%"class.minou::Memory"*, %"class.std::vector.234"* dereferenceable(24)) #0 comdat align 2 {
  %3 = alloca %"class.minou::Memory"*, align 8
  %4 = alloca %"class.std::vector.234"*, align 8
  %5 = alloca %"struct.minou::Cons"*, align 8
  %6 = alloca %"struct.minou::Cons"*, align 8
  %7 = alloca %"class.std::vector.234"*, align 8
  %8 = alloca %"class.__gnu_cxx::__normal_iterator", align 8
  %9 = alloca %"class.__gnu_cxx::__normal_iterator", align 8
  %10 = alloca %"struct.minou::Atom", align 8
  %11 = alloca %"struct.minou::Cons"*, align 8
  %12 = alloca %"struct.minou::Atom", align 8
  store %"class.minou::Memory"* %0, %"class.minou::Memory"** %3, align 8
  store %"class.std::vector.234"* %1, %"class.std::vector.234"** %4, align 8
  %13 = load %"class.minou::Memory"*, %"class.minou::Memory"** %3, align 8
  store %"struct.minou::Cons"* null, %"struct.minou::Cons"** %5, align 8
  store %"struct.minou::Cons"* null, %"struct.minou::Cons"** %6, align 8
  %14 = load %"class.std::vector.234"*, %"class.std::vector.234"** %4, align 8
  store %"class.std::vector.234"* %14, %"class.std::vector.234"** %7, align 8
  %15 = load %"class.std::vector.234"*, %"class.std::vector.234"** %7, align 8
  %16 = call %"struct.minou::Atom"* @_ZNKSt6vectorIN5minou4AtomESaIS1_EE5beginEv(%"class.std::vector.234"* %15) #3
  %17 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %8, i32 0, i32 0
  store %"struct.minou::Atom"* %16, %"struct.minou::Atom"** %17, align 8
  %18 = load %"class.std::vector.234"*, %"class.std::vector.234"** %7, align 8
  %19 = call %"struct.minou::Atom"* @_ZNKSt6vectorIN5minou4AtomESaIS1_EE3endEv(%"class.std::vector.234"* %18) #3
  %20 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %9, i32 0, i32 0
  store %"struct.minou::Atom"* %19, %"struct.minou::Atom"** %20, align 8
  br label %21

; <label>:21:                                     ; preds = %43, %2
  %22 = call zeroext i1 @_ZN9__gnu_cxxneIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEEbRKNS_17__normal_iteratorIT_T0_EESD_(%"class.__gnu_cxx::__normal_iterator"* dereferenceable(8) %8, %"class.__gnu_cxx::__normal_iterator"* dereferenceable(8) %9) #3
  br i1 %22, label %23, label %45

; <label>:23:                                     ; preds = %21
  %24 = call dereferenceable(8) %"struct.minou::Atom"* @_ZNK9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEdeEv(%"class.__gnu_cxx::__normal_iterator"* %8) #3
  %25 = bitcast %"struct.minou::Atom"* %10 to i8*
  %26 = bitcast %"struct.minou::Atom"* %24 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* %26, i64 8, i32 8, i1 false)
  %27 = bitcast %"struct.minou::Atom"* %12 to i8*
  %28 = bitcast %"struct.minou::Atom"* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 8, i32 8, i1 false)
  %29 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %12, i32 0, i32 0
  %30 = load i64, i64* %29, align 8
  %31 = call %"struct.minou::Cons"* @_ZN5minou6Memory10alloc_consENS_4AtomEPNS_4ConsE(%"class.minou::Memory"* %13, i64 %30, %"struct.minou::Cons"* null)
  store %"struct.minou::Cons"* %31, %"struct.minou::Cons"** %11, align 8
  %32 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %5, align 8
  %33 = icmp ne %"struct.minou::Cons"* %32, null
  br i1 %33, label %37, label %34

; <label>:34:                                     ; preds = %23
  %35 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %11, align 8
  store %"struct.minou::Cons"* %35, %"struct.minou::Cons"** %5, align 8
  %36 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %5, align 8
  store %"struct.minou::Cons"* %36, %"struct.minou::Cons"** %6, align 8
  br label %42

; <label>:37:                                     ; preds = %23
  %38 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %11, align 8
  %39 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %5, align 8
  %40 = getelementptr inbounds %"struct.minou::Cons", %"struct.minou::Cons"* %39, i32 0, i32 1
  store %"struct.minou::Cons"* %38, %"struct.minou::Cons"** %40, align 8
  %41 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %11, align 8
  store %"struct.minou::Cons"* %41, %"struct.minou::Cons"** %5, align 8
  br label %42

; <label>:42:                                     ; preds = %37, %34
  br label %43

; <label>:43:                                     ; preds = %42
  %44 = call dereferenceable(8) %"class.__gnu_cxx::__normal_iterator"* @_ZN9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEppEv(%"class.__gnu_cxx::__normal_iterator"* %8) #3
  br label %21

; <label>:45:                                     ; preds = %21
  %46 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %6, align 8
  ret %"struct.minou::Cons"* %46
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt6vectorIN5minou4AtomESaIS1_EED2Ev(%"class.std::vector.234"*) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::vector.234"*, align 8
  %3 = alloca i8*
  %4 = alloca i32
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %2, align 8
  %5 = load %"class.std::vector.234"*, %"class.std::vector.234"** %2, align 8
  %6 = bitcast %"class.std::vector.234"* %5 to %"struct.std::_Vector_base.235"*
  %7 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %6, i32 0, i32 0
  %8 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %7, i32 0, i32 0
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %8, align 8
  %10 = bitcast %"class.std::vector.234"* %5 to %"struct.std::_Vector_base.235"*
  %11 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %10, i32 0, i32 0
  %12 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %11, i32 0, i32 1
  %13 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %12, align 8
  %14 = bitcast %"class.std::vector.234"* %5 to %"struct.std::_Vector_base.235"*
  %15 = call dereferenceable(1) %"class.std::allocator.236"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"* %14) #3
  invoke void @_ZSt8_DestroyIPN5minou4AtomES1_EvT_S3_RSaIT0_E(%"struct.minou::Atom"* %9, %"struct.minou::Atom"* %13, %"class.std::allocator.236"* dereferenceable(1) %15)
          to label %16 unwind label %18

; <label>:16:                                     ; preds = %1
  %17 = bitcast %"class.std::vector.234"* %5 to %"struct.std::_Vector_base.235"*
  call void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EED2Ev(%"struct.std::_Vector_base.235"* %17) #3
  ret void

; <label>:18:                                     ; preds = %1
  %19 = landingpad { i8*, i32 }
          catch i8* null
  %20 = extractvalue { i8*, i32 } %19, 0
  store i8* %20, i8** %3, align 8
  %21 = extractvalue { i8*, i32 } %19, 1
  store i32 %21, i32* %4, align 4
  %22 = bitcast %"class.std::vector.234"* %5 to %"struct.std::_Vector_base.235"*
  call void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EED2Ev(%"struct.std::_Vector_base.235"* %22) #3
  br label %23

; <label>:23:                                     ; preds = %18
  %24 = load i8*, i8** %3, align 8
  call void @__clang_call_terminate(i8* %24) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define i64 @equalsp_ex(i32, ...) #0 {
  %2 = alloca i64, align 8
  %3 = alloca i32, align 4
  %4 = alloca [1 x %struct.__va_list_tag], align 16
  %5 = alloca %"struct.minou::Atom", align 8
  %6 = alloca %"struct.minou::Atom", align 8
  %7 = alloca i32, align 4
  %8 = alloca %"struct.minou::Atom", align 8
  %9 = alloca %"struct.minou::Atom", align 8
  %10 = alloca %"struct.minou::Atom", align 8
  %11 = alloca %"struct.minou::Atom", align 8
  %12 = alloca %"struct.minou::Atom", align 8
  store i32 %0, i32* %3, align 4
  %13 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %4, i32 0, i32 0
  %14 = bitcast %struct.__va_list_tag* %13 to i8*
  call void @llvm.va_start(i8* %14)
  %15 = load i32, i32* %3, align 4
  %16 = icmp sle i32 %15, 0
  br i1 %16, label %17, label %22

; <label>:17:                                     ; preds = %1
  %18 = call i64 @_ZN5minou12make_booleanEb(i1 zeroext false)
  %19 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %5, i32 0, i32 0
  store i64 %18, i64* %19, align 8
  %20 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %5, i32 0, i32 0
  %21 = load i64, i64* %20, align 8
  store i64 %21, i64* %2, align 8
  br label %89

; <label>:22:                                     ; preds = %1
  %23 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %4, i32 0, i32 0
  %24 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 16
  %26 = icmp ule i32 %25, 40
  br i1 %26, label %27, label %33

; <label>:27:                                     ; preds = %22
  %28 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %23, i32 0, i32 3
  %29 = load i8*, i8** %28, align 16
  %30 = getelementptr i8, i8* %29, i32 %25
  %31 = bitcast i8* %30 to %"struct.minou::Atom"*
  %32 = add i32 %25, 8
  store i32 %32, i32* %24, align 16
  br label %38

; <label>:33:                                     ; preds = %22
  %34 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %23, i32 0, i32 2
  %35 = load i8*, i8** %34, align 8
  %36 = bitcast i8* %35 to %"struct.minou::Atom"*
  %37 = getelementptr i8, i8* %35, i32 8
  store i8* %37, i8** %34, align 8
  br label %38

; <label>:38:                                     ; preds = %33, %27
  %39 = phi %"struct.minou::Atom"* [ %31, %27 ], [ %36, %33 ]
  %40 = bitcast %"struct.minou::Atom"* %6 to i8*
  %41 = bitcast %"struct.minou::Atom"* %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %40, i8* %41, i64 8, i32 8, i1 false)
  store i32 1, i32* %7, align 4
  br label %42

; <label>:42:                                     ; preds = %81, %38
  %43 = load i32, i32* %7, align 4
  %44 = load i32, i32* %3, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %84

; <label>:46:                                     ; preds = %42
  %47 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %4, i32 0, i32 0
  %48 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 16
  %50 = icmp ule i32 %49, 40
  br i1 %50, label %51, label %57

; <label>:51:                                     ; preds = %46
  %52 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %47, i32 0, i32 3
  %53 = load i8*, i8** %52, align 16
  %54 = getelementptr i8, i8* %53, i32 %49
  %55 = bitcast i8* %54 to %"struct.minou::Atom"*
  %56 = add i32 %49, 8
  store i32 %56, i32* %48, align 16
  br label %62

; <label>:57:                                     ; preds = %46
  %58 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %47, i32 0, i32 2
  %59 = load i8*, i8** %58, align 8
  %60 = bitcast i8* %59 to %"struct.minou::Atom"*
  %61 = getelementptr i8, i8* %59, i32 8
  store i8* %61, i8** %58, align 8
  br label %62

; <label>:62:                                     ; preds = %57, %51
  %63 = phi %"struct.minou::Atom"* [ %55, %51 ], [ %60, %57 ]
  %64 = bitcast %"struct.minou::Atom"* %8 to i8*
  %65 = bitcast %"struct.minou::Atom"* %63 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %64, i8* %65, i64 8, i32 8, i1 false)
  %66 = bitcast %"struct.minou::Atom"* %9 to i8*
  %67 = bitcast %"struct.minou::Atom"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %66, i8* %67, i64 8, i32 8, i1 false)
  %68 = bitcast %"struct.minou::Atom"* %10 to i8*
  %69 = bitcast %"struct.minou::Atom"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %68, i8* %69, i64 8, i32 8, i1 false)
  %70 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %9, i32 0, i32 0
  %71 = load i64, i64* %70, align 8
  %72 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %10, i32 0, i32 0
  %73 = load i64, i64* %72, align 8
  %74 = call zeroext i1 @_ZN5minou7equalspENS_4AtomES0_(i64 %71, i64 %73)
  br i1 %74, label %80, label %75

; <label>:75:                                     ; preds = %62
  %76 = call i64 @_ZN5minou12make_booleanEb(i1 zeroext false)
  %77 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %11, i32 0, i32 0
  store i64 %76, i64* %77, align 8
  %78 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %11, i32 0, i32 0
  %79 = load i64, i64* %78, align 8
  store i64 %79, i64* %2, align 8
  br label %89

; <label>:80:                                     ; preds = %62
  br label %81

; <label>:81:                                     ; preds = %80
  %82 = load i32, i32* %7, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, i32* %7, align 4
  br label %42

; <label>:84:                                     ; preds = %42
  %85 = call i64 @_ZN5minou12make_booleanEb(i1 zeroext true)
  %86 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %12, i32 0, i32 0
  store i64 %85, i64* %86, align 8
  %87 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %12, i32 0, i32 0
  %88 = load i64, i64* %87, align 8
  store i64 %88, i64* %2, align 8
  br label %89

; <label>:89:                                     ; preds = %84, %75, %17
  %90 = load i64, i64* %2, align 8
  ret i64 %90
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZN5minou12make_booleanEb(i1 zeroext) #2 comdat {
  %2 = alloca %"struct.minou::Atom", align 8
  %3 = alloca i8, align 1
  %4 = zext i1 %0 to i8
  store i8 %4, i8* %3, align 1
  %5 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %2, i32 0, i32 0
  %6 = load i8, i8* %3, align 1
  %7 = trunc i8 %6 to i1
  %8 = zext i1 %7 to i64
  %9 = shl i64 %8, 3
  %10 = or i64 2, %9
  store i64 %10, i64* %5, align 8
  %11 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %2, i32 0, i32 0
  %12 = load i64, i64* %11, align 8
  ret i64 %12
}

declare zeroext i1 @_ZN5minou7equalspENS_4AtomES0_(i64, i64) #4

; Function Attrs: noinline optnone uwtable
define i64 @builtin_cons(%"class.minou::Engine"*, i64, i64) #0 {
  %4 = alloca %"struct.minou::Atom", align 8
  %5 = alloca %"struct.minou::Atom", align 8
  %6 = alloca %"class.minou::Engine"*, align 8
  %7 = alloca %"struct.minou::Atom", align 8
  %8 = alloca %"struct.minou::Atom", align 8
  %9 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  store i64 %1, i64* %9, align 8
  %10 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %5, i32 0, i32 0
  store i64 %2, i64* %10, align 8
  store %"class.minou::Engine"* %0, %"class.minou::Engine"** %6, align 8
  %11 = load %"class.minou::Engine"*, %"class.minou::Engine"** %6, align 8
  %12 = call dereferenceable(72) %"class.minou::Memory"* @_ZN5minou6Engine10get_memoryEv(%"class.minou::Engine"* %11)
  %13 = bitcast %"struct.minou::Atom"* %8 to i8*
  %14 = bitcast %"struct.minou::Atom"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* %14, i64 8, i32 8, i1 false)
  %15 = call %"struct.minou::Cons"* @_ZNK5minou4Atom4consEv(%"struct.minou::Atom"* %5)
  %16 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %8, i32 0, i32 0
  %17 = load i64, i64* %16, align 8
  %18 = call %"struct.minou::Cons"* @_ZN5minou6Memory10alloc_consENS_4AtomEPNS_4ConsE(%"class.minou::Memory"* %12, i64 %17, %"struct.minou::Cons"* %15)
  %19 = call i64 @_ZN5minou9make_consEPKNS_4ConsE(%"struct.minou::Cons"* %18)
  %20 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %7, i32 0, i32 0
  store i64 %19, i64* %20, align 8
  %21 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %7, i32 0, i32 0
  %22 = load i64, i64* %21, align 8
  ret i64 %22
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Cons"* @_ZN5minou6Memory10alloc_consENS_4AtomEPNS_4ConsE(%"class.minou::Memory"*, i64, %"struct.minou::Cons"*) #0 comdat align 2 {
  %4 = alloca %"struct.minou::Atom", align 8
  %5 = alloca %"class.minou::Memory"*, align 8
  %6 = alloca %"struct.minou::Cons"*, align 8
  %7 = alloca %"struct.minou::HeapNode"*, align 8
  %8 = alloca %"struct.minou::Cons"*, align 8
  %9 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  store i64 %1, i64* %9, align 8
  store %"class.minou::Memory"* %0, %"class.minou::Memory"** %5, align 8
  store %"struct.minou::Cons"* %2, %"struct.minou::Cons"** %6, align 8
  %10 = load %"class.minou::Memory"*, %"class.minou::Memory"** %5, align 8
  %11 = call %"struct.minou::HeapNode"* @_ZN5minou6Memory5allocINS_4ConsEEEPNS_8HeapNodeEv(%"class.minou::Memory"* %10)
  store %"struct.minou::HeapNode"* %11, %"struct.minou::HeapNode"** %7, align 8
  %12 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %7, align 8
  %13 = getelementptr inbounds %"struct.minou::HeapNode", %"struct.minou::HeapNode"* %12, i32 0, i32 1
  %14 = getelementptr inbounds [0 x i8], [0 x i8]* %13, i32 0, i32 0
  %15 = bitcast i8* %14 to %"struct.minou::Cons"*
  store %"struct.minou::Cons"* %15, %"struct.minou::Cons"** %8, align 8
  %16 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %8, align 8
  %17 = getelementptr inbounds %"struct.minou::Cons", %"struct.minou::Cons"* %16, i32 0, i32 0
  %18 = bitcast %"struct.minou::Atom"* %17 to i8*
  %19 = bitcast %"struct.minou::Atom"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 8, i32 8, i1 false)
  %20 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %6, align 8
  %21 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %8, align 8
  %22 = getelementptr inbounds %"struct.minou::Cons", %"struct.minou::Cons"* %21, i32 0, i32 1
  store %"struct.minou::Cons"* %20, %"struct.minou::Cons"** %22, align 8
  %23 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %7, align 8
  call void @_ZN5minou8HeapNode8set_typeENS_8AtomTypeE(%"struct.minou::HeapNode"* %23, i8 zeroext 1)
  %24 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %8, align 8
  ret %"struct.minou::Cons"* %24
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Cons"* @_ZNK5minou4Atom4consEv(%"struct.minou::Atom"*) #0 comdat align 2 {
  %2 = alloca %"struct.minou::Cons"*, align 8
  %3 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %3, align 8
  %4 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %3, align 8
  %5 = call zeroext i8 @_ZNK5minou4Atom8get_typeEv(%"struct.minou::Atom"* %4)
  %6 = icmp eq i8 %5, 4
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %1
  store %"struct.minou::Cons"* null, %"struct.minou::Cons"** %2, align 8
  br label %18

; <label>:8:                                      ; preds = %1
  %9 = call zeroext i8 @_ZNK5minou4Atom8get_typeEv(%"struct.minou::Atom"* %4)
  %10 = icmp eq i8 %9, 1
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %8
  br label %14

; <label>:12:                                     ; preds = %8
  call void @__assert_fail(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.7, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i32 0, i32 0), i32 200, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__PRETTY_FUNCTION__._ZNK5minou4Atom4consEv, i32 0, i32 0)) #7
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:14:                                     ; preds = %13, %11
  %15 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  %16 = load i64, i64* %15, align 8
  %17 = inttoptr i64 %16 to %"struct.minou::Cons"*
  store %"struct.minou::Cons"* %17, %"struct.minou::Cons"** %2, align 8
  br label %18

; <label>:18:                                     ; preds = %14, %7
  %19 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %2, align 8
  ret %"struct.minou::Cons"* %19
}

; Function Attrs: noinline optnone uwtable
define i64 @builtin_append(i32, ...) #0 {
  %2 = alloca i32, align 4
  %3 = alloca [1 x %struct.__va_list_tag], align 16
  %4 = alloca %"struct.minou::Cons"*, align 8
  %5 = alloca %"struct.minou::Cons"*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %"struct.minou::Atom", align 8
  store i32 %0, i32* %2, align 4
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %9 = bitcast %struct.__va_list_tag* %8 to i8*
  call void @llvm.va_start(i8* %9)
  %10 = load i32, i32* %2, align 4
  %11 = icmp sgt i32 %10, 1
  br i1 %11, label %12, label %13

; <label>:12:                                     ; preds = %1
  br label %15

; <label>:13:                                     ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 67, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @__PRETTY_FUNCTION__.builtin_append, i32 0, i32 0)) #7
  unreachable
                                                  ; No predecessors!
  br label %15

; <label>:15:                                     ; preds = %14, %12
  %16 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %17 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 16
  %19 = icmp ule i32 %18, 40
  br i1 %19, label %20, label %26

; <label>:20:                                     ; preds = %15
  %21 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %16, i32 0, i32 3
  %22 = load i8*, i8** %21, align 16
  %23 = getelementptr i8, i8* %22, i32 %18
  %24 = bitcast i8* %23 to %"struct.minou::Cons"**
  %25 = add i32 %18, 8
  store i32 %25, i32* %17, align 16
  br label %31

; <label>:26:                                     ; preds = %15
  %27 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %16, i32 0, i32 2
  %28 = load i8*, i8** %27, align 8
  %29 = bitcast i8* %28 to %"struct.minou::Cons"**
  %30 = getelementptr i8, i8* %28, i32 8
  store i8* %30, i8** %27, align 8
  br label %31

; <label>:31:                                     ; preds = %26, %20
  %32 = phi %"struct.minou::Cons"** [ %24, %20 ], [ %29, %26 ]
  %33 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %32, align 8
  store %"struct.minou::Cons"* %33, %"struct.minou::Cons"** %4, align 8
  %34 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %4, align 8
  %35 = call %"struct.minou::Cons"* @_ZN5minou4Cons4tailEv(%"struct.minou::Cons"* %34)
  store %"struct.minou::Cons"* %35, %"struct.minou::Cons"** %5, align 8
  store i32 1, i32* %6, align 4
  br label %36

; <label>:36:                                     ; preds = %68, %31
  %37 = load i32, i32* %6, align 4
  %38 = load i32, i32* %2, align 4
  %39 = icmp slt i32 %37, %38
  br i1 %39, label %40, label %71

; <label>:40:                                     ; preds = %36
  %41 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %42 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %41, i32 0, i32 0
  %43 = load i32, i32* %42, align 16
  %44 = icmp ule i32 %43, 40
  br i1 %44, label %45, label %51

; <label>:45:                                     ; preds = %40
  %46 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %41, i32 0, i32 3
  %47 = load i8*, i8** %46, align 16
  %48 = getelementptr i8, i8* %47, i32 %43
  %49 = bitcast i8* %48 to %"struct.minou::Atom"*
  %50 = add i32 %43, 8
  store i32 %50, i32* %42, align 16
  br label %56

; <label>:51:                                     ; preds = %40
  %52 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %41, i32 0, i32 2
  %53 = load i8*, i8** %52, align 8
  %54 = bitcast i8* %53 to %"struct.minou::Atom"*
  %55 = getelementptr i8, i8* %53, i32 8
  store i8* %55, i8** %52, align 8
  br label %56

; <label>:56:                                     ; preds = %51, %45
  %57 = phi %"struct.minou::Atom"* [ %49, %45 ], [ %54, %51 ]
  %58 = bitcast %"struct.minou::Atom"* %7 to i8*
  %59 = bitcast %"struct.minou::Atom"* %57 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %58, i8* %59, i64 8, i32 8, i1 false)
  %60 = call %"struct.minou::Cons"* @_ZNK5minou4Atom4consEv(%"struct.minou::Atom"* %7)
  %61 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %5, align 8
  %62 = getelementptr inbounds %"struct.minou::Cons", %"struct.minou::Cons"* %61, i32 0, i32 1
  store %"struct.minou::Cons"* %60, %"struct.minou::Cons"** %62, align 8
  %63 = call zeroext i1 @_ZNK5minou4Atom6is_nilEv(%"struct.minou::Atom"* %7)
  br i1 %63, label %64, label %65

; <label>:64:                                     ; preds = %56
  br label %71

; <label>:65:                                     ; preds = %56
  %66 = call %"struct.minou::Cons"* @_ZNK5minou4Atom4consEv(%"struct.minou::Atom"* %7)
  %67 = call %"struct.minou::Cons"* @_ZN5minou4Cons4tailEv(%"struct.minou::Cons"* %66)
  store %"struct.minou::Cons"* %67, %"struct.minou::Cons"** %5, align 8
  br label %68

; <label>:68:                                     ; preds = %65
  %69 = load i32, i32* %6, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, i32* %6, align 4
  br label %36

; <label>:71:                                     ; preds = %64, %36
  %72 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %4, align 8
  %73 = ptrtoint %"struct.minou::Cons"* %72 to i64
  ret i64 %73
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #5

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Cons"* @_ZN5minou4Cons4tailEv(%"struct.minou::Cons"*) #0 comdat align 2 {
  %2 = alloca %"struct.minou::Cons"*, align 8
  %3 = alloca %"struct.minou::Cons"*, align 8
  %4 = alloca %"struct.minou::Cons"*, align 8
  %5 = alloca %"class.minou::Cons::iterator", align 8
  %6 = alloca %"class.minou::Cons::iterator", align 8
  %7 = alloca %"class.minou::Cons::iterator", align 8
  %8 = alloca %"struct.minou::Cons"*, align 8
  store %"struct.minou::Cons"* %0, %"struct.minou::Cons"** %3, align 8
  %9 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %3, align 8
  store %"struct.minou::Cons"* %9, %"struct.minou::Cons"** %4, align 8
  %10 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %4, align 8
  %11 = call %"struct.minou::Cons"* @_ZN5minou4Cons5beginEv(%"struct.minou::Cons"* %10)
  %12 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %5, i32 0, i32 0
  store %"struct.minou::Cons"* %11, %"struct.minou::Cons"** %12, align 8
  %13 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %4, align 8
  %14 = call %"struct.minou::Cons"* @_ZN5minou4Cons3endEv(%"struct.minou::Cons"* %13)
  %15 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %6, i32 0, i32 0
  store %"struct.minou::Cons"* %14, %"struct.minou::Cons"** %15, align 8
  br label %16

; <label>:16:                                     ; preds = %31, %1
  %17 = bitcast %"class.minou::Cons::iterator"* %7 to i8*
  %18 = bitcast %"class.minou::Cons::iterator"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %17, i8* %18, i64 8, i32 8, i1 false)
  %19 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %7, i32 0, i32 0
  %20 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %19, align 8
  %21 = call zeroext i1 @_ZNK5minou4Cons8iteratorneES1_(%"class.minou::Cons::iterator"* %5, %"struct.minou::Cons"* %20)
  br i1 %21, label %22, label %33

; <label>:22:                                     ; preds = %16
  %23 = call %"struct.minou::Cons"* @_ZN5minou4Cons8iteratordeEv(%"class.minou::Cons::iterator"* %5)
  store %"struct.minou::Cons"* %23, %"struct.minou::Cons"** %8, align 8
  %24 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %8, align 8
  %25 = getelementptr inbounds %"struct.minou::Cons", %"struct.minou::Cons"* %24, i32 0, i32 1
  %26 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %25, align 8
  %27 = icmp ne %"struct.minou::Cons"* %26, null
  br i1 %27, label %30, label %28

; <label>:28:                                     ; preds = %22
  %29 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %8, align 8
  store %"struct.minou::Cons"* %29, %"struct.minou::Cons"** %2, align 8
  br label %34

; <label>:30:                                     ; preds = %22
  br label %31

; <label>:31:                                     ; preds = %30
  %32 = call dereferenceable(8) %"class.minou::Cons::iterator"* @_ZN5minou4Cons8iteratorppEv(%"class.minou::Cons::iterator"* %5)
  br label %16

; <label>:33:                                     ; preds = %16
  store %"struct.minou::Cons"* %9, %"struct.minou::Cons"** %2, align 8
  br label %34

; <label>:34:                                     ; preds = %33, %28
  %35 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %2, align 8
  ret %"struct.minou::Cons"* %35
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i1 @_ZNK5minou4Atom6is_nilEv(%"struct.minou::Atom"*) #0 comdat align 2 {
  %2 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %2, align 8
  %3 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %2, align 8
  %4 = call zeroext i8 @_ZNK5minou4Atom8get_typeEv(%"struct.minou::Atom"* %3)
  %5 = icmp eq i8 %4, 4
  ret i1 %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEEixERS5_(%"class.std::map"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %3 = alloca %"class.std::map"*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %6 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %7 = alloca %"struct.std::less", align 1
  %8 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %9 = alloca %"struct.std::_Rb_tree_const_iterator", align 8
  %10 = alloca %"class.std::tuple.286", align 8
  %11 = alloca %"class.std::tuple.289", align 1
  store %"class.std::map"* %0, %"class.std::map"** %3, align 8
  store i32* %1, i32** %4, align 8
  %12 = load %"class.std::map"*, %"class.std::map"** %3, align 8
  %13 = load i32*, i32** %4, align 8
  %14 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE11lower_boundERS5_(%"class.std::map"* %12, i32* dereferenceable(4) %13)
  %15 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %5, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %14, %"struct.std::_Rb_tree_node_base"** %15, align 8
  %16 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE3endEv(%"class.std::map"* %12) #3
  %17 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %6, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %16, %"struct.std::_Rb_tree_node_base"** %17, align 8
  %18 = call zeroext i1 @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEeqERKS5_(%"struct.std::_Rb_tree_iterator"* %5, %"struct.std::_Rb_tree_iterator"* dereferenceable(8) %6) #3
  br i1 %18, label %24, label %19

; <label>:19:                                     ; preds = %2
  call void @_ZNKSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE8key_compEv(%"class.std::map"* %12)
  %20 = load i32*, i32** %4, align 8
  %21 = call dereferenceable(16) %"struct.std::pair.283"* @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEdeEv(%"struct.std::_Rb_tree_iterator"* %5) #3
  %22 = getelementptr inbounds %"struct.std::pair.283", %"struct.std::pair.283"* %21, i32 0, i32 0
  %23 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %7, i32* dereferenceable(4) %20, i32* dereferenceable(4) %22)
  br label %24

; <label>:24:                                     ; preds = %19, %2
  %25 = phi i1 [ true, %2 ], [ %23, %19 ]
  br i1 %25, label %26, label %35

; <label>:26:                                     ; preds = %24
  %27 = getelementptr inbounds %"class.std::map", %"class.std::map"* %12, i32 0, i32 0
  call void @_ZNSt23_Rb_tree_const_iteratorISt4pairIKiN5minou4AtomEEEC2ERKSt17_Rb_tree_iteratorIS4_E(%"struct.std::_Rb_tree_const_iterator"* %9, %"struct.std::_Rb_tree_iterator"* dereferenceable(8) %5) #3
  %28 = load i32*, i32** %4, align 8
  call void @_ZNSt5tupleIJRKiEEC2IvLb1EEES1_(%"class.std::tuple.286"* %10, i32* dereferenceable(4) %28)
  %29 = getelementptr inbounds %"struct.std::_Rb_tree_const_iterator", %"struct.std::_Rb_tree_const_iterator"* %9, i32 0, i32 0
  %30 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %29, align 8
  %31 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEESt17_Rb_tree_iteratorIS4_ESt23_Rb_tree_const_iteratorIS4_EDpOT_(%"class.std::_Rb_tree"* %27, %"struct.std::_Rb_tree_node_base"* %30, %"struct.std::piecewise_construct_t"* dereferenceable(1) @_ZSt19piecewise_construct, %"class.std::tuple.286"* dereferenceable(8) %10, %"class.std::tuple.289"* dereferenceable(1) %11)
  %32 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %31, %"struct.std::_Rb_tree_node_base"** %32, align 8
  %33 = bitcast %"struct.std::_Rb_tree_iterator"* %5 to i8*
  %34 = bitcast %"struct.std::_Rb_tree_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %33, i8* %34, i64 8, i32 8, i1 false)
  br label %35

; <label>:35:                                     ; preds = %26, %24
  %36 = call dereferenceable(16) %"struct.std::pair.283"* @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEdeEv(%"struct.std::_Rb_tree_iterator"* %5) #3
  %37 = getelementptr inbounds %"struct.std::pair.283", %"struct.std::pair.283"* %36, i32 0, i32 1
  ret %"struct.minou::Atom"* %37
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE11lower_boundERS5_(%"class.std::map"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %3 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %4 = alloca %"class.std::map"*, align 8
  %5 = alloca i32*, align 8
  store %"class.std::map"* %0, %"class.std::map"** %4, align 8
  store i32* %1, i32** %5, align 8
  %6 = load %"class.std::map"*, %"class.std::map"** %4, align 8
  %7 = getelementptr inbounds %"class.std::map", %"class.std::map"* %6, i32 0, i32 0
  %8 = load i32*, i32** %5, align 8
  %9 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11lower_boundERS1_(%"class.std::_Rb_tree"* %7, i32* dereferenceable(4) %8)
  %10 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %9, %"struct.std::_Rb_tree_node_base"** %10, align 8
  %11 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %12 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %11, align 8
  ret %"struct.std::_Rb_tree_node_base"* %12
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEeqERKS5_(%"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"* dereferenceable(8)) #2 comdat align 2 {
  %3 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  %4 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  store %"struct.std::_Rb_tree_iterator"* %0, %"struct.std::_Rb_tree_iterator"** %3, align 8
  store %"struct.std::_Rb_tree_iterator"* %1, %"struct.std::_Rb_tree_iterator"** %4, align 8
  %5 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %5, i32 0, i32 0
  %7 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %6, align 8
  %8 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %4, align 8
  %9 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %10 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %9, align 8
  %11 = icmp eq %"struct.std::_Rb_tree_node_base"* %7, %10
  ret i1 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE3endEv(%"class.std::map"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %3 = alloca %"class.std::map"*, align 8
  store %"class.std::map"* %0, %"class.std::map"** %3, align 8
  %4 = load %"class.std::map"*, %"class.std::map"** %3, align 8
  %5 = getelementptr inbounds %"class.std::map", %"class.std::map"* %4, i32 0, i32 0
  %6 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE3endEv(%"class.std::_Rb_tree"* %5) #3
  %7 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %2, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %6, %"struct.std::_Rb_tree_node_base"** %7, align 8
  %8 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %2, i32 0, i32 0
  %9 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %8, align 8
  ret %"struct.std::_Rb_tree_node_base"* %9
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNKSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE8key_compEv(%"class.std::map"*) #0 comdat align 2 {
  %2 = alloca %"struct.std::less", align 1
  %3 = alloca %"class.std::map"*, align 8
  %4 = alloca %"struct.std::less", align 1
  store %"class.std::map"* %0, %"class.std::map"** %3, align 8
  %5 = load %"class.std::map"*, %"class.std::map"** %3, align 8
  %6 = getelementptr inbounds %"class.std::map", %"class.std::map"* %5, i32 0, i32 0
  call void @_ZNKSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8key_compEv(%"class.std::_Rb_tree"* %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"*, i32* dereferenceable(4), i32* dereferenceable(4)) #2 comdat align 2 {
  %4 = alloca %"struct.std::less"*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  store %"struct.std::less"* %0, %"struct.std::less"** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32* %2, i32** %6, align 8
  %7 = load %"struct.std::less"*, %"struct.std::less"** %4, align 8
  %8 = load i32*, i32** %5, align 8
  %9 = load i32, i32* %8, align 4
  %10 = load i32*, i32** %6, align 8
  %11 = load i32, i32* %10, align 4
  %12 = icmp slt i32 %9, %11
  ret i1 %12
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(16) %"struct.std::pair.283"* @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEdeEv(%"struct.std::_Rb_tree_iterator"*) #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  store %"struct.std::_Rb_tree_iterator"* %0, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %5 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %4, align 8
  %6 = bitcast %"struct.std::_Rb_tree_node_base"* %5 to %"struct.std::_Rb_tree_node"*
  %7 = invoke %"struct.std::pair.283"* @_ZNSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %6)
          to label %8 unwind label %9

; <label>:8:                                      ; preds = %1
  ret %"struct.std::pair.283"* %7

; <label>:9:                                      ; preds = %1
  %10 = landingpad { i8*, i32 }
          catch i8* null
  %11 = extractvalue { i8*, i32 } %10, 0
  call void @__clang_call_terminate(i8* %11) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEESt17_Rb_tree_iteratorIS4_ESt23_Rb_tree_const_iteratorIS4_EDpOT_(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node_base"*, %"struct.std::piecewise_construct_t"* dereferenceable(1), %"class.std::tuple.286"* dereferenceable(8), %"class.std::tuple.289"* dereferenceable(1)) #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %6 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %7 = alloca %"struct.std::_Rb_tree_const_iterator", align 8
  %8 = alloca %"class.std::_Rb_tree"*, align 8
  %9 = alloca %"struct.std::piecewise_construct_t"*, align 8
  %10 = alloca %"class.std::tuple.286"*, align 8
  %11 = alloca %"class.std::tuple.289"*, align 8
  %12 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %13 = alloca %"struct.std::pair.292", align 8
  %14 = alloca %"struct.std::_Rb_tree_const_iterator", align 8
  %15 = alloca i8*
  %16 = alloca i32
  %17 = getelementptr inbounds %"struct.std::_Rb_tree_const_iterator", %"struct.std::_Rb_tree_const_iterator"* %7, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %1, %"struct.std::_Rb_tree_node_base"** %17, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %8, align 8
  store %"struct.std::piecewise_construct_t"* %2, %"struct.std::piecewise_construct_t"** %9, align 8
  store %"class.std::tuple.286"* %3, %"class.std::tuple.286"** %10, align 8
  store %"class.std::tuple.289"* %4, %"class.std::tuple.289"** %11, align 8
  %18 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %8, align 8
  %19 = load %"struct.std::piecewise_construct_t"*, %"struct.std::piecewise_construct_t"** %9, align 8
  %20 = call dereferenceable(1) %"struct.std::piecewise_construct_t"* @_ZSt7forwardIRKSt21piecewise_construct_tEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::piecewise_construct_t"* dereferenceable(1) %19) #3
  %21 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %10, align 8
  %22 = call dereferenceable(8) %"class.std::tuple.286"* @_ZSt7forwardISt5tupleIJRKiEEEOT_RNSt16remove_referenceIS4_E4typeE(%"class.std::tuple.286"* dereferenceable(8) %21) #3
  %23 = load %"class.std::tuple.289"*, %"class.std::tuple.289"** %11, align 8
  %24 = call dereferenceable(1) %"class.std::tuple.289"* @_ZSt7forwardISt5tupleIJEEEOT_RNSt16remove_referenceIS2_E4typeE(%"class.std::tuple.289"* dereferenceable(1) %23) #3
  %25 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_create_nodeIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEEPSt13_Rb_tree_nodeIS4_EDpOT_(%"class.std::_Rb_tree"* %18, %"struct.std::piecewise_construct_t"* dereferenceable(1) %20, %"class.std::tuple.286"* dereferenceable(8) %22, %"class.std::tuple.289"* dereferenceable(1) %24)
  store %"struct.std::_Rb_tree_node"* %25, %"struct.std::_Rb_tree_node"** %12, align 8
  %26 = bitcast %"struct.std::_Rb_tree_const_iterator"* %14 to i8*
  %27 = bitcast %"struct.std::_Rb_tree_const_iterator"* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %26, i8* %27, i64 8, i32 8, i1 false)
  %28 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %12, align 8
  %29 = invoke dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt13_Rb_tree_nodeIS4_E(%"struct.std::_Rb_tree_node"* %28)
          to label %30 unwind label %52

; <label>:30:                                     ; preds = %5
  %31 = getelementptr inbounds %"struct.std::_Rb_tree_const_iterator", %"struct.std::_Rb_tree_const_iterator"* %14, i32 0, i32 0
  %32 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %31, align 8
  %33 = invoke { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE29_M_get_insert_hint_unique_posESt23_Rb_tree_const_iteratorIS4_ERS1_(%"class.std::_Rb_tree"* %18, %"struct.std::_Rb_tree_node_base"* %32, i32* dereferenceable(4) %29)
          to label %34 unwind label %52

; <label>:34:                                     ; preds = %30
  %35 = bitcast %"struct.std::pair.292"* %13 to { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }*
  %36 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %35, i32 0, i32 0
  %37 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %33, 0
  store %"struct.std::_Rb_tree_node_base"* %37, %"struct.std::_Rb_tree_node_base"** %36, align 8
  %38 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %35, i32 0, i32 1
  %39 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %33, 1
  store %"struct.std::_Rb_tree_node_base"* %39, %"struct.std::_Rb_tree_node_base"** %38, align 8
  %40 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %13, i32 0, i32 1
  %41 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %40, align 8
  %42 = icmp ne %"struct.std::_Rb_tree_node_base"* %41, null
  br i1 %42, label %43, label %60

; <label>:43:                                     ; preds = %34
  %44 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %13, i32 0, i32 0
  %45 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %44, align 8
  %46 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %13, i32 0, i32 1
  %47 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %46, align 8
  %48 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %12, align 8
  %49 = invoke %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_insert_nodeEPSt18_Rb_tree_node_baseSC_PSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"* %18, %"struct.std::_Rb_tree_node_base"* %45, %"struct.std::_Rb_tree_node_base"* %47, %"struct.std::_Rb_tree_node"* %48)
          to label %50 unwind label %52

; <label>:50:                                     ; preds = %43
  %51 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %6, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %49, %"struct.std::_Rb_tree_node_base"** %51, align 8
  br label %70

; <label>:52:                                     ; preds = %43, %30, %5
  %53 = landingpad { i8*, i32 }
          catch i8* null
  %54 = extractvalue { i8*, i32 } %53, 0
  store i8* %54, i8** %15, align 8
  %55 = extractvalue { i8*, i32 } %53, 1
  store i32 %55, i32* %16, align 4
  br label %56

; <label>:56:                                     ; preds = %52
  %57 = load i8*, i8** %15, align 8
  %58 = call i8* @__cxa_begin_catch(i8* %57) #3
  %59 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %12, align 8
  call void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_drop_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"* %18, %"struct.std::_Rb_tree_node"* %59) #3
  invoke void @__cxa_rethrow() #14
          to label %81 unwind label %64

; <label>:60:                                     ; preds = %34
  %61 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %12, align 8
  call void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_drop_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"* %18, %"struct.std::_Rb_tree_node"* %61) #3
  %62 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %13, i32 0, i32 0
  %63 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %62, align 8
  call void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"* %6, %"struct.std::_Rb_tree_node_base"* %63) #3
  br label %70

; <label>:64:                                     ; preds = %56
  %65 = landingpad { i8*, i32 }
          cleanup
  %66 = extractvalue { i8*, i32 } %65, 0
  store i8* %66, i8** %15, align 8
  %67 = extractvalue { i8*, i32 } %65, 1
  store i32 %67, i32* %16, align 4
  invoke void @__cxa_end_catch()
          to label %68 unwind label %78

; <label>:68:                                     ; preds = %64
  br label %73
                                                  ; No predecessors!
  call void @llvm.trap()
  unreachable

; <label>:70:                                     ; preds = %60, %50
  %71 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %6, i32 0, i32 0
  %72 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %71, align 8
  ret %"struct.std::_Rb_tree_node_base"* %72

; <label>:73:                                     ; preds = %68
  %74 = load i8*, i8** %15, align 8
  %75 = load i32, i32* %16, align 4
  %76 = insertvalue { i8*, i32 } undef, i8* %74, 0
  %77 = insertvalue { i8*, i32 } %76, i32 %75, 1
  resume { i8*, i32 } %77

; <label>:78:                                     ; preds = %64
  %79 = landingpad { i8*, i32 }
          catch i8* null
  %80 = extractvalue { i8*, i32 } %79, 0
  call void @__clang_call_terminate(i8* %80) #7
  unreachable

; <label>:81:                                     ; preds = %56
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt23_Rb_tree_const_iteratorISt4pairIKiN5minou4AtomEEEC2ERKSt17_Rb_tree_iteratorIS4_E(%"struct.std::_Rb_tree_const_iterator"*, %"struct.std::_Rb_tree_iterator"* dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"struct.std::_Rb_tree_const_iterator"*, align 8
  %4 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  store %"struct.std::_Rb_tree_const_iterator"* %0, %"struct.std::_Rb_tree_const_iterator"** %3, align 8
  store %"struct.std::_Rb_tree_iterator"* %1, %"struct.std::_Rb_tree_iterator"** %4, align 8
  %5 = load %"struct.std::_Rb_tree_const_iterator"*, %"struct.std::_Rb_tree_const_iterator"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::_Rb_tree_const_iterator", %"struct.std::_Rb_tree_const_iterator"* %5, i32 0, i32 0
  %7 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %4, align 8
  %8 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %7, i32 0, i32 0
  %9 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %8, align 8
  store %"struct.std::_Rb_tree_node_base"* %9, %"struct.std::_Rb_tree_node_base"** %6, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt5tupleIJRKiEEC2IvLb1EEES1_(%"class.std::tuple.286"*, i32* dereferenceable(4)) unnamed_addr #0 comdat align 2 {
  %3 = alloca %"class.std::tuple.286"*, align 8
  %4 = alloca i32*, align 8
  store %"class.std::tuple.286"* %0, %"class.std::tuple.286"** %3, align 8
  store i32* %1, i32** %4, align 8
  %5 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %3, align 8
  %6 = bitcast %"class.std::tuple.286"* %5 to %"struct.std::_Tuple_impl.287"*
  %7 = load i32*, i32** %4, align 8
  call void @_ZNSt11_Tuple_implILm0EJRKiEEC2ES1_(%"struct.std::_Tuple_impl.287"* %6, i32* dereferenceable(4) %7)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11lower_boundERS1_(%"class.std::_Rb_tree"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %3 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %4 = alloca %"class.std::_Rb_tree"*, align 8
  %5 = alloca i32*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %4, align 8
  store i32* %1, i32** %5, align 8
  %6 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %4, align 8
  %7 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_M_beginEv(%"class.std::_Rb_tree"* %6) #3
  %8 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_M_endEv(%"class.std::_Rb_tree"* %6) #3
  %9 = load i32*, i32** %5, align 8
  %10 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_lower_boundEPSt13_Rb_tree_nodeIS4_EPSt18_Rb_tree_node_baseRS1_(%"class.std::_Rb_tree"* %6, %"struct.std::_Rb_tree_node"* %7, %"struct.std::_Rb_tree_node_base"* %8, i32* dereferenceable(4) %9)
  %11 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %10, %"struct.std::_Rb_tree_node_base"** %11, align 8
  %12 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %13 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %12, align 8
  ret %"struct.std::_Rb_tree_node_base"* %13
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_lower_boundEPSt13_Rb_tree_nodeIS4_EPSt18_Rb_tree_node_baseRS1_(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node_base"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %5 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %6 = alloca %"class.std::_Rb_tree"*, align 8
  %7 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %8 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %9 = alloca i32*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %6, align 8
  store %"struct.std::_Rb_tree_node"* %1, %"struct.std::_Rb_tree_node"** %7, align 8
  store %"struct.std::_Rb_tree_node_base"* %2, %"struct.std::_Rb_tree_node_base"** %8, align 8
  store i32* %3, i32** %9, align 8
  %10 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %6, align 8
  br label %11

; <label>:11:                                     ; preds = %32, %4
  %12 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %13 = icmp ne %"struct.std::_Rb_tree_node"* %12, null
  br i1 %13, label %14, label %33

; <label>:14:                                     ; preds = %11
  %15 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %10, i32 0, i32 0
  %16 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %15 to %"struct.std::_Rb_tree_key_compare"*
  %17 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %16, i32 0, i32 0
  %18 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %19 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt13_Rb_tree_nodeIS4_E(%"struct.std::_Rb_tree_node"* %18)
  %20 = load i32*, i32** %9, align 8
  %21 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %17, i32* dereferenceable(4) %19, i32* dereferenceable(4) %20)
  br i1 %21, label %28, label %22

; <label>:22:                                     ; preds = %14
  %23 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %24 = bitcast %"struct.std::_Rb_tree_node"* %23 to %"struct.std::_Rb_tree_node_base"*
  store %"struct.std::_Rb_tree_node_base"* %24, %"struct.std::_Rb_tree_node_base"** %8, align 8
  %25 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %26 = bitcast %"struct.std::_Rb_tree_node"* %25 to %"struct.std::_Rb_tree_node_base"*
  %27 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE7_S_leftEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %26) #3
  store %"struct.std::_Rb_tree_node"* %27, %"struct.std::_Rb_tree_node"** %7, align 8
  br label %32

; <label>:28:                                     ; preds = %14
  %29 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %30 = bitcast %"struct.std::_Rb_tree_node"* %29 to %"struct.std::_Rb_tree_node_base"*
  %31 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_rightEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %30) #3
  store %"struct.std::_Rb_tree_node"* %31, %"struct.std::_Rb_tree_node"** %7, align 8
  br label %32

; <label>:32:                                     ; preds = %28, %22
  br label %11

; <label>:33:                                     ; preds = %11
  %34 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %8, align 8
  call void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"* %5, %"struct.std::_Rb_tree_node_base"* %34) #3
  %35 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %5, i32 0, i32 0
  %36 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %35, align 8
  ret %"struct.std::_Rb_tree_node_base"* %36
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_M_beginEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %2, align 8
  %3 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 8
  %7 = bitcast i8* %6 to %"struct.std::_Rb_tree_header"*
  %8 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %7, i32 0, i32 0
  %9 = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %8, i32 0, i32 1
  %10 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %9, align 8
  %11 = bitcast %"struct.std::_Rb_tree_node_base"* %10 to %"struct.std::_Rb_tree_node"*
  ret %"struct.std::_Rb_tree_node"* %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_M_endEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %2, align 8
  %3 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 8
  %7 = bitcast i8* %6 to %"struct.std::_Rb_tree_header"*
  %8 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %7, i32 0, i32 0
  ret %"struct.std::_Rb_tree_node_base"* %8
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt13_Rb_tree_nodeIS4_E(%"struct.std::_Rb_tree_node"*) #0 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %3 = alloca %"struct.std::_Select1st", align 1
  store %"struct.std::_Rb_tree_node"* %0, %"struct.std::_Rb_tree_node"** %2, align 8
  %4 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %2, align 8
  %5 = call dereferenceable(16) %"struct.std::pair.283"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_valueEPKSt13_Rb_tree_nodeIS4_E(%"struct.std::_Rb_tree_node"* %4)
  %6 = call dereferenceable(4) i32* @_ZNKSt10_Select1stISt4pairIKiN5minou4AtomEEEclERKS4_(%"struct.std::_Select1st"* %3, %"struct.std::pair.283"* dereferenceable(16) %5)
  ret i32* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE7_S_leftEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  store %"struct.std::_Rb_tree_node_base"* %0, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %3, i32 0, i32 2
  %5 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %4, align 8
  %6 = bitcast %"struct.std::_Rb_tree_node_base"* %5 to %"struct.std::_Rb_tree_node"*
  ret %"struct.std::_Rb_tree_node"* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_rightEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  store %"struct.std::_Rb_tree_node_base"* %0, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %3, i32 0, i32 3
  %5 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %4, align 8
  %6 = bitcast %"struct.std::_Rb_tree_node_base"* %5 to %"struct.std::_Rb_tree_node"*
  ret %"struct.std::_Rb_tree_node"* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_node_base"*) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  %4 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  store %"struct.std::_Rb_tree_iterator"* %0, %"struct.std::_Rb_tree_iterator"** %3, align 8
  store %"struct.std::_Rb_tree_node_base"* %1, %"struct.std::_Rb_tree_node_base"** %4, align 8
  %5 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %5, i32 0, i32 0
  %7 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %4, align 8
  store %"struct.std::_Rb_tree_node_base"* %7, %"struct.std::_Rb_tree_node_base"** %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZNKSt10_Select1stISt4pairIKiN5minou4AtomEEEclERKS4_(%"struct.std::_Select1st"*, %"struct.std::pair.283"* dereferenceable(16)) #2 comdat align 2 {
  %3 = alloca %"struct.std::_Select1st"*, align 8
  %4 = alloca %"struct.std::pair.283"*, align 8
  store %"struct.std::_Select1st"* %0, %"struct.std::_Select1st"** %3, align 8
  store %"struct.std::pair.283"* %1, %"struct.std::pair.283"** %4, align 8
  %5 = load %"struct.std::_Select1st"*, %"struct.std::_Select1st"** %3, align 8
  %6 = load %"struct.std::pair.283"*, %"struct.std::pair.283"** %4, align 8
  %7 = getelementptr inbounds %"struct.std::pair.283", %"struct.std::pair.283"* %6, i32 0, i32 0
  ret i32* %7
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(16) %"struct.std::pair.283"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_valueEPKSt13_Rb_tree_nodeIS4_E(%"struct.std::_Rb_tree_node"*) #0 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"struct.std::_Rb_tree_node"* %0, %"struct.std::_Rb_tree_node"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %2, align 8
  %4 = call %"struct.std::pair.283"* @_ZNKSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %3)
  ret %"struct.std::pair.283"* %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::pair.283"* @_ZNKSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"struct.std::_Rb_tree_node"* %0, %"struct.std::_Rb_tree_node"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_node", %"struct.std::_Rb_tree_node"* %3, i32 0, i32 1
  %5 = call %"struct.std::pair.283"* @_ZNK9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf.290"* %4) #3
  ret %"struct.std::pair.283"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::pair.283"* @_ZNK9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf.290"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf.290"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf.290"* %0, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf.290"*, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %4 = call i8* @_ZNK9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf.290"* %3) #3
  %5 = bitcast i8* %4 to %"struct.std::pair.283"*
  ret %"struct.std::pair.283"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i8* @_ZNK9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf.290"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf.290"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf.290"* %0, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf.290"*, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %4 = getelementptr inbounds %"struct.__gnu_cxx::__aligned_membuf.290", %"struct.__gnu_cxx::__aligned_membuf.290"* %3, i32 0, i32 0
  %5 = bitcast [16 x i8]* %4 to i8*
  ret i8* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE3endEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %3 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %3, align 8
  %4 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %3, align 8
  %5 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %4, i32 0, i32 0
  %6 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 8
  %8 = bitcast i8* %7 to %"struct.std::_Rb_tree_header"*
  %9 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %8, i32 0, i32 0
  call void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"* %2, %"struct.std::_Rb_tree_node_base"* %9) #3
  %10 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %2, i32 0, i32 0
  %11 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %10, align 8
  ret %"struct.std::_Rb_tree_node_base"* %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNKSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8key_compEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::less", align 1
  %3 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %3, align 8
  %4 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %3, align 8
  %5 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %4, i32 0, i32 0
  %6 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %5 to %"struct.std::_Rb_tree_key_compare"*
  %7 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %6, i32 0, i32 0
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::pair.283"* @_ZNSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"struct.std::_Rb_tree_node"* %0, %"struct.std::_Rb_tree_node"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_node", %"struct.std::_Rb_tree_node"* %3, i32 0, i32 1
  %5 = call %"struct.std::pair.283"* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf.290"* %4) #3
  ret %"struct.std::pair.283"* %5
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #6 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #3
  call void @_ZSt9terminatev() #7
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::pair.283"* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf.290"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf.290"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf.290"* %0, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf.290"*, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %4 = call i8* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf.290"* %3) #3
  %5 = bitcast i8* %4 to %"struct.std::pair.283"*
  ret %"struct.std::pair.283"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i8* @_ZN9__gnu_cxx16__aligned_membufISt4pairIKiN5minou4AtomEEE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf.290"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf.290"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf.290"* %0, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf.290"*, %"struct.__gnu_cxx::__aligned_membuf.290"** %2, align 8
  %4 = getelementptr inbounds %"struct.__gnu_cxx::__aligned_membuf.290", %"struct.__gnu_cxx::__aligned_membuf.290"* %3, i32 0, i32 0
  %5 = bitcast [16 x i8]* %4 to i8*
  ret i8* %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_create_nodeIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEEPSt13_Rb_tree_nodeIS4_EDpOT_(%"class.std::_Rb_tree"*, %"struct.std::piecewise_construct_t"* dereferenceable(1), %"class.std::tuple.286"* dereferenceable(8), %"class.std::tuple.289"* dereferenceable(1)) #0 comdat align 2 {
  %5 = alloca %"class.std::_Rb_tree"*, align 8
  %6 = alloca %"struct.std::piecewise_construct_t"*, align 8
  %7 = alloca %"class.std::tuple.286"*, align 8
  %8 = alloca %"class.std::tuple.289"*, align 8
  %9 = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %5, align 8
  store %"struct.std::piecewise_construct_t"* %1, %"struct.std::piecewise_construct_t"** %6, align 8
  store %"class.std::tuple.286"* %2, %"class.std::tuple.286"** %7, align 8
  store %"class.std::tuple.289"* %3, %"class.std::tuple.289"** %8, align 8
  %10 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %5, align 8
  %11 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_get_nodeEv(%"class.std::_Rb_tree"* %10)
  store %"struct.std::_Rb_tree_node"* %11, %"struct.std::_Rb_tree_node"** %9, align 8
  %12 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %9, align 8
  %13 = load %"struct.std::piecewise_construct_t"*, %"struct.std::piecewise_construct_t"** %6, align 8
  %14 = call dereferenceable(1) %"struct.std::piecewise_construct_t"* @_ZSt7forwardIRKSt21piecewise_construct_tEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::piecewise_construct_t"* dereferenceable(1) %13) #3
  %15 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %7, align 8
  %16 = call dereferenceable(8) %"class.std::tuple.286"* @_ZSt7forwardISt5tupleIJRKiEEEOT_RNSt16remove_referenceIS4_E4typeE(%"class.std::tuple.286"* dereferenceable(8) %15) #3
  %17 = load %"class.std::tuple.289"*, %"class.std::tuple.289"** %8, align 8
  %18 = call dereferenceable(1) %"class.std::tuple.289"* @_ZSt7forwardISt5tupleIJEEEOT_RNSt16remove_referenceIS2_E4typeE(%"class.std::tuple.289"* dereferenceable(1) %17) #3
  call void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE17_M_construct_nodeIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEEvPSt13_Rb_tree_nodeIS4_EDpOT_(%"class.std::_Rb_tree"* %10, %"struct.std::_Rb_tree_node"* %12, %"struct.std::piecewise_construct_t"* dereferenceable(1) %14, %"class.std::tuple.286"* dereferenceable(8) %16, %"class.std::tuple.289"* dereferenceable(1) %18)
  %19 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %9, align 8
  ret %"struct.std::_Rb_tree_node"* %19
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"struct.std::piecewise_construct_t"* @_ZSt7forwardIRKSt21piecewise_construct_tEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::piecewise_construct_t"* dereferenceable(1)) #2 comdat {
  %2 = alloca %"struct.std::piecewise_construct_t"*, align 8
  store %"struct.std::piecewise_construct_t"* %0, %"struct.std::piecewise_construct_t"** %2, align 8
  %3 = load %"struct.std::piecewise_construct_t"*, %"struct.std::piecewise_construct_t"** %2, align 8
  ret %"struct.std::piecewise_construct_t"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.std::tuple.286"* @_ZSt7forwardISt5tupleIJRKiEEEOT_RNSt16remove_referenceIS4_E4typeE(%"class.std::tuple.286"* dereferenceable(8)) #2 comdat {
  %2 = alloca %"class.std::tuple.286"*, align 8
  store %"class.std::tuple.286"* %0, %"class.std::tuple.286"** %2, align 8
  %3 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %2, align 8
  ret %"class.std::tuple.286"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"class.std::tuple.289"* @_ZSt7forwardISt5tupleIJEEEOT_RNSt16remove_referenceIS2_E4typeE(%"class.std::tuple.289"* dereferenceable(1)) #2 comdat {
  %2 = alloca %"class.std::tuple.289"*, align 8
  store %"class.std::tuple.289"* %0, %"class.std::tuple.289"** %2, align 8
  %3 = load %"class.std::tuple.289"*, %"class.std::tuple.289"** %2, align 8
  ret %"class.std::tuple.289"* %3
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE29_M_get_insert_hint_unique_posESt23_Rb_tree_const_iteratorIS4_ERS1_(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node_base"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %4 = alloca %"struct.std::pair.292", align 8
  %5 = alloca %"struct.std::_Rb_tree_const_iterator", align 8
  %6 = alloca %"class.std::_Rb_tree"*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %9 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %10 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %11 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %12 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %13 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %14 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %15 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %16 = getelementptr inbounds %"struct.std::_Rb_tree_const_iterator", %"struct.std::_Rb_tree_const_iterator"* %5, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %1, %"struct.std::_Rb_tree_node_base"** %16, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %6, align 8
  store i32* %2, i32** %7, align 8
  %17 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %6, align 8
  %18 = call %"struct.std::_Rb_tree_node_base"* @_ZNKSt23_Rb_tree_const_iteratorISt4pairIKiN5minou4AtomEEE13_M_const_castEv(%"struct.std::_Rb_tree_const_iterator"* %5) #3
  %19 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %18, %"struct.std::_Rb_tree_node_base"** %19, align 8
  %20 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %21 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %20, align 8
  %22 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_M_endEv(%"class.std::_Rb_tree"* %17) #3
  %23 = icmp eq %"struct.std::_Rb_tree_node_base"* %21, %22
  br i1 %23, label %24, label %46

; <label>:24:                                     ; preds = %3
  %25 = call i64 @_ZNKSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE4sizeEv(%"class.std::_Rb_tree"* %17) #3
  %26 = icmp ugt i64 %25, 0
  br i1 %26, label %27, label %38

; <label>:27:                                     ; preds = %24
  %28 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %17, i32 0, i32 0
  %29 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %28 to %"struct.std::_Rb_tree_key_compare"*
  %30 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %29, i32 0, i32 0
  %31 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_rightmostEv(%"class.std::_Rb_tree"* %17) #3
  %32 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %31, align 8
  %33 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %32)
  %34 = load i32*, i32** %7, align 8
  %35 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %30, i32* dereferenceable(4) %33, i32* dereferenceable(4) %34)
  br i1 %35, label %36, label %38

; <label>:36:                                     ; preds = %27
  store %"struct.std::_Rb_tree_node_base"* null, %"struct.std::_Rb_tree_node_base"** %9, align 8
  %37 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_rightmostEv(%"class.std::_Rb_tree"* %17) #3
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEERKS1_OT_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %9, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %37)
  br label %143

; <label>:38:                                     ; preds = %27, %24
  %39 = load i32*, i32** %7, align 8
  %40 = call { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE24_M_get_insert_unique_posERS1_(%"class.std::_Rb_tree"* %17, i32* dereferenceable(4) %39)
  %41 = bitcast %"struct.std::pair.292"* %4 to { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }*
  %42 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %41, i32 0, i32 0
  %43 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %40, 0
  store %"struct.std::_Rb_tree_node_base"* %43, %"struct.std::_Rb_tree_node_base"** %42, align 8
  %44 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %41, i32 0, i32 1
  %45 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %40, 1
  store %"struct.std::_Rb_tree_node_base"* %45, %"struct.std::_Rb_tree_node_base"** %44, align 8
  br label %143

; <label>:46:                                     ; preds = %3
  %47 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %17, i32 0, i32 0
  %48 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %47 to %"struct.std::_Rb_tree_key_compare"*
  %49 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %48, i32 0, i32 0
  %50 = load i32*, i32** %7, align 8
  %51 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %52 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %51, align 8
  %53 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %52)
  %54 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %49, i32* dereferenceable(4) %50, i32* dereferenceable(4) %53)
  br i1 %54, label %55, label %94

; <label>:55:                                     ; preds = %46
  %56 = bitcast %"struct.std::_Rb_tree_iterator"* %10 to i8*
  %57 = bitcast %"struct.std::_Rb_tree_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %56, i8* %57, i64 8, i32 8, i1 false)
  %58 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %59 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %58, align 8
  %60 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_leftmostEv(%"class.std::_Rb_tree"* %17) #3
  %61 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %60, align 8
  %62 = icmp eq %"struct.std::_Rb_tree_node_base"* %59, %61
  br i1 %62, label %63, label %66

; <label>:63:                                     ; preds = %55
  %64 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_leftmostEv(%"class.std::_Rb_tree"* %17) #3
  %65 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_leftmostEv(%"class.std::_Rb_tree"* %17) #3
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_S4_Lb1EEEOT_OT0_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %64, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %65)
  br label %143

; <label>:66:                                     ; preds = %55
  %67 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %17, i32 0, i32 0
  %68 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %67 to %"struct.std::_Rb_tree_key_compare"*
  %69 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %68, i32 0, i32 0
  %70 = call dereferenceable(8) %"struct.std::_Rb_tree_iterator"* @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEmmEv(%"struct.std::_Rb_tree_iterator"* %10) #3
  %71 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %70, i32 0, i32 0
  %72 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %71, align 8
  %73 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %72)
  %74 = load i32*, i32** %7, align 8
  %75 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %69, i32* dereferenceable(4) %73, i32* dereferenceable(4) %74)
  br i1 %75, label %76, label %86

; <label>:76:                                     ; preds = %66
  %77 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %10, i32 0, i32 0
  %78 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %77, align 8
  %79 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_rightEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %78) #3
  %80 = icmp eq %"struct.std::_Rb_tree_node"* %79, null
  br i1 %80, label %81, label %83

; <label>:81:                                     ; preds = %76
  store %"struct.std::_Rb_tree_node_base"* null, %"struct.std::_Rb_tree_node_base"** %11, align 8
  %82 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %10, i32 0, i32 0
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEERKS1_OT_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %11, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %82)
  br label %143

; <label>:83:                                     ; preds = %76
  %84 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %85 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_S4_Lb1EEEOT_OT0_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %84, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %85)
  br label %143

; <label>:86:                                     ; preds = %66
  %87 = load i32*, i32** %7, align 8
  %88 = call { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE24_M_get_insert_unique_posERS1_(%"class.std::_Rb_tree"* %17, i32* dereferenceable(4) %87)
  %89 = bitcast %"struct.std::pair.292"* %4 to { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }*
  %90 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %89, i32 0, i32 0
  %91 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %88, 0
  store %"struct.std::_Rb_tree_node_base"* %91, %"struct.std::_Rb_tree_node_base"** %90, align 8
  %92 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %89, i32 0, i32 1
  %93 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %88, 1
  store %"struct.std::_Rb_tree_node_base"* %93, %"struct.std::_Rb_tree_node_base"** %92, align 8
  br label %143

; <label>:94:                                     ; preds = %46
  %95 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %17, i32 0, i32 0
  %96 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %95 to %"struct.std::_Rb_tree_key_compare"*
  %97 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %96, i32 0, i32 0
  %98 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %99 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %98, align 8
  %100 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %99)
  %101 = load i32*, i32** %7, align 8
  %102 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %97, i32* dereferenceable(4) %100, i32* dereferenceable(4) %101)
  br i1 %102, label %103, label %141

; <label>:103:                                    ; preds = %94
  %104 = bitcast %"struct.std::_Rb_tree_iterator"* %12 to i8*
  %105 = bitcast %"struct.std::_Rb_tree_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %104, i8* %105, i64 8, i32 8, i1 false)
  %106 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %107 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %106, align 8
  %108 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_rightmostEv(%"class.std::_Rb_tree"* %17) #3
  %109 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %108, align 8
  %110 = icmp eq %"struct.std::_Rb_tree_node_base"* %107, %109
  br i1 %110, label %111, label %113

; <label>:111:                                    ; preds = %103
  store %"struct.std::_Rb_tree_node_base"* null, %"struct.std::_Rb_tree_node_base"** %13, align 8
  %112 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_rightmostEv(%"class.std::_Rb_tree"* %17) #3
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEERKS1_OT_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %13, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %112)
  br label %143

; <label>:113:                                    ; preds = %103
  %114 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %17, i32 0, i32 0
  %115 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %114 to %"struct.std::_Rb_tree_key_compare"*
  %116 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %115, i32 0, i32 0
  %117 = load i32*, i32** %7, align 8
  %118 = call dereferenceable(8) %"struct.std::_Rb_tree_iterator"* @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEppEv(%"struct.std::_Rb_tree_iterator"* %12) #3
  %119 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %118, i32 0, i32 0
  %120 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %119, align 8
  %121 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %120)
  %122 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %116, i32* dereferenceable(4) %117, i32* dereferenceable(4) %121)
  br i1 %122, label %123, label %133

; <label>:123:                                    ; preds = %113
  %124 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  %125 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %124, align 8
  %126 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_rightEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %125) #3
  %127 = icmp eq %"struct.std::_Rb_tree_node"* %126, null
  br i1 %127, label %128, label %130

; <label>:128:                                    ; preds = %123
  store %"struct.std::_Rb_tree_node_base"* null, %"struct.std::_Rb_tree_node_base"** %14, align 8
  %129 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEERKS1_OT_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %14, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %129)
  br label %143

; <label>:130:                                    ; preds = %123
  %131 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %12, i32 0, i32 0
  %132 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %12, i32 0, i32 0
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_S4_Lb1EEEOT_OT0_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %131, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %132)
  br label %143

; <label>:133:                                    ; preds = %113
  %134 = load i32*, i32** %7, align 8
  %135 = call { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE24_M_get_insert_unique_posERS1_(%"class.std::_Rb_tree"* %17, i32* dereferenceable(4) %134)
  %136 = bitcast %"struct.std::pair.292"* %4 to { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }*
  %137 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %136, i32 0, i32 0
  %138 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %135, 0
  store %"struct.std::_Rb_tree_node_base"* %138, %"struct.std::_Rb_tree_node_base"** %137, align 8
  %139 = getelementptr inbounds { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %136, i32 0, i32 1
  %140 = extractvalue { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %135, 1
  store %"struct.std::_Rb_tree_node_base"* %140, %"struct.std::_Rb_tree_node_base"** %139, align 8
  br label %143

; <label>:141:                                    ; preds = %94
  %142 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %8, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* null, %"struct.std::_Rb_tree_node_base"** %15, align 8
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEEOT_RKS1_(%"struct.std::pair.292"* %4, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %142, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %15)
  br label %143

; <label>:143:                                    ; preds = %141, %133, %130, %128, %111, %86, %83, %81, %63, %38, %36
  %144 = bitcast %"struct.std::pair.292"* %4 to { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }*
  %145 = load { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %144, align 8
  ret { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %145
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_insert_nodeEPSt18_Rb_tree_node_baseSC_PSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node"*) #0 comdat align 2 {
  %5 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %6 = alloca %"class.std::_Rb_tree"*, align 8
  %7 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %8 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %9 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %10 = alloca i8, align 1
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %6, align 8
  store %"struct.std::_Rb_tree_node_base"* %1, %"struct.std::_Rb_tree_node_base"** %7, align 8
  store %"struct.std::_Rb_tree_node_base"* %2, %"struct.std::_Rb_tree_node_base"** %8, align 8
  store %"struct.std::_Rb_tree_node"* %3, %"struct.std::_Rb_tree_node"** %9, align 8
  %11 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %6, align 8
  %12 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %7, align 8
  %13 = icmp ne %"struct.std::_Rb_tree_node_base"* %12, null
  br i1 %13, label %27, label %14

; <label>:14:                                     ; preds = %4
  %15 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %8, align 8
  %16 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_M_endEv(%"class.std::_Rb_tree"* %11) #3
  %17 = icmp eq %"struct.std::_Rb_tree_node_base"* %15, %16
  br i1 %17, label %27, label %18

; <label>:18:                                     ; preds = %14
  %19 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %11, i32 0, i32 0
  %20 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %19 to %"struct.std::_Rb_tree_key_compare"*
  %21 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %20, i32 0, i32 0
  %22 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %9, align 8
  %23 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt13_Rb_tree_nodeIS4_E(%"struct.std::_Rb_tree_node"* %22)
  %24 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %8, align 8
  %25 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %24)
  %26 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %21, i32* dereferenceable(4) %23, i32* dereferenceable(4) %25)
  br label %27

; <label>:27:                                     ; preds = %18, %14, %4
  %28 = phi i1 [ true, %14 ], [ true, %4 ], [ %26, %18 ]
  %29 = zext i1 %28 to i8
  store i8 %29, i8* %10, align 1
  %30 = load i8, i8* %10, align 1
  %31 = trunc i8 %30 to i1
  %32 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %9, align 8
  %33 = bitcast %"struct.std::_Rb_tree_node"* %32 to %"struct.std::_Rb_tree_node_base"*
  %34 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %8, align 8
  %35 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %11, i32 0, i32 0
  %36 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %35 to i8*
  %37 = getelementptr inbounds i8, i8* %36, i64 8
  %38 = bitcast i8* %37 to %"struct.std::_Rb_tree_header"*
  %39 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %38, i32 0, i32 0
  call void @_ZSt29_Rb_tree_insert_and_rebalancebPSt18_Rb_tree_node_baseS0_RS_(i1 zeroext %31, %"struct.std::_Rb_tree_node_base"* %33, %"struct.std::_Rb_tree_node_base"* %34, %"struct.std::_Rb_tree_node_base"* dereferenceable(32) %39) #3
  %40 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %11, i32 0, i32 0
  %41 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %40 to i8*
  %42 = getelementptr inbounds i8, i8* %41, i64 8
  %43 = bitcast i8* %42 to %"struct.std::_Rb_tree_header"*
  %44 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %43, i32 0, i32 1
  %45 = load i64, i64* %44, align 8
  %46 = add i64 %45, 1
  store i64 %46, i64* %44, align 8
  %47 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %9, align 8
  %48 = bitcast %"struct.std::_Rb_tree_node"* %47 to %"struct.std::_Rb_tree_node_base"*
  call void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"* %5, %"struct.std::_Rb_tree_node_base"* %48) #3
  %49 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %5, i32 0, i32 0
  %50 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %49, align 8
  ret %"struct.std::_Rb_tree_node_base"* %50
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_drop_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node"*) #2 comdat align 2 {
  %3 = alloca %"class.std::_Rb_tree"*, align 8
  %4 = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %3, align 8
  store %"struct.std::_Rb_tree_node"* %1, %"struct.std::_Rb_tree_node"** %4, align 8
  %5 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %3, align 8
  %6 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %4, align 8
  call void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE15_M_destroy_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"* %5, %"struct.std::_Rb_tree_node"* %6) #3
  %7 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %4, align 8
  call void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_put_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"* %5, %"struct.std::_Rb_tree_node"* %7) #3
  ret void
}

declare void @__cxa_rethrow()

declare void @__cxa_end_catch()

; Function Attrs: noreturn nounwind
declare void @llvm.trap() #7

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_get_nodeEv(%"class.std::_Rb_tree"*) #0 comdat align 2 {
  %2 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %2, align 8
  %3 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %2, align 8
  %4 = call dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"* %3) #3
  %5 = call %"struct.std::_Rb_tree_node"* @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE8allocateERS7_m(%"class.std::allocator"* dereferenceable(1) %4, i64 1)
  ret %"struct.std::_Rb_tree_node"* %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE17_M_construct_nodeIJRKSt21piecewise_construct_tSt5tupleIJRS1_EESF_IJEEEEEvPSt13_Rb_tree_nodeIS4_EDpOT_(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node"*, %"struct.std::piecewise_construct_t"* dereferenceable(1), %"class.std::tuple.286"* dereferenceable(8), %"class.std::tuple.289"* dereferenceable(1)) #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %6 = alloca %"class.std::_Rb_tree"*, align 8
  %7 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %8 = alloca %"struct.std::piecewise_construct_t"*, align 8
  %9 = alloca %"class.std::tuple.286"*, align 8
  %10 = alloca %"class.std::tuple.289"*, align 8
  %11 = alloca i8*
  %12 = alloca i32
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %6, align 8
  store %"struct.std::_Rb_tree_node"* %1, %"struct.std::_Rb_tree_node"** %7, align 8
  store %"struct.std::piecewise_construct_t"* %2, %"struct.std::piecewise_construct_t"** %8, align 8
  store %"class.std::tuple.286"* %3, %"class.std::tuple.286"** %9, align 8
  store %"class.std::tuple.289"* %4, %"class.std::tuple.289"** %10, align 8
  %13 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %6, align 8
  %14 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %15 = bitcast %"struct.std::_Rb_tree_node"* %14 to i8*
  %16 = bitcast i8* %15 to %"struct.std::_Rb_tree_node"*
  %17 = call dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"* %13) #3
  %18 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %19 = invoke %"struct.std::pair.283"* @_ZNSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %18)
          to label %20 unwind label %28

; <label>:20:                                     ; preds = %5
  %21 = load %"struct.std::piecewise_construct_t"*, %"struct.std::piecewise_construct_t"** %8, align 8
  %22 = call dereferenceable(1) %"struct.std::piecewise_construct_t"* @_ZSt7forwardIRKSt21piecewise_construct_tEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::piecewise_construct_t"* dereferenceable(1) %21) #3
  %23 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %9, align 8
  %24 = call dereferenceable(8) %"class.std::tuple.286"* @_ZSt7forwardISt5tupleIJRKiEEEOT_RNSt16remove_referenceIS4_E4typeE(%"class.std::tuple.286"* dereferenceable(8) %23) #3
  %25 = load %"class.std::tuple.289"*, %"class.std::tuple.289"** %10, align 8
  %26 = call dereferenceable(1) %"class.std::tuple.289"* @_ZSt7forwardISt5tupleIJEEEOT_RNSt16remove_referenceIS2_E4typeE(%"class.std::tuple.289"* dereferenceable(1) %25) #3
  invoke void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE9constructIS5_JRKSt21piecewise_construct_tSt5tupleIJRS2_EESD_IJEEEEEvRS7_PT_DpOT0_(%"class.std::allocator"* dereferenceable(1) %17, %"struct.std::pair.283"* %19, %"struct.std::piecewise_construct_t"* dereferenceable(1) %22, %"class.std::tuple.286"* dereferenceable(8) %24, %"class.std::tuple.289"* dereferenceable(1) %26)
          to label %27 unwind label %28

; <label>:27:                                     ; preds = %20
  br label %42

; <label>:28:                                     ; preds = %20, %5
  %29 = landingpad { i8*, i32 }
          catch i8* null
  %30 = extractvalue { i8*, i32 } %29, 0
  store i8* %30, i8** %11, align 8
  %31 = extractvalue { i8*, i32 } %29, 1
  store i32 %31, i32* %12, align 4
  br label %32

; <label>:32:                                     ; preds = %28
  %33 = load i8*, i8** %11, align 8
  %34 = call i8* @__cxa_begin_catch(i8* %33) #3
  %35 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  %36 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %7, align 8
  call void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_put_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"* %13, %"struct.std::_Rb_tree_node"* %36) #3
  invoke void @__cxa_rethrow() #14
          to label %51 unwind label %37

; <label>:37:                                     ; preds = %32
  %38 = landingpad { i8*, i32 }
          cleanup
  %39 = extractvalue { i8*, i32 } %38, 0
  store i8* %39, i8** %11, align 8
  %40 = extractvalue { i8*, i32 } %38, 1
  store i32 %40, i32* %12, align 4
  invoke void @__cxa_end_catch()
          to label %41 unwind label %48

; <label>:41:                                     ; preds = %37
  br label %43

; <label>:42:                                     ; preds = %27
  ret void

; <label>:43:                                     ; preds = %41
  %44 = load i8*, i8** %11, align 8
  %45 = load i32, i32* %12, align 4
  %46 = insertvalue { i8*, i32 } undef, i8* %44, 0
  %47 = insertvalue { i8*, i32 } %46, i32 %45, 1
  resume { i8*, i32 } %47

; <label>:48:                                     ; preds = %37
  %49 = landingpad { i8*, i32 }
          catch i8* null
  %50 = extractvalue { i8*, i32 } %49, 0
  call void @__clang_call_terminate(i8* %50) #7
  unreachable

; <label>:51:                                     ; preds = %32
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node"* @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE8allocateERS7_m(%"class.std::allocator"* dereferenceable(1), i64) #0 comdat align 2 {
  %3 = alloca %"class.std::allocator"*, align 8
  %4 = alloca i64, align 8
  store %"class.std::allocator"* %0, %"class.std::allocator"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.std::allocator"*, %"class.std::allocator"** %3, align 8
  %6 = bitcast %"class.std::allocator"* %5 to %"class.__gnu_cxx::new_allocator"*
  %7 = load i64, i64* %4, align 8
  %8 = call %"struct.std::_Rb_tree_node"* @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE8allocateEmPKv(%"class.__gnu_cxx::new_allocator"* %6, i64 %7, i8* null)
  ret %"struct.std::_Rb_tree_node"* %8
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %2, align 8
  %3 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %4 to %"class.std::allocator"*
  ret %"class.std::allocator"* %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node"* @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE8allocateEmPKv(%"class.__gnu_cxx::new_allocator"*, i64, i8*) #0 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  store %"class.__gnu_cxx::new_allocator"* %0, %"class.__gnu_cxx::new_allocator"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8* %2, i8** %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %4, align 8
  %8 = load i64, i64* %5, align 8
  %9 = call i64 @_ZNK9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE8max_sizeEv(%"class.__gnu_cxx::new_allocator"* %7) #3
  %10 = icmp ugt i64 %8, %9
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %3
  call void @_ZSt17__throw_bad_allocv() #14
  unreachable

; <label>:12:                                     ; preds = %3
  %13 = load i64, i64* %5, align 8
  %14 = mul i64 %13, 48
  %15 = call i8* @_Znwm(i64 %14)
  %16 = bitcast i8* %15 to %"struct.std::_Rb_tree_node"*
  ret %"struct.std::_Rb_tree_node"* %16
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZNK9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE8max_sizeEv(%"class.__gnu_cxx::new_allocator"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  store %"class.__gnu_cxx::new_allocator"* %0, %"class.__gnu_cxx::new_allocator"** %2, align 8
  %3 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %2, align 8
  ret i64 384307168202282325
}

; Function Attrs: noreturn
declare void @_ZSt17__throw_bad_allocv() #8

; Function Attrs: nobuiltin
declare noalias i8* @_Znwm(i64) #9

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE9constructIS5_JRKSt21piecewise_construct_tSt5tupleIJRS2_EESD_IJEEEEEvRS7_PT_DpOT0_(%"class.std::allocator"* dereferenceable(1), %"struct.std::pair.283"*, %"struct.std::piecewise_construct_t"* dereferenceable(1), %"class.std::tuple.286"* dereferenceable(8), %"class.std::tuple.289"* dereferenceable(1)) #0 comdat align 2 {
  %6 = alloca %"class.std::allocator"*, align 8
  %7 = alloca %"struct.std::pair.283"*, align 8
  %8 = alloca %"struct.std::piecewise_construct_t"*, align 8
  %9 = alloca %"class.std::tuple.286"*, align 8
  %10 = alloca %"class.std::tuple.289"*, align 8
  store %"class.std::allocator"* %0, %"class.std::allocator"** %6, align 8
  store %"struct.std::pair.283"* %1, %"struct.std::pair.283"** %7, align 8
  store %"struct.std::piecewise_construct_t"* %2, %"struct.std::piecewise_construct_t"** %8, align 8
  store %"class.std::tuple.286"* %3, %"class.std::tuple.286"** %9, align 8
  store %"class.std::tuple.289"* %4, %"class.std::tuple.289"** %10, align 8
  %11 = load %"class.std::allocator"*, %"class.std::allocator"** %6, align 8
  %12 = bitcast %"class.std::allocator"* %11 to %"class.__gnu_cxx::new_allocator"*
  %13 = load %"struct.std::pair.283"*, %"struct.std::pair.283"** %7, align 8
  %14 = load %"struct.std::piecewise_construct_t"*, %"struct.std::piecewise_construct_t"** %8, align 8
  %15 = call dereferenceable(1) %"struct.std::piecewise_construct_t"* @_ZSt7forwardIRKSt21piecewise_construct_tEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::piecewise_construct_t"* dereferenceable(1) %14) #3
  %16 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %9, align 8
  %17 = call dereferenceable(8) %"class.std::tuple.286"* @_ZSt7forwardISt5tupleIJRKiEEEOT_RNSt16remove_referenceIS4_E4typeE(%"class.std::tuple.286"* dereferenceable(8) %16) #3
  %18 = load %"class.std::tuple.289"*, %"class.std::tuple.289"** %10, align 8
  %19 = call dereferenceable(1) %"class.std::tuple.289"* @_ZSt7forwardISt5tupleIJEEEOT_RNSt16remove_referenceIS2_E4typeE(%"class.std::tuple.289"* dereferenceable(1) %18) #3
  call void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE9constructIS6_JRKSt21piecewise_construct_tSt5tupleIJRS3_EESD_IJEEEEEvPT_DpOT0_(%"class.__gnu_cxx::new_allocator"* %12, %"struct.std::pair.283"* %13, %"struct.std::piecewise_construct_t"* dereferenceable(1) %15, %"class.std::tuple.286"* dereferenceable(8) %17, %"class.std::tuple.289"* dereferenceable(1) %19)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_put_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node"*) #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::_Rb_tree"*, align 8
  %4 = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %3, align 8
  store %"struct.std::_Rb_tree_node"* %1, %"struct.std::_Rb_tree_node"** %4, align 8
  %5 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %3, align 8
  %6 = call dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"* %5) #3
  %7 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %4, align 8
  invoke void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE10deallocateERS7_PS6_m(%"class.std::allocator"* dereferenceable(1) %6, %"struct.std::_Rb_tree_node"* %7, i64 1)
          to label %8 unwind label %9

; <label>:8:                                      ; preds = %2
  ret void

; <label>:9:                                      ; preds = %2
  %10 = landingpad { i8*, i32 }
          catch i8* null
  %11 = extractvalue { i8*, i32 } %10, 0
  call void @__clang_call_terminate(i8* %11) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE9constructIS6_JRKSt21piecewise_construct_tSt5tupleIJRS3_EESD_IJEEEEEvPT_DpOT0_(%"class.__gnu_cxx::new_allocator"*, %"struct.std::pair.283"*, %"struct.std::piecewise_construct_t"* dereferenceable(1), %"class.std::tuple.286"* dereferenceable(8), %"class.std::tuple.289"* dereferenceable(1)) #0 comdat align 2 {
  %6 = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  %7 = alloca %"struct.std::pair.283"*, align 8
  %8 = alloca %"struct.std::piecewise_construct_t"*, align 8
  %9 = alloca %"class.std::tuple.286"*, align 8
  %10 = alloca %"class.std::tuple.289"*, align 8
  %11 = alloca %"struct.std::piecewise_construct_t", align 1
  %12 = alloca %"class.std::tuple.286", align 8
  %13 = alloca %"class.std::tuple.289", align 1
  store %"class.__gnu_cxx::new_allocator"* %0, %"class.__gnu_cxx::new_allocator"** %6, align 8
  store %"struct.std::pair.283"* %1, %"struct.std::pair.283"** %7, align 8
  store %"struct.std::piecewise_construct_t"* %2, %"struct.std::piecewise_construct_t"** %8, align 8
  store %"class.std::tuple.286"* %3, %"class.std::tuple.286"** %9, align 8
  store %"class.std::tuple.289"* %4, %"class.std::tuple.289"** %10, align 8
  %14 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %6, align 8
  %15 = load %"struct.std::pair.283"*, %"struct.std::pair.283"** %7, align 8
  %16 = bitcast %"struct.std::pair.283"* %15 to i8*
  %17 = bitcast i8* %16 to %"struct.std::pair.283"*
  %18 = load %"struct.std::piecewise_construct_t"*, %"struct.std::piecewise_construct_t"** %8, align 8
  %19 = call dereferenceable(1) %"struct.std::piecewise_construct_t"* @_ZSt7forwardIRKSt21piecewise_construct_tEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::piecewise_construct_t"* dereferenceable(1) %18) #3
  %20 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %9, align 8
  %21 = call dereferenceable(8) %"class.std::tuple.286"* @_ZSt7forwardISt5tupleIJRKiEEEOT_RNSt16remove_referenceIS4_E4typeE(%"class.std::tuple.286"* dereferenceable(8) %20) #3
  call void @_ZNSt5tupleIJRKiEEC2EOS2_(%"class.std::tuple.286"* %12, %"class.std::tuple.286"* dereferenceable(8) %21) #3
  %22 = load %"class.std::tuple.289"*, %"class.std::tuple.289"** %10, align 8
  %23 = call dereferenceable(1) %"class.std::tuple.289"* @_ZSt7forwardISt5tupleIJEEEOT_RNSt16remove_referenceIS2_E4typeE(%"class.std::tuple.289"* dereferenceable(1) %22) #3
  call void @_ZNSt4pairIKiN5minou4AtomEEC2IJRS0_EJEEESt21piecewise_construct_tSt5tupleIJDpT_EES7_IJDpT0_EE(%"struct.std::pair.283"* %17, %"class.std::tuple.286"* %12)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt5tupleIJRKiEEC2EOS2_(%"class.std::tuple.286"*, %"class.std::tuple.286"* dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.std::tuple.286"*, align 8
  %4 = alloca %"class.std::tuple.286"*, align 8
  store %"class.std::tuple.286"* %0, %"class.std::tuple.286"** %3, align 8
  store %"class.std::tuple.286"* %1, %"class.std::tuple.286"** %4, align 8
  %5 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %3, align 8
  %6 = bitcast %"class.std::tuple.286"* %5 to %"struct.std::_Tuple_impl.287"*
  %7 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %4, align 8
  %8 = bitcast %"class.std::tuple.286"* %7 to %"struct.std::_Tuple_impl.287"*
  call void @_ZNSt11_Tuple_implILm0EJRKiEEC2EOS2_(%"struct.std::_Tuple_impl.287"* %6, %"struct.std::_Tuple_impl.287"* dereferenceable(8) %8) #3
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt4pairIKiN5minou4AtomEEC2IJRS0_EJEEESt21piecewise_construct_tSt5tupleIJDpT_EES7_IJDpT0_EE(%"struct.std::pair.283"*, %"class.std::tuple.286"*) unnamed_addr #0 comdat align 2 {
  %3 = alloca %"struct.std::piecewise_construct_t", align 1
  %4 = alloca %"class.std::tuple.289", align 1
  %5 = alloca %"struct.std::pair.283"*, align 8
  %6 = alloca %"struct.std::_Index_tuple", align 1
  %7 = alloca %"struct.std::_Index_tuple.295", align 1
  store %"struct.std::pair.283"* %0, %"struct.std::pair.283"** %5, align 8
  %8 = load %"struct.std::pair.283"*, %"struct.std::pair.283"** %5, align 8
  call void @_ZNSt4pairIKiN5minou4AtomEEC2IJRS0_EJLm0EEJEJEEERSt5tupleIJDpT_EERS6_IJDpT1_EESt12_Index_tupleIJXspT0_EEESF_IJXspT2_EEE(%"struct.std::pair.283"* %8, %"class.std::tuple.286"* dereferenceable(8) %1, %"class.std::tuple.289"* dereferenceable(1) %4)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt11_Tuple_implILm0EJRKiEEC2EOS2_(%"struct.std::_Tuple_impl.287"*, %"struct.std::_Tuple_impl.287"* dereferenceable(8)) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"struct.std::_Tuple_impl.287"*, align 8
  %4 = alloca %"struct.std::_Tuple_impl.287"*, align 8
  store %"struct.std::_Tuple_impl.287"* %0, %"struct.std::_Tuple_impl.287"** %3, align 8
  store %"struct.std::_Tuple_impl.287"* %1, %"struct.std::_Tuple_impl.287"** %4, align 8
  %5 = load %"struct.std::_Tuple_impl.287"*, %"struct.std::_Tuple_impl.287"** %3, align 8
  %6 = bitcast %"struct.std::_Tuple_impl.287"* %5 to %"struct.std::_Head_base.288"*
  %7 = load %"struct.std::_Tuple_impl.287"*, %"struct.std::_Tuple_impl.287"** %4, align 8
  %8 = call dereferenceable(4) i32* @_ZNSt11_Tuple_implILm0EJRKiEE7_M_headERS2_(%"struct.std::_Tuple_impl.287"* dereferenceable(8) %7) #3
  %9 = call dereferenceable(4) i32* @_ZSt7forwardIRKiEOT_RNSt16remove_referenceIS2_E4typeE(i32* dereferenceable(4) %8) #3
  invoke void @_ZNSt10_Head_baseILm0ERKiLb0EEC2ES1_(%"struct.std::_Head_base.288"* %6, i32* dereferenceable(4) %9)
          to label %10 unwind label %11

; <label>:10:                                     ; preds = %2
  ret void

; <label>:11:                                     ; preds = %2
  %12 = landingpad { i8*, i32 }
          catch i8* null
  %13 = extractvalue { i8*, i32 } %12, 0
  call void @__clang_call_terminate(i8* %13) #7
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZSt7forwardIRKiEOT_RNSt16remove_referenceIS2_E4typeE(i32* dereferenceable(4)) #2 comdat {
  %2 = alloca i32*, align 8
  store i32* %0, i32** %2, align 8
  %3 = load i32*, i32** %2, align 8
  ret i32* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZNSt11_Tuple_implILm0EJRKiEE7_M_headERS2_(%"struct.std::_Tuple_impl.287"* dereferenceable(8)) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Tuple_impl.287"*, align 8
  store %"struct.std::_Tuple_impl.287"* %0, %"struct.std::_Tuple_impl.287"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.287"*, %"struct.std::_Tuple_impl.287"** %2, align 8
  %4 = bitcast %"struct.std::_Tuple_impl.287"* %3 to %"struct.std::_Head_base.288"*
  %5 = call dereferenceable(4) i32* @_ZNSt10_Head_baseILm0ERKiLb0EE7_M_headERS2_(%"struct.std::_Head_base.288"* dereferenceable(8) %4) #3
  ret i32* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt10_Head_baseILm0ERKiLb0EEC2ES1_(%"struct.std::_Head_base.288"*, i32* dereferenceable(4)) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"struct.std::_Head_base.288"*, align 8
  %4 = alloca i32*, align 8
  store %"struct.std::_Head_base.288"* %0, %"struct.std::_Head_base.288"** %3, align 8
  store i32* %1, i32** %4, align 8
  %5 = load %"struct.std::_Head_base.288"*, %"struct.std::_Head_base.288"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::_Head_base.288", %"struct.std::_Head_base.288"* %5, i32 0, i32 0
  %7 = load i32*, i32** %4, align 8
  store i32* %7, i32** %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZNSt10_Head_baseILm0ERKiLb0EE7_M_headERS2_(%"struct.std::_Head_base.288"* dereferenceable(8)) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Head_base.288"*, align 8
  store %"struct.std::_Head_base.288"* %0, %"struct.std::_Head_base.288"** %2, align 8
  %3 = load %"struct.std::_Head_base.288"*, %"struct.std::_Head_base.288"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Head_base.288", %"struct.std::_Head_base.288"* %3, i32 0, i32 0
  %5 = load i32*, i32** %4, align 8
  ret i32* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt4pairIKiN5minou4AtomEEC2IJRS0_EJLm0EEJEJEEERSt5tupleIJDpT_EERS6_IJDpT1_EESt12_Index_tupleIJXspT0_EEESF_IJXspT2_EEE(%"struct.std::pair.283"*, %"class.std::tuple.286"* dereferenceable(8), %"class.std::tuple.289"* dereferenceable(1)) unnamed_addr #2 comdat align 2 {
  %4 = alloca %"struct.std::_Index_tuple", align 1
  %5 = alloca %"struct.std::_Index_tuple.295", align 1
  %6 = alloca %"struct.std::pair.283"*, align 8
  %7 = alloca %"class.std::tuple.286"*, align 8
  %8 = alloca %"class.std::tuple.289"*, align 8
  store %"struct.std::pair.283"* %0, %"struct.std::pair.283"** %6, align 8
  store %"class.std::tuple.286"* %1, %"class.std::tuple.286"** %7, align 8
  store %"class.std::tuple.289"* %2, %"class.std::tuple.289"** %8, align 8
  %9 = load %"struct.std::pair.283"*, %"struct.std::pair.283"** %6, align 8
  %10 = bitcast %"struct.std::pair.283"* %9 to %"class.std::__pair_base.284"*
  %11 = getelementptr inbounds %"struct.std::pair.283", %"struct.std::pair.283"* %9, i32 0, i32 0
  %12 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %7, align 8
  %13 = call dereferenceable(4) i32* @_ZSt3getILm0EJRKiEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS6_(%"class.std::tuple.286"* dereferenceable(8) %12) #3
  %14 = call dereferenceable(4) i32* @_ZSt7forwardIRKiEOT_RNSt16remove_referenceIS2_E4typeE(i32* dereferenceable(4) %13) #3
  %15 = load i32, i32* %14, align 4
  store i32 %15, i32* %11, align 8
  %16 = getelementptr inbounds %"struct.std::pair.283", %"struct.std::pair.283"* %9, i32 0, i32 1
  %17 = bitcast %"struct.minou::Atom"* %16 to i8*
  call void @llvm.memset.p0i8.i64(i8* %17, i8 0, i64 8, i32 8, i1 false)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZSt3getILm0EJRKiEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS6_(%"class.std::tuple.286"* dereferenceable(8)) #2 comdat {
  %2 = alloca %"class.std::tuple.286"*, align 8
  store %"class.std::tuple.286"* %0, %"class.std::tuple.286"** %2, align 8
  %3 = load %"class.std::tuple.286"*, %"class.std::tuple.286"** %2, align 8
  %4 = bitcast %"class.std::tuple.286"* %3 to %"struct.std::_Tuple_impl.287"*
  %5 = call dereferenceable(4) i32* @_ZSt12__get_helperILm0ERKiJEERT0_RSt11_Tuple_implIXT_EJS2_DpT1_EE(%"struct.std::_Tuple_impl.287"* dereferenceable(8) %4) #3
  ret i32* %5
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZSt12__get_helperILm0ERKiJEERT0_RSt11_Tuple_implIXT_EJS2_DpT1_EE(%"struct.std::_Tuple_impl.287"* dereferenceable(8)) #2 comdat {
  %2 = alloca %"struct.std::_Tuple_impl.287"*, align 8
  store %"struct.std::_Tuple_impl.287"* %0, %"struct.std::_Tuple_impl.287"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.287"*, %"struct.std::_Tuple_impl.287"** %2, align 8
  %4 = call dereferenceable(4) i32* @_ZNSt11_Tuple_implILm0EJRKiEE7_M_headERS2_(%"struct.std::_Tuple_impl.287"* dereferenceable(8) %3) #3
  ret i32* %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE10deallocateERS7_PS6_m(%"class.std::allocator"* dereferenceable(1), %"struct.std::_Rb_tree_node"*, i64) #0 comdat align 2 {
  %4 = alloca %"class.std::allocator"*, align 8
  %5 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %6 = alloca i64, align 8
  store %"class.std::allocator"* %0, %"class.std::allocator"** %4, align 8
  store %"struct.std::_Rb_tree_node"* %1, %"struct.std::_Rb_tree_node"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.std::allocator"*, %"class.std::allocator"** %4, align 8
  %8 = bitcast %"class.std::allocator"* %7 to %"class.__gnu_cxx::new_allocator"*
  %9 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %5, align 8
  %10 = load i64, i64* %6, align 8
  call void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE10deallocateEPS7_m(%"class.__gnu_cxx::new_allocator"* %8, %"struct.std::_Rb_tree_node"* %9, i64 %10)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE10deallocateEPS7_m(%"class.__gnu_cxx::new_allocator"*, %"struct.std::_Rb_tree_node"*, i64) #2 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  %5 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %6 = alloca i64, align 8
  store %"class.__gnu_cxx::new_allocator"* %0, %"class.__gnu_cxx::new_allocator"** %4, align 8
  store %"struct.std::_Rb_tree_node"* %1, %"struct.std::_Rb_tree_node"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %4, align 8
  %8 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %5, align 8
  %9 = bitcast %"struct.std::_Rb_tree_node"* %8 to i8*
  call void @_ZdlPv(i8* %9) #3
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #10

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNKSt23_Rb_tree_const_iteratorISt4pairIKiN5minou4AtomEEE13_M_const_castEv(%"struct.std::_Rb_tree_const_iterator"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %3 = alloca %"struct.std::_Rb_tree_const_iterator"*, align 8
  store %"struct.std::_Rb_tree_const_iterator"* %0, %"struct.std::_Rb_tree_const_iterator"** %3, align 8
  %4 = load %"struct.std::_Rb_tree_const_iterator"*, %"struct.std::_Rb_tree_const_iterator"** %3, align 8
  %5 = getelementptr inbounds %"struct.std::_Rb_tree_const_iterator", %"struct.std::_Rb_tree_const_iterator"* %4, i32 0, i32 0
  %6 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %5, align 8
  call void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"* %2, %"struct.std::_Rb_tree_node_base"* %6) #3
  %7 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %2, i32 0, i32 0
  %8 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %7, align 8
  ret %"struct.std::_Rb_tree_node_base"* %8
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZNKSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE4sizeEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %2, align 8
  %3 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 8
  %7 = bitcast i8* %6 to %"struct.std::_Rb_tree_header"*
  %8 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %7, i32 0, i32 1
  %9 = load i64, i64* %8, align 8
  ret i64 %9
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"*) #0 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %3 = alloca %"struct.std::_Select1st", align 1
  store %"struct.std::_Rb_tree_node_base"* %0, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %4 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %5 = call dereferenceable(16) %"struct.std::pair.283"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_valueEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %4)
  %6 = call dereferenceable(4) i32* @_ZNKSt10_Select1stISt4pairIKiN5minou4AtomEEEclERKS4_(%"struct.std::_Select1st"* %3, %"struct.std::pair.283"* dereferenceable(16) %5)
  ret i32* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE12_M_rightmostEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %2, align 8
  %3 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 8
  %7 = bitcast i8* %6 to %"struct.std::_Rb_tree_header"*
  %8 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %7, i32 0, i32 0
  %9 = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %8, i32 0, i32 3
  ret %"struct.std::_Rb_tree_node_base"** %9
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEERKS1_OT_(%"struct.std::pair.292"*, %"struct.std::_Rb_tree_node_base"** dereferenceable(8), %"struct.std::_Rb_tree_node_base"** dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %4 = alloca %"struct.std::pair.292"*, align 8
  %5 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  %6 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  store %"struct.std::pair.292"* %0, %"struct.std::pair.292"** %4, align 8
  store %"struct.std::_Rb_tree_node_base"** %1, %"struct.std::_Rb_tree_node_base"*** %5, align 8
  store %"struct.std::_Rb_tree_node_base"** %2, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %7 = load %"struct.std::pair.292"*, %"struct.std::pair.292"** %4, align 8
  %8 = bitcast %"struct.std::pair.292"* %7 to %"class.std::__pair_base.293"*
  %9 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 0
  %10 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %5, align 8
  %11 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %10, align 8
  store %"struct.std::_Rb_tree_node_base"* %11, %"struct.std::_Rb_tree_node_base"** %9, align 8
  %12 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 1
  %13 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %14 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZSt7forwardIRPSt18_Rb_tree_node_baseEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::_Rb_tree_node_base"** dereferenceable(8) %13) #3
  %15 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %14, align 8
  store %"struct.std::_Rb_tree_node_base"* %15, %"struct.std::_Rb_tree_node_base"** %12, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE24_M_get_insert_unique_posERS1_(%"class.std::_Rb_tree"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %3 = alloca %"struct.std::pair.292", align 8
  %4 = alloca %"class.std::_Rb_tree"*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca %"struct.std::_Rb_tree_node"*, align 8
  %7 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  %8 = alloca i8, align 1
  %9 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %10 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %11 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %4, align 8
  store i32* %1, i32** %5, align 8
  %12 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %4, align 8
  %13 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_M_beginEv(%"class.std::_Rb_tree"* %12) #3
  store %"struct.std::_Rb_tree_node"* %13, %"struct.std::_Rb_tree_node"** %6, align 8
  %14 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_M_endEv(%"class.std::_Rb_tree"* %12) #3
  store %"struct.std::_Rb_tree_node_base"* %14, %"struct.std::_Rb_tree_node_base"** %7, align 8
  store i8 1, i8* %8, align 1
  br label %15

; <label>:15:                                     ; preds = %39, %2
  %16 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %6, align 8
  %17 = icmp ne %"struct.std::_Rb_tree_node"* %16, null
  br i1 %17, label %18, label %41

; <label>:18:                                     ; preds = %15
  %19 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %6, align 8
  %20 = bitcast %"struct.std::_Rb_tree_node"* %19 to %"struct.std::_Rb_tree_node_base"*
  store %"struct.std::_Rb_tree_node_base"* %20, %"struct.std::_Rb_tree_node_base"** %7, align 8
  %21 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %12, i32 0, i32 0
  %22 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %21 to %"struct.std::_Rb_tree_key_compare"*
  %23 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %22, i32 0, i32 0
  %24 = load i32*, i32** %5, align 8
  %25 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %6, align 8
  %26 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt13_Rb_tree_nodeIS4_E(%"struct.std::_Rb_tree_node"* %25)
  %27 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %23, i32* dereferenceable(4) %24, i32* dereferenceable(4) %26)
  %28 = zext i1 %27 to i8
  store i8 %28, i8* %8, align 1
  %29 = load i8, i8* %8, align 1
  %30 = trunc i8 %29 to i1
  br i1 %30, label %31, label %35

; <label>:31:                                     ; preds = %18
  %32 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %6, align 8
  %33 = bitcast %"struct.std::_Rb_tree_node"* %32 to %"struct.std::_Rb_tree_node_base"*
  %34 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE7_S_leftEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %33) #3
  br label %39

; <label>:35:                                     ; preds = %18
  %36 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %6, align 8
  %37 = bitcast %"struct.std::_Rb_tree_node"* %36 to %"struct.std::_Rb_tree_node_base"*
  %38 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_rightEPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %37) #3
  br label %39

; <label>:39:                                     ; preds = %35, %31
  %40 = phi %"struct.std::_Rb_tree_node"* [ %34, %31 ], [ %38, %35 ]
  store %"struct.std::_Rb_tree_node"* %40, %"struct.std::_Rb_tree_node"** %6, align 8
  br label %15

; <label>:41:                                     ; preds = %15
  %42 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %7, align 8
  call void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"* %9, %"struct.std::_Rb_tree_node_base"* %42) #3
  %43 = load i8, i8* %8, align 1
  %44 = trunc i8 %43 to i1
  br i1 %44, label %45, label %53

; <label>:45:                                     ; preds = %41
  %46 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE5beginEv(%"class.std::_Rb_tree"* %12) #3
  %47 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %10, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %46, %"struct.std::_Rb_tree_node_base"** %47, align 8
  %48 = call zeroext i1 @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEeqERKS5_(%"struct.std::_Rb_tree_iterator"* %9, %"struct.std::_Rb_tree_iterator"* dereferenceable(8) %10) #3
  br i1 %48, label %49, label %50

; <label>:49:                                     ; preds = %45
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRPSt13_Rb_tree_nodeIS_IKiN5minou4AtomEEERS1_Lb1EEEOT_OT0_(%"struct.std::pair.292"* %3, %"struct.std::_Rb_tree_node"** dereferenceable(8) %6, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %7)
  br label %65

; <label>:50:                                     ; preds = %45
  %51 = call dereferenceable(8) %"struct.std::_Rb_tree_iterator"* @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEmmEv(%"struct.std::_Rb_tree_iterator"* %9) #3
  br label %52

; <label>:52:                                     ; preds = %50
  br label %53

; <label>:53:                                     ; preds = %52, %41
  %54 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %12, i32 0, i32 0
  %55 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %54 to %"struct.std::_Rb_tree_key_compare"*
  %56 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %55, i32 0, i32 0
  %57 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %9, i32 0, i32 0
  %58 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %57, align 8
  %59 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %58)
  %60 = load i32*, i32** %5, align 8
  %61 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %56, i32* dereferenceable(4) %59, i32* dereferenceable(4) %60)
  br i1 %61, label %62, label %63

; <label>:62:                                     ; preds = %53
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRPSt13_Rb_tree_nodeIS_IKiN5minou4AtomEEERS1_Lb1EEEOT_OT0_(%"struct.std::pair.292"* %3, %"struct.std::_Rb_tree_node"** dereferenceable(8) %6, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %7)
  br label %65

; <label>:63:                                     ; preds = %53
  %64 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %9, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* null, %"struct.std::_Rb_tree_node_base"** %11, align 8
  call void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEEOT_RKS1_(%"struct.std::pair.292"* %3, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %64, %"struct.std::_Rb_tree_node_base"** dereferenceable(8) %11)
  br label %65

; <label>:65:                                     ; preds = %63, %62, %49
  %66 = bitcast %"struct.std::pair.292"* %3 to { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }*
  %67 = load { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }, { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* }* %66, align 8
  ret { %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* } %67
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE11_M_leftmostEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %2, align 8
  %3 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 8
  %7 = bitcast i8* %6 to %"struct.std::_Rb_tree_header"*
  %8 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %7, i32 0, i32 0
  %9 = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %8, i32 0, i32 2
  ret %"struct.std::_Rb_tree_node_base"** %9
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_S4_Lb1EEEOT_OT0_(%"struct.std::pair.292"*, %"struct.std::_Rb_tree_node_base"** dereferenceable(8), %"struct.std::_Rb_tree_node_base"** dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %4 = alloca %"struct.std::pair.292"*, align 8
  %5 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  %6 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  store %"struct.std::pair.292"* %0, %"struct.std::pair.292"** %4, align 8
  store %"struct.std::_Rb_tree_node_base"** %1, %"struct.std::_Rb_tree_node_base"*** %5, align 8
  store %"struct.std::_Rb_tree_node_base"** %2, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %7 = load %"struct.std::pair.292"*, %"struct.std::pair.292"** %4, align 8
  %8 = bitcast %"struct.std::pair.292"* %7 to %"class.std::__pair_base.293"*
  %9 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 0
  %10 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %5, align 8
  %11 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZSt7forwardIRPSt18_Rb_tree_node_baseEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::_Rb_tree_node_base"** dereferenceable(8) %10) #3
  %12 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %11, align 8
  store %"struct.std::_Rb_tree_node_base"* %12, %"struct.std::_Rb_tree_node_base"** %9, align 8
  %13 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 1
  %14 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %15 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZSt7forwardIRPSt18_Rb_tree_node_baseEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::_Rb_tree_node_base"** dereferenceable(8) %14) #3
  %16 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %15, align 8
  store %"struct.std::_Rb_tree_node_base"* %16, %"struct.std::_Rb_tree_node_base"** %13, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.std::_Rb_tree_iterator"* @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEmmEv(%"struct.std::_Rb_tree_iterator"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  store %"struct.std::_Rb_tree_iterator"* %0, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %5 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %4, align 8
  %6 = call %"struct.std::_Rb_tree_node_base"* @_ZSt18_Rb_tree_decrementPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %5) #15
  %7 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %6, %"struct.std::_Rb_tree_node_base"** %7, align 8
  ret %"struct.std::_Rb_tree_iterator"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.std::_Rb_tree_iterator"* @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEppEv(%"struct.std::_Rb_tree_iterator"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  store %"struct.std::_Rb_tree_iterator"* %0, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %5 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %4, align 8
  %6 = call %"struct.std::_Rb_tree_node_base"* @_ZSt18_Rb_tree_incrementPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %5) #15
  %7 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %6, %"struct.std::_Rb_tree_node_base"** %7, align 8
  ret %"struct.std::_Rb_tree_iterator"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRS1_Lb1EEEOT_RKS1_(%"struct.std::pair.292"*, %"struct.std::_Rb_tree_node_base"** dereferenceable(8), %"struct.std::_Rb_tree_node_base"** dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %4 = alloca %"struct.std::pair.292"*, align 8
  %5 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  %6 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  store %"struct.std::pair.292"* %0, %"struct.std::pair.292"** %4, align 8
  store %"struct.std::_Rb_tree_node_base"** %1, %"struct.std::_Rb_tree_node_base"*** %5, align 8
  store %"struct.std::_Rb_tree_node_base"** %2, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %7 = load %"struct.std::pair.292"*, %"struct.std::pair.292"** %4, align 8
  %8 = bitcast %"struct.std::pair.292"* %7 to %"class.std::__pair_base.293"*
  %9 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 0
  %10 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %5, align 8
  %11 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZSt7forwardIRPSt18_Rb_tree_node_baseEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::_Rb_tree_node_base"** dereferenceable(8) %10) #3
  %12 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %11, align 8
  store %"struct.std::_Rb_tree_node_base"* %12, %"struct.std::_Rb_tree_node_base"** %9, align 8
  %13 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 1
  %14 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %15 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %14, align 8
  store %"struct.std::_Rb_tree_node_base"* %15, %"struct.std::_Rb_tree_node_base"** %13, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(16) %"struct.std::pair.283"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_S_valueEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_node_base"*, align 8
  store %"struct.std::_Rb_tree_node_base"* %0, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %2, align 8
  %4 = bitcast %"struct.std::_Rb_tree_node_base"* %3 to %"struct.std::_Rb_tree_node"*
  %5 = call %"struct.std::pair.283"* @_ZNKSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %4)
  ret %"struct.std::pair.283"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZSt7forwardIRPSt18_Rb_tree_node_baseEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::_Rb_tree_node_base"** dereferenceable(8)) #2 comdat {
  %2 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  store %"struct.std::_Rb_tree_node_base"** %0, %"struct.std::_Rb_tree_node_base"*** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %2, align 8
  ret %"struct.std::_Rb_tree_node_base"** %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE5beginEv(%"class.std::_Rb_tree"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %3 = alloca %"class.std::_Rb_tree"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %3, align 8
  %4 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %3, align 8
  %5 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %4, i32 0, i32 0
  %6 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 8
  %8 = bitcast i8* %7 to %"struct.std::_Rb_tree_header"*
  %9 = getelementptr inbounds %"struct.std::_Rb_tree_header", %"struct.std::_Rb_tree_header"* %8, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::_Rb_tree_node_base", %"struct.std::_Rb_tree_node_base"* %9, i32 0, i32 2
  %11 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %10, align 8
  call void @_ZNSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEC2EPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_iterator"* %2, %"struct.std::_Rb_tree_node_base"* %11) #3
  %12 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %2, i32 0, i32 0
  %13 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %12, align 8
  ret %"struct.std::_Rb_tree_node_base"* %13
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt4pairIPSt18_Rb_tree_node_baseS1_EC2IRPSt13_Rb_tree_nodeIS_IKiN5minou4AtomEEERS1_Lb1EEEOT_OT0_(%"struct.std::pair.292"*, %"struct.std::_Rb_tree_node"** dereferenceable(8), %"struct.std::_Rb_tree_node_base"** dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %4 = alloca %"struct.std::pair.292"*, align 8
  %5 = alloca %"struct.std::_Rb_tree_node"**, align 8
  %6 = alloca %"struct.std::_Rb_tree_node_base"**, align 8
  store %"struct.std::pair.292"* %0, %"struct.std::pair.292"** %4, align 8
  store %"struct.std::_Rb_tree_node"** %1, %"struct.std::_Rb_tree_node"*** %5, align 8
  store %"struct.std::_Rb_tree_node_base"** %2, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %7 = load %"struct.std::pair.292"*, %"struct.std::pair.292"** %4, align 8
  %8 = bitcast %"struct.std::pair.292"* %7 to %"class.std::__pair_base.293"*
  %9 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 0
  %10 = load %"struct.std::_Rb_tree_node"**, %"struct.std::_Rb_tree_node"*** %5, align 8
  %11 = call dereferenceable(8) %"struct.std::_Rb_tree_node"** @_ZSt7forwardIRPSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEOT_RNSt16remove_referenceIS9_E4typeE(%"struct.std::_Rb_tree_node"** dereferenceable(8) %10) #3
  %12 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %11, align 8
  %13 = bitcast %"struct.std::_Rb_tree_node"* %12 to %"struct.std::_Rb_tree_node_base"*
  store %"struct.std::_Rb_tree_node_base"* %13, %"struct.std::_Rb_tree_node_base"** %9, align 8
  %14 = getelementptr inbounds %"struct.std::pair.292", %"struct.std::pair.292"* %7, i32 0, i32 1
  %15 = load %"struct.std::_Rb_tree_node_base"**, %"struct.std::_Rb_tree_node_base"*** %6, align 8
  %16 = call dereferenceable(8) %"struct.std::_Rb_tree_node_base"** @_ZSt7forwardIRPSt18_Rb_tree_node_baseEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.std::_Rb_tree_node_base"** dereferenceable(8) %15) #3
  %17 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %16, align 8
  store %"struct.std::_Rb_tree_node_base"* %17, %"struct.std::_Rb_tree_node_base"** %14, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.std::_Rb_tree_node"** @_ZSt7forwardIRPSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEOT_RNSt16remove_referenceIS9_E4typeE(%"struct.std::_Rb_tree_node"** dereferenceable(8)) #2 comdat {
  %2 = alloca %"struct.std::_Rb_tree_node"**, align 8
  store %"struct.std::_Rb_tree_node"** %0, %"struct.std::_Rb_tree_node"*** %2, align 8
  %3 = load %"struct.std::_Rb_tree_node"**, %"struct.std::_Rb_tree_node"*** %2, align 8
  ret %"struct.std::_Rb_tree_node"** %3
}

; Function Attrs: nounwind readonly
declare %"struct.std::_Rb_tree_node_base"* @_ZSt18_Rb_tree_decrementPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"*) #11

; Function Attrs: nounwind readonly
declare %"struct.std::_Rb_tree_node_base"* @_ZSt18_Rb_tree_incrementPSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"*) #11

; Function Attrs: nounwind
declare void @_ZSt29_Rb_tree_insert_and_rebalancebPSt18_Rb_tree_node_baseS0_RS_(i1 zeroext, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"* dereferenceable(32)) #12

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE15_M_destroy_nodeEPSt13_Rb_tree_nodeIS4_E(%"class.std::_Rb_tree"*, %"struct.std::_Rb_tree_node"*) #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::_Rb_tree"*, align 8
  %4 = alloca %"struct.std::_Rb_tree_node"*, align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %3, align 8
  store %"struct.std::_Rb_tree_node"* %1, %"struct.std::_Rb_tree_node"** %4, align 8
  %5 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %3, align 8
  %6 = call dereferenceable(1) %"class.std::allocator"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE21_M_get_Node_allocatorEv(%"class.std::_Rb_tree"* %5) #3
  %7 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %4, align 8
  %8 = invoke %"struct.std::pair.283"* @_ZNSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %7)
          to label %9 unwind label %12

; <label>:9:                                      ; preds = %2
  invoke void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE7destroyIS5_EEvRS7_PT_(%"class.std::allocator"* dereferenceable(1) %6, %"struct.std::pair.283"* %8)
          to label %10 unwind label %12

; <label>:10:                                     ; preds = %9
  %11 = load %"struct.std::_Rb_tree_node"*, %"struct.std::_Rb_tree_node"** %4, align 8
  ret void

; <label>:12:                                     ; preds = %9, %2
  %13 = landingpad { i8*, i32 }
          catch i8* null
  %14 = extractvalue { i8*, i32 } %13, 0
  call void @__clang_call_terminate(i8* %14) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEEE7destroyIS5_EEvRS7_PT_(%"class.std::allocator"* dereferenceable(1), %"struct.std::pair.283"*) #0 comdat align 2 {
  %3 = alloca %"class.std::allocator"*, align 8
  %4 = alloca %"struct.std::pair.283"*, align 8
  store %"class.std::allocator"* %0, %"class.std::allocator"** %3, align 8
  store %"struct.std::pair.283"* %1, %"struct.std::pair.283"** %4, align 8
  %5 = load %"class.std::allocator"*, %"class.std::allocator"** %3, align 8
  %6 = bitcast %"class.std::allocator"* %5 to %"class.__gnu_cxx::new_allocator"*
  %7 = load %"struct.std::pair.283"*, %"struct.std::pair.283"** %4, align 8
  call void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE7destroyIS6_EEvPT_(%"class.__gnu_cxx::new_allocator"* %6, %"struct.std::pair.283"* %7)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEEE7destroyIS6_EEvPT_(%"class.__gnu_cxx::new_allocator"*, %"struct.std::pair.283"*) #2 comdat align 2 {
  %3 = alloca %"class.__gnu_cxx::new_allocator"*, align 8
  %4 = alloca %"struct.std::pair.283"*, align 8
  store %"class.__gnu_cxx::new_allocator"* %0, %"class.__gnu_cxx::new_allocator"** %3, align 8
  store %"struct.std::pair.283"* %1, %"struct.std::pair.283"** %4, align 8
  %5 = load %"class.__gnu_cxx::new_allocator"*, %"class.__gnu_cxx::new_allocator"** %3, align 8
  %6 = load %"struct.std::pair.283"*, %"struct.std::pair.283"** %4, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt11_Tuple_implILm0EJRKiEEC2ES1_(%"struct.std::_Tuple_impl.287"*, i32* dereferenceable(4)) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"struct.std::_Tuple_impl.287"*, align 8
  %4 = alloca i32*, align 8
  store %"struct.std::_Tuple_impl.287"* %0, %"struct.std::_Tuple_impl.287"** %3, align 8
  store i32* %1, i32** %4, align 8
  %5 = load %"struct.std::_Tuple_impl.287"*, %"struct.std::_Tuple_impl.287"** %3, align 8
  %6 = bitcast %"struct.std::_Tuple_impl.287"* %5 to %"struct.std::_Head_base.288"*
  %7 = load i32*, i32** %4, align 8
  call void @_ZNSt10_Head_baseILm0ERKiLb0EEC2ES1_(%"struct.std::_Head_base.288"* %6, i32* dereferenceable(4) %7)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i8 @_ZNK5minou4Atom8get_typeEv(%"struct.minou::Atom"*) #0 comdat align 2 {
  %2 = alloca i8, align 1
  %3 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %3, align 8
  %4 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %3, align 8
  %5 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  %6 = load i64, i64* %5, align 8
  %7 = and i64 %6, 7
  switch i64 %7, label %12 [
    i64 1, label %8
    i64 2, label %9
    i64 3, label %10
    i64 4, label %11
  ]

; <label>:8:                                      ; preds = %1
  store i8 0, i8* %2, align 1
  br label %18

; <label>:9:                                      ; preds = %1
  store i8 5, i8* %2, align 1
  br label %18

; <label>:10:                                     ; preds = %1
  store i8 4, i8* %2, align 1
  br label %18

; <label>:11:                                     ; preds = %1
  store i8 2, i8* %2, align 1
  br label %18

; <label>:12:                                     ; preds = %1
  %13 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %4, i32 0, i32 0
  %14 = load i64, i64* %13, align 8
  %15 = sub i64 %14, 8
  %16 = inttoptr i64 %15 to %"struct.minou::HeapNode"*
  %17 = call zeroext i8 @_ZNK5minou8HeapNode4typeEv(%"struct.minou::HeapNode"* %16)
  store i8 %17, i8* %2, align 1
  br label %18

; <label>:18:                                     ; preds = %12, %11, %10, %9, %8
  %19 = load i8, i8* %2, align 1
  ret i8 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i32 @_ZN5minou6Symbol4fromEi(i32) #2 comdat align 2 {
  %2 = alloca %"struct.minou::Symbol", align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  %4 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %2, i32 0, i32 0
  %5 = load i32, i32* %3, align 4
  store i32 %5, i32* %4, align 4
  %6 = getelementptr inbounds %"struct.minou::Symbol", %"struct.minou::Symbol"* %2, i32 0, i32 0
  %7 = load i32, i32* %6, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i8 @_ZNK5minou8HeapNode4typeEv(%"struct.minou::HeapNode"*) #2 comdat align 2 {
  %2 = alloca %"struct.minou::HeapNode"*, align 8
  store %"struct.minou::HeapNode"* %0, %"struct.minou::HeapNode"** %2, align 8
  %3 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %2, align 8
  %4 = getelementptr inbounds %"struct.minou::HeapNode", %"struct.minou::HeapNode"* %3, i32 0, i32 0
  %5 = load i64, i64* %4, align 8
  %6 = and i64 %5, 255
  %7 = trunc i64 %6 to i8
  ret i8 %7
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt3mapIiN5minou4AtomESt4lessIiESaISt4pairIKiS1_EEE4findERS5_(%"class.std::map"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %3 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %4 = alloca %"class.std::map"*, align 8
  %5 = alloca i32*, align 8
  store %"class.std::map"* %0, %"class.std::map"** %4, align 8
  store i32* %1, i32** %5, align 8
  %6 = load %"class.std::map"*, %"class.std::map"** %4, align 8
  %7 = getelementptr inbounds %"class.std::map", %"class.std::map"* %6, i32 0, i32 0
  %8 = load i32*, i32** %5, align 8
  %9 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE4findERS1_(%"class.std::_Rb_tree"* %7, i32* dereferenceable(4) %8)
  %10 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %9, %"struct.std::_Rb_tree_node_base"** %10, align 8
  %11 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %12 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %11, align 8
  ret %"struct.std::_Rb_tree_node_base"* %12
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt8optionalIN5minou4AtomEEC2Ev(%"class.std::optional"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::optional"*, align 8
  store %"class.std::optional"* %0, %"class.std::optional"** %2, align 8
  %3 = load %"class.std::optional"*, %"class.std::optional"** %2, align 8
  %4 = bitcast %"class.std::optional"* %3 to %"class.std::_Optional_base"*
  call void @_ZNSt14_Optional_baseIN5minou4AtomEEC2Ev(%"class.std::_Optional_base"* %4) #3
  %5 = bitcast %"class.std::optional"* %3 to %"struct.std::_Enable_copy_move"*
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::pair.283"* @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEptEv(%"struct.std::_Rb_tree_iterator"*) #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"struct.std::_Rb_tree_iterator"*, align 8
  store %"struct.std::_Rb_tree_iterator"* %0, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %3 = load %"struct.std::_Rb_tree_iterator"*, %"struct.std::_Rb_tree_iterator"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %5 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %4, align 8
  %6 = bitcast %"struct.std::_Rb_tree_node_base"* %5 to %"struct.std::_Rb_tree_node"*
  %7 = invoke %"struct.std::pair.283"* @_ZNSt13_Rb_tree_nodeISt4pairIKiN5minou4AtomEEE9_M_valptrEv(%"struct.std::_Rb_tree_node"* %6)
          to label %8 unwind label %9

; <label>:8:                                      ; preds = %1
  ret %"struct.std::pair.283"* %7

; <label>:9:                                      ; preds = %1
  %10 = landingpad { i8*, i32 }
          catch i8* null
  %11 = extractvalue { i8*, i32 } %10, 0
  call void @__clang_call_terminate(i8* %11) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt8optionalIN5minou4AtomEEC2IRS1_Lb1EEEOT_(%"class.std::optional"*, %"struct.minou::Atom"* dereferenceable(8)) unnamed_addr #0 comdat align 2 {
  %3 = alloca %"class.std::optional"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  %5 = alloca %"struct.std::in_place_t", align 1
  store %"class.std::optional"* %0, %"class.std::optional"** %3, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %4, align 8
  %6 = load %"class.std::optional"*, %"class.std::optional"** %3, align 8
  %7 = bitcast %"class.std::optional"* %6 to %"class.std::_Optional_base"*
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %9 = call dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRN5minou4AtomEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.minou::Atom"* dereferenceable(8) %8) #3
  call void @_ZNSt14_Optional_baseIN5minou4AtomEEC2IJRS1_ELb0EEESt10in_place_tDpOT_(%"class.std::_Optional_base"* %7, %"struct.minou::Atom"* dereferenceable(8) %9)
  %10 = bitcast %"class.std::optional"* %6 to %"struct.std::_Enable_copy_move"*
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE4findERS1_(%"class.std::_Rb_tree"*, i32* dereferenceable(4)) #0 comdat align 2 {
  %3 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %4 = alloca %"class.std::_Rb_tree"*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca %"struct.std::_Rb_tree_iterator", align 8
  %7 = alloca %"struct.std::_Rb_tree_iterator", align 8
  store %"class.std::_Rb_tree"* %0, %"class.std::_Rb_tree"** %4, align 8
  store i32* %1, i32** %5, align 8
  %8 = load %"class.std::_Rb_tree"*, %"class.std::_Rb_tree"** %4, align 8
  %9 = call %"struct.std::_Rb_tree_node"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE8_M_beginEv(%"class.std::_Rb_tree"* %8) #3
  %10 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_M_endEv(%"class.std::_Rb_tree"* %8) #3
  %11 = load i32*, i32** %5, align 8
  %12 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE14_M_lower_boundEPSt13_Rb_tree_nodeIS4_EPSt18_Rb_tree_node_baseRS1_(%"class.std::_Rb_tree"* %8, %"struct.std::_Rb_tree_node"* %9, %"struct.std::_Rb_tree_node_base"* %10, i32* dereferenceable(4) %11)
  %13 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %6, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %12, %"struct.std::_Rb_tree_node_base"** %13, align 8
  %14 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE3endEv(%"class.std::_Rb_tree"* %8) #3
  %15 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %7, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %14, %"struct.std::_Rb_tree_node_base"** %15, align 8
  %16 = call zeroext i1 @_ZNKSt17_Rb_tree_iteratorISt4pairIKiN5minou4AtomEEEeqERKS5_(%"struct.std::_Rb_tree_iterator"* %6, %"struct.std::_Rb_tree_iterator"* dereferenceable(8) %7) #3
  br i1 %16, label %26, label %17

; <label>:17:                                     ; preds = %2
  %18 = getelementptr inbounds %"class.std::_Rb_tree", %"class.std::_Rb_tree"* %8, i32 0, i32 0
  %19 = bitcast %"struct.std::_Rb_tree<int, std::pair<const int, minou::Atom>, std::_Select1st<std::pair<const int, minou::Atom> >, std::less<int>, std::allocator<std::pair<const int, minou::Atom> > >::_Rb_tree_impl"* %18 to %"struct.std::_Rb_tree_key_compare"*
  %20 = getelementptr inbounds %"struct.std::_Rb_tree_key_compare", %"struct.std::_Rb_tree_key_compare"* %19, i32 0, i32 0
  %21 = load i32*, i32** %5, align 8
  %22 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %6, i32 0, i32 0
  %23 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %22, align 8
  %24 = call dereferenceable(4) i32* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE6_S_keyEPKSt18_Rb_tree_node_base(%"struct.std::_Rb_tree_node_base"* %23)
  %25 = call zeroext i1 @_ZNKSt4lessIiEclERKiS2_(%"struct.std::less"* %20, i32* dereferenceable(4) %21, i32* dereferenceable(4) %24)
  br i1 %25, label %26, label %29

; <label>:26:                                     ; preds = %17, %2
  %27 = call %"struct.std::_Rb_tree_node_base"* @_ZNSt8_Rb_treeIiSt4pairIKiN5minou4AtomEESt10_Select1stIS4_ESt4lessIiESaIS4_EE3endEv(%"class.std::_Rb_tree"* %8) #3
  %28 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  store %"struct.std::_Rb_tree_node_base"* %27, %"struct.std::_Rb_tree_node_base"** %28, align 8
  br label %32

; <label>:29:                                     ; preds = %17
  %30 = bitcast %"struct.std::_Rb_tree_iterator"* %3 to i8*
  %31 = bitcast %"struct.std::_Rb_tree_iterator"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %30, i8* %31, i64 8, i32 8, i1 false)
  br label %32

; <label>:32:                                     ; preds = %29, %26
  %33 = getelementptr inbounds %"struct.std::_Rb_tree_iterator", %"struct.std::_Rb_tree_iterator"* %3, i32 0, i32 0
  %34 = load %"struct.std::_Rb_tree_node_base"*, %"struct.std::_Rb_tree_node_base"** %33, align 8
  ret %"struct.std::_Rb_tree_node_base"* %34
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt14_Optional_baseIN5minou4AtomEEC2Ev(%"class.std::_Optional_base"*) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::_Optional_base"*, align 8
  store %"class.std::_Optional_base"* %0, %"class.std::_Optional_base"** %2, align 8
  %3 = load %"class.std::_Optional_base"*, %"class.std::_Optional_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Optional_base", %"class.std::_Optional_base"* %3, i32 0, i32 0
  invoke void @_ZNSt17_Optional_payloadIN5minou4AtomELb1ELb1EEC2Ev(%"struct.std::_Optional_payload"* %4)
          to label %5 unwind label %6

; <label>:5:                                      ; preds = %1
  ret void

; <label>:6:                                      ; preds = %1
  %7 = landingpad { i8*, i32 }
          catch i8* null
  %8 = extractvalue { i8*, i32 } %7, 0
  call void @__clang_call_terminate(i8* %8) #7
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt17_Optional_payloadIN5minou4AtomELb1ELb1EEC2Ev(%"struct.std::_Optional_payload"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload"*, align 8
  store %"struct.std::_Optional_payload"* %0, %"struct.std::_Optional_payload"** %2, align 8
  %3 = load %"struct.std::_Optional_payload"*, %"struct.std::_Optional_payload"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload", %"struct.std::_Optional_payload"* %3, i32 0, i32 0
  %5 = bitcast %union.anon* %4 to %"struct.std::_Optional_payload<minou::Atom, true, true>::_Empty_byte"*
  %6 = getelementptr inbounds %"struct.std::_Optional_payload", %"struct.std::_Optional_payload"* %3, i32 0, i32 1
  store i8 0, i8* %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRN5minou4AtomEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.minou::Atom"* dereferenceable(8)) #2 comdat {
  %2 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %2, align 8
  %3 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %2, align 8
  ret %"struct.minou::Atom"* %3
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt14_Optional_baseIN5minou4AtomEEC2IJRS1_ELb0EEESt10in_place_tDpOT_(%"class.std::_Optional_base"*, %"struct.minou::Atom"* dereferenceable(8)) unnamed_addr #0 comdat align 2 {
  %3 = alloca %"struct.std::in_place_t", align 1
  %4 = alloca %"class.std::_Optional_base"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"struct.std::in_place_t", align 1
  store %"class.std::_Optional_base"* %0, %"class.std::_Optional_base"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  %7 = load %"class.std::_Optional_base"*, %"class.std::_Optional_base"** %4, align 8
  %8 = getelementptr inbounds %"class.std::_Optional_base", %"class.std::_Optional_base"* %7, i32 0, i32 0
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %10 = call dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRN5minou4AtomEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.minou::Atom"* dereferenceable(8) %9) #3
  call void @_ZNSt17_Optional_payloadIN5minou4AtomELb1ELb1EEC2IJRS1_EEESt10in_place_tDpOT_(%"struct.std::_Optional_payload"* %8, %"struct.minou::Atom"* dereferenceable(8) %10)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt17_Optional_payloadIN5minou4AtomELb1ELb1EEC2IJRS1_EEESt10in_place_tDpOT_(%"struct.std::_Optional_payload"*, %"struct.minou::Atom"* dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"struct.std::in_place_t", align 1
  %4 = alloca %"struct.std::_Optional_payload"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.std::_Optional_payload"* %0, %"struct.std::_Optional_payload"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  %6 = load %"struct.std::_Optional_payload"*, %"struct.std::_Optional_payload"** %4, align 8
  %7 = getelementptr inbounds %"struct.std::_Optional_payload", %"struct.std::_Optional_payload"* %6, i32 0, i32 0
  %8 = bitcast %union.anon* %7 to %"struct.minou::Atom"*
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %10 = call dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRN5minou4AtomEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.minou::Atom"* dereferenceable(8) %9) #3
  %11 = bitcast %"struct.minou::Atom"* %8 to i8*
  %12 = bitcast %"struct.minou::Atom"* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* %12, i64 8, i32 8, i1 false)
  %13 = getelementptr inbounds %"struct.std::_Optional_payload", %"struct.std::_Optional_payload"* %6, i32 0, i32 1
  store i8 1, i8* %13, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNKSt14_Optional_baseIN5minou4AtomEE13_M_is_engagedEv(%"class.std::_Optional_base"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Optional_base"*, align 8
  store %"class.std::_Optional_base"* %0, %"class.std::_Optional_base"** %2, align 8
  %3 = load %"class.std::_Optional_base"*, %"class.std::_Optional_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Optional_base", %"class.std::_Optional_base"* %3, i32 0, i32 0
  %5 = getelementptr inbounds %"struct.std::_Optional_payload", %"struct.std::_Optional_payload"* %4, i32 0, i32 1
  %6 = load i8, i8* %5, align 8
  %7 = trunc i8 %6 to i1
  ret i1 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"* @_ZNSt14_Optional_baseIN5minou4AtomEE6_M_getEv(%"class.std::_Optional_base"*) #2 comdat align 2 {
  %2 = alloca %"class.std::_Optional_base"*, align 8
  store %"class.std::_Optional_base"* %0, %"class.std::_Optional_base"** %2, align 8
  %3 = load %"class.std::_Optional_base"*, %"class.std::_Optional_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::_Optional_base", %"class.std::_Optional_base"* %3, i32 0, i32 0
  %5 = getelementptr inbounds %"struct.std::_Optional_payload", %"struct.std::_Optional_payload"* %4, i32 0, i32 0
  %6 = bitcast %union.anon* %5 to %"struct.minou::Atom"*
  ret %"struct.minou::Atom"* %6
}

; Function Attrs: noinline noreturn optnone uwtable
define linkonce_odr void @_ZSt27__throw_bad_optional_accessv() #13 comdat personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %1 = alloca i8*
  %2 = alloca i32
  %3 = call i8* @__cxa_allocate_exception(i64 8) #3
  %4 = bitcast i8* %3 to %"class.std::bad_optional_access"*
  invoke void @_ZNSt19bad_optional_accessC2Ev(%"class.std::bad_optional_access"* %4)
          to label %5 unwind label %6

; <label>:5:                                      ; preds = %0
  call void @__cxa_throw(i8* %3, i8* bitcast ({ i8*, i8*, i8* }* @_ZTISt19bad_optional_access to i8*), i8* bitcast (void (%"class.std::bad_optional_access"*)* @_ZNSt19bad_optional_accessD2Ev to i8*)) #14
  unreachable

; <label>:6:                                      ; preds = %0
  %7 = landingpad { i8*, i32 }
          cleanup
  %8 = extractvalue { i8*, i32 } %7, 0
  store i8* %8, i8** %1, align 8
  %9 = extractvalue { i8*, i32 } %7, 1
  store i32 %9, i32* %2, align 4
  call void @__cxa_free_exception(i8* %3) #3
  br label %11
                                                  ; No predecessors!
  unreachable

; <label>:11:                                     ; preds = %6
  %12 = load i8*, i8** %1, align 8
  %13 = load i32, i32* %2, align 4
  %14 = insertvalue { i8*, i32 } undef, i8* %12, 0
  %15 = insertvalue { i8*, i32 } %14, i32 %13, 1
  resume { i8*, i32 } %15
}

declare i8* @__cxa_allocate_exception(i64)

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt19bad_optional_accessC2Ev(%"class.std::bad_optional_access"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::bad_optional_access"*, align 8
  store %"class.std::bad_optional_access"* %0, %"class.std::bad_optional_access"** %2, align 8
  %3 = load %"class.std::bad_optional_access"*, %"class.std::bad_optional_access"** %2, align 8
  %4 = bitcast %"class.std::bad_optional_access"* %3 to %"class.std::exception"*
  call void @_ZNSt9exceptionC2Ev(%"class.std::exception"* %4) #3
  %5 = bitcast %"class.std::bad_optional_access"* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [5 x i8*] }, { [5 x i8*] }* @_ZTVSt19bad_optional_access, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %5, align 8
  ret void
}

declare void @__cxa_free_exception(i8*)

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt19bad_optional_accessD2Ev(%"class.std::bad_optional_access"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::bad_optional_access"*, align 8
  store %"class.std::bad_optional_access"* %0, %"class.std::bad_optional_access"** %2, align 8
  %3 = load %"class.std::bad_optional_access"*, %"class.std::bad_optional_access"** %2, align 8
  %4 = bitcast %"class.std::bad_optional_access"* %3 to %"class.std::exception"*
  call void @_ZNSt9exceptionD2Ev(%"class.std::exception"* %4) #3
  ret void
}

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt9exceptionC2Ev(%"class.std::exception"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::exception"*, align 8
  store %"class.std::exception"* %0, %"class.std::exception"** %2, align 8
  %3 = load %"class.std::exception"*, %"class.std::exception"** %2, align 8
  %4 = bitcast %"class.std::exception"* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [5 x i8*] }, { [5 x i8*] }* @_ZTVSt9exception, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %4, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt19bad_optional_accessD0Ev(%"class.std::bad_optional_access"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::bad_optional_access"*, align 8
  store %"class.std::bad_optional_access"* %0, %"class.std::bad_optional_access"** %2, align 8
  %3 = load %"class.std::bad_optional_access"*, %"class.std::bad_optional_access"** %2, align 8
  call void @_ZNSt19bad_optional_accessD2Ev(%"class.std::bad_optional_access"* %3) #3
  %4 = bitcast %"class.std::bad_optional_access"* %3 to i8*
  call void @_ZdlPv(i8* %4) #16
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i8* @_ZNKSt19bad_optional_access4whatEv(%"class.std::bad_optional_access"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::bad_optional_access"*, align 8
  store %"class.std::bad_optional_access"* %0, %"class.std::bad_optional_access"** %2, align 8
  %3 = load %"class.std::bad_optional_access"*, %"class.std::bad_optional_access"** %2, align 8
  ret i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.4, i32 0, i32 0)
}

; Function Attrs: nounwind
declare void @_ZNSt9exceptionD2Ev(%"class.std::exception"*) unnamed_addr #12

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNKSt6vectorIN5minou4AtomESaIS1_EE5beginEv(%"class.std::vector.234"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator", align 8
  %3 = alloca %"class.std::vector.234"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %3, align 8
  %5 = load %"class.std::vector.234"*, %"class.std::vector.234"** %3, align 8
  %6 = bitcast %"class.std::vector.234"* %5 to %"struct.std::_Vector_base.235"*
  %7 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %6, i32 0, i32 0
  %8 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %7, i32 0, i32 0
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %8, align 8
  store %"struct.minou::Atom"* %9, %"struct.minou::Atom"** %4, align 8
  call void @_ZN9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS4_(%"class.__gnu_cxx::__normal_iterator"* %2, %"struct.minou::Atom"** dereferenceable(8) %4) #3
  %10 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %2, i32 0, i32 0
  %11 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  ret %"struct.minou::Atom"* %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNKSt6vectorIN5minou4AtomESaIS1_EE3endEv(%"class.std::vector.234"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator", align 8
  %3 = alloca %"class.std::vector.234"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %3, align 8
  %5 = load %"class.std::vector.234"*, %"class.std::vector.234"** %3, align 8
  %6 = bitcast %"class.std::vector.234"* %5 to %"struct.std::_Vector_base.235"*
  %7 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %6, i32 0, i32 0
  %8 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %7, i32 0, i32 1
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %8, align 8
  store %"struct.minou::Atom"* %9, %"struct.minou::Atom"** %4, align 8
  call void @_ZN9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS4_(%"class.__gnu_cxx::__normal_iterator"* %2, %"struct.minou::Atom"** dereferenceable(8) %4) #3
  %10 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %2, i32 0, i32 0
  %11 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  ret %"struct.minou::Atom"* %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZN9__gnu_cxxneIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEEbRKNS_17__normal_iteratorIT_T0_EESD_(%"class.__gnu_cxx::__normal_iterator"* dereferenceable(8), %"class.__gnu_cxx::__normal_iterator"* dereferenceable(8)) #2 comdat {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator"*, align 8
  %4 = alloca %"class.__gnu_cxx::__normal_iterator"*, align 8
  store %"class.__gnu_cxx::__normal_iterator"* %0, %"class.__gnu_cxx::__normal_iterator"** %3, align 8
  store %"class.__gnu_cxx::__normal_iterator"* %1, %"class.__gnu_cxx::__normal_iterator"** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator"*, %"class.__gnu_cxx::__normal_iterator"** %3, align 8
  %6 = call dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator"* %5) #3
  %7 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %8 = load %"class.__gnu_cxx::__normal_iterator"*, %"class.__gnu_cxx::__normal_iterator"** %4, align 8
  %9 = call dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator"* %8) #3
  %10 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %9, align 8
  %11 = icmp ne %"struct.minou::Atom"* %7, %10
  ret i1 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"* @_ZNK9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEdeEv(%"class.__gnu_cxx::__normal_iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator"*, align 8
  store %"class.__gnu_cxx::__normal_iterator"* %0, %"class.__gnu_cxx::__normal_iterator"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator"*, %"class.__gnu_cxx::__normal_iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %3, i32 0, i32 0
  %5 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  ret %"struct.minou::Atom"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.__gnu_cxx::__normal_iterator"* @_ZN9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEppEv(%"class.__gnu_cxx::__normal_iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator"*, align 8
  store %"class.__gnu_cxx::__normal_iterator"* %0, %"class.__gnu_cxx::__normal_iterator"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator"*, %"class.__gnu_cxx::__normal_iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %3, i32 0, i32 0
  %5 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %6 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %5, i32 1
  store %"struct.minou::Atom"* %6, %"struct.minou::Atom"** %4, align 8
  ret %"class.__gnu_cxx::__normal_iterator"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS4_(%"class.__gnu_cxx::__normal_iterator"*, %"struct.minou::Atom"** dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator"*, align 8
  %4 = alloca %"struct.minou::Atom"**, align 8
  store %"class.__gnu_cxx::__normal_iterator"* %0, %"class.__gnu_cxx::__normal_iterator"** %3, align 8
  store %"struct.minou::Atom"** %1, %"struct.minou::Atom"*** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator"*, %"class.__gnu_cxx::__normal_iterator"** %3, align 8
  %6 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %5, i32 0, i32 0
  %7 = load %"struct.minou::Atom"**, %"struct.minou::Atom"*** %4, align 8
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %7, align 8
  store %"struct.minou::Atom"* %8, %"struct.minou::Atom"** %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPKN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator"*, align 8
  store %"class.__gnu_cxx::__normal_iterator"* %0, %"class.__gnu_cxx::__normal_iterator"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator"*, %"class.__gnu_cxx::__normal_iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator", %"class.__gnu_cxx::__normal_iterator"* %3, i32 0, i32 0
  ret %"struct.minou::Atom"** %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::HeapNode"* @_ZN5minou6Memory5allocINS_4ConsEEEPNS_8HeapNodeEv(%"class.minou::Memory"*) #0 comdat align 2 {
  %2 = alloca %"class.minou::Memory"*, align 8
  %3 = alloca %"struct.minou::HeapNode"*, align 8
  store %"class.minou::Memory"* %0, %"class.minou::Memory"** %2, align 8
  %4 = load %"class.minou::Memory"*, %"class.minou::Memory"** %2, align 8
  %5 = call noalias i8* @malloc(i64 24) #3
  %6 = bitcast i8* %5 to %"struct.minou::HeapNode"*
  store %"struct.minou::HeapNode"* %6, %"struct.minou::HeapNode"** %3, align 8
  %7 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %3, align 8
  %8 = getelementptr inbounds %"struct.minou::HeapNode", %"struct.minou::HeapNode"* %7, i32 0, i32 1
  %9 = getelementptr inbounds [0 x i8], [0 x i8]* %8, i32 0, i32 0
  %10 = ptrtoint i8* %9 to i64
  %11 = and i64 %10, 7
  %12 = icmp eq i64 %11, 0
  br i1 %12, label %13, label %14

; <label>:13:                                     ; preds = %1
  br label %16

; <label>:14:                                     ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.5, i32 0, i32 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.6, i32 0, i32 0), i32 140, i8* getelementptr inbounds ([58 x i8], [58 x i8]* @__PRETTY_FUNCTION__._ZN5minou6Memory5allocINS_4ConsEEEPNS_8HeapNodeEv, i32 0, i32 0)) #7
  unreachable
                                                  ; No predecessors!
  br label %16

; <label>:16:                                     ; preds = %15, %13
  %17 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %3, align 8
  %18 = bitcast %"struct.minou::HeapNode"* %17 to i8*
  call void @llvm.memset.p0i8.i64(i8* %18, i8 0, i64 24, i32 8, i1 false)
  %19 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %3, align 8
  call void @_ZN5minou8HeapNode8set_sizeEi(%"struct.minou::HeapNode"* %19, i32 16)
  %20 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %3, align 8
  call void @_ZN5minou6Memory16add_to_free_listEPNS_8HeapNodeE(%"class.minou::Memory"* %4, %"struct.minou::HeapNode"* %20)
  %21 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %3, align 8
  ret %"struct.minou::HeapNode"* %21
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN5minou8HeapNode8set_typeENS_8AtomTypeE(%"struct.minou::HeapNode"*, i8 zeroext) #2 comdat align 2 {
  %3 = alloca %"struct.minou::HeapNode"*, align 8
  %4 = alloca i8, align 1
  store %"struct.minou::HeapNode"* %0, %"struct.minou::HeapNode"** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %3, align 8
  %6 = getelementptr inbounds %"struct.minou::HeapNode", %"struct.minou::HeapNode"* %5, i32 0, i32 0
  %7 = load i64, i64* %6, align 8
  %8 = and i64 %7, -256
  store i64 %8, i64* %6, align 8
  %9 = load i8, i8* %4, align 1
  %10 = zext i8 %9 to i32
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds %"struct.minou::HeapNode", %"struct.minou::HeapNode"* %5, i32 0, i32 0
  %13 = load i64, i64* %12, align 8
  %14 = or i64 %13, %11
  store i64 %14, i64* %12, align 8
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #12

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN5minou8HeapNode8set_sizeEi(%"struct.minou::HeapNode"*, i32) #2 comdat align 2 {
  %3 = alloca %"struct.minou::HeapNode"*, align 8
  %4 = alloca i32, align 4
  store %"struct.minou::HeapNode"* %0, %"struct.minou::HeapNode"** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %3, align 8
  %6 = getelementptr inbounds %"struct.minou::HeapNode", %"struct.minou::HeapNode"* %5, i32 0, i32 0
  %7 = load i64, i64* %6, align 8
  %8 = and i64 %7, 65535
  %9 = load i32, i32* %4, align 4
  %10 = shl i32 %9, 16
  %11 = sext i32 %10 to i64
  %12 = or i64 %8, %11
  %13 = getelementptr inbounds %"struct.minou::HeapNode", %"struct.minou::HeapNode"* %5, i32 0, i32 0
  store i64 %12, i64* %13, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN5minou6Memory16add_to_free_listEPNS_8HeapNodeE(%"class.minou::Memory"*, %"struct.minou::HeapNode"*) #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.minou::Memory"*, align 8
  %4 = alloca %"struct.minou::HeapNode"*, align 8
  %5 = alloca %"class.std::scoped_lock", align 8
  %6 = alloca i8*
  %7 = alloca i32
  store %"class.minou::Memory"* %0, %"class.minou::Memory"** %3, align 8
  store %"struct.minou::HeapNode"* %1, %"struct.minou::HeapNode"** %4, align 8
  %8 = load %"class.minou::Memory"*, %"class.minou::Memory"** %3, align 8
  %9 = getelementptr inbounds %"class.minou::Memory", %"class.minou::Memory"* %8, i32 0, i32 3
  call void @_ZNSt11scoped_lockIJSt5mutexEEC2ERS0_(%"class.std::scoped_lock"* %5, %"class.std::mutex"* dereferenceable(40) %9)
  %10 = getelementptr inbounds %"class.minou::Memory", %"class.minou::Memory"* %8, i32 0, i32 2
  invoke void @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE10push_frontERKS3_(%"class.std::__cxx11::list"* %10, %"struct.minou::HeapNode"** dereferenceable(8) %4)
          to label %11 unwind label %15

; <label>:11:                                     ; preds = %2
  %12 = getelementptr inbounds %"class.minou::Memory", %"class.minou::Memory"* %8, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* %12, align 8
  call void @_ZNSt11scoped_lockIJSt5mutexEED2Ev(%"class.std::scoped_lock"* %5) #3
  ret void

; <label>:15:                                     ; preds = %2
  %16 = landingpad { i8*, i32 }
          cleanup
  %17 = extractvalue { i8*, i32 } %16, 0
  store i8* %17, i8** %6, align 8
  %18 = extractvalue { i8*, i32 } %16, 1
  store i32 %18, i32* %7, align 4
  call void @_ZNSt11scoped_lockIJSt5mutexEED2Ev(%"class.std::scoped_lock"* %5) #3
  br label %19

; <label>:19:                                     ; preds = %15
  %20 = load i8*, i8** %6, align 8
  %21 = load i32, i32* %7, align 4
  %22 = insertvalue { i8*, i32 } undef, i8* %20, 0
  %23 = insertvalue { i8*, i32 } %22, i32 %21, 1
  resume { i8*, i32 } %23
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt11scoped_lockIJSt5mutexEEC2ERS0_(%"class.std::scoped_lock"*, %"class.std::mutex"* dereferenceable(40)) unnamed_addr #0 comdat align 2 {
  %3 = alloca %"class.std::scoped_lock"*, align 8
  %4 = alloca %"class.std::mutex"*, align 8
  store %"class.std::scoped_lock"* %0, %"class.std::scoped_lock"** %3, align 8
  store %"class.std::mutex"* %1, %"class.std::mutex"** %4, align 8
  %5 = load %"class.std::scoped_lock"*, %"class.std::scoped_lock"** %3, align 8
  %6 = getelementptr inbounds %"class.std::scoped_lock", %"class.std::scoped_lock"* %5, i32 0, i32 0
  %7 = load %"class.std::mutex"*, %"class.std::mutex"** %4, align 8
  store %"class.std::mutex"* %7, %"class.std::mutex"** %6, align 8
  %8 = getelementptr inbounds %"class.std::scoped_lock", %"class.std::scoped_lock"* %5, i32 0, i32 0
  %9 = load %"class.std::mutex"*, %"class.std::mutex"** %8, align 8
  call void @_ZNSt5mutex4lockEv(%"class.std::mutex"* %9)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE10push_frontERKS3_(%"class.std::__cxx11::list"*, %"struct.minou::HeapNode"** dereferenceable(8)) #0 comdat align 2 {
  %3 = alloca %"class.std::__cxx11::list"*, align 8
  %4 = alloca %"struct.minou::HeapNode"**, align 8
  %5 = alloca %"struct.std::_List_iterator", align 8
  store %"class.std::__cxx11::list"* %0, %"class.std::__cxx11::list"** %3, align 8
  store %"struct.minou::HeapNode"** %1, %"struct.minou::HeapNode"*** %4, align 8
  %6 = load %"class.std::__cxx11::list"*, %"class.std::__cxx11::list"** %3, align 8
  %7 = call %"struct.std::__detail::_List_node_base"* @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE5beginEv(%"class.std::__cxx11::list"* %6) #3
  %8 = getelementptr inbounds %"struct.std::_List_iterator", %"struct.std::_List_iterator"* %5, i32 0, i32 0
  store %"struct.std::__detail::_List_node_base"* %7, %"struct.std::__detail::_List_node_base"** %8, align 8
  %9 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %4, align 8
  %10 = getelementptr inbounds %"struct.std::_List_iterator", %"struct.std::_List_iterator"* %5, i32 0, i32 0
  %11 = load %"struct.std::__detail::_List_node_base"*, %"struct.std::__detail::_List_node_base"** %10, align 8
  call void @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE9_M_insertIJRKS3_EEEvSt14_List_iteratorIS3_EDpOT_(%"class.std::__cxx11::list"* %6, %"struct.std::__detail::_List_node_base"* %11, %"struct.minou::HeapNode"** dereferenceable(8) %9)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt11scoped_lockIJSt5mutexEED2Ev(%"class.std::scoped_lock"*) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::scoped_lock"*, align 8
  store %"class.std::scoped_lock"* %0, %"class.std::scoped_lock"** %2, align 8
  %3 = load %"class.std::scoped_lock"*, %"class.std::scoped_lock"** %2, align 8
  %4 = getelementptr inbounds %"class.std::scoped_lock", %"class.std::scoped_lock"* %3, i32 0, i32 0
  %5 = load %"class.std::mutex"*, %"class.std::mutex"** %4, align 8
  invoke void @_ZNSt5mutex6unlockEv(%"class.std::mutex"* %5)
          to label %6 unwind label %7

; <label>:6:                                      ; preds = %1
  ret void

; <label>:7:                                      ; preds = %1
  %8 = landingpad { i8*, i32 }
          catch i8* null
  %9 = extractvalue { i8*, i32 } %8, 0
  call void @__clang_call_terminate(i8* %9) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt5mutex4lockEv(%"class.std::mutex"*) #0 comdat align 2 {
  %2 = alloca %"class.std::mutex"*, align 8
  %3 = alloca i32, align 4
  store %"class.std::mutex"* %0, %"class.std::mutex"** %2, align 8
  %4 = load %"class.std::mutex"*, %"class.std::mutex"** %2, align 8
  %5 = bitcast %"class.std::mutex"* %4 to %"class.std::__mutex_base"*
  %6 = getelementptr inbounds %"class.std::__mutex_base", %"class.std::__mutex_base"* %5, i32 0, i32 0
  %7 = call i32 @_ZL20__gthread_mutex_lockP15pthread_mutex_t(%union.pthread_mutex_t* %6)
  store i32 %7, i32* %3, align 4
  %8 = load i32, i32* %3, align 4
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %12

; <label>:10:                                     ; preds = %1
  %11 = load i32, i32* %3, align 4
  call void @_ZSt20__throw_system_errori(i32 %11) #14
  unreachable

; <label>:12:                                     ; preds = %1
  ret void
}

; Function Attrs: noinline optnone uwtable
define internal i32 @_ZL20__gthread_mutex_lockP15pthread_mutex_t(%union.pthread_mutex_t*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %union.pthread_mutex_t*, align 8
  store %union.pthread_mutex_t* %0, %union.pthread_mutex_t** %3, align 8
  %4 = call i32 @_ZL18__gthread_active_pv()
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %9

; <label>:6:                                      ; preds = %1
  %7 = load %union.pthread_mutex_t*, %union.pthread_mutex_t** %3, align 8
  %8 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* %7) #3
  store i32 %8, i32* %2, align 4
  br label %10

; <label>:9:                                      ; preds = %1
  store i32 0, i32* %2, align 4
  br label %10

; <label>:10:                                     ; preds = %9, %6
  %11 = load i32, i32* %2, align 4
  ret i32 %11
}

; Function Attrs: noreturn
declare void @_ZSt20__throw_system_errori(i32) #8

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @_ZL18__gthread_active_pv() #2 {
  ret i32 zext (i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null) to i32)
}

; Function Attrs: nounwind
declare extern_weak i32 @pthread_mutex_lock(%union.pthread_mutex_t*) #12

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #12

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE9_M_insertIJRKS3_EEEvSt14_List_iteratorIS3_EDpOT_(%"class.std::__cxx11::list"*, %"struct.std::__detail::_List_node_base"*, %"struct.minou::HeapNode"** dereferenceable(8)) #0 comdat align 2 {
  %4 = alloca %"struct.std::_List_iterator", align 8
  %5 = alloca %"class.std::__cxx11::list"*, align 8
  %6 = alloca %"struct.minou::HeapNode"**, align 8
  %7 = alloca %"struct.std::_List_node.296"*, align 8
  %8 = getelementptr inbounds %"struct.std::_List_iterator", %"struct.std::_List_iterator"* %4, i32 0, i32 0
  store %"struct.std::__detail::_List_node_base"* %1, %"struct.std::__detail::_List_node_base"** %8, align 8
  store %"class.std::__cxx11::list"* %0, %"class.std::__cxx11::list"** %5, align 8
  store %"struct.minou::HeapNode"** %2, %"struct.minou::HeapNode"*** %6, align 8
  %9 = load %"class.std::__cxx11::list"*, %"class.std::__cxx11::list"** %5, align 8
  %10 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %6, align 8
  %11 = call dereferenceable(8) %"struct.minou::HeapNode"** @_ZSt7forwardIRKPN5minou8HeapNodeEEOT_RNSt16remove_referenceIS5_E4typeE(%"struct.minou::HeapNode"** dereferenceable(8) %10) #3
  %12 = call %"struct.std::_List_node.296"* @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE14_M_create_nodeIJRKS3_EEEPSt10_List_nodeIS3_EDpOT_(%"class.std::__cxx11::list"* %9, %"struct.minou::HeapNode"** dereferenceable(8) %11)
  store %"struct.std::_List_node.296"* %12, %"struct.std::_List_node.296"** %7, align 8
  %13 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %7, align 8
  %14 = bitcast %"struct.std::_List_node.296"* %13 to %"struct.std::__detail::_List_node_base"*
  %15 = getelementptr inbounds %"struct.std::_List_iterator", %"struct.std::_List_iterator"* %4, i32 0, i32 0
  %16 = load %"struct.std::__detail::_List_node_base"*, %"struct.std::__detail::_List_node_base"** %15, align 8
  call void @_ZNSt8__detail15_List_node_base7_M_hookEPS0_(%"struct.std::__detail::_List_node_base"* %14, %"struct.std::__detail::_List_node_base"* %16) #3
  %17 = bitcast %"class.std::__cxx11::list"* %9 to %"class.std::__cxx11::_List_base"*
  call void @_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE11_M_inc_sizeEm(%"class.std::__cxx11::_List_base"* %17, i64 1)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.std::__detail::_List_node_base"* @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE5beginEv(%"class.std::__cxx11::list"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_List_iterator", align 8
  %3 = alloca %"class.std::__cxx11::list"*, align 8
  store %"class.std::__cxx11::list"* %0, %"class.std::__cxx11::list"** %3, align 8
  %4 = load %"class.std::__cxx11::list"*, %"class.std::__cxx11::list"** %3, align 8
  %5 = bitcast %"class.std::__cxx11::list"* %4 to %"class.std::__cxx11::_List_base"*
  %6 = getelementptr inbounds %"class.std::__cxx11::_List_base", %"class.std::__cxx11::_List_base"* %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl", %"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl"* %6, i32 0, i32 0
  %8 = bitcast %"struct.std::_List_node"* %7 to %"struct.std::__detail::_List_node_base"*
  %9 = getelementptr inbounds %"struct.std::__detail::_List_node_base", %"struct.std::__detail::_List_node_base"* %8, i32 0, i32 0
  %10 = load %"struct.std::__detail::_List_node_base"*, %"struct.std::__detail::_List_node_base"** %9, align 8
  call void @_ZNSt14_List_iteratorIPN5minou8HeapNodeEEC2EPNSt8__detail15_List_node_baseE(%"struct.std::_List_iterator"* %2, %"struct.std::__detail::_List_node_base"* %10) #3
  %11 = getelementptr inbounds %"struct.std::_List_iterator", %"struct.std::_List_iterator"* %2, i32 0, i32 0
  %12 = load %"struct.std::__detail::_List_node_base"*, %"struct.std::__detail::_List_node_base"** %11, align 8
  ret %"struct.std::__detail::_List_node_base"* %12
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_List_node.296"* @_ZNSt7__cxx114listIPN5minou8HeapNodeESaIS3_EE14_M_create_nodeIJRKS3_EEEPSt10_List_nodeIS3_EDpOT_(%"class.std::__cxx11::list"*, %"struct.minou::HeapNode"** dereferenceable(8)) #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::__cxx11::list"*, align 8
  %4 = alloca %"struct.minou::HeapNode"**, align 8
  %5 = alloca %"struct.std::_List_node.296"*, align 8
  %6 = alloca %"class.std::allocator.15"*, align 8
  %7 = alloca %"struct.std::__allocated_ptr", align 8
  %8 = alloca i8*
  %9 = alloca i32
  store %"class.std::__cxx11::list"* %0, %"class.std::__cxx11::list"** %3, align 8
  store %"struct.minou::HeapNode"** %1, %"struct.minou::HeapNode"*** %4, align 8
  %10 = load %"class.std::__cxx11::list"*, %"class.std::__cxx11::list"** %3, align 8
  %11 = bitcast %"class.std::__cxx11::list"* %10 to %"class.std::__cxx11::_List_base"*
  %12 = call %"struct.std::_List_node.296"* @_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE11_M_get_nodeEv(%"class.std::__cxx11::_List_base"* %11)
  store %"struct.std::_List_node.296"* %12, %"struct.std::_List_node.296"** %5, align 8
  %13 = bitcast %"class.std::__cxx11::list"* %10 to %"class.std::__cxx11::_List_base"*
  %14 = call dereferenceable(1) %"class.std::allocator.15"* @_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE21_M_get_Node_allocatorEv(%"class.std::__cxx11::_List_base"* %13) #3
  store %"class.std::allocator.15"* %14, %"class.std::allocator.15"** %6, align 8
  %15 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %6, align 8
  %16 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %5, align 8
  call void @_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEEC2ERS5_PS4_(%"struct.std::__allocated_ptr"* %7, %"class.std::allocator.15"* dereferenceable(1) %15, %"struct.std::_List_node.296"* %16) #3
  %17 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %6, align 8
  %18 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %5, align 8
  %19 = invoke %"struct.minou::HeapNode"** @_ZNSt10_List_nodeIPN5minou8HeapNodeEE9_M_valptrEv(%"struct.std::_List_node.296"* %18)
          to label %20 unwind label %26

; <label>:20:                                     ; preds = %2
  %21 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %4, align 8
  %22 = call dereferenceable(8) %"struct.minou::HeapNode"** @_ZSt7forwardIRKPN5minou8HeapNodeEEOT_RNSt16remove_referenceIS5_E4typeE(%"struct.minou::HeapNode"** dereferenceable(8) %21) #3
  invoke void @_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE9constructIS3_JRKS3_EEEvRS5_PT_DpOT0_(%"class.std::allocator.15"* dereferenceable(1) %17, %"struct.minou::HeapNode"** %19, %"struct.minou::HeapNode"** dereferenceable(8) %22)
          to label %23 unwind label %26

; <label>:23:                                     ; preds = %20
  %24 = call dereferenceable(16) %"struct.std::__allocated_ptr"* @_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEEaSEDn(%"struct.std::__allocated_ptr"* %7, i8* null) #3
  %25 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %5, align 8
  call void @_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEED2Ev(%"struct.std::__allocated_ptr"* %7) #3
  ret %"struct.std::_List_node.296"* %25

; <label>:26:                                     ; preds = %20, %2
  %27 = landingpad { i8*, i32 }
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  store i8* %28, i8** %8, align 8
  %29 = extractvalue { i8*, i32 } %27, 1
  store i32 %29, i32* %9, align 4
  call void @_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEED2Ev(%"struct.std::__allocated_ptr"* %7) #3
  br label %30

; <label>:30:                                     ; preds = %26
  %31 = load i8*, i8** %8, align 8
  %32 = load i32, i32* %9, align 4
  %33 = insertvalue { i8*, i32 } undef, i8* %31, 0
  %34 = insertvalue { i8*, i32 } %33, i32 %32, 1
  resume { i8*, i32 } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::HeapNode"** @_ZSt7forwardIRKPN5minou8HeapNodeEEOT_RNSt16remove_referenceIS5_E4typeE(%"struct.minou::HeapNode"** dereferenceable(8)) #2 comdat {
  %2 = alloca %"struct.minou::HeapNode"**, align 8
  store %"struct.minou::HeapNode"** %0, %"struct.minou::HeapNode"*** %2, align 8
  %3 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %2, align 8
  ret %"struct.minou::HeapNode"** %3
}

; Function Attrs: nounwind
declare void @_ZNSt8__detail15_List_node_base7_M_hookEPS0_(%"struct.std::__detail::_List_node_base"*, %"struct.std::__detail::_List_node_base"*) #12

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE11_M_inc_sizeEm(%"class.std::__cxx11::_List_base"*, i64) #0 comdat align 2 {
  %3 = alloca %"class.std::__cxx11::_List_base"*, align 8
  %4 = alloca i64, align 8
  store %"class.std::__cxx11::_List_base"* %0, %"class.std::__cxx11::_List_base"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.std::__cxx11::_List_base"*, %"class.std::__cxx11::_List_base"** %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = getelementptr inbounds %"class.std::__cxx11::_List_base", %"class.std::__cxx11::_List_base"* %5, i32 0, i32 0
  %8 = getelementptr inbounds %"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl", %"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl"* %7, i32 0, i32 0
  %9 = call i64* @_ZNSt10_List_nodeImE9_M_valptrEv(%"struct.std::_List_node"* %8)
  %10 = load i64, i64* %9, align 8
  %11 = add i64 %10, %6
  store i64 %11, i64* %9, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_List_node.296"* @_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE11_M_get_nodeEv(%"class.std::__cxx11::_List_base"*) #0 comdat align 2 {
  %2 = alloca %"class.std::__cxx11::_List_base"*, align 8
  store %"class.std::__cxx11::_List_base"* %0, %"class.std::__cxx11::_List_base"** %2, align 8
  %3 = load %"class.std::__cxx11::_List_base"*, %"class.std::__cxx11::_List_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__cxx11::_List_base", %"class.std::__cxx11::_List_base"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl"* %4 to %"class.std::allocator.15"*
  %6 = call %"struct.std::_List_node.296"* @_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE8allocateERS5_m(%"class.std::allocator.15"* dereferenceable(1) %5, i64 1)
  ret %"struct.std::_List_node.296"* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"class.std::allocator.15"* @_ZNSt7__cxx1110_List_baseIPN5minou8HeapNodeESaIS3_EE21_M_get_Node_allocatorEv(%"class.std::__cxx11::_List_base"*) #2 comdat align 2 {
  %2 = alloca %"class.std::__cxx11::_List_base"*, align 8
  store %"class.std::__cxx11::_List_base"* %0, %"class.std::__cxx11::_List_base"** %2, align 8
  %3 = load %"class.std::__cxx11::_List_base"*, %"class.std::__cxx11::_List_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__cxx11::_List_base", %"class.std::__cxx11::_List_base"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::__cxx11::_List_base<minou::HeapNode *, std::allocator<minou::HeapNode *> >::_List_impl"* %4 to %"class.std::allocator.15"*
  ret %"class.std::allocator.15"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEEC2ERS5_PS4_(%"struct.std::__allocated_ptr"*, %"class.std::allocator.15"* dereferenceable(1), %"struct.std::_List_node.296"*) unnamed_addr #2 comdat align 2 {
  %4 = alloca %"struct.std::__allocated_ptr"*, align 8
  %5 = alloca %"class.std::allocator.15"*, align 8
  %6 = alloca %"struct.std::_List_node.296"*, align 8
  store %"struct.std::__allocated_ptr"* %0, %"struct.std::__allocated_ptr"** %4, align 8
  store %"class.std::allocator.15"* %1, %"class.std::allocator.15"** %5, align 8
  store %"struct.std::_List_node.296"* %2, %"struct.std::_List_node.296"** %6, align 8
  %7 = load %"struct.std::__allocated_ptr"*, %"struct.std::__allocated_ptr"** %4, align 8
  %8 = getelementptr inbounds %"struct.std::__allocated_ptr", %"struct.std::__allocated_ptr"* %7, i32 0, i32 0
  %9 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %5, align 8
  %10 = call %"class.std::allocator.15"* @_ZSt11__addressofISaISt10_List_nodeIPN5minou8HeapNodeEEEEPT_RS6_(%"class.std::allocator.15"* dereferenceable(1) %9) #3
  store %"class.std::allocator.15"* %10, %"class.std::allocator.15"** %8, align 8
  %11 = getelementptr inbounds %"struct.std::__allocated_ptr", %"struct.std::__allocated_ptr"* %7, i32 0, i32 1
  %12 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %6, align 8
  store %"struct.std::_List_node.296"* %12, %"struct.std::_List_node.296"** %11, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE9constructIS3_JRKS3_EEEvRS5_PT_DpOT0_(%"class.std::allocator.15"* dereferenceable(1), %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"** dereferenceable(8)) #0 comdat align 2 {
  %4 = alloca %"class.std::allocator.15"*, align 8
  %5 = alloca %"struct.minou::HeapNode"**, align 8
  %6 = alloca %"struct.minou::HeapNode"**, align 8
  store %"class.std::allocator.15"* %0, %"class.std::allocator.15"** %4, align 8
  store %"struct.minou::HeapNode"** %1, %"struct.minou::HeapNode"*** %5, align 8
  store %"struct.minou::HeapNode"** %2, %"struct.minou::HeapNode"*** %6, align 8
  %7 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %4, align 8
  %8 = bitcast %"class.std::allocator.15"* %7 to %"class.__gnu_cxx::new_allocator.16"*
  %9 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %5, align 8
  %10 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %6, align 8
  %11 = call dereferenceable(8) %"struct.minou::HeapNode"** @_ZSt7forwardIRKPN5minou8HeapNodeEEOT_RNSt16remove_referenceIS5_E4typeE(%"struct.minou::HeapNode"** dereferenceable(8) %10) #3
  call void @_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE9constructIS4_JRKS4_EEEvPT_DpOT0_(%"class.__gnu_cxx::new_allocator.16"* %8, %"struct.minou::HeapNode"** %9, %"struct.minou::HeapNode"** dereferenceable(8) %11)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::HeapNode"** @_ZNSt10_List_nodeIPN5minou8HeapNodeEE9_M_valptrEv(%"struct.std::_List_node.296"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_List_node.296"*, align 8
  store %"struct.std::_List_node.296"* %0, %"struct.std::_List_node.296"** %2, align 8
  %3 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_List_node.296", %"struct.std::_List_node.296"* %3, i32 0, i32 1
  %5 = call %"struct.minou::HeapNode"** @_ZN9__gnu_cxx16__aligned_membufIPN5minou8HeapNodeEE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf.297"* %4) #3
  ret %"struct.minou::HeapNode"** %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(16) %"struct.std::__allocated_ptr"* @_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEEaSEDn(%"struct.std::__allocated_ptr"*, i8*) #2 comdat align 2 {
  %3 = alloca %"struct.std::__allocated_ptr"*, align 8
  %4 = alloca i8*, align 8
  store %"struct.std::__allocated_ptr"* %0, %"struct.std::__allocated_ptr"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"struct.std::__allocated_ptr"*, %"struct.std::__allocated_ptr"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::__allocated_ptr", %"struct.std::__allocated_ptr"* %5, i32 0, i32 1
  store %"struct.std::_List_node.296"* null, %"struct.std::_List_node.296"** %6, align 8
  ret %"struct.std::__allocated_ptr"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt15__allocated_ptrISaISt10_List_nodeIPN5minou8HeapNodeEEEED2Ev(%"struct.std::__allocated_ptr"*) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"struct.std::__allocated_ptr"*, align 8
  store %"struct.std::__allocated_ptr"* %0, %"struct.std::__allocated_ptr"** %2, align 8
  %3 = load %"struct.std::__allocated_ptr"*, %"struct.std::__allocated_ptr"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::__allocated_ptr", %"struct.std::__allocated_ptr"* %3, i32 0, i32 1
  %5 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %4, align 8
  %6 = icmp ne %"struct.std::_List_node.296"* %5, null
  br i1 %6, label %7, label %13

; <label>:7:                                      ; preds = %1
  %8 = getelementptr inbounds %"struct.std::__allocated_ptr", %"struct.std::__allocated_ptr"* %3, i32 0, i32 0
  %9 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %8, align 8
  %10 = getelementptr inbounds %"struct.std::__allocated_ptr", %"struct.std::__allocated_ptr"* %3, i32 0, i32 1
  %11 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %10, align 8
  invoke void @_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE10deallocateERS5_PS4_m(%"class.std::allocator.15"* dereferenceable(1) %9, %"struct.std::_List_node.296"* %11, i64 1)
          to label %12 unwind label %14

; <label>:12:                                     ; preds = %7
  br label %13

; <label>:13:                                     ; preds = %12, %1
  ret void

; <label>:14:                                     ; preds = %7
  %15 = landingpad { i8*, i32 }
          catch i8* null
  %16 = extractvalue { i8*, i32 } %15, 0
  call void @__clang_call_terminate(i8* %16) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_List_node.296"* @_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE8allocateERS5_m(%"class.std::allocator.15"* dereferenceable(1), i64) #0 comdat align 2 {
  %3 = alloca %"class.std::allocator.15"*, align 8
  %4 = alloca i64, align 8
  store %"class.std::allocator.15"* %0, %"class.std::allocator.15"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %3, align 8
  %6 = bitcast %"class.std::allocator.15"* %5 to %"class.__gnu_cxx::new_allocator.16"*
  %7 = load i64, i64* %4, align 8
  %8 = call %"struct.std::_List_node.296"* @_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE8allocateEmPKv(%"class.__gnu_cxx::new_allocator.16"* %6, i64 %7, i8* null)
  ret %"struct.std::_List_node.296"* %8
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.std::_List_node.296"* @_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE8allocateEmPKv(%"class.__gnu_cxx::new_allocator.16"*, i64, i8*) #0 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator.16"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  store %"class.__gnu_cxx::new_allocator.16"* %0, %"class.__gnu_cxx::new_allocator.16"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8* %2, i8** %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator.16"*, %"class.__gnu_cxx::new_allocator.16"** %4, align 8
  %8 = load i64, i64* %5, align 8
  %9 = call i64 @_ZNK9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE8max_sizeEv(%"class.__gnu_cxx::new_allocator.16"* %7) #3
  %10 = icmp ugt i64 %8, %9
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %3
  call void @_ZSt17__throw_bad_allocv() #14
  unreachable

; <label>:12:                                     ; preds = %3
  %13 = load i64, i64* %5, align 8
  %14 = mul i64 %13, 24
  %15 = call i8* @_Znwm(i64 %14)
  %16 = bitcast i8* %15 to %"struct.std::_List_node.296"*
  ret %"struct.std::_List_node.296"* %16
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZNK9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE8max_sizeEv(%"class.__gnu_cxx::new_allocator.16"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::new_allocator.16"*, align 8
  store %"class.__gnu_cxx::new_allocator.16"* %0, %"class.__gnu_cxx::new_allocator.16"** %2, align 8
  %3 = load %"class.__gnu_cxx::new_allocator.16"*, %"class.__gnu_cxx::new_allocator.16"** %2, align 8
  ret i64 768614336404564650
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.std::allocator.15"* @_ZSt11__addressofISaISt10_List_nodeIPN5minou8HeapNodeEEEEPT_RS6_(%"class.std::allocator.15"* dereferenceable(1)) #2 comdat {
  %2 = alloca %"class.std::allocator.15"*, align 8
  store %"class.std::allocator.15"* %0, %"class.std::allocator.15"** %2, align 8
  %3 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %2, align 8
  ret %"class.std::allocator.15"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE9constructIS4_JRKS4_EEEvPT_DpOT0_(%"class.__gnu_cxx::new_allocator.16"*, %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"** dereferenceable(8)) #2 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator.16"*, align 8
  %5 = alloca %"struct.minou::HeapNode"**, align 8
  %6 = alloca %"struct.minou::HeapNode"**, align 8
  store %"class.__gnu_cxx::new_allocator.16"* %0, %"class.__gnu_cxx::new_allocator.16"** %4, align 8
  store %"struct.minou::HeapNode"** %1, %"struct.minou::HeapNode"*** %5, align 8
  store %"struct.minou::HeapNode"** %2, %"struct.minou::HeapNode"*** %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator.16"*, %"class.__gnu_cxx::new_allocator.16"** %4, align 8
  %8 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %5, align 8
  %9 = bitcast %"struct.minou::HeapNode"** %8 to i8*
  %10 = bitcast i8* %9 to %"struct.minou::HeapNode"**
  %11 = load %"struct.minou::HeapNode"**, %"struct.minou::HeapNode"*** %6, align 8
  %12 = call dereferenceable(8) %"struct.minou::HeapNode"** @_ZSt7forwardIRKPN5minou8HeapNodeEEOT_RNSt16remove_referenceIS5_E4typeE(%"struct.minou::HeapNode"** dereferenceable(8) %11) #3
  %13 = load %"struct.minou::HeapNode"*, %"struct.minou::HeapNode"** %12, align 8
  store %"struct.minou::HeapNode"* %13, %"struct.minou::HeapNode"** %10, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::HeapNode"** @_ZN9__gnu_cxx16__aligned_membufIPN5minou8HeapNodeEE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf.297"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf.297"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf.297"* %0, %"struct.__gnu_cxx::__aligned_membuf.297"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf.297"*, %"struct.__gnu_cxx::__aligned_membuf.297"** %2, align 8
  %4 = call i8* @_ZN9__gnu_cxx16__aligned_membufIPN5minou8HeapNodeEE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf.297"* %3) #3
  %5 = bitcast i8* %4 to %"struct.minou::HeapNode"**
  ret %"struct.minou::HeapNode"** %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i8* @_ZN9__gnu_cxx16__aligned_membufIPN5minou8HeapNodeEE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf.297"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf.297"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf.297"* %0, %"struct.__gnu_cxx::__aligned_membuf.297"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf.297"*, %"struct.__gnu_cxx::__aligned_membuf.297"** %2, align 8
  %4 = getelementptr inbounds %"struct.__gnu_cxx::__aligned_membuf.297", %"struct.__gnu_cxx::__aligned_membuf.297"* %3, i32 0, i32 0
  %5 = bitcast [8 x i8]* %4 to i8*
  ret i8* %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaISt10_List_nodeIPN5minou8HeapNodeEEEE10deallocateERS5_PS4_m(%"class.std::allocator.15"* dereferenceable(1), %"struct.std::_List_node.296"*, i64) #0 comdat align 2 {
  %4 = alloca %"class.std::allocator.15"*, align 8
  %5 = alloca %"struct.std::_List_node.296"*, align 8
  %6 = alloca i64, align 8
  store %"class.std::allocator.15"* %0, %"class.std::allocator.15"** %4, align 8
  store %"struct.std::_List_node.296"* %1, %"struct.std::_List_node.296"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.std::allocator.15"*, %"class.std::allocator.15"** %4, align 8
  %8 = bitcast %"class.std::allocator.15"* %7 to %"class.__gnu_cxx::new_allocator.16"*
  %9 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %5, align 8
  %10 = load i64, i64* %6, align 8
  call void @_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE10deallocateEPS5_m(%"class.__gnu_cxx::new_allocator.16"* %8, %"struct.std::_List_node.296"* %9, i64 %10)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt10_List_nodeIPN5minou8HeapNodeEEE10deallocateEPS5_m(%"class.__gnu_cxx::new_allocator.16"*, %"struct.std::_List_node.296"*, i64) #2 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator.16"*, align 8
  %5 = alloca %"struct.std::_List_node.296"*, align 8
  %6 = alloca i64, align 8
  store %"class.__gnu_cxx::new_allocator.16"* %0, %"class.__gnu_cxx::new_allocator.16"** %4, align 8
  store %"struct.std::_List_node.296"* %1, %"struct.std::_List_node.296"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator.16"*, %"class.__gnu_cxx::new_allocator.16"** %4, align 8
  %8 = load %"struct.std::_List_node.296"*, %"struct.std::_List_node.296"** %5, align 8
  %9 = bitcast %"struct.std::_List_node.296"* %8 to i8*
  call void @_ZdlPv(i8* %9) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64* @_ZNSt10_List_nodeImE9_M_valptrEv(%"struct.std::_List_node"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_List_node"*, align 8
  store %"struct.std::_List_node"* %0, %"struct.std::_List_node"** %2, align 8
  %3 = load %"struct.std::_List_node"*, %"struct.std::_List_node"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_List_node", %"struct.std::_List_node"* %3, i32 0, i32 1
  %5 = call i64* @_ZN9__gnu_cxx16__aligned_membufImE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf"* %4) #3
  ret i64* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64* @_ZN9__gnu_cxx16__aligned_membufImE6_M_ptrEv(%"struct.__gnu_cxx::__aligned_membuf"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf"* %0, %"struct.__gnu_cxx::__aligned_membuf"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf"*, %"struct.__gnu_cxx::__aligned_membuf"** %2, align 8
  %4 = call i8* @_ZN9__gnu_cxx16__aligned_membufImE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf"* %3) #3
  %5 = bitcast i8* %4 to i64*
  ret i64* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i8* @_ZN9__gnu_cxx16__aligned_membufImE7_M_addrEv(%"struct.__gnu_cxx::__aligned_membuf"*) #2 comdat align 2 {
  %2 = alloca %"struct.__gnu_cxx::__aligned_membuf"*, align 8
  store %"struct.__gnu_cxx::__aligned_membuf"* %0, %"struct.__gnu_cxx::__aligned_membuf"** %2, align 8
  %3 = load %"struct.__gnu_cxx::__aligned_membuf"*, %"struct.__gnu_cxx::__aligned_membuf"** %2, align 8
  %4 = getelementptr inbounds %"struct.__gnu_cxx::__aligned_membuf", %"struct.__gnu_cxx::__aligned_membuf"* %3, i32 0, i32 0
  %5 = bitcast [8 x i8]* %4 to i8*
  ret i8* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt14_List_iteratorIPN5minou8HeapNodeEEC2EPNSt8__detail15_List_node_baseE(%"struct.std::_List_iterator"*, %"struct.std::__detail::_List_node_base"*) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"struct.std::_List_iterator"*, align 8
  %4 = alloca %"struct.std::__detail::_List_node_base"*, align 8
  store %"struct.std::_List_iterator"* %0, %"struct.std::_List_iterator"** %3, align 8
  store %"struct.std::__detail::_List_node_base"* %1, %"struct.std::__detail::_List_node_base"** %4, align 8
  %5 = load %"struct.std::_List_iterator"*, %"struct.std::_List_iterator"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::_List_iterator", %"struct.std::_List_iterator"* %5, i32 0, i32 0
  %7 = load %"struct.std::__detail::_List_node_base"*, %"struct.std::__detail::_List_node_base"** %4, align 8
  store %"struct.std::__detail::_List_node_base"* %7, %"struct.std::__detail::_List_node_base"** %6, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt5mutex6unlockEv(%"class.std::mutex"*) #0 comdat align 2 {
  %2 = alloca %"class.std::mutex"*, align 8
  store %"class.std::mutex"* %0, %"class.std::mutex"** %2, align 8
  %3 = load %"class.std::mutex"*, %"class.std::mutex"** %2, align 8
  %4 = bitcast %"class.std::mutex"* %3 to %"class.std::__mutex_base"*
  %5 = getelementptr inbounds %"class.std::__mutex_base", %"class.std::__mutex_base"* %4, i32 0, i32 0
  %6 = call i32 @_ZL22__gthread_mutex_unlockP15pthread_mutex_t(%union.pthread_mutex_t* %5)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @_ZL22__gthread_mutex_unlockP15pthread_mutex_t(%union.pthread_mutex_t*) #2 {
  %2 = alloca i32, align 4
  %3 = alloca %union.pthread_mutex_t*, align 8
  store %union.pthread_mutex_t* %0, %union.pthread_mutex_t** %3, align 8
  %4 = call i32 @_ZL18__gthread_active_pv()
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %9

; <label>:6:                                      ; preds = %1
  %7 = load %union.pthread_mutex_t*, %union.pthread_mutex_t** %3, align 8
  %8 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* %7) #3
  store i32 %8, i32* %2, align 4
  br label %10

; <label>:9:                                      ; preds = %1
  store i32 0, i32* %2, align 4
  br label %10

; <label>:10:                                     ; preds = %9, %6
  %11 = load i32, i32* %2, align 4
  ret i32 %11
}

; Function Attrs: nounwind
declare extern_weak i32 @pthread_mutex_unlock(%union.pthread_mutex_t*) #12

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Cons"* @_ZN5minou4Cons5beginEv(%"struct.minou::Cons"*) #0 comdat align 2 {
  %2 = alloca %"class.minou::Cons::iterator", align 8
  %3 = alloca %"struct.minou::Cons"*, align 8
  store %"struct.minou::Cons"* %0, %"struct.minou::Cons"** %3, align 8
  %4 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %3, align 8
  call void @_ZN5minou4Cons8iteratorC2EPS0_(%"class.minou::Cons::iterator"* %2, %"struct.minou::Cons"* %4)
  %5 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %2, i32 0, i32 0
  %6 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %5, align 8
  ret %"struct.minou::Cons"* %6
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Cons"* @_ZN5minou4Cons3endEv(%"struct.minou::Cons"*) #0 comdat align 2 {
  %2 = alloca %"class.minou::Cons::iterator", align 8
  %3 = alloca %"struct.minou::Cons"*, align 8
  store %"struct.minou::Cons"* %0, %"struct.minou::Cons"** %3, align 8
  %4 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %3, align 8
  call void @_ZN5minou4Cons8iteratorC2EPS0_(%"class.minou::Cons::iterator"* %2, %"struct.minou::Cons"* null)
  %5 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %2, i32 0, i32 0
  %6 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %5, align 8
  ret %"struct.minou::Cons"* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNK5minou4Cons8iteratorneES1_(%"class.minou::Cons::iterator"*, %"struct.minou::Cons"*) #2 comdat align 2 {
  %3 = alloca %"class.minou::Cons::iterator", align 8
  %4 = alloca %"class.minou::Cons::iterator"*, align 8
  %5 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %3, i32 0, i32 0
  store %"struct.minou::Cons"* %1, %"struct.minou::Cons"** %5, align 8
  store %"class.minou::Cons::iterator"* %0, %"class.minou::Cons::iterator"** %4, align 8
  %6 = load %"class.minou::Cons::iterator"*, %"class.minou::Cons::iterator"** %4, align 8
  %7 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %6, i32 0, i32 0
  %8 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %7, align 8
  %9 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %3, i32 0, i32 0
  %10 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %9, align 8
  %11 = icmp ne %"struct.minou::Cons"* %8, %10
  ret i1 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Cons"* @_ZN5minou4Cons8iteratordeEv(%"class.minou::Cons::iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.minou::Cons::iterator"*, align 8
  store %"class.minou::Cons::iterator"* %0, %"class.minou::Cons::iterator"** %2, align 8
  %3 = load %"class.minou::Cons::iterator"*, %"class.minou::Cons::iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %3, i32 0, i32 0
  %5 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %4, align 8
  ret %"struct.minou::Cons"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.minou::Cons::iterator"* @_ZN5minou4Cons8iteratorppEv(%"class.minou::Cons::iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.minou::Cons::iterator"*, align 8
  store %"class.minou::Cons::iterator"* %0, %"class.minou::Cons::iterator"** %2, align 8
  %3 = load %"class.minou::Cons::iterator"*, %"class.minou::Cons::iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %3, i32 0, i32 0
  %5 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %4, align 8
  %6 = getelementptr inbounds %"struct.minou::Cons", %"struct.minou::Cons"* %5, i32 0, i32 1
  %7 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %6, align 8
  %8 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %3, i32 0, i32 0
  store %"struct.minou::Cons"* %7, %"struct.minou::Cons"** %8, align 8
  ret %"class.minou::Cons::iterator"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN5minou4Cons8iteratorC2EPS0_(%"class.minou::Cons::iterator"*, %"struct.minou::Cons"*) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.minou::Cons::iterator"*, align 8
  %4 = alloca %"struct.minou::Cons"*, align 8
  store %"class.minou::Cons::iterator"* %0, %"class.minou::Cons::iterator"** %3, align 8
  store %"struct.minou::Cons"* %1, %"struct.minou::Cons"** %4, align 8
  %5 = load %"class.minou::Cons::iterator"*, %"class.minou::Cons::iterator"** %3, align 8
  %6 = getelementptr inbounds %"class.minou::Cons::iterator", %"class.minou::Cons::iterator"* %5, i32 0, i32 0
  %7 = load %"struct.minou::Cons"*, %"struct.minou::Cons"** %4, align 8
  store %"struct.minou::Cons"* %7, %"struct.minou::Cons"** %6, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EEC2Ev(%"struct.std::_Vector_base.235"*) unnamed_addr #0 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base.235"*, align 8
  store %"struct.std::_Vector_base.235"* %0, %"struct.std::_Vector_base.235"** %2, align 8
  %3 = load %"struct.std::_Vector_base.235"*, %"struct.std::_Vector_base.235"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %3, i32 0, i32 0
  call void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE12_Vector_implC2Ev(%"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %4)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE12_Vector_implC2Ev(%"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"*, align 8
  store %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %0, %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"** %2, align 8
  %3 = load %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"*, %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %3 to %"class.std::allocator.236"*
  call void @_ZNSaIN5minou4AtomEEC2Ev(%"class.std::allocator.236"* %4) #3
  %5 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %3, i32 0, i32 0
  store %"struct.minou::Atom"* null, %"struct.minou::Atom"** %5, align 8
  %6 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %3, i32 0, i32 1
  store %"struct.minou::Atom"* null, %"struct.minou::Atom"** %6, align 8
  %7 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %3, i32 0, i32 2
  store %"struct.minou::Atom"* null, %"struct.minou::Atom"** %7, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSaIN5minou4AtomEEC2Ev(%"class.std::allocator.236"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::allocator.236"*, align 8
  store %"class.std::allocator.236"* %0, %"class.std::allocator.236"** %2, align 8
  %3 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %2, align 8
  %4 = bitcast %"class.std::allocator.236"* %3 to %"class.__gnu_cxx::new_allocator.237"*
  call void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEEC2Ev(%"class.__gnu_cxx::new_allocator.237"* %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEEC2Ev(%"class.__gnu_cxx::new_allocator.237"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::new_allocator.237"*, align 8
  store %"class.__gnu_cxx::new_allocator.237"* %0, %"class.__gnu_cxx::new_allocator.237"** %2, align 8
  %3 = load %"class.__gnu_cxx::new_allocator.237"*, %"class.__gnu_cxx::new_allocator.237"** %2, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZSt8_DestroyIPN5minou4AtomES1_EvT_S3_RSaIT0_E(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"class.std::allocator.236"* dereferenceable(1)) #0 comdat {
  %4 = alloca %"struct.minou::Atom"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"class.std::allocator.236"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store %"class.std::allocator.236"* %2, %"class.std::allocator.236"** %6, align 8
  %7 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  call void @_ZSt8_DestroyIPN5minou4AtomEEvT_S3_(%"struct.minou::Atom"* %7, %"struct.minou::Atom"* %8)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"class.std::allocator.236"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base.235"*, align 8
  store %"struct.std::_Vector_base.235"* %0, %"struct.std::_Vector_base.235"** %2, align 8
  %3 = load %"struct.std::_Vector_base.235"*, %"struct.std::_Vector_base.235"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %4 to %"class.std::allocator.236"*
  ret %"class.std::allocator.236"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EED2Ev(%"struct.std::_Vector_base.235"*) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"struct.std::_Vector_base.235"*, align 8
  %3 = alloca i8*
  %4 = alloca i32
  store %"struct.std::_Vector_base.235"* %0, %"struct.std::_Vector_base.235"** %2, align 8
  %5 = load %"struct.std::_Vector_base.235"*, %"struct.std::_Vector_base.235"** %2, align 8
  %6 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %6, i32 0, i32 0
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %7, align 8
  %9 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %9, i32 0, i32 2
  %11 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %12 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  %13 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %12, i32 0, i32 0
  %14 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %13, align 8
  %15 = ptrtoint %"struct.minou::Atom"* %11 to i64
  %16 = ptrtoint %"struct.minou::Atom"* %14 to i64
  %17 = sub i64 %15, %16
  %18 = sdiv exact i64 %17, 8
  invoke void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE13_M_deallocateEPS1_m(%"struct.std::_Vector_base.235"* %5, %"struct.minou::Atom"* %8, i64 %18)
          to label %19 unwind label %21

; <label>:19:                                     ; preds = %1
  %20 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  call void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %20) #3
  ret void

; <label>:21:                                     ; preds = %1
  %22 = landingpad { i8*, i32 }
          catch i8* null
  %23 = extractvalue { i8*, i32 } %22, 0
  store i8* %23, i8** %3, align 8
  %24 = extractvalue { i8*, i32 } %22, 1
  store i32 %24, i32* %4, align 4
  %25 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  call void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %25) #3
  br label %26

; <label>:26:                                     ; preds = %21
  %27 = load i8*, i8** %3, align 8
  call void @__clang_call_terminate(i8* %27) #7
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZSt8_DestroyIPN5minou4AtomEEvT_S3_(%"struct.minou::Atom"*, %"struct.minou::Atom"*) #0 comdat {
  %3 = alloca %"struct.minou::Atom"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %3, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %4, align 8
  %5 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %3, align 8
  %6 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  call void @_ZNSt12_Destroy_auxILb1EE9__destroyIPN5minou4AtomEEEvT_S5_(%"struct.minou::Atom"* %5, %"struct.minou::Atom"* %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Destroy_auxILb1EE9__destroyIPN5minou4AtomEEEvT_S5_(%"struct.minou::Atom"*, %"struct.minou::Atom"*) #2 comdat align 2 {
  %3 = alloca %"struct.minou::Atom"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %3, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %4, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE13_M_deallocateEPS1_m(%"struct.std::_Vector_base.235"*, %"struct.minou::Atom"*, i64) #0 comdat align 2 {
  %4 = alloca %"struct.std::_Vector_base.235"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca i64, align 8
  store %"struct.std::_Vector_base.235"* %0, %"struct.std::_Vector_base.235"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"struct.std::_Vector_base.235"*, %"struct.std::_Vector_base.235"** %4, align 8
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %9 = icmp ne %"struct.minou::Atom"* %8, null
  br i1 %9, label %10, label %15

; <label>:10:                                     ; preds = %3
  %11 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %7, i32 0, i32 0
  %12 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %11 to %"class.std::allocator.236"*
  %13 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %14 = load i64, i64* %6, align 8
  call void @_ZNSt16allocator_traitsISaIN5minou4AtomEEE10deallocateERS2_PS1_m(%"class.std::allocator.236"* dereferenceable(1) %12, %"struct.minou::Atom"* %13, i64 %14)
  br label %15

; <label>:15:                                     ; preds = %10, %3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"*, align 8
  store %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %0, %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"** %2, align 8
  %3 = load %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"*, %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %3 to %"class.std::allocator.236"*
  call void @_ZNSaIN5minou4AtomEED2Ev(%"class.std::allocator.236"* %4) #3
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaIN5minou4AtomEEE10deallocateERS2_PS1_m(%"class.std::allocator.236"* dereferenceable(1), %"struct.minou::Atom"*, i64) #0 comdat align 2 {
  %4 = alloca %"class.std::allocator.236"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca i64, align 8
  store %"class.std::allocator.236"* %0, %"class.std::allocator.236"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %4, align 8
  %8 = bitcast %"class.std::allocator.236"* %7 to %"class.__gnu_cxx::new_allocator.237"*
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %10 = load i64, i64* %6, align 8
  call void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE10deallocateEPS2_m(%"class.__gnu_cxx::new_allocator.237"* %8, %"struct.minou::Atom"* %9, i64 %10)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE10deallocateEPS2_m(%"class.__gnu_cxx::new_allocator.237"*, %"struct.minou::Atom"*, i64) #2 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator.237"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca i64, align 8
  store %"class.__gnu_cxx::new_allocator.237"* %0, %"class.__gnu_cxx::new_allocator.237"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator.237"*, %"class.__gnu_cxx::new_allocator.237"** %4, align 8
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %9 = bitcast %"struct.minou::Atom"* %8 to i8*
  call void @_ZdlPv(i8* %9) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSaIN5minou4AtomEED2Ev(%"class.std::allocator.236"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.std::allocator.236"*, align 8
  store %"class.std::allocator.236"* %0, %"class.std::allocator.236"** %2, align 8
  %3 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %2, align 8
  %4 = bitcast %"class.std::allocator.236"* %3 to %"class.__gnu_cxx::new_allocator.237"*
  call void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEED2Ev(%"class.__gnu_cxx::new_allocator.237"* %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEED2Ev(%"class.__gnu_cxx::new_allocator.237"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::new_allocator.237"*, align 8
  store %"class.__gnu_cxx::new_allocator.237"* %0, %"class.__gnu_cxx::new_allocator.237"** %2, align 8
  %3 = load %"class.__gnu_cxx::new_allocator.237"*, %"class.__gnu_cxx::new_allocator.237"** %2, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaIN5minou4AtomEEE9constructIS1_JRKS1_EEEvRS2_PT_DpOT0_(%"class.std::allocator.236"* dereferenceable(1), %"struct.minou::Atom"*, %"struct.minou::Atom"* dereferenceable(8)) #0 comdat align 2 {
  %4 = alloca %"class.std::allocator.236"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  store %"class.std::allocator.236"* %0, %"class.std::allocator.236"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  %7 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %4, align 8
  %8 = bitcast %"class.std::allocator.236"* %7 to %"class.__gnu_cxx::new_allocator.237"*
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %10 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %11 = call dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRKN5minou4AtomEEOT_RNSt16remove_referenceIS4_E4typeE(%"struct.minou::Atom"* dereferenceable(8) %10) #3
  call void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE9constructIS2_JRKS2_EEEvPT_DpOT0_(%"class.__gnu_cxx::new_allocator.237"* %8, %"struct.minou::Atom"* %9, %"struct.minou::Atom"* dereferenceable(8) %11)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt6vectorIN5minou4AtomESaIS1_EE17_M_realloc_insertIJRKS1_EEEvN9__gnu_cxx17__normal_iteratorIPS1_S3_EEDpOT_(%"class.std::vector.234"*, %"struct.minou::Atom"*, %"struct.minou::Atom"* dereferenceable(8)) #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca %"class.__gnu_cxx::__normal_iterator.298", align 8
  %5 = alloca %"class.std::vector.234"*, align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %"class.__gnu_cxx::__normal_iterator.298", align 8
  %10 = alloca %"struct.minou::Atom"*, align 8
  %11 = alloca %"struct.minou::Atom"*, align 8
  %12 = alloca i8*
  %13 = alloca i32
  %14 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %4, i32 0, i32 0
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %14, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %5, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  %15 = load %"class.std::vector.234"*, %"class.std::vector.234"** %5, align 8
  %16 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE12_M_check_lenEmPKc(%"class.std::vector.234"* %15, i64 1, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.8, i32 0, i32 0))
  store i64 %16, i64* %7, align 8
  %17 = call %"struct.minou::Atom"* @_ZNSt6vectorIN5minou4AtomESaIS1_EE5beginEv(%"class.std::vector.234"* %15) #3
  %18 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %9, i32 0, i32 0
  store %"struct.minou::Atom"* %17, %"struct.minou::Atom"** %18, align 8
  %19 = call i64 @_ZN9__gnu_cxxmiIPN5minou4AtomESt6vectorIS2_SaIS2_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSA_SD_(%"class.__gnu_cxx::__normal_iterator.298"* dereferenceable(8) %4, %"class.__gnu_cxx::__normal_iterator.298"* dereferenceable(8) %9) #3
  store i64 %19, i64* %8, align 8
  %20 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %21 = load i64, i64* %7, align 8
  %22 = call %"struct.minou::Atom"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE11_M_allocateEm(%"struct.std::_Vector_base.235"* %20, i64 %21)
  store %"struct.minou::Atom"* %22, %"struct.minou::Atom"** %10, align 8
  %23 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  store %"struct.minou::Atom"* %23, %"struct.minou::Atom"** %11, align 8
  %24 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %25 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %24, i32 0, i32 0
  %26 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %25 to %"class.std::allocator.236"*
  %27 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %28 = load i64, i64* %8, align 8
  %29 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %27, i64 %28
  %30 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %31 = call dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRKN5minou4AtomEEOT_RNSt16remove_referenceIS4_E4typeE(%"struct.minou::Atom"* dereferenceable(8) %30) #3
  invoke void @_ZNSt16allocator_traitsISaIN5minou4AtomEEE9constructIS1_JRKS1_EEEvRS2_PT_DpOT0_(%"class.std::allocator.236"* dereferenceable(1) %26, %"struct.minou::Atom"* %29, %"struct.minou::Atom"* dereferenceable(8) %31)
          to label %32 unwind label %57

; <label>:32:                                     ; preds = %3
  store %"struct.minou::Atom"* null, %"struct.minou::Atom"** %11, align 8
  %33 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %34 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %33, i32 0, i32 0
  %35 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %34, i32 0, i32 0
  %36 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %35, align 8
  %37 = call dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.298"* %4) #3
  %38 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %37, align 8
  %39 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %40 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %41 = call dereferenceable(1) %"class.std::allocator.236"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"* %40) #3
  %42 = invoke %"struct.minou::Atom"* @_ZSt34__uninitialized_move_if_noexcept_aIPN5minou4AtomES2_SaIS1_EET0_T_S5_S4_RT1_(%"struct.minou::Atom"* %36, %"struct.minou::Atom"* %38, %"struct.minou::Atom"* %39, %"class.std::allocator.236"* dereferenceable(1) %41)
          to label %43 unwind label %57

; <label>:43:                                     ; preds = %32
  store %"struct.minou::Atom"* %42, %"struct.minou::Atom"** %11, align 8
  %44 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %11, align 8
  %45 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %44, i32 1
  store %"struct.minou::Atom"* %45, %"struct.minou::Atom"** %11, align 8
  %46 = call dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.298"* %4) #3
  %47 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %46, align 8
  %48 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %49 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %48, i32 0, i32 0
  %50 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %49, i32 0, i32 1
  %51 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %50, align 8
  %52 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %11, align 8
  %53 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %54 = call dereferenceable(1) %"class.std::allocator.236"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"* %53) #3
  %55 = invoke %"struct.minou::Atom"* @_ZSt34__uninitialized_move_if_noexcept_aIPN5minou4AtomES2_SaIS1_EET0_T_S5_S4_RT1_(%"struct.minou::Atom"* %47, %"struct.minou::Atom"* %51, %"struct.minou::Atom"* %52, %"class.std::allocator.236"* dereferenceable(1) %54)
          to label %56 unwind label %57

; <label>:56:                                     ; preds = %43
  store %"struct.minou::Atom"* %55, %"struct.minou::Atom"** %11, align 8
  br label %90

; <label>:57:                                     ; preds = %43, %32, %3
  %58 = landingpad { i8*, i32 }
          catch i8* null
  %59 = extractvalue { i8*, i32 } %58, 0
  store i8* %59, i8** %12, align 8
  %60 = extractvalue { i8*, i32 } %58, 1
  store i32 %60, i32* %13, align 4
  br label %61

; <label>:61:                                     ; preds = %57
  %62 = load i8*, i8** %12, align 8
  %63 = call i8* @__cxa_begin_catch(i8* %62) #3
  %64 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %11, align 8
  %65 = icmp ne %"struct.minou::Atom"* %64, null
  br i1 %65, label %78, label %66

; <label>:66:                                     ; preds = %61
  %67 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %68 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %67, i32 0, i32 0
  %69 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %68 to %"class.std::allocator.236"*
  %70 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %71 = load i64, i64* %8, align 8
  %72 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %70, i64 %71
  invoke void @_ZNSt16allocator_traitsISaIN5minou4AtomEEE7destroyIS1_EEvRS2_PT_(%"class.std::allocator.236"* dereferenceable(1) %69, %"struct.minou::Atom"* %72)
          to label %73 unwind label %74

; <label>:73:                                     ; preds = %66
  br label %84

; <label>:74:                                     ; preds = %88, %84, %78, %66
  %75 = landingpad { i8*, i32 }
          cleanup
  %76 = extractvalue { i8*, i32 } %75, 0
  store i8* %76, i8** %12, align 8
  %77 = extractvalue { i8*, i32 } %75, 1
  store i32 %77, i32* %13, align 4
  invoke void @__cxa_end_catch()
          to label %89 unwind label %137

; <label>:78:                                     ; preds = %61
  %79 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %80 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %11, align 8
  %81 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %82 = call dereferenceable(1) %"class.std::allocator.236"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"* %81) #3
  invoke void @_ZSt8_DestroyIPN5minou4AtomES1_EvT_S3_RSaIT0_E(%"struct.minou::Atom"* %79, %"struct.minou::Atom"* %80, %"class.std::allocator.236"* dereferenceable(1) %82)
          to label %83 unwind label %74

; <label>:83:                                     ; preds = %78
  br label %84

; <label>:84:                                     ; preds = %83, %73
  %85 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %86 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %87 = load i64, i64* %7, align 8
  invoke void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE13_M_deallocateEPS1_m(%"struct.std::_Vector_base.235"* %85, %"struct.minou::Atom"* %86, i64 %87)
          to label %88 unwind label %74

; <label>:88:                                     ; preds = %84
  invoke void @__cxa_rethrow() #14
          to label %140 unwind label %74

; <label>:89:                                     ; preds = %74
  br label %132

; <label>:90:                                     ; preds = %56
  %91 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %92 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %91, i32 0, i32 0
  %93 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %92, i32 0, i32 0
  %94 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %93, align 8
  %95 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %96 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %95, i32 0, i32 0
  %97 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %96, i32 0, i32 1
  %98 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %97, align 8
  %99 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %100 = call dereferenceable(1) %"class.std::allocator.236"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"* %99) #3
  call void @_ZSt8_DestroyIPN5minou4AtomES1_EvT_S3_RSaIT0_E(%"struct.minou::Atom"* %94, %"struct.minou::Atom"* %98, %"class.std::allocator.236"* dereferenceable(1) %100)
  %101 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %102 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %103 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %102, i32 0, i32 0
  %104 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %103, i32 0, i32 0
  %105 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %104, align 8
  %106 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %107 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %106, i32 0, i32 0
  %108 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %107, i32 0, i32 2
  %109 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %108, align 8
  %110 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %111 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %110, i32 0, i32 0
  %112 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %111, i32 0, i32 0
  %113 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %112, align 8
  %114 = ptrtoint %"struct.minou::Atom"* %109 to i64
  %115 = ptrtoint %"struct.minou::Atom"* %113 to i64
  %116 = sub i64 %114, %115
  %117 = sdiv exact i64 %116, 8
  call void @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE13_M_deallocateEPS1_m(%"struct.std::_Vector_base.235"* %101, %"struct.minou::Atom"* %105, i64 %117)
  %118 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %119 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %120 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %119, i32 0, i32 0
  %121 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %120, i32 0, i32 0
  store %"struct.minou::Atom"* %118, %"struct.minou::Atom"** %121, align 8
  %122 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %11, align 8
  %123 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %124 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %123, i32 0, i32 0
  %125 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %124, i32 0, i32 1
  store %"struct.minou::Atom"* %122, %"struct.minou::Atom"** %125, align 8
  %126 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %127 = load i64, i64* %7, align 8
  %128 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %126, i64 %127
  %129 = bitcast %"class.std::vector.234"* %15 to %"struct.std::_Vector_base.235"*
  %130 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %129, i32 0, i32 0
  %131 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %130, i32 0, i32 2
  store %"struct.minou::Atom"* %128, %"struct.minou::Atom"** %131, align 8
  ret void

; <label>:132:                                    ; preds = %89
  %133 = load i8*, i8** %12, align 8
  %134 = load i32, i32* %13, align 4
  %135 = insertvalue { i8*, i32 } undef, i8* %133, 0
  %136 = insertvalue { i8*, i32 } %135, i32 %134, 1
  resume { i8*, i32 } %136

; <label>:137:                                    ; preds = %74
  %138 = landingpad { i8*, i32 }
          catch i8* null
  %139 = extractvalue { i8*, i32 } %138, 0
  call void @__clang_call_terminate(i8* %139) #7
  unreachable

; <label>:140:                                    ; preds = %88
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNSt6vectorIN5minou4AtomESaIS1_EE3endEv(%"class.std::vector.234"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.298", align 8
  %3 = alloca %"class.std::vector.234"*, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %3, align 8
  %4 = load %"class.std::vector.234"*, %"class.std::vector.234"** %3, align 8
  %5 = bitcast %"class.std::vector.234"* %4 to %"struct.std::_Vector_base.235"*
  %6 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %6, i32 0, i32 1
  call void @_ZN9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS3_(%"class.__gnu_cxx::__normal_iterator.298"* %2, %"struct.minou::Atom"** dereferenceable(8) %7) #3
  %8 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %2, i32 0, i32 0
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %8, align 8
  ret %"struct.minou::Atom"* %9
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE9constructIS2_JRKS2_EEEvPT_DpOT0_(%"class.__gnu_cxx::new_allocator.237"*, %"struct.minou::Atom"*, %"struct.minou::Atom"* dereferenceable(8)) #2 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator.237"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  store %"class.__gnu_cxx::new_allocator.237"* %0, %"class.__gnu_cxx::new_allocator.237"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator.237"*, %"class.__gnu_cxx::new_allocator.237"** %4, align 8
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %9 = bitcast %"struct.minou::Atom"* %8 to i8*
  %10 = bitcast i8* %9 to %"struct.minou::Atom"*
  %11 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %12 = call dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRKN5minou4AtomEEOT_RNSt16remove_referenceIS4_E4typeE(%"struct.minou::Atom"* dereferenceable(8) %11) #3
  %13 = bitcast %"struct.minou::Atom"* %10 to i8*
  %14 = bitcast %"struct.minou::Atom"* %12 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* %14, i64 8, i32 8, i1 false)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"* @_ZSt7forwardIRKN5minou4AtomEEOT_RNSt16remove_referenceIS4_E4typeE(%"struct.minou::Atom"* dereferenceable(8)) #2 comdat {
  %2 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %2, align 8
  %3 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %2, align 8
  ret %"struct.minou::Atom"* %3
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE12_M_check_lenEmPKc(%"class.std::vector.234"*, i64, i8*) #0 comdat align 2 {
  %4 = alloca %"class.std::vector.234"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8* %2, i8** %6, align 8
  %9 = load %"class.std::vector.234"*, %"class.std::vector.234"** %4, align 8
  %10 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE8max_sizeEv(%"class.std::vector.234"* %9) #3
  %11 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE4sizeEv(%"class.std::vector.234"* %9) #3
  %12 = sub i64 %10, %11
  %13 = load i64, i64* %5, align 8
  %14 = icmp ult i64 %12, %13
  br i1 %14, label %15, label %17

; <label>:15:                                     ; preds = %3
  %16 = load i8*, i8** %6, align 8
  call void @_ZSt20__throw_length_errorPKc(i8* %16) #14
  unreachable

; <label>:17:                                     ; preds = %3
  %18 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE4sizeEv(%"class.std::vector.234"* %9) #3
  %19 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE4sizeEv(%"class.std::vector.234"* %9) #3
  store i64 %19, i64* %8, align 8
  %20 = call dereferenceable(8) i64* @_ZSt3maxImERKT_S2_S2_(i64* dereferenceable(8) %8, i64* dereferenceable(8) %5)
  %21 = load i64, i64* %20, align 8
  %22 = add i64 %18, %21
  store i64 %22, i64* %7, align 8
  %23 = load i64, i64* %7, align 8
  %24 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE4sizeEv(%"class.std::vector.234"* %9) #3
  %25 = icmp ult i64 %23, %24
  br i1 %25, label %30, label %26

; <label>:26:                                     ; preds = %17
  %27 = load i64, i64* %7, align 8
  %28 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE8max_sizeEv(%"class.std::vector.234"* %9) #3
  %29 = icmp ugt i64 %27, %28
  br i1 %29, label %30, label %32

; <label>:30:                                     ; preds = %26, %17
  %31 = call i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE8max_sizeEv(%"class.std::vector.234"* %9) #3
  br label %34

; <label>:32:                                     ; preds = %26
  %33 = load i64, i64* %7, align 8
  br label %34

; <label>:34:                                     ; preds = %32, %30
  %35 = phi i64 [ %31, %30 ], [ %33, %32 ]
  ret i64 %35
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZN9__gnu_cxxmiIPN5minou4AtomESt6vectorIS2_SaIS2_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSA_SD_(%"class.__gnu_cxx::__normal_iterator.298"* dereferenceable(8), %"class.__gnu_cxx::__normal_iterator.298"* dereferenceable(8)) #2 comdat {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator.298"*, align 8
  %4 = alloca %"class.__gnu_cxx::__normal_iterator.298"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.298"* %0, %"class.__gnu_cxx::__normal_iterator.298"** %3, align 8
  store %"class.__gnu_cxx::__normal_iterator.298"* %1, %"class.__gnu_cxx::__normal_iterator.298"** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator.298"*, %"class.__gnu_cxx::__normal_iterator.298"** %3, align 8
  %6 = call dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.298"* %5) #3
  %7 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %8 = load %"class.__gnu_cxx::__normal_iterator.298"*, %"class.__gnu_cxx::__normal_iterator.298"** %4, align 8
  %9 = call dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.298"* %8) #3
  %10 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %9, align 8
  %11 = ptrtoint %"struct.minou::Atom"* %7 to i64
  %12 = ptrtoint %"struct.minou::Atom"* %10 to i64
  %13 = sub i64 %11, %12
  %14 = sdiv exact i64 %13, 8
  ret i64 %14
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNSt6vectorIN5minou4AtomESaIS1_EE5beginEv(%"class.std::vector.234"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.298", align 8
  %3 = alloca %"class.std::vector.234"*, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %3, align 8
  %4 = load %"class.std::vector.234"*, %"class.std::vector.234"** %3, align 8
  %5 = bitcast %"class.std::vector.234"* %4 to %"struct.std::_Vector_base.235"*
  %6 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %6, i32 0, i32 0
  call void @_ZN9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS3_(%"class.__gnu_cxx::__normal_iterator.298"* %2, %"struct.minou::Atom"** dereferenceable(8) %7) #3
  %8 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %2, i32 0, i32 0
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %8, align 8
  ret %"struct.minou::Atom"* %9
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNSt12_Vector_baseIN5minou4AtomESaIS1_EE11_M_allocateEm(%"struct.std::_Vector_base.235"*, i64) #0 comdat align 2 {
  %3 = alloca %"struct.std::_Vector_base.235"*, align 8
  %4 = alloca i64, align 8
  store %"struct.std::_Vector_base.235"* %0, %"struct.std::_Vector_base.235"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"struct.std::_Vector_base.235"*, %"struct.std::_Vector_base.235"** %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ne i64 %6, 0
  br i1 %7, label %8, label %13

; <label>:8:                                      ; preds = %2
  %9 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %5, i32 0, i32 0
  %10 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %9 to %"class.std::allocator.236"*
  %11 = load i64, i64* %4, align 8
  %12 = call %"struct.minou::Atom"* @_ZNSt16allocator_traitsISaIN5minou4AtomEEE8allocateERS2_m(%"class.std::allocator.236"* dereferenceable(1) %10, i64 %11)
  br label %14

; <label>:13:                                     ; preds = %2
  br label %14

; <label>:14:                                     ; preds = %13, %8
  %15 = phi %"struct.minou::Atom"* [ %12, %8 ], [ null, %13 ]
  ret %"struct.minou::Atom"* %15
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt34__uninitialized_move_if_noexcept_aIPN5minou4AtomES2_SaIS1_EET0_T_S5_S4_RT1_(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*, %"class.std::allocator.236"* dereferenceable(1)) #0 comdat {
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  %7 = alloca %"struct.minou::Atom"*, align 8
  %8 = alloca %"class.std::allocator.236"*, align 8
  %9 = alloca %"class.std::move_iterator", align 8
  %10 = alloca %"class.std::move_iterator", align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %5, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %6, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %7, align 8
  store %"class.std::allocator.236"* %3, %"class.std::allocator.236"** %8, align 8
  %11 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %12 = call %"struct.minou::Atom"* @_ZSt32__make_move_if_noexcept_iteratorIN5minou4AtomESt13move_iteratorIPS1_EET0_PT_(%"struct.minou::Atom"* %11)
  %13 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %9, i32 0, i32 0
  store %"struct.minou::Atom"* %12, %"struct.minou::Atom"** %13, align 8
  %14 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %15 = call %"struct.minou::Atom"* @_ZSt32__make_move_if_noexcept_iteratorIN5minou4AtomESt13move_iteratorIPS1_EET0_PT_(%"struct.minou::Atom"* %14)
  %16 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %10, i32 0, i32 0
  store %"struct.minou::Atom"* %15, %"struct.minou::Atom"** %16, align 8
  %17 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %7, align 8
  %18 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %8, align 8
  %19 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %9, i32 0, i32 0
  %20 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %19, align 8
  %21 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %10, i32 0, i32 0
  %22 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %21, align 8
  %23 = call %"struct.minou::Atom"* @_ZSt22__uninitialized_copy_aISt13move_iteratorIPN5minou4AtomEES3_S2_ET0_T_S6_S5_RSaIT1_E(%"struct.minou::Atom"* %20, %"struct.minou::Atom"* %22, %"struct.minou::Atom"* %17, %"class.std::allocator.236"* dereferenceable(1) %18)
  ret %"struct.minou::Atom"* %23
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"struct.minou::Atom"** @_ZNK9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEE4baseEv(%"class.__gnu_cxx::__normal_iterator.298"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::__normal_iterator.298"*, align 8
  store %"class.__gnu_cxx::__normal_iterator.298"* %0, %"class.__gnu_cxx::__normal_iterator.298"** %2, align 8
  %3 = load %"class.__gnu_cxx::__normal_iterator.298"*, %"class.__gnu_cxx::__normal_iterator.298"** %2, align 8
  %4 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %3, i32 0, i32 0
  ret %"struct.minou::Atom"** %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaIN5minou4AtomEEE7destroyIS1_EEvRS2_PT_(%"class.std::allocator.236"* dereferenceable(1), %"struct.minou::Atom"*) #0 comdat align 2 {
  %3 = alloca %"class.std::allocator.236"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  store %"class.std::allocator.236"* %0, %"class.std::allocator.236"** %3, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %4, align 8
  %5 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %3, align 8
  %6 = bitcast %"class.std::allocator.236"* %5 to %"class.__gnu_cxx::new_allocator.237"*
  %7 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  call void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE7destroyIS2_EEvPT_(%"class.__gnu_cxx::new_allocator.237"* %6, %"struct.minou::Atom"* %7)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE8max_sizeEv(%"class.std::vector.234"*) #2 comdat align 2 {
  %2 = alloca %"class.std::vector.234"*, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %2, align 8
  %3 = load %"class.std::vector.234"*, %"class.std::vector.234"** %2, align 8
  %4 = bitcast %"class.std::vector.234"* %3 to %"struct.std::_Vector_base.235"*
  %5 = call dereferenceable(1) %"class.std::allocator.236"* @_ZNKSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"* %4) #3
  %6 = call i64 @_ZNSt16allocator_traitsISaIN5minou4AtomEEE8max_sizeERKS2_(%"class.std::allocator.236"* dereferenceable(1) %5) #3
  ret i64 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZNKSt6vectorIN5minou4AtomESaIS1_EE4sizeEv(%"class.std::vector.234"*) #2 comdat align 2 {
  %2 = alloca %"class.std::vector.234"*, align 8
  store %"class.std::vector.234"* %0, %"class.std::vector.234"** %2, align 8
  %3 = load %"class.std::vector.234"*, %"class.std::vector.234"** %2, align 8
  %4 = bitcast %"class.std::vector.234"* %3 to %"struct.std::_Vector_base.235"*
  %5 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %4, i32 0, i32 0
  %6 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %5, i32 0, i32 1
  %7 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %8 = bitcast %"class.std::vector.234"* %3 to %"struct.std::_Vector_base.235"*
  %9 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %8, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl", %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %9, i32 0, i32 0
  %11 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %10, align 8
  %12 = ptrtoint %"struct.minou::Atom"* %7 to i64
  %13 = ptrtoint %"struct.minou::Atom"* %11 to i64
  %14 = sub i64 %12, %13
  %15 = sdiv exact i64 %14, 8
  ret i64 %15
}

; Function Attrs: noreturn
declare void @_ZSt20__throw_length_errorPKc(i8*) #8

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) i64* @_ZSt3maxImERKT_S2_S2_(i64* dereferenceable(8), i64* dereferenceable(8)) #2 comdat {
  %3 = alloca i64*, align 8
  %4 = alloca i64*, align 8
  %5 = alloca i64*, align 8
  store i64* %0, i64** %4, align 8
  store i64* %1, i64** %5, align 8
  %6 = load i64*, i64** %4, align 8
  %7 = load i64, i64* %6, align 8
  %8 = load i64*, i64** %5, align 8
  %9 = load i64, i64* %8, align 8
  %10 = icmp ult i64 %7, %9
  br i1 %10, label %11, label %13

; <label>:11:                                     ; preds = %2
  %12 = load i64*, i64** %5, align 8
  store i64* %12, i64** %3, align 8
  br label %15

; <label>:13:                                     ; preds = %2
  %14 = load i64*, i64** %4, align 8
  store i64* %14, i64** %3, align 8
  br label %15

; <label>:15:                                     ; preds = %13, %11
  %16 = load i64*, i64** %3, align 8
  ret i64* %16
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZNSt16allocator_traitsISaIN5minou4AtomEEE8max_sizeERKS2_(%"class.std::allocator.236"* dereferenceable(1)) #2 comdat align 2 {
  %2 = alloca %"class.std::allocator.236"*, align 8
  store %"class.std::allocator.236"* %0, %"class.std::allocator.236"** %2, align 8
  %3 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %2, align 8
  %4 = bitcast %"class.std::allocator.236"* %3 to %"class.__gnu_cxx::new_allocator.237"*
  %5 = call i64 @_ZNK9__gnu_cxx13new_allocatorIN5minou4AtomEE8max_sizeEv(%"class.__gnu_cxx::new_allocator.237"* %4) #3
  ret i64 %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"class.std::allocator.236"* @_ZNKSt12_Vector_baseIN5minou4AtomESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.235"*) #2 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base.235"*, align 8
  store %"struct.std::_Vector_base.235"* %0, %"struct.std::_Vector_base.235"** %2, align 8
  %3 = load %"struct.std::_Vector_base.235"*, %"struct.std::_Vector_base.235"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Vector_base.235", %"struct.std::_Vector_base.235"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Vector_base<minou::Atom, std::allocator<minou::Atom> >::_Vector_impl"* %4 to %"class.std::allocator.236"*
  ret %"class.std::allocator.236"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i64 @_ZNK9__gnu_cxx13new_allocatorIN5minou4AtomEE8max_sizeEv(%"class.__gnu_cxx::new_allocator.237"*) #2 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::new_allocator.237"*, align 8
  store %"class.__gnu_cxx::new_allocator.237"* %0, %"class.__gnu_cxx::new_allocator.237"** %2, align 8
  %3 = load %"class.__gnu_cxx::new_allocator.237"*, %"class.__gnu_cxx::new_allocator.237"** %2, align 8
  ret i64 2305843009213693951
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx17__normal_iteratorIPN5minou4AtomESt6vectorIS2_SaIS2_EEEC2ERKS3_(%"class.__gnu_cxx::__normal_iterator.298"*, %"struct.minou::Atom"** dereferenceable(8)) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.__gnu_cxx::__normal_iterator.298"*, align 8
  %4 = alloca %"struct.minou::Atom"**, align 8
  store %"class.__gnu_cxx::__normal_iterator.298"* %0, %"class.__gnu_cxx::__normal_iterator.298"** %3, align 8
  store %"struct.minou::Atom"** %1, %"struct.minou::Atom"*** %4, align 8
  %5 = load %"class.__gnu_cxx::__normal_iterator.298"*, %"class.__gnu_cxx::__normal_iterator.298"** %3, align 8
  %6 = getelementptr inbounds %"class.__gnu_cxx::__normal_iterator.298", %"class.__gnu_cxx::__normal_iterator.298"* %5, i32 0, i32 0
  %7 = load %"struct.minou::Atom"**, %"struct.minou::Atom"*** %4, align 8
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %7, align 8
  store %"struct.minou::Atom"* %8, %"struct.minou::Atom"** %6, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNSt16allocator_traitsISaIN5minou4AtomEEE8allocateERS2_m(%"class.std::allocator.236"* dereferenceable(1), i64) #0 comdat align 2 {
  %3 = alloca %"class.std::allocator.236"*, align 8
  %4 = alloca i64, align 8
  store %"class.std::allocator.236"* %0, %"class.std::allocator.236"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.std::allocator.236"*, %"class.std::allocator.236"** %3, align 8
  %6 = bitcast %"class.std::allocator.236"* %5 to %"class.__gnu_cxx::new_allocator.237"*
  %7 = load i64, i64* %4, align 8
  %8 = call %"struct.minou::Atom"* @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE8allocateEmPKv(%"class.__gnu_cxx::new_allocator.237"* %6, i64 %7, i8* null)
  ret %"struct.minou::Atom"* %8
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE8allocateEmPKv(%"class.__gnu_cxx::new_allocator.237"*, i64, i8*) #0 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator.237"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  store %"class.__gnu_cxx::new_allocator.237"* %0, %"class.__gnu_cxx::new_allocator.237"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8* %2, i8** %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator.237"*, %"class.__gnu_cxx::new_allocator.237"** %4, align 8
  %8 = load i64, i64* %5, align 8
  %9 = call i64 @_ZNK9__gnu_cxx13new_allocatorIN5minou4AtomEE8max_sizeEv(%"class.__gnu_cxx::new_allocator.237"* %7) #3
  %10 = icmp ugt i64 %8, %9
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %3
  call void @_ZSt17__throw_bad_allocv() #14
  unreachable

; <label>:12:                                     ; preds = %3
  %13 = load i64, i64* %5, align 8
  %14 = mul i64 %13, 8
  %15 = call i8* @_Znwm(i64 %14)
  %16 = bitcast i8* %15 to %"struct.minou::Atom"*
  ret %"struct.minou::Atom"* %16
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt22__uninitialized_copy_aISt13move_iteratorIPN5minou4AtomEES3_S2_ET0_T_S6_S5_RSaIT1_E(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*, %"class.std::allocator.236"* dereferenceable(1)) #0 comdat {
  %5 = alloca %"class.std::move_iterator", align 8
  %6 = alloca %"class.std::move_iterator", align 8
  %7 = alloca %"struct.minou::Atom"*, align 8
  %8 = alloca %"class.std::allocator.236"*, align 8
  %9 = alloca %"class.std::move_iterator", align 8
  %10 = alloca %"class.std::move_iterator", align 8
  %11 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %5, i32 0, i32 0
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %11, align 8
  %12 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %6, i32 0, i32 0
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %12, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %7, align 8
  store %"class.std::allocator.236"* %3, %"class.std::allocator.236"** %8, align 8
  %13 = bitcast %"class.std::move_iterator"* %9 to i8*
  %14 = bitcast %"class.std::move_iterator"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* %14, i64 8, i32 8, i1 false)
  %15 = bitcast %"class.std::move_iterator"* %10 to i8*
  %16 = bitcast %"class.std::move_iterator"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* %16, i64 8, i32 8, i1 false)
  %17 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %7, align 8
  %18 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %9, i32 0, i32 0
  %19 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %18, align 8
  %20 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %10, i32 0, i32 0
  %21 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %20, align 8
  %22 = call %"struct.minou::Atom"* @_ZSt18uninitialized_copyISt13move_iteratorIPN5minou4AtomEES3_ET0_T_S6_S5_(%"struct.minou::Atom"* %19, %"struct.minou::Atom"* %21, %"struct.minou::Atom"* %17)
  ret %"struct.minou::Atom"* %22
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt32__make_move_if_noexcept_iteratorIN5minou4AtomESt13move_iteratorIPS1_EET0_PT_(%"struct.minou::Atom"*) #0 comdat {
  %2 = alloca %"class.std::move_iterator", align 8
  %3 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %3, align 8
  %4 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %3, align 8
  call void @_ZNSt13move_iteratorIPN5minou4AtomEEC2ES2_(%"class.std::move_iterator"* %2, %"struct.minou::Atom"* %4)
  %5 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %2, i32 0, i32 0
  %6 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  ret %"struct.minou::Atom"* %6
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt18uninitialized_copyISt13move_iteratorIPN5minou4AtomEES3_ET0_T_S6_S5_(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*) #0 comdat {
  %4 = alloca %"class.std::move_iterator", align 8
  %5 = alloca %"class.std::move_iterator", align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  %7 = alloca i8, align 1
  %8 = alloca %"class.std::move_iterator", align 8
  %9 = alloca %"class.std::move_iterator", align 8
  %10 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %4, i32 0, i32 0
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %10, align 8
  %11 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %5, i32 0, i32 0
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %11, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  store i8 1, i8* %7, align 1
  %12 = bitcast %"class.std::move_iterator"* %8 to i8*
  %13 = bitcast %"class.std::move_iterator"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* %13, i64 8, i32 8, i1 false)
  %14 = bitcast %"class.std::move_iterator"* %9 to i8*
  %15 = bitcast %"class.std::move_iterator"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %14, i8* %15, i64 8, i32 8, i1 false)
  %16 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %17 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %8, i32 0, i32 0
  %18 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %17, align 8
  %19 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %9, i32 0, i32 0
  %20 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %19, align 8
  %21 = call %"struct.minou::Atom"* @_ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPN5minou4AtomEES5_EET0_T_S8_S7_(%"struct.minou::Atom"* %18, %"struct.minou::Atom"* %20, %"struct.minou::Atom"* %16)
  ret %"struct.minou::Atom"* %21
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPN5minou4AtomEES5_EET0_T_S8_S7_(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*) #0 comdat align 2 {
  %4 = alloca %"class.std::move_iterator", align 8
  %5 = alloca %"class.std::move_iterator", align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  %7 = alloca %"class.std::move_iterator", align 8
  %8 = alloca %"class.std::move_iterator", align 8
  %9 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %4, i32 0, i32 0
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %9, align 8
  %10 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %5, i32 0, i32 0
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %10, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  %11 = bitcast %"class.std::move_iterator"* %7 to i8*
  %12 = bitcast %"class.std::move_iterator"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* %12, i64 8, i32 8, i1 false)
  %13 = bitcast %"class.std::move_iterator"* %8 to i8*
  %14 = bitcast %"class.std::move_iterator"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* %14, i64 8, i32 8, i1 false)
  %15 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %16 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %7, i32 0, i32 0
  %17 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %16, align 8
  %18 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %8, i32 0, i32 0
  %19 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %18, align 8
  %20 = call %"struct.minou::Atom"* @_ZSt4copyISt13move_iteratorIPN5minou4AtomEES3_ET0_T_S6_S5_(%"struct.minou::Atom"* %17, %"struct.minou::Atom"* %19, %"struct.minou::Atom"* %15)
  ret %"struct.minou::Atom"* %20
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt4copyISt13move_iteratorIPN5minou4AtomEES3_ET0_T_S6_S5_(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*) #0 comdat {
  %4 = alloca %"class.std::move_iterator", align 8
  %5 = alloca %"class.std::move_iterator", align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  %7 = alloca %"class.std::move_iterator", align 8
  %8 = alloca %"class.std::move_iterator", align 8
  %9 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %4, i32 0, i32 0
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %9, align 8
  %10 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %5, i32 0, i32 0
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %10, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  %11 = bitcast %"class.std::move_iterator"* %7 to i8*
  %12 = bitcast %"class.std::move_iterator"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* %12, i64 8, i32 8, i1 false)
  %13 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %7, i32 0, i32 0
  %14 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %13, align 8
  %15 = call %"struct.minou::Atom"* @_ZSt12__miter_baseIPN5minou4AtomEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E(%"struct.minou::Atom"* %14)
  %16 = bitcast %"class.std::move_iterator"* %8 to i8*
  %17 = bitcast %"class.std::move_iterator"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %16, i8* %17, i64 8, i32 8, i1 false)
  %18 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %8, i32 0, i32 0
  %19 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %18, align 8
  %20 = call %"struct.minou::Atom"* @_ZSt12__miter_baseIPN5minou4AtomEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E(%"struct.minou::Atom"* %19)
  %21 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %22 = call %"struct.minou::Atom"* @_ZSt14__copy_move_a2ILb1EPN5minou4AtomES2_ET1_T0_S4_S3_(%"struct.minou::Atom"* %15, %"struct.minou::Atom"* %20, %"struct.minou::Atom"* %21)
  ret %"struct.minou::Atom"* %22
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt14__copy_move_a2ILb1EPN5minou4AtomES2_ET1_T0_S4_S3_(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*) #0 comdat {
  %4 = alloca %"struct.minou::Atom"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  %7 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %8 = call %"struct.minou::Atom"* @_ZSt12__niter_baseIPN5minou4AtomEET_S3_(%"struct.minou::Atom"* %7)
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %10 = call %"struct.minou::Atom"* @_ZSt12__niter_baseIPN5minou4AtomEET_S3_(%"struct.minou::Atom"* %9)
  %11 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %12 = call %"struct.minou::Atom"* @_ZSt12__niter_baseIPN5minou4AtomEET_S3_(%"struct.minou::Atom"* %11)
  %13 = call %"struct.minou::Atom"* @_ZSt13__copy_move_aILb1EPN5minou4AtomES2_ET1_T0_S4_S3_(%"struct.minou::Atom"* %8, %"struct.minou::Atom"* %10, %"struct.minou::Atom"* %12)
  ret %"struct.minou::Atom"* %13
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt12__miter_baseIPN5minou4AtomEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E(%"struct.minou::Atom"*) #0 comdat {
  %2 = alloca %"class.std::move_iterator", align 8
  %3 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %2, i32 0, i32 0
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %3, align 8
  %4 = call %"struct.minou::Atom"* @_ZNKSt13move_iteratorIPN5minou4AtomEE4baseEv(%"class.std::move_iterator"* %2)
  %5 = call %"struct.minou::Atom"* @_ZSt12__miter_baseIPN5minou4AtomEET_S3_(%"struct.minou::Atom"* %4)
  ret %"struct.minou::Atom"* %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt13__copy_move_aILb1EPN5minou4AtomES2_ET1_T0_S4_S3_(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*) #0 comdat {
  %4 = alloca %"struct.minou::Atom"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  %7 = alloca i8, align 1
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  store i8 1, i8* %7, align 1
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %10 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %11 = call %"struct.minou::Atom"* @_ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIN5minou4AtomEEEPT_PKS5_S8_S6_(%"struct.minou::Atom"* %8, %"struct.minou::Atom"* %9, %"struct.minou::Atom"* %10)
  ret %"struct.minou::Atom"* %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt12__niter_baseIPN5minou4AtomEET_S3_(%"struct.minou::Atom"*) #2 comdat {
  %2 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %2, align 8
  %3 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %2, align 8
  ret %"struct.minou::Atom"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIN5minou4AtomEEEPT_PKS5_S8_S6_(%"struct.minou::Atom"*, %"struct.minou::Atom"*, %"struct.minou::Atom"*) #2 comdat align 2 {
  %4 = alloca %"struct.minou::Atom"*, align 8
  %5 = alloca %"struct.minou::Atom"*, align 8
  %6 = alloca %"struct.minou::Atom"*, align 8
  %7 = alloca i64, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %4, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %5, align 8
  store %"struct.minou::Atom"* %2, %"struct.minou::Atom"** %6, align 8
  %8 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %5, align 8
  %9 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %10 = ptrtoint %"struct.minou::Atom"* %8 to i64
  %11 = ptrtoint %"struct.minou::Atom"* %9 to i64
  %12 = sub i64 %10, %11
  %13 = sdiv exact i64 %12, 8
  store i64 %13, i64* %7, align 8
  %14 = load i64, i64* %7, align 8
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

; <label>:16:                                     ; preds = %3
  %17 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %18 = bitcast %"struct.minou::Atom"* %17 to i8*
  %19 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  %20 = bitcast %"struct.minou::Atom"* %19 to i8*
  %21 = load i64, i64* %7, align 8
  %22 = mul i64 8, %21
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %18, i8* %20, i64 %22, i32 8, i1 false)
  br label %23

; <label>:23:                                     ; preds = %16, %3
  %24 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %6, align 8
  %25 = load i64, i64* %7, align 8
  %26 = getelementptr inbounds %"struct.minou::Atom", %"struct.minou::Atom"* %24, i64 %25
  ret %"struct.minou::Atom"* %26
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZSt12__miter_baseIPN5minou4AtomEET_S3_(%"struct.minou::Atom"*) #2 comdat {
  %2 = alloca %"struct.minou::Atom"*, align 8
  store %"struct.minou::Atom"* %0, %"struct.minou::Atom"** %2, align 8
  %3 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %2, align 8
  ret %"struct.minou::Atom"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"struct.minou::Atom"* @_ZNKSt13move_iteratorIPN5minou4AtomEE4baseEv(%"class.std::move_iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.std::move_iterator"*, align 8
  store %"class.std::move_iterator"* %0, %"class.std::move_iterator"** %2, align 8
  %3 = load %"class.std::move_iterator"*, %"class.std::move_iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %3, i32 0, i32 0
  %5 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  ret %"struct.minou::Atom"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt13move_iteratorIPN5minou4AtomEEC2ES2_(%"class.std::move_iterator"*, %"struct.minou::Atom"*) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.std::move_iterator"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  store %"class.std::move_iterator"* %0, %"class.std::move_iterator"** %3, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %4, align 8
  %5 = load %"class.std::move_iterator"*, %"class.std::move_iterator"** %3, align 8
  %6 = getelementptr inbounds %"class.std::move_iterator", %"class.std::move_iterator"* %5, i32 0, i32 0
  %7 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  store %"struct.minou::Atom"* %7, %"struct.minou::Atom"** %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorIN5minou4AtomEE7destroyIS2_EEvPT_(%"class.__gnu_cxx::new_allocator.237"*, %"struct.minou::Atom"*) #2 comdat align 2 {
  %3 = alloca %"class.__gnu_cxx::new_allocator.237"*, align 8
  %4 = alloca %"struct.minou::Atom"*, align 8
  store %"class.__gnu_cxx::new_allocator.237"* %0, %"class.__gnu_cxx::new_allocator.237"** %3, align 8
  store %"struct.minou::Atom"* %1, %"struct.minou::Atom"** %4, align 8
  %5 = load %"class.__gnu_cxx::new_allocator.237"*, %"class.__gnu_cxx::new_allocator.237"** %3, align 8
  %6 = load %"struct.minou::Atom"*, %"struct.minou::Atom"** %4, align 8
  ret void
}

attributes #0 = { noinline optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline noreturn nounwind }
attributes #7 = { noreturn nounwind }
attributes #8 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nobuiltin "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nobuiltin nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #11 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #12 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #13 = { noinline noreturn optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #14 = { noreturn }
attributes #15 = { nounwind readonly }
attributes #16 = { builtin nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
