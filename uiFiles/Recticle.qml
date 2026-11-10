import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle{
    property real ofseter:0
    property real aglet:0
    property alias kaiuki:teto
    property alias clicks:clicker
    property real transitionDurations:120
    property bool hovered
    width:80
    height:70
    color:"transparent"

    Rectangle{
        id:yea

        anchors.fill:parent
        color: hovered ? secondaryColor : mainColor
        border.width:2
        border.color:secondaryColor

        Text{
            id:teto
            anchors.centerIn:parent
            text:"Hi!"
            font.pixelSize:36
            font.family:fonfam
            color:hovered ? mainColor : secondaryColor
            Behavior on color{
                ColorAnimation{
                    duration:transitionDurations+80
                }
            }
        }

        transform:Translate{
            id:movementTranslate
            Behavior on y{
                NumberAnimation{
                    duration:transitionDurations
                }
            }
        }

        Behavior on color{
            ColorAnimation{
                duration:transitionDurations+80
            }
        }
    }

    MouseArea{
        id:clicker
        hoverEnabled:true
        anchors.fill:parent
        onEntered: {
            movementTranslate.y=-5
            hovered = true
        }
        onExited: {
            movementTranslate.y=0
            hovered = false
        }
    }
}