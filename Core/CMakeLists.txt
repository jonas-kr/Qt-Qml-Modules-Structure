qt_add_qml_module(Core
    URI Core
    VERSION 1.0

    SOURCES
    Auth.cpp
    Auth.hpp
)

target_link_libraries(Core
    PRIVATE
    Qt6::Qml
    Qt6::Network
)
