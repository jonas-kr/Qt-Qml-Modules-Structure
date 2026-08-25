import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import LUNARA 1.0

Item {
    property string email: ""
    property string password: ""

   // signal loginSuccessful

    Connections {
        target: app
        onLoginSuccessful : console.log("Login Successful")
    }

    anchors.fill: parent
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15
        Text {
            id: welcom
            text: qsTr("Welcom Back")
            color: "#f2f2f2"
            font.pixelSize: 20
            font.weight: Font.DemiBold
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: desc
            text: qsTr("Sign in to access your video library")
            color: "#f2f2f2"
            font.pixelSize: 12
            opacity: 0.5
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -5
            Layout.bottomMargin: 10
        }

        Rectangle {
            id: emailArea
            width: 300
            height: 40
            radius: 10
            color: "#40444E"
            border.color: "#404349"
            border.width: 1
            Layout.alignment: Qt.AlignHCenter
            TextField {
                id: emailtext
                placeholderText: "Email"
                placeholderTextColor: "#888888"
                color: "#f2f2f2"
                font.pixelSize: 15
                anchors.fill: parent
                background: null
                anchors.margins: 8
                onTextChanged: email = text
            }
        }

        Rectangle {
            id: passwordArea
            width: 300
            height: 40
            radius: 10
            color: "#40444E"
            border.color: "#404349"
            border.width: 1
            Layout.alignment: Qt.AlignHCenter
            TextField {
                id: passwordtext
                placeholderText: "Password"
                placeholderTextColor: "#888888"
                color: "#f2f2f2"
                font.pixelSize: 15
                anchors.fill: parent
                background: null
                anchors.margins: 8
                echoMode: TextInput.Password
                onTextChanged: password = text
            }
        }

        RowLayout {
            CheckBox {
                id: rememberMe

                text: "Remember me"
                checked: false

                contentItem: Text {
                    text: parent.text
                    color: "#f2f2f2"
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: -5
                    leftPadding: rememberMe.indicator.width + rememberMe.spacing + 2
                }
            }
            Item {
                Layout.fillWidth: parent
            }

            Text {
                id: forgetPassword
                text: qsTr("Forget password?")
                color: "#f2f2f2"
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: loginBtn
            width: 300
            height: 45
            radius: 10
            color: "red"
            Layout.alignment: Qt.AlignHCenter
            Text {
                text: qsTr("Sign In")
                anchors.centerIn: parent
                color: "#f2f2f2"
                font.pixelSize: 14
                font.weight: Font.Normal
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    console.log("Button clicked")
                    //console.log(email + password)
                    App.login(email, password)
                    // pageLoader.replace(upload)
                }
            }
        }
    }
}
