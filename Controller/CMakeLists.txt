qt_add_qml_module(Controller
    URI Controller
    VERSION 1.0

    SOURCES
    Controller.cpp
    Controller.hpp
)

target_link_libraries(Controller
    PRIVATE
    Qt6::Qml
    Qt6::Network
    Core
)
