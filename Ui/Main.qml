import QtQuick
import QtQuick.Controls

ApplicationWindow {
    FontLoader {
        id: myFont
        source: "qrc:/fonts/Montserrat.ttf"
    }
    width: 1280
    height: 720
    visible: true
    //visibility: Window.FullScreen
    title: qsTr("LUNARA")
    font.family: myFont.name
    palette.text: "#f2f2f2"

    Text {
        id: header
        text: qsTr("Hello Worlds")
        color: "#fff"
    }

}
