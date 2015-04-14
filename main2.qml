
import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

ApplicationWindow {
    visible: true
    width: 800
    height: 1280
    property real scaleFactor: Screen.pixelDensity / 5.0
    property int intScaleFactor: Math.max(1, scaleFactor)
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }

    ToolBar
    {
        id: header
        //text: "twaddleMSG2"
        //rightMargin: icon.width

    }

    ListModel {
        id: pageModel
        ListElement {
            title: "mainpage"
            page: "/main.qml"
        }
        ListElement {
            title: "Настройки"
            page: "/ButtonPage.qml"
        }
        ListElement {
            title: "Список контактов"
            page: "content/ProgressBarPage.qml"
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }

        initialItem: Item {
            width: parent.width
            height: parent.height
            ListView {
                model: pageModel
                anchors.fill: parent
                delegate: AndroidDelegate {
                    text: title
                    onClicked: stackView.push(Qt.resolvedUrl(page))
                }
            }
        }
    }

}
