qt_add_qml_module(Controller
    URI Controller
    VERSION 1.0

    SOURCES appController.cpp appController.hpp

)

target_include_directories(Controller PRIVATE
    ${CMAKE_SOURCE_DIR}/Core
)

target_link_libraries(Controller PRIVATE
    Qt6::Qml
    Core
)
