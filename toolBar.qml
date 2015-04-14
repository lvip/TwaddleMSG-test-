import QtQuick 2.2
import QtQuick.Controls 1.2

toolBar: BorderImage {
    border.bottom: 8
    source: "/icons/icons/back_icon.png"
    width: parent.width
    height: 100

    Rectangle {
        id: backButton
        width: opacity ? 60 : 0
        anchors.left: parent.left
        anchors.leftMargin: 20
        opacity: stackView.depth > 1 ? 1 : 0
        anchors.verticalCenter: parent.verticalCenter
        antialiasing: true
        height: 60
        radius: 4
        color: backmouse.pressed ? "#222" : "transparent"
        Behavior on opacity { NumberAnimation{} }
        Image {
            anchors.verticalCenter: parent.verticalCenter
            source: "/icons/icons/back_icon.png"
        }
        MouseArea {
            id: backmouse
            anchors.fill: parent
            anchors.margins: -10
            onClicked: stackView.pop()
        }
    }
