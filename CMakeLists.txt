cmake_minimum_required(VERSION 3.1)

project(WinDivert C)

if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  message(FATAL_ERROR "${CMAKE_SYSTEM_NAME} not supported. ${PROJECT_NAME} is a Windows-only project.")
endif()

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules")
set(CMAKE_SCRIPT_PATH "${CMAKE_SOURCE_DIR}/cmake/Scripts")

include(MacroEnsureOutOfSourceBuild)
macro_ensure_out_of_source_build("${PROJECT_NAME} requires an out of source build. Please create a separate build directory and run 'cmake /path/to/${PROJECT_NAME} [options]' there.")

# XXX - get version
set(VERSION "v1.3.0-28-gaf5cd69")

#
# Try to enable as many C99 features as we can.
# At minimum, we want C++/C99-style // comments.
# (Sadly, this won't work with CMake prior to 3.1.)
#
set(CMAKE_C_STANDARD 99)

#
# Build all runtimes in the top-level binary directory; that way,
# on Windows, the executables will be in the same directory as
# the DLLs, so the system will find pcap.dll when any of the
# executables are run.
#
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/run)

#
# OPTIONS
# =======

option(ENABLE_TESTS "Enable Unit Tests" OFF)
option(ENABLE_EXAMPLES "Enable Unit Tests" OFF)
option(BUILD_STATIC_LIBS "Build shared libraries" ON)
option(BUILD_DEBUG "Build shared libraries" ON)
if (MSVC)
  option(ENABLE_DRIVER "Enable Unit Tests" ON)
endif()


add_subdirectory(dll)

if(ENABLE_DRIVER)
  add_subdirectory(sys)
endif()

if(ENABLE_EXAMPLES)
  add_subdirectory(examples)
endif()

if(ENABLE_TESTS)
  add_subdirectory(test)
endif()

#
# INSTALLATION
# ============
if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 8)
  #
  # Install 64-bit code built with MSVC in the amd64 subdirectories,
  # as that's where it expects it to be.
  #
  install(TARGETS ${LIBRARY_NAME} ${LIBRARY_NAME_STATIC}
          RUNTIME DESTINATION bin/amd64
          LIBRARY DESTINATION lib/amd64
          ARCHIVE DESTINATION lib/amd64)
    if(NOT MINGW)
      install(FILES $<TARGET_FILE_DIR:${LIBRARY_NAME_STATIC}>/${LIBRARY_NAME_STATIC}.pdb
              DESTINATION bin/amd64 OPTIONAL)
    endif()
else()
  #
  # Install 32-bit code, and 64-bit code not built with MSVC
  # in the top-level directories, as those are where they
  # expect it to be.
  #
  install(TARGETS ${LIBRARY_NAME} ${LIBRARY_NAME_STATIC}
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION lib
          ARCHIVE DESTINATION lib)
    if(NOT MINGW)
      install(FILES $<TARGET_FILE_DIR:${LIBRARY_NAME_STATIC}>/${LIBRARY_NAME_STATIC}.pdb
              DESTINATION bin OPTIONAL)
    endif()
endif()

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/include/windivert.h DESTINATION include)
