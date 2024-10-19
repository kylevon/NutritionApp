cmake_minimum_required(VERSION 3.16)

project(chrononutrition VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Core)

qt_standard_project_setup(REQUIRES 6.5)

# Set the QTP0004 policy to NEW using qt_policy
if(QT_KNOWN_POLICY_QTP0004)
    qt_policy(SET QTP0004 NEW)
endif()

qt_add_executable(appchrononutrition
    main.cpp
)

# Find all QML files in the views directory with relative paths
file(GLOB_RECURSE VIEW_QML_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "views/*.qml")
file(GLOB_RECURSE COMPONENTS_QML_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "components/*.qml")

qt_add_qml_module(appchrononutrition
    URI chrononutrition
    VERSION 1.0
    QML_FILES
        Main.qml
        ${VIEW_QML_FILES}
        ${COMPONENTS_QML_FILES}
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appchrononutrition PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appchrononutrition
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appchrononutrition
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appchrononutrition
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
