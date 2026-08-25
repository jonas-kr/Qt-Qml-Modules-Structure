qt_add_qml_module(Ui
    URI UI
    VERSION 1.0

    QML_FILES
        Main.qml
        
    RESOURCE_PREFIX "/"
    QML_FILES components/Form.qml components/InputField.qml
    QML_FILES Pages/Login.qml Pages/Upload.qml
    RESOURCES assets.qrc
)