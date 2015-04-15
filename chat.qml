
import QtQuick 2.2
import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.1
import QtBluetooth 5.3

Item {
    id: top

    Component.onCompleted: state = "chatActive"

    property string remoteDeviceName: ""
    property bool serviceFound: false

    //! [BtDiscoveryModel-1]
    BluetoothDiscoveryModel {
        id: btModel
        running: true
        discoveryMode: BluetoothDiscoveryModel.MinimalServiceDiscovery
    //! [BtDiscoveryModel-1]
        onRunningChanged : {
            if (!btModel.running && top.state == "begin" && !serviceFound) {
                searchBox.animationRunning = false;
                searchBox.appendText("\nNo service found. \n\nPlease start server\nand restart app.")
            }
        }

        onErrorChanged: {
            if (error != BluetoothDiscoveryModel.NoError && !btModel.running) {
                searchBox.animationRunning = false
                searchBox.appendText("\n\nDiscovery failed.\nPlease ensure Bluetooth is available.")
            }
        }

    //! [BtDiscoveryModel-2]
        onServiceDiscovered: {
            if (serviceFound)
                return
            serviceFound = true
            console.log("Found new service " + service.deviceAddress + " " + service.deviceName + " " + service.serviceName);
            searchBox.appendText("\nConnecting to server...")
            remoteDeviceName = service.deviceName
            socket.setService(service)
        }
    //! [BtDiscoveryModel-2]
    //! [BtDiscoveryModel-3]
        uuidFilter: "e8e10f95-1a70-4b27-9ccf-02010264e9c8"
    }
    //! [BtDiscoveryModel-3]

    //! [BluetoothSocket-1]
    BluetoothSocket {
        id: socket
        connected: true

        onSocketStateChanged: {
            console.log("Connected to server")
            top.state = "chatActive"
        }
    //! [BluetoothSocket-1]
    //! [BluetoothSocket-3]
        onStringDataChanged: {
            console.log("Received data: " )
            var data = remoteDeviceName + ": " + socket.stringData;
            data = data.substring(0, data.indexOf('\n'))
            chatContent.append({content: data})
    //! [BluetoothSocket-3]
            console.log(data);
    //! [BluetoothSocket-4]
        }
    //! [BluetoothSocket-4]
    //! [BluetoothSocket-2]
    }
    //! [BluetoothSocket-2]

    ListModel {
        id: chatContent
        ListElement {
            content: "Connected to chat server"
        }
    }


    Rectangle {
        id: background
        z: 0
        anchors.fill: parent
        color: "#5d5b59"
    }

    Search {
        id: searchBox
        anchors.centerIn: top
        opacity: 1
    }


    Rectangle {
        id: chatBox
        opacity: 0
        anchors.centerIn: top

        color: "#5d5b59"
        border.color: "black"
        border.width: 1
        radius: 5
        anchors.fill: parent

        function sendMessage()
        {
            // toogle focus to force end of input method composer
            var hasFocus = input.focus;
            input.focus = false;

            var data = input.text.toUpperCase()
            input.clear()

            chatContent.append({content: "Me: " + data})
            //! [BluetoothSocket-5]
            socket.stringData = data
            //! [BluetoothSocket-5]
            chatView.positionViewAtEnd()

            input.focus = hasFocus;
        }

        Item {
            anchors.fill: parent
            anchors.margins: 10

            InputBox {
                id: input
                Keys.onReturnPressed: chatBox.sendMessage()
                height: sendButton.height
                width: parent.width - sendButton.width - 15
                anchors.left: parent.left

            }

            ButtonM {
                id: sendButton
                anchors.right: parent.right
                label: "Send"
                onButtonClick: chatBox.sendMessage()
            }
            ButtonM {
                id: clearA
                anchors.right: sendButton.left
                label: "Удалить всё"
                onButtonClick: chatContent.clear()
            }


            Rectangle {
                id: rectangle1
                height: parent.height - input.height - 15
                width: parent.width;
                color: "#d7d6d5"
                anchors.bottom: parent.bottom
                border.color: "black"
                border.width: 1
                radius: 5

                ListView {
                    id: chatView
                    width: parent.width-5
                    height: parent.height-5
                    anchors.centerIn: parent
                    model: chatContent
                    spacing: 10
                    clip: true
                    add: Transition { NumberAnimation { properties: "y"; from: parent.height; duration: 250 } }
                    removeDisplaced: Transition { NumberAnimation { properties: "y"; duration: 300 } }
                    remove: Transition { NumberAnimation { property: "opacity"; to: 0; duration: 300 } }
                    delegate: Rectangle {
                        //z:6
                        Menu { id: contextMenu
                            MenuItem {
                                text: qsTr('Копировать сообщение')
                                shortcut: "Ctrl+C"
                                //onTriggered: stackView.push(Qt.resolvedUrl("/chat/chat.qml"))
                            }
                            MenuItem {
                                text: qsTr('Удалить сообщение')
                                shortcut: "Ctrl+DEL"
                                onTriggered: chatContent.remove(index)
                            }
                            MenuItem {
                                text: qsTr('Информация о сообщении')
                                shortcut: "Ctrl+I"
                                //onTriggered: stackView.push(Qt.resolvedUrl("contact.qml"))
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                             onClicked:         if(mouse.button & Qt.RightButton) {
                                                    contextMenu.popup()
                                                    //stackView.push(Qt.resolvedUrl("contact.qml"))
                                                }
                                                else{}
                        }
                          width: parent.width
                          height: 40
                          radius: 10
                          color:"gray"
                          Text {
                              //z:7
                              anchors.fill: parent
                              horizontalAlignment: Text.AlignHCenter
                              verticalAlignment: Text.AlignVCenter
                              elide: Text.ElideRight
                              wrapMode: Text.Wrap
                              renderType: Text.NativeRendering
                              text: modelData
                          }
                      }
                }
            }
        }
    }

    states: [
        State {
            name: "begin"
            PropertyChanges { target: searchBox; opacity: 1 }
            PropertyChanges { target: chatBox; opacity: 0 }
        },
        State {
            name: "chatActive"
            PropertyChanges { target: searchBox; opacity: 0 }
            PropertyChanges { target: chatBox; opacity: 1 }

            PropertyChanges {
                target: rectangle1
                transformOrigin: Item.Center
            }
        }
    ]
}
