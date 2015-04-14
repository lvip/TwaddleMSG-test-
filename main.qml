import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import Enginio 1.0

ApplicationWindow {
    visible: true
    width: 360
    height: 360
    property real scaleFactor: Screen.pixelDensity / 5.0
    property int intScaleFactor: Math.max(1, scaleFactor)
    Header {
        id: header
        text: "twaddleMSG"
        //rightMargin: icon.width
    }

    Image {
        id: image1
        fillMode: Image.Tile
        source: "qrc:/te.jpg"
        z: -1
        anchors.fill: parent
        rotation: 45
        Behavior on rotation {NumberAnimation{ easing.type: Easing.Linear;duration: 1000}}
        Behavior on opacity  {NumberAnimation{ easing.type: Easing.Linear;duration: 300}}
        //Behavior on OpacityAnimator{NumberAnimation{ easing.type: Easing.InQuad;duration: 1000}}
        MouseArea
            {
                id: addMouseArea
                clip: false
                transformOrigin: Item.Center
                anchors.fill: parent
                hoverEnabled: true
                onEntered: image1.opacity = 0.5
                onExited: image1.opacity  = 1

                onClicked:
                {
                    image1.rotation=(image1.rotation == 360) ? 45:image1.rotation+45
                }
            }

    }
    Rectangle
   {
       id: exit
       anchors.bottom: parent.bottom
       color: "#aaf4f4"
       width: 100
       height: 50
       Text {
           id: todoText
           text: "Выход"
           font.family: "Gill Sans Ultra Bold"
           font.pixelSize: 26
           color: "#333"

           anchors.fill: parent
           elide: Text.ElideRight
       }
       MouseArea
       {
           anchors.fill: parent
           onClicked: Qt.quit();
       }
   }

}