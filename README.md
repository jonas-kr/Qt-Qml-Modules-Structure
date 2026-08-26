# Qt QML Modules Structure

This project demonstrates a modular Qt 6/QML application structure. The application is split into separate CMake/QML modules for the UI, controllers, and reusable C++ logic.

## Directory Structure

```text
Qt-Qml-Modules-Structure/
├── CMakeLists.txt          # Main application and module configuration
├── main.cpp                # Application entry point
├── Core/                   # Reusable C++ logic
│   ├── CMakeLists.txt
│   ├── Auth.hpp
│   └── Auth.cpp
├── Controller/             # Application-facing C++ controllers
│   ├── CMakeLists.txt
│   ├── Controller.hpp
│   └── Controller.cpp
└── Ui/                     # QML presentation module
    ├── CMakeLists.txt
    ├── Main.qml
    ├── pages/
    │   └── Home.qml
    ├── components/
    │   └── Sidebar.qml
    ├── assets/
    │   └── images/
    │       └── fiverrlogo.png
    └── assets.qrc
```

## Module Responsibilities

### Core

`Core` contains reusable C++ classes such as authentication, networking, storage, and data models. It should not depend on the UI.

### Controller

`Controller` connects the UI to Core functionality. Controllers expose operations to QML using `Q_INVOKABLE`, properties, and signals. The module links against `Core` in `Controller/CMakeLists.txt`.

### Ui

`Ui` contains QML files, reusable components, pages, and static resources. It is registered as the QML module with URI `Ui`.

The application loads the root QML component in `main.cpp`:

```cpp
engine.loadFromModule("Ui", "Main");
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
        pages/Home.qml
        components/Sidebar.qml
)
```

The application target must link the modules it uses:

```cmake
target_link_libraries(app PRIVATE
    Controller
    Core
    Ui
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
        Auth.cpp
        Auth.hpp
)
```

## Adding a QML Page or Component

Add the file to the `QML_FILES` list in `Ui/CMakeLists.txt`:

```cmake
qt_add_qml_module(Ui
    URI Ui
    QML_FILES
        Main.qml
        pages/Home.qml
        components/Sidebar.qml
    RESOURCES
        assets.qrc
)
```

Keep reusable controls in `components/` and application screens in `pages/`. Static assets are stored under `assets/` and listed in `assets.qrc`.

## Build

Open the project in Qt Creator and select a Qt 6.10 or newer kit with a working CMake and compiler. Then configure and build the project.

From a configured terminal, the equivalent commands are:

```powershell
cmake -S . -B build
cmake --build build --parallel
```

The executable is generated inside the selected build directory. Build output should remain untracked; this repository ignores `build/` and `.qtcreator/`.

## Dependency Direction

Keep dependencies flowing in one direction:

```text
Ui -> Controller -> Core
```

Core should remain independent of Controller and Ui. This keeps the business logic reusable and makes the project easier to test and extend.
