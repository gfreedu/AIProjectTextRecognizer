import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Effects

Rectangle{
    id:yea
    property real ofseter:0
    property real aglet:0
    property bool hovern:false
    width:50
    height:50
    color:mainColor
    
    border.width:2
    border.color:secondaryColor

    transform:Translate{
        y:ofseter
    }

    Behavior on ofseter{
        NumberAnimation{
            duration:120
        }
    }

    AnimatedImage{
        id:teto
        anchors.centerIn:parent
        source:hovern?Qt.resolvedUrl("animationAssets/moving.gif"):Qt.resolvedUrl("animationAssets/stiller.gif")
        visible:false
    }

    MultiEffect{
        anchors.fill:teto
        source:teto
        colorizationColor:secondaryColor
        colorization:1
    }

    MouseArea{
        hoverEnabled:true
        anchors.fill:parent
        onEntered: {
            parent.ofseter=-5
            hovern=true
        }
        onExited: {
            parent.ofseter=0
            hovern=false
        }
        onClicked: {
            backend.saveFile()
        }
    }
}