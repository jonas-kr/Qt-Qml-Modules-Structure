cmake_minimum_required(VERSION 3.16)

project(ModularStructure VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Qml)

qt_add_executable(app
    main.cpp
)

add_subdirectory(Core)
add_subdirectory(Ui)
add_subdirectory(Controller)

target_include_directories(app PRIVATE Core)

target_link_libraries(app PRIVATE
    Qt6::Quick
    Qt6::Qml
    Core
    Ui
    Controller
)
