import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0 as Controls
Rectangle {
    width: 400
    height: 600

    Rectangle {
        id: header
        anchors.top: parent.top
        width: parent.width
        height: 70 * scaleFactor
        color: "white"
        Rectangle {
            width: parent.width ; height: 1
            anchors.bottom: parent.bottom
            color: "#bbb"
        }
    }

    BorderImage {
        id: input

        width: parent.width
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        border.left: 5; border.top: 5
        border.right: 5; border.bottom: 5

        Rectangle {
            y: -1 ; height: 1
            width: parent.width
            color: "#bbb"
        }
        Rectangle {
            y: 0 ; height: 1
            width: parent.width
            color: "white"
        }
    }
    Column {
        anchors.centerIn: parent
        anchors.alignWhenCentered: true
        width: 360 * scaleFactor
        spacing: 14 * intScaleFactor

        TextField {
            id: nameInput
            onAccepted: passwordInput.forceActiveFocus()
            placeholderText: "Username"
            KeyNavigation.tab: passwordInput
        }

        TextField {
            id: passwordInput
            onAccepted: login()
            placeholderText: "Password"
            echoMode: TextInput.Password
            KeyNavigation.tab: loginButton
        }

        Row {
            // button
            spacing: 20 * scaleFactor
            width: 360 * scaleFactor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.alignWhenCentered: true
            TouchButton {
                id: loginButton
                text: "Login"
                baseColor: "#7a5"
                width: (parent.width - parent.spacing)/2
                onClicked: {
                    stackView2.opacity=0
                    stackView2.z=-3
                    stackView.visible=true
                    stackView.opacity=1
                }
                enabled: nameInput.text.length && passwordInput.text.length
                KeyNavigation.tab: registerButton
            }
            TouchButton {
                id: registerButton
                text: "Register"
                onClicked: registerAndLogin()
                width: (parent.width - parent.spacing)/2
                enabled:  nameInput.text.length && passwordInput.text.length
                KeyNavigation.tab: nameInput
            }
        }
    }

    Text {
        id: statusText
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 70 * scaleFactor
        font.pixelSize: 18 * scaleFactor
        color: "#444"
    }
}
