
# include_directories(. ../include ${LIBCHECK_INCLUDE_DIRS})

# include_directories(
  # ${CMAKE_CURRENT_BINARY_DIR}
  # ${CMAKE_SOURCE_DIR}/include
# )

# The target (make target) to run the test app directly with make/nmake/msbuild etc...
add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} -V)
# add_custom_target(test_verbose COMMAND ${CMAKE_CTEST_COMMAND} --extra-verbose --build-run-dir ${CMAKE_BINARY_DIR}/src/)


# Add test app
# ------------
#
# NOTE: We're going through all this hassle because "The target name "test" is
# reserved or not valid for certain CMake features, such as generator expressions,
# and may result in undefined behavior."
# In other words: We can't name the test executable "just" test.exe
# macro(_t NAME)
  add_executable(test_all test.c)
  if(ENABLE_STATIC_LIB)
  # XXX- add this globally
    add_definitions(-DWINDIVERTSTATIC -DWINDIVERTSTATIC)
    target_link_libraries(test_all lib${CMAKE_PROJECT_NAME})
    set_target_properties(test_all PROPERTIES COMPILE_DEFINITIONS "WINDIVERTEXPORT=")
  else()
      target_link_libraries(test_all ${CMAKE_PROJECT_NAME})
  endif()
  add_test(test_all ${CMAKE_CURRENT_BINARY_DIR}/test_all)
# endmacro()

# _t(ec_decode)

