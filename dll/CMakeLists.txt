INCLUDE_DIRECTORIES(".")
# ADD_LIBRARY(regex OBJECT "regex.c" "regex.h")
ADD_LIBRARY(regex STATIC "regex.c" "regex.h")
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
