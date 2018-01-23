# INCLUDE_DIRECTORIES(".")

# add_definitions(-DHAVE_CONFIG_H)

# include_directories(
  # ${CMAKE_CURRENT_BINARY_DIR}
  # ${WinDivert_SOURCE_DIR}/include
# )

# ADD_LIBRARY(divert OBJECT "windivert.c" "windivert_helper.c")
# XXX - should we say ${CMAKE_PROJECT_NAME} from cmakecache.txt instead? read docs!
ADD_LIBRARY(${PROJECT_NAME} SHARED "windivert.c")
# ADD_LIBRARY(windivert SHARED "windivert.c" "${WinDivert_SOURCE_DIR}/sys/windivert.rc")

if(ENABLE_STATIC_LIB)
ADD_LIBRARY(lib${PROJECT_NAME} STATIC "windivert.c")
endif()

if (MINGW)
# MinGW (, gcc, libtool & co.) has a well established naming convention for libraries and DLLs.
# cmake honors/follows that.
# Windivert doesn't follow this convention so we need to tell cmake to build the shared library 
# without the "lib" prefix on MinGW for compatibility with older/other windivert builds.
  set_target_properties(${project} PROPERTIES 
                        PREFIX ""
                        OUTPUT_NAME "windivert"
  )
  # set_target_properties(${LIBRARY_NAME}_static PROPERTIES
                        # OUTPUT_NAME "${LIBRARY_NAME}"
# )
endif()

# https://stackoverflow.com/questions/41205725/how-to-disable-specific-warning-inherited-from-parent-in-visual-studio
# Anyway, if your projects are generated with CMake, add_compile_options can be used to add options to the compilation of source files in the current directory. This can be used to enable the warning 4101 at "global scope":

# add_compile_options(/w4101)
# You can then use target_compile_definitions to disable it per-target:

# add_library(foo ...)
# target_compile_definitions(foo PUBLIC /wd4101)
# EDIT:

# From your comments, in the head CMake file of the repo there is:

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /w44101")
# And in your project CMake file you attempt to do:

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4101")
# What you should do is removing the /w44101 from CMAKE_CXX_FLAGS. You can achieve this using string(REPLACE ...) to replace /w44101 with an empty string:

# string(REPLACE "/w44101" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
