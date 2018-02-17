# XXX - Support for Universal Windows projects are provided from cmake version 3.4.0 onwards.
# https://docs.travis-ci.com/user/languages/cpp/
# Ubuntu 12.04 ships with cmake 2.8.7 and Ubuntu 14.04 ships with cmake 3.2.2.
# You can upgrade cmake to 3.2.3 on Precise from the george-edison55-precise-backports source (note that the cmake-data package contains dependencies which Aptitude does not automatically resolve), c.f.
# So if we're *not* building Universal or if we're cross-compiling (not building
# the driver), the minimum version can/should be lowered)
# The minimum required cmake version really only matters when cross compiling
# as some operating system/distros only provided very old cmake builds by
# default.

# if(not cross-compiling blblabla
cmake_minimum_required(VERSION 3.4)

project(WinDivert C)

# GENERAL STUFF
# =============

# Check if we're targeting (any flavor of) Windows
if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Windows" AND
NOT ${CMAKE_SYSTEM_NAME} MATCHES "WindowsCE" AND
NOT ${CMAKE_SYSTEM_NAME} MATCHES "WindowsPhone" AND
NOT ${CMAKE_SYSTEM_NAME} MATCHES "WindowsStore")
  message(FATAL_ERROR "OS \"${CMAKE_SYSTEM_NAME}\" is not supported. \
${CMAKE_PROJECT_NAME} is a Windows-only project.")
endif()

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules")
set(CMAKE_SCRIPT_PATH "${CMAKE_SOURCE_DIR}/cmake/Scripts")

# Enforce out-of-source build
# ---------------------------
#
# For now, those who wish to build with cmake, must do so in a folder other than
# WinDivert's root directory. This can be for example a new folder within (or outside)
# WinDivert's root directory (usually called "build"), and is mostly meant to avoid 
# mixing binaries produces by other means (mingw-build.sh, msvc-build.bat etc).
# See README (within this package) or cmake's docs for more infos.
include(MacroEnsureOutOfSourceBuild)
macro_ensure_out_of_source_build("${CMAKE_PROJECT_NAME} requires an out-of-source build. Please create a separate build directory and run 'cmake /path/to/${CMAKE_PROJECT_NAME} [options]' there.")

# VERSIONING
# ==========

# Get, WinDivert's version string from [windivert_root]/VERSION
file(STRINGS ${CMAKE_SOURCE_DIR}/VERSION
    PACKAGE_VERSION
    LIMIT_COUNT 1 # Read only the first line
)
set(VERSION ${PACKAGE_VERSION})

# XXX - alternatively get version via git describe
# set(VERSION "v1.3.0-28-gaf5cd69")

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

option(ENABLE_TESTS "Build (and run) Tests" ON)
option(ENABLE_EXAMPLES "Build example applications" ON)
option(ENABLE_STATIC_LIB "Build static library (libwindivert)" ON)
if(MSVC)
  option(ENABLE_DRIVER "Build kernel module" ON)
endif()

if(MSVC)
  option(ENABLE_STATIC_RT "Build with static Runtime" OFF)
elseif(MINGW)
  option(ENABLE_STATIC_RT "Build with static Runtime" ON)
endif()

# debug related options
# XXX - ENABLE_DEBUG implies cmake_build type=debug and/or RelWithDebInfo
option(ENABLE_DEBUG "Enable various debugging features" OFF)
if(ENABLE_DEBUG)
    option(ENABLE_WSOCKTRACE "Link with WSOCK-TRACE instead of winsock2" OFF)
endif()

# XXX - off for now
option(ENABLE_SUMMARY "PRint a summary at the end of configuration step" OFF)




# options useful for package maintainers
# XXX - use cpack instead?
# XXX - forcefully overwrite install_prefix when this is on
# XXX - forcefully set ENABLE_EXAMPLES, ENABLE_STATIC_LIB and ENABLE_DRIVER to "ON"
option(ENABLE_RELEASE "Build a WinDivert binary package" OFF)

# BUILD PARAMETERS
# ================

# XXX - add arm here too?
# XXX - make "CPU" amd64 x86 arm and arm64 instead for ${ENABLE_RELEASE} installation!
if(CMAKE_SIZEOF_VOID_P EQUAL 4)
  set(CPU i386)
  set(BITS 32)
  # ADD_DEFINITIONS(-D_X86_=1)
  # ADD_DEFINITIONS(-Di386=1)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(CPU x86_64)
  set(BITS 64)
  # ADD_DEFINITIONS(-D_WIN64)
  # ADD_DEFINITIONS(-D_AMD64_)
  # ADD_DEFINITIONS(-DAMD64)
else()
  set(CPU unknown)
  set(BITS unknown)
endif()

include_directories(${CMAKE_SOURCE_DIR}/include)

if(NOT ENABLE_STATIC_LIB)
# Build all runtimes in the top-level binary directory; that way,
# on Windows, the executables will be in the same directory as
# the DLLs, so the system will find pcap.dll when any of the
# executables are run.
#
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/run)
endif()

if(ENABLE_STATIC_RT)
  message(STATUS "Using STATIC runtime")
  if(MSVC)
    foreach(RT_FLAG
      CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
      CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO)
      string(REGEX REPLACE "/MD" "/MT" ${RT_FLAG} "${${RT_FLAG}}")
    endforeach()
  elseif(MINGW)
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -static-libgcc")
  endif()
else()
  message(STATUS "Using DYNAMIC runtime")
endif()

# set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--output-def -Wl,${PROJECT_NAME}.def -Wl,--warn-common -Wl,--no-as-needed -Wl,--nxcompat -Wl,--dynamicbase" CACHE STRING "" FORCE)
# set(CMAKE_SHARED_LINKER_FLAGS "/machine:${MSVC_C_ARCHITECTURE_ID} /nologo /NXCOMPAT /DYNAMICBASE /DELAYLOAD:wpcap.dll /ERRORREPORT:NONE" CACHE STRING "" FORCE)

# set general build flags for debug build-type
# if(NOT MSVC)
# set(CMAKE_C_FLAGS_DEBUG "-O0 -ggdb3 -DDEBUG -Wall -Wno-pointer-sign -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security -Wextra -Wredundant-decls" CACHE STRING "" FORCE)
# append ASAN build flags if compiler version has support
# if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU" AND NOT OS_MINGW)
   # if (CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.8)
      # set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fsanitize=address -fno-omit-frame-pointer" CACHE STRING "" FORCE)
      # message("Building with ASAN support (GNU compiler)")
   # else (CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.8)
      # message("Building without ASAN support (GNU compiler)")
   # endif (CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.8)
# elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang" AND NOT OS_MINGW)
   # if (CMAKE_C_COMPILER_VERSION VERSION_GREATER 3.1)
      # set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fsanitize=address -fno-omit-frame-pointer" CACHE STRING "" FORCE)
      # message("Building with ASAN support (Clang compiler)")
   # elseif (CMAKE_C_COMPILER_VERSION VERSION_GREATER 3.1)
      # message("Building without ASAN support (Clang compiler)")
   # endif (CMAKE_C_COMPILER_VERSION VERSION_GREATER 3.1)
# endif ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
# else(NOT MSVC)
# set(CMAKE_C_FLAGS_DEBUG "/MDd /Ob0 /Od /DDEBUG /D_DEBUG /RTC1 /ZI /Gm- /D_FORTIFY_SOURCE=2" CACHE STRING "" FORCE)
# endif(NOT MSVC)

# set build flags for release build-type
# if(NOT MSVC)
# set(CMAKE_C_FLAGS_RELEASE "-O2 -w -D_FORTIFY_SOURCE=2" CACHE STRING "" FORCE)
# else(NOT MSVC)
# set(CMAKE_C_FLAGS_RELEASE "/MD /O2 /Zi /Ob2 /DNDEBUG /D_FORTIFY_SOURCE=2" CACHE STRING "" FORCE)
# endif(NOT MSVC)

add_definitions(-DWINDIVERT_DEBUG)
# include(FindWSOCKTRACE)

set(WINSOCK2 ws2_32)

# ADD SUBDIRECTORIES
# ==================

add_subdirectory(dll)

if(ENABLE_DRIVER)
  add_subdirectory(sys)
endif()

if(ENABLE_EXAMPLES)
  add_subdirectory(examples)
endif()

if(ENABLE_TESTS)
  # required for unit testing using CMake's ctest command
  include(CTest)
  enable_testing()
  add_subdirectory(test)
endif()

# INSTALLATION
# ============

# XXX- install just like in the prebuild folder layout
# XXX see release-build.sh:
# if we're building a release rename cmake_install_prefix to: NAME=WinDivert-$VERSION

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
      # install(FILES $<TARGET_FILE_DIR:libwindivert>/libwindivert.pdb
              # DESTINATION bin/amd64 OPTIONAL)
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
      # install(FILES $<TARGET_FILE_DIR:libwindivert>/libwindivert.pdb
              # DESTINATION bin OPTIONAL)
    endif()
endif()

install(FILES ${CMAKE_SOURCE_DIR}/include/windivert.h DESTINATION include)

if(ENABLE_RELEASE)
# XXX - make this work... foreach-style!
# don't forget WinDivert.html in doc folder!
  set(MISCFILES CHANGELOG LICENSE README VERSION)
  install(FILES ${CMAKE_SOURCE_DIR}/include/windivert.h DESTINATION include)
endif()

# UNINSTALLATION
# ==============
# XXX - "IMMEDIATE" is not in cmake's docs... check if important
configure_file(
  "${CMAKE_SCRIPT_PATH}/cmake_uninstall.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
  IMMEDIATE @ONLY)

add_custom_target(uninstall
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

# MISCELLANEOUS
# =============

# If we notice that this isn't the first time they've run 
# XXX - Only call this or the summary. never both
# if(NOT ("${CMAKE_CACHEFILE_DIR}" STREQUAL ""))
  # message("")
  # message("HAVING TROUBLE BUILDING ${CMAKE_PROJECT_NAME}? ")
  # message("")
  # message("  1. Install any missing dependencies")
  # message("  2. run 'make clean-all'")
  # message("  3. run 'cmake ${CMAKE_SOURCE_DIR}'")
  # message("")
# endif()

# Add a target that will ensure that the build directory is properly cleaned.
add_custom_target(clean-all
  COMMAND ${CMAKE_BUILD_TOOL} clean
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_SCRIPT_PATH}/clean-all.cmake)

# XXX - Add a nice build summary at the end
if(ENABLE_SUMMARY)
include(WinDivertSummary)
endif()
include(FeatureSummary)
IF(CMAKE_VERSION VERSION_GREATER 3)
	FEATURE_SUMMARY(WHAT ENABLED_FEATURES DISABLED_FEATURES)
ENDIF()
feature_summary(WHAT ALL)
