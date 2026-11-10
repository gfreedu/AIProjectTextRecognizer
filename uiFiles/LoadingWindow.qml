import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Rectangle{
    color:mainColor
    width:busy?300:250
    height:busy?300:250
    border.width:2
    border.color:secondaryColor
    anchors.centerIn:parent
    opacity:busy?1:0
    visible:opacity===0?false:true

    AnimatedImage{
        id:loadingGif
        anchors.fill:parent
        source:Qt.resolvedUrl("animationAssets/loading.gif")
        playing:busy
        visible:false
    }
    MultiEffect{
        source:loadingGif
        anchors.fill:loadingGif
        colorizationColor:secondaryColor
        colorization:1
    }
    AnimatedImage{
        anchors.fill:parent
        source:Qt.resolvedUrl("animationAssets/loadingOverlay.gif")
        playing:busy
    }
    Behavior on opacity{
        NumberAnimation{
            duration:200
        }
    }
    Behavior on height{
        SpringAnimation{
            spring: 4
            damping: 0.2
        }
    }
    Behavior on width{
        SpringAnimation{
            spring: 4
            damping: 0.2
        }
    }
}