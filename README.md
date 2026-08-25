# Qt Modules Structure

This project demonstrates a modular Qt 6/QML application structure. Each feature area is kept in its own directory and exposed as a CMake target.

## Directory Structure

```text
Structure/
├── CMakeLists.txt        # Main application and module configuration
├── main.cpp              # Application entry point
├── Core/                 # Reusable C++ business logic
│   ├── CMakeLists.txt
│   ├── LoginAuth.hpp
│   └── LoginAuth.cpp
├── Controller/           # Application-facing controllers
│   ├── CMakeLists.txt
│   ├── appController.hpp
│   └── appController.cpp
└── Ui/                   # QML presentation layer
    ├── CMakeLists.txt
    ├── Main.qml
    ├── components/
    ├── Pages/
    ├── fonts/
    ├── images/
    └── assets.qrc
```

## Module Responsibilities

### Core

`Core` contains reusable C++ classes such as authentication, networking, storage, and data models. It should not depend on the UI.

### Controller

`Controller` connects the UI to Core functionality. Controllers expose operations to QML using `Q_INVOKABLE`, properties, and signals.

The Controller module includes headers from Core through CMake:

```cmake
target_include_directories(Controller PRIVATE
    ${CMAKE_SOURCE_DIR}/Core
)
```

### Ui

`Ui` contains QML files, reusable components, pages, and static resources. It is registered as the QML module with URI `UI`.

The application loads the root QML component in `main.cpp`:

```cpp
engine.loadFromModule("UI", "Main");
```

## CMake Module Pattern

Each module has its own `CMakeLists.txt` and is added from the root configuration:

```cmake
add_subdirectory(Core)
add_subdirectory(Ui)
add_subdirectory(Controller)
```

A C++ module can be defined as follows:

```cmake
qt_add_library(MyModule STATIC)

qt_add_qml_module(MyModule
    URI MyModule
    VERSION 1.0
    SOURCES
        MyClass.cpp
        MyClass.hpp
)

target_link_libraries(MyModule PRIVATE
    Qt6::Qml
)
```

A QML-only module can be defined as follows:

```cmake
qt_add_qml_module(MyUiModule
    URI MyUiModule
    VERSION 1.0
    QML_FILES
        Main.qml
        components/Button.qml
)
```

The application target must link the modules it uses:

```cmake
target_link_libraries(app PRIVATE
    Core
    Ui
    Controller
)
```

## Adding a New C++ Class

1. Add the header and source file to the appropriate module directory.
2. Add both files to that module's `SOURCES` list.
3. Add required include directories with `target_include_directories`.
4. Link dependencies with `target_link_libraries`.
5. Use `Q_OBJECT` for Qt meta-object features.
6. Use `Q_INVOKABLE`, `Q_PROPERTY`, and signals when exposing functionality to QML.

Example:

```cmake
qt_add_qml_module(Core
    URI Core
    VERSION 1.0
    SOURCES
        LoginAuth.cpp
        LoginAuth.hpp
        UserProfile.cpp
        UserProfile.hpp
)
```

## Adding a QML Page or Component

Add the file to the `QML_FILES` list in `Ui/CMakeLists.txt`:

```cmake
qt_add_qml_module(Ui
    URI UI
    VERSION 1.0
    QML_FILES
        Main.qml
        Pages/Login.qml
        Pages/Settings.qml
        components/InputField.qml
)
```

Keep reusable controls in `components/` and application screens in `Pages/`.

## Build

Open the project in Qt Creator and select a Qt 6 kit with a working CMake and compiler. Then configure and build the project.

From a configured terminal, the equivalent commands are:

```powershell
cmake -S . -B build
cmake --build build --parallel
```

The executable is generated inside the selected build directory.

## Dependency Direction

Keep dependencies flowing in one direction:

```text
Ui -> Controller -> Core
```

Core should remain independent of Controller and Ui. This keeps the business logic reusable and makes the project easier to test and extend.
