#
# Check: a unit test framework for C
#
# Copyright (C) 2011 Mateusz Loskot
# Copyright (C) 2001, 2002 Arien Malec
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.
#

if(MSVC)
  file(GLOB PROJECT_SOURCE_LIST_WIN32_C ${pcap_SOURCE_DIR}/missing/getopt.c)
  include_directories(${pcap_SOURCE_DIR}/missing)
endif(MSVC)

add_custom_target(tests)

macro(add_example_executable _executable)
  add_executable(${_executable} EXCLUDE_FROM_ALL
    ${_executable}.c ${PROJECT_SOURCE_LIST_WIN32_C})
  set_target_properties(${_executable} PROPERTIES
    COMPILE_OPTIONS "${C_ADDITIONAL_FLAGS}")
  if(ENABLE_STATIC_LIB)
    target_link_libraries(${_executable}
      ${ARGN} ${LIBRARY_NAME} ${PCAP_LINK_LIBRARIES})
  else()
    target_link_libraries(${_executable}
      ${ARGN} ${LIBRARY_NAME}_static ${PCAP_LINK_LIBRARIES})
  endif()
  add_dependencies(tests ${_executable})
endmacro()

add_example_executable(netdump)
add_example_executable(netfilter)
add_example_executable(passthru)
add_example_executable(findalldevstest)
add_example_executable(streamdump)
add_example_executable(webfilter)
