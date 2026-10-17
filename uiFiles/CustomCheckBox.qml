import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Effects

Rectangle{
    id:yea
    property real ofseter:0
    property real aglet:0
    property bool actuallyChecked:false

    width:30
    height:width
    color:mainColor

    transform:Translate{
        y:ofseter
    }

    Behavior on ofseter{
        NumberAnimation{
            duration:100
        }
    }

    Image{
        id:teto
        anchors.fill:parent
        source: Qt.resolvedUrl("animationAssets/checkBoxImage/background.png")
        fillMode:Image.PreserveAspectFit
        visible:false
    }
    Image{
        id:miku
        anchors.fill:parent
        source: Qt.resolvedUrl("animationAssets/checkBoxImage/check.png")
        fillMode:Image.PreserveAspectFit
        visible:false
    }
    MultiEffect{
        anchors.fill:teto
        source:teto
        colorizationColor:secondaryColor
        colorization:1
    }
    MultiEffect{
        anchors.fill:miku
        source:miku
        colorizationColor:secondaryColor
        colorization:1
        visible:actuallyChecked
    }

    MouseArea{
        id:clicker
        hoverEnabled:true
        anchors.fill:parent
        onEntered: {
            parent.ofseter=-1
        }
        onExited: {
            parent.ofseter=0
        }
        onClicked:{
            actuallyChecked = !actuallyChecked
        }
    }
}