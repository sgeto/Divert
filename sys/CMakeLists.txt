
message(WARNING "FIX ME!")
message(WARNING "MSVC_VERSION: ${MSVC_VERSION}")

enable_language(NONE)

# Set global directories

SET(WD_INC_DIR ${CMAKE_SOURCE_DIR}/include)
SET(WD_INF_DIR ${CMAKE_SOURCE_DIR}/inf)
SET(WD_SYS_DIR ${CMAKE_SOURCE_DIR}/sys)

# INCLUDE(genvsfilelist)
# INCLUDE(genvsfilters)

SET(WD_SYS_SOURCES
    ${WD_SYS_DIR}/windivert.c
    )

SET(WD_INF_SOURCES
    ${WD_INF_DIR}/WinDivert$(PlatformArchitecture).inf
    )

SET(WD_RC_SOURCES
    ${WD_SYS_DIR}/windivert.rc
    )

SET(TreatWarningAsError "false")
set(Inf2CatUseLocalTime "true")
set(PreprocessorDefinitions
  BINARY_COMPATIBLE=0
  NT
  UNICODE
  _UNICODE
  NDIS60
  NDIS_SUPPORT_NDIS60
  )
set(DbgPreprocessorDefinitions DEBUG_ON)

set(AdditionalDependencies
  $(DDK_LIB_PATH)\\wdmsec.lib
  $(DDK_LIB_PATH)\\ndis.lib
  $(DDK_LIB_PATH)\\fwpkclnt.lib
  $(SDK_LIB_PATH)\\uuid.lib
  )

# GEN_VS_FILTER_LIST("${WD_SYS_SOURCES}" "" PART_VS_FILTER_LIST)
# SET(VS_FILTER_LIST "${VS_FILTER_LIST} ${PART_VS_FILTER_LIST}")

# CONFIGURE_FILE(${CMAKE_SCRIPT_PATH}/sourceslist.in ${CMAKE_CURRENT_BINARY_DIR}/sources.targets @ONLY)
# CONFIGURE_FILE(${CMAKE_SCRIPT_PATH}/sourcefilters.in ${CMAKE_CURRENT_BINARY_DIR}/filters.targets @ONLY)

# include(FindWDK.cmake)

find_package(WDK REQUIRED)
find_package(WindowsSDK)
find_package(WinHID)

message(WARNING "WDK_FOUND: ${WDK_FOUND} WDK_INCLUDE_DIRS: ${WDK_INCLUDE_DIRS} WDK_LIBRARIES: ${WDK_LIBRARIES} WDK_BIN: ${WDK_BIN}")

message(WARNING "WINDOWSSDK_FOUND: ${WINDOWSSDK_FOUND} WINDOWSSDK_LATEST_DIR: ${WINDOWSSDK_LATEST_DIR} WINDOWSSDK_LATEST_NAME: ${WINDOWSSDK_LATEST_NAME} WINDOWSSDK_FOUND_PREFERENCE: ${WINDOWSSDK_FOUND_PREFERENCE} WINDOWSSDK_DIRS: ${WINDOWSSDK_DIRS}")

message(WARNING "WINHID_INCLUDE_DIR: ${WINHID_INCLUDE_DIR} WINHID_CRT_INCLUDE_DIR: ${WINHID_CRT_INCLUDE_DIR} WINHID_LIBRARY: ${WINHID_LIBRARY} WINHID_FOUND: ${WINHID_FOUND}")

if(NOT ${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
  file(COPY ${CMAKE_SOURCE_DIR}/inf DESTINATION ${CMAKE_BINARY_DIR})
  file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/windivert.c ${CMAKE_CURRENT_SOURCE_DIR}/windivert.rc DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
endif()

# WinDivert.vcxproj WinDivert.vcxproj.filters

configure_file("${CMAKE_SCRIPT_PATH}/${CMAKE_PROJECT_NAME}.universal.props.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_PROJECT_NAME}.universal.props"
  NEWLINE_STYLE WIN32 @ONLY)

configure_file("${CMAKE_SCRIPT_PATH}/${CMAKE_PROJECT_NAME}.vcxproj.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_PROJECT_NAME}.vcxproj"
  NEWLINE_STYLE WIN32 @ONLY)

configure_file("${CMAKE_SCRIPT_PATH}/${CMAKE_PROJECT_NAME}.vcxproj.filters.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_PROJECT_NAME}.vcxproj.filters"
  NEWLINE_STYLE WIN32 @ONLY)

add_custom_target(driver ALL
cmake --build ${CMAKE_CURRENT_BINARY_DIR} --target WinDivert
# COMMAND \"${CMAKE_COMMAND}\" \"-E\" \"remove\" \"${TARGET}\" [command1 [args1...]]

# COMMAND \"${CMAKE_COMMAND}\" \"-E\" \"remove\" \"${TARGET}\" [command1 [args1...]]
                  # [DEPENDS depend depend depend ... ]
                  # [BYPRODUCTS [files...]]
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Building kernel module ${CMAKE_PROJECT_NAME}${BITS}.sys"]
                  # [VERBATIM] [USES_TERMINAL]
                  # [COMMAND_EXPAND_LISTS]
                  # SOURCES windivert.c windivert.rc
                  )

# Variables:
#  WINDOWSSDK_FOUND - if any version of the windows or platform SDK was found that is usable with the current version of visual studio
#  WINDOWSSDK_LATEST_DIR
#  WINDOWSSDK_LATEST_NAME
#  WINDOWSSDK_FOUND_PREFERENCE - if we found an entry indicating a "preferred" SDK listed for this visual studio version
#  WINDOWSSDK_PREFERRED_DIR
#  WINDOWSSDK_PREFERRED_NAME
#
#  WINDOWSSDK_DIRS - contains no duplicates, ordered most recent first.
#  WINDOWSSDK_PREFERRED_FIRST_DIRS - contains no duplicates, ordered with preferred first, followed by the rest in descending recency


# Cache Variables: (probably not for direct use in your scripts)
#  WINHID_INCLUDE_DIR
#  WINHID_CRT_INCLUDE_DIR
#  WINHID_LIBRARY
#
# Non-cache variables you might use in your CMakeLists.txt:
#  WINHID_FOUND
#  WINHID_INCLUDE_DIRS
#  WINHID_LIBRARIES

# include_directories(. ../include ${LIBCHECK_INCLUDE_DIRS})
# target_link_libraries( blablablaadd_definitions(-DWINDIVERT_KERNEL) in windivert.h
# add_definitions(-DDEBUG_ON) exclusive to sys sys/windivert.c
# add_custom_target(test_verbose COMMAND ${CMAKE_CTEST_COMMAND} -V)

# Adds a test by name
# macro(_t NAME)
  # add_executable(test_${NAME} test_${NAME}.c)
  # target_link_libraries(test_${NAME} lib_ettercap ec_interfaces
  # ${LIBCHECK_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} ${LIBCHECK_LDFLAGS})
  # add_test(test_${NAME} ${CMAKE_CURRENT_BINARY_DIR}/test_${NAME})
# endmacro()

# _t(ec_decode)

