
include_directories(. ../include ${LIBCHECK_INCLUDE_DIRS})

include_directories(
  ${CMAKE_CURRENT_BINARY_DIR}
  ${WinDivert_SOURCE_DIR}/include
)

# The command (make target) to run the test app directly with make/nmake/msbuild etc...
add_custom_target(test_verbose COMMAND ${CMAKE_CTEST_COMMAND} -V)
# add_custom_target(test_verbose COMMAND ${CMAKE_CTEST_COMMAND} --extra-verbose --build-run-dir ${CMAKE_BINARY_DIR}/src/)


# Adds a test by name
# NOTE: We're going through all this hassle because "The target name "test" is reserved or not valid
# for certain CMake features, such as generator expressions, and may result in undefined behavior."
# In other words: We can't name the test executable "just" test.exe
# macro(_t NAME)
  add_executable(test_all test.c)
  if(ENABLE_STATIC_LIB)
  # XXX- add this globally
    add_definitions(-DWINDIVERTSTATIC -DWINDIVERTSTATIC)
    target_link_libraries(test_all lib${PROJECT_NAME})
    set_target_properties(test_all PROPERTIES COMPILE_FLAGS -DWINDIVERTSTATIC)
  else()
      target_link_libraries(test_all ${PROJECT_NAME})
  endif()
  add_test(test_all ${CMAKE_CURRENT_BINARY_DIR}/test_all)
# endmacro()

# _t(ec_decode)

