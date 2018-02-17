  STRING(TOUPPER "${CMAKE_BUILD_TYPE}" buildtype)
  IF (CMAKE_C_FLAGS)
    SET(cfsp " ")
  ENDIF(CMAKE_C_FLAGS)
  MESSAGE(STATUS "")
  MESSAGE(STATUS "")
  MESSAGE(STATUS "${CMAKE_PROJECT_NAME} v${PACKAGE_VERSION} configuration summary:")
  MESSAGE(STATUS "")
  MESSAGE(STATUS "  Install prefix .................. : ${CMAKE_INSTALL_PREFIX}")
  MESSAGE(STATUS "  C compiler ...................... : ${CMAKE_C_COMPILER}")
# CMAKE_C_COMPILER_VERSION is not guaranteed to be defined for all compilers or languages.
  MESSAGE(STATUS "  C compiler Version............... : ${CMAKE_C_COMPILER_VERSION}")
  MESSAGE(STATUS "  C compiler flags ................ : ${CMAKE_C_FLAGS}${cfsp}${CMAKE_C_FLAGS_${buildtype}}")
  MESSAGE(STATUS "  Linker search directories ....... : ${LINK_DIRECTORIES}")
  IF(NOT ${CMAKE_BUILD_TYPE} STREQUAL "")
  MESSAGE(STATUS "  Cmake build type          ....... : ${CMAKE_BUILD_TYPE}")
  endif()
  MESSAGE(STATUS "")
  # MESSAGE(STATUS "  Build 8 bit PCRE library ........ : ${PCRE_BUILD_PCRE8}")
  # MESSAGE(STATUS "  Build 16 bit PCRE library ....... : ${PCRE_BUILD_PCRE16}")
  # MESSAGE(STATUS "  Build 32 bit PCRE library ....... : ${PCRE_BUILD_PCRE32}")
  # MESSAGE(STATUS "  Build C++ library ............... : ${PCRE_BUILD_PCRECPP}")
  # MESSAGE(STATUS "  Enable JIT compiling support .... : ${PCRE_SUPPORT_JIT}")
  # MESSAGE(STATUS "  Enable UTF support .............. : ${PCRE_SUPPORT_UTF}")
  # MESSAGE(STATUS "  Unicode properties .............. : ${PCRE_SUPPORT_UNICODE_PROPERTIES}")
  # MESSAGE(STATUS "  Newline char/sequence ........... : ${PCRE_NEWLINE}")
  # MESSAGE(STATUS "  \\R matches only ANYCRLF ......... : ${PCRE_SUPPORT_BSR_ANYCRLF}")
  # MESSAGE(STATUS "  EBCDIC coding ................... : ${PCRE_EBCDIC}")
  # MESSAGE(STATUS "  EBCDIC coding with NL=0x25 ...... : ${PCRE_EBCDIC_NL25}")
  # MESSAGE(STATUS "  Rebuild char tables ............. : ${PCRE_REBUILD_CHARTABLES}")
  # MESSAGE(STATUS "  No stack recursion .............. : ${PCRE_NO_RECURSE}")
  # MESSAGE(STATUS "  POSIX mem threshold ............. : ${PCRE_POSIX_MALLOC_THRESHOLD}")
  # MESSAGE(STATUS "  Internal link size .............. : ${PCRE_LINK_SIZE}")
  # MESSAGE(STATUS "  Parentheses nest limit .......... : ${PCRE_PARENS_NEST_LIMIT}")
  # MESSAGE(STATUS "  Match limit ..................... : ${PCRE_MATCH_LIMIT}")
  # MESSAGE(STATUS "  Match limit recursion ........... : ${PCRE_MATCH_LIMIT_RECURSION}")
  # MESSAGE(STATUS "  Build shared libs ............... : ${BUILD_SHARED_LIBS}")
  # MESSAGE(STATUS "  Build static libs ............... : ${BUILD_STATIC_LIBS}")
  # MESSAGE(STATUS "  Build pcregrep .................. : ${PCRE_BUILD_PCREGREP}")
  # MESSAGE(STATUS "  Enable JIT in pcregrep .......... : ${PCRE_SUPPORT_PCREGREP_JIT}")
  # MESSAGE(STATUS "  Buffer size for pcregrep ........ : ${PCREGREP_BUFSIZE}")
  # MESSAGE(STATUS "  Build tests (implies pcretest  .. : ${PCRE_BUILD_TESTS}")
  # MESSAGE(STATUS "               and pcregrep)")
  IF(ENABLE_TESTS)
    MESSAGE(STATUS "  Build (and run) Tests ......... : ${ENABLE_TESTS}")
  ENDIF()
  IF(ENABLE_EXAMPLES)
    MESSAGE(STATUS "  Build example applications ....... : ${ENABLE_EXAMPLES}")
  ENDIF()
  IF(ENABLE_STATIC_LIB)
    MESSAGE(STATUS "  Build static library (libwindivert) .. : ${ENABLE_STATIC_LIB}")
  ENDIF()
  IF(ENABLE_DRIVER)
    MESSAGE(STATUS "  Build kernel module .. : ${ENABLE_DRIVER}")
  ENDIF()
  MESSAGE(STATUS "  Build with static Runtime .................: ${ENABLE_STATIC_RT}")
  MESSAGE(STATUS "  Enable various debugging features .................: ${ENABLE_DEBUG}")

  MESSAGE(STATUS "")

# https://stackoverflow.com/questions/9298278/cmake-print-out-all-accessible-variables-in-a-script
# Using the get_cmake_property function the following loop will print out all CMake variables defined and their values:

# get_cmake_property(_variableNames VARIABLES)
# foreach (_variableName ${_variableNames})
    # message(STATUS "${_variableName}=${${_variableName}}")
# endforeach()

# https://cmake.org/Wiki/CMake_Useful_Variables
# https://cmake.org/Wiki/CMake_Useful_Variables/Logging_Useful_Variables

CMAKE_BINARY_DIR CMAKE_SOURCE_DIR 

CMAKE_GENERATOR 
the generator specified on the commandline.

CMAKE_C_COMPILER_ID 
one of "Clang", "GNU", "Intel", or "MSVC". This works even if a compiler wrapper like ccache is used.

CMAKE_INCLUDE_CURRENT_DIR 
automatically add CMAKE_CURRENT_SOURCE_DIR and CMAKE_CURRENT_BINARY_DIR to the include directories in every processed CMakeLists.txt. It behaves as if you had used INCLUDE_DIRECTORIES in every CMakeLists.txt file or your project. The added directory paths are relative to the being-processed CMakeLists.txt, which is different in each directory. (See this thread for more details).

CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE 
order the include directories so that directories which are in the source or build tree always come before directories outside the project.

BUILD_SHARED_LIBS 
if this is set to ON, then all libraries are built as shared libraries by default.
SET(BUILD_SHARED_LIBS ON)

CMAKE_BUILD_TYPE 
A variable which controls the type of build when using a single-configuration generator like the Makefile generator. It is case-insensitive.
CMake will create by default the following variables when using a single-configuration generator:

None (CMAKE_C_FLAGS or CMAKE_CXX_FLAGS used)
Debug (CMAKE_C_FLAGS_DEBUG or CMAKE_CXX_FLAGS_DEBUG)
Release (CMAKE_C_FLAGS_RELEASE or CMAKE_CXX_FLAGS_RELEASE)
RelWithDebInfo (CMAKE_C_FLAGS_RELWITHDEBINFO or CMAKE_CXX_FLAGS_RELWITHDEBINFO
MinSizeRel (CMAKE_C_FLAGS_MINSIZEREL or CMAKE_CXX_FLAGS_MINSIZEREL)
You can use these default compilation flags (or modify them) by setting the CMAKE_BUILD_TYPE variable at configuration time on the command line, or from within the "ccmake" GUI. Note! The default values for these flags change with different compilers. If CMake does not know your compiler, the contents will be empty.

If you are using the Makefile generator, you can create your own build type like this:
SET(CMAKE_BUILD_TYPE distribution)
SET(CMAKE_CXX_FLAGS_DISTRIBUTION "-O3")
SET(CMAKE_C_FLAGS_DISTRIBUTION "-O3")

Note that CMAKE_BUILD_TYPE is not initialized with a readable value at configuration time. This is because the user is free to select a build type at build time. Use CMAKE_CFG_INTDIR if you need a variable that evaluates to the correct build time directory.

CMAKE_CONFIGURATION_TYPES 
When using a multi-configuration generator, such as the one for Visual Studio, this variable contains a list of the available configurations.

CMAKE_CFG_INTDIR 
meta-variable! Please note that this is an important variable, since on multi-configuration generators it will be generated into dynamically switched content based on the configuration that the user currently selected within the generated build environment. Indicates the name of the current configuration (~ directory) for the project. May be used for any purpose which needs per-configuration-dynamic switching of strings, not just OutputDir configuration. For multi-configuration generators (e.g. MSVC) the resulting strings are typically some of "Debug", "Release", "RelWithDebInfo", or "MinSizeRel". For other compiler generators (single-configuration ones) it is typically ".", as they don't use MSVC-style configuration directories.

CMAKE_SHARED_LINKER_FLAGS 
additional compiler flags for building shared libraries, e.g.: 
set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--no-undefined")
On Unix systems, this will make linker report any unresolved symbols from object files (which is quite typical when you compile many targets in CMake projects, but do not bother with linking target dependencies in proper order). On mac, the flag is -Wl,-undefined-error.

CMAKE_EXECUTABLE_SUFFIX 
Suffix of executables on the target platform.
CMAKE_FIND_LIBRARY_PREFIXES 
List of possible library prefixes used by find_library(). "lib" on UNIX systems.
CMAKE_FIND_LIBRARY_SUFFIXES 
List of possible library suffixes used by find_library(). ".a;.so" on UNIX systems. Note that it's possible to use this to control whether find_package() modules find shared or static libraries.
CMAKE_<SHARED|STATIC>_LIBRARY_PREFIX 
Prefix for shared or static libraries on this platform. Read-only.
CMAKE_<SHARED|STATIC>_LIBRARY_SUFFIX 
Suffix for shared or static libraries on this platform. Read-only.
CMAKE_<config>_POSTFIX 
Adds a custom "postfix" to static and shared libraries when in a certain build type. Example: Setting CMAKE_BUILD_TYPE=DEBUG and CMAKE_DEBUG_POSTFIX="_d" would turn mylib.lib into mylib_d.lib.

# if the compiler is a variant of gcc, this should be set to 1 
MESSAGE( STATUS "CMAKE_COMPILER_IS_GNUCC: " ${CMAKE_COMPILER_IS_GNUCC} )

# if the compiler is a variant of g++, this should be set to 1 
MESSAGE( STATUS "CMAKE_COMPILER_IS_GNUCXX : " ${CMAKE_COMPILER_IS_GNUCXX} )

# the tools for creating libraries 
MESSAGE( STATUS "CMAKE_AR: " ${CMAKE_AR} )
MESSAGE( STATUS "CMAKE_RANLIB: " ${CMAKE_RANLIB} )