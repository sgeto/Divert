message(STATUS "MSVC_VERSION: ${MSVC_VERSION}")

find_package(WDKold REQUIRED)
# find_package(WDKold)
find_package(WindowsSDK)
find_package(WinHID)
find_package(WinDDK REQUIRED)

message(WARNING "WDKold_FOUND: ${WDKold_FOUND} WDK_INCLUDE_DIRS: ${WDK_INCLUDE_DIRS} WDK_LIBRARIES: ${WDK_LIBRARIES} WDK_BIN: ${WDK_BIN}")

message(WARNING "WINDOWSSDK_FOUND: ${WINDOWSSDK_FOUND} WINDOWSSDK_LATEST_DIR: ${WINDOWSSDK_LATEST_DIR} WINDOWSSDK_LATEST_NAME: ${WINDOWSSDK_LATEST_NAME} WINDOWSSDK_FOUND_PREFERENCE: ${WINDOWSSDK_FOUND_PREFERENCE} WINDOWSSDK_DIRS: ${WINDOWSSDK_DIRS}")

message(WARNING "WINHID_INCLUDE_DIR: ${WINHID_INCLUDE_DIR} WINHID_CRT_INCLUDE_DIR: ${WINHID_CRT_INCLUDE_DIR} WINHID_LIBRARY: ${WINHID_LIBRARY} WINHID_FOUND: ${WINHID_FOUND}")
# _______________________________

# Files/Directories
# =================

# XXX - change BITS to ARCH!
SET(WD_INF_SOURCES
    ${CMAKE_SOURCE_DIR}/inf/WinDivert${BITS}.inf
)

SET(WD_RC_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/windivert.rc
)

SET(WD_SYS_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/windivert.c
    ${WD_RC_SOURCES}
)

# Variables
# =========

# Windows 7 and Windows Server 2008 R2 support NDIS 6.20.
# Windows CE (ARM) supports NDIS 5.1
ADD_DEFINITIONS(-DNDIS620)

set(WDK_WINVER "0x0601")  # Windows 7 (This is the default)
# set(WDK_WINVER "0x0A00")  # Windows 10

# Target
# ======
# XXX - fix REQUIRED in find module
find_package(WDK REQUIRED)
wdk_add_driver(${CMAKE_PROJECT_NAME}${BITS}
    KMDF 1.15
    ${WD_SYS_SOURCES}
)

target_link_libraries(${CMAKE_PROJECT_NAME}${BITS} fwpkclnt ndis wdmsec uuid)
