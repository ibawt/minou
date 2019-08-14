cmake_minimum_required(VERSION 3.0)
project(minou)

configure_file(CMakeLists.txt.in googletest-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "CMake step for googletest failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "Build step for googletest failed: ${result}")
endif()

# Prevent overriding the parent project's compiler/linker
# settings on Windows
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Add googletest directly to our build. This defines
# the gtest and gtest_main targets.
add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/googletest-src
                 ${CMAKE_CURRENT_BINARY_DIR}/googletest-build
                 EXCLUDE_FROM_ALL)

# The gtest/gtest_main targets carry header search path
# dependencies automatically when using CMake 2.8.11 or
# later. Otherwise we have to add them here ourselves.
if (CMAKE_VERSION VERSION_LESS 2.8.11)
  include_directories("${gtest_SOURCE_DIR}/include")
endif()

add_subdirectory(vendor/fmt)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

set (main src/main.cpp)

set(files
  src/base.hpp
  src/types.hpp
  src/env.hpp
  src/env.cpp
  src/memory.hpp
  src/memory.cpp
  src/engine.hpp
  src/engine.cpp
  src/slab.hpp
  src/slab.cpp
  src/minou.hpp
  src/minou.cpp
  src/parser.cpp
  src/parser.hpp
  src/eval.cpp
  src/eval.hpp
  src/symbol_intern.hpp
  src/symbol_interner.cpp
  src/bytecode.hpp
  src/vm.hpp
  src/vm.cpp
  src/compiler.hpp
  src/compiler.cpp
  )

add_executable(minou ${main} ${files})

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

llvm_map_components_to_libnames(llvm_libs support core irreader)

target_compile_features(minou PRIVATE cxx_std_17)
target_link_libraries(minou readline fmt ${llvm_libs})

# # Add test cpp file
add_executable( minou-tests t/test_main.cpp ${files})
# # Link test executable against gtest & gtest_main
target_compile_features(minou-tests PRIVATE cxx_std_17)
target_link_libraries(minou-tests gtest gtest_main fmt ${llvm_libs})
include_directories("src/" "vendor/fmt/include" ${LLVM_INCLUDE_DIRS})
