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
  src/minou.hpp
  src/minou.cpp
  src/parser.cpp
  src/parser.hpp
  src/eval.cpp
  src/eval.hpp
  )

add_executable(minou ${main} ${files})

target_compile_features(minou PRIVATE cxx_std_17)
target_link_libraries(minou readline)

# # Add test cpp file
add_executable( minou-tests t/test_main.cpp ${files})
# # Link test executable against gtest & gtest_main
target_compile_features(minou-tests PRIVATE cxx_std_17)
target_link_libraries(minou-tests gtest gtest_main)
include_directories("src/")
