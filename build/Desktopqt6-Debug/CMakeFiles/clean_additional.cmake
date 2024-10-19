# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appchrononutrition_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appchrononutrition_autogen.dir/ParseCache.txt"
  "appchrononutrition_autogen"
  )
endif()
