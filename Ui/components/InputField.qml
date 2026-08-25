import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: 300
    height: 40
    radius: 10
    color: "#40444E"
    border.color: "#404349"
    border.width: 1
    Layout.alignment: Qt.AlignHCenter
    TextArea{
        id:passwordtext
        placeholderText: "Password"
        placeholderTextColor: "#888888"
        color: "#f2f2f2"
        font.pixelSize: 16
        anchors.fill: parent
        background: null
        anchors.margins: 7

    }
}
