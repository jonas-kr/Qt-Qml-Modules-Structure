import QtQuick
import QtQuick.Controls

ApplicationWindow {
    FontLoader {
        id: myFont
        source: "qrc:ui/Montserrat.ttf"
    }
    width: 1920
    height: 1080
    visible: true
    //visibility: Window.FullScreen
    title: qsTr("LUNARA")
    font.family: myFont.name
    palette.text: "#f2f2f2"


}
