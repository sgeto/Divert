
message(WARNING "FIX ME!")
message(FATAL_ERROR "MSVC_VERSION: ${MSVC_VERSION}")

# include(FindWDK.cmake)

find_package(WDK REQUIRED)
find_package(WindowsSDK)
find_package(WinHID)

message(WARNING "WDK_FOUND: ${WDK_FOUND} WDK_INCLUDE_DIRS: ${WDK_INCLUDE_DIRS} WDK_LIBRARIES: ${WDK_LIBRARIES} WDK_BIN: ${WDK_BIN}")

message(WARNING "WINDOWSSDK_FOUND: ${WINDOWSSDK_FOUND} WINDOWSSDK_LATEST_DIR: ${WINDOWSSDK_LATEST_DIR} WINDOWSSDK_LATEST_NAME: ${WINDOWSSDK_LATEST_NAME} WINDOWSSDK_FOUND_PREFERENCE: ${WINDOWSSDK_FOUND_PREFERENCE} WINDOWSSDK_DIRS: ${WINDOWSSDK_DIRS}")

message(WARNING "WINHID_INCLUDE_DIR: ${WINHID_INCLUDE_DIR} WINHID_CRT_INCLUDE_DIR: ${WINHID_CRT_INCLUDE_DIR} WINHID_LIBRARY: ${WINHID_LIBRARY} WINHID_FOUND: ${WINHID_FOUND}")

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

