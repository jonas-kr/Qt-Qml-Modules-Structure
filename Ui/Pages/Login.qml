import QtQuick
import QtQuick.Layouts

import "../components"

Item {
    Rectangle {
        id: background
        anchors.fill: parent
        color: "#121717"
    }
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15
        Rectangle {
            id: logo
            width: 60
            height: 60
            radius: 10
            color: "#262B38"
            border.color: "#40444E"
            border.width: 1
            Layout.alignment: Qt.AlignHCenter
            Rectangle {
                width: 20
                height: 20
                radius: 5
                color: "#f2f2f2"
                anchors.centerIn: parent
            }
        }

        Text {
            id: lunara
            text: qsTr("LUNARA")
            color: "#f2f2f2"
            font.pixelSize: 40
            font.letterSpacing: 8
            font.family: myFont.name
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: title2
            text: qsTr("Professional Video Player")
            color: "#f2f2f2"
            font.pixelSize: 15
            opacity: 0.5
            font.weight: Font.Light
            font.family: myFont.name
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -16
            Layout.bottomMargin: 15

        }

        Rectangle {
            id: loginForm
            width: 350
            height: 320
            color:"#262B38"
            radius: 10
            border.color: "#40444E"
            border.width: 1
            Layout.alignment: Qt.AlignHCenter

            Form{
             //   onLoginSuccessful();
            }

        }
    }
}
