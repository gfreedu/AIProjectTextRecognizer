import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Rectangle{
    color:mainColor
    width:300
    height:300
    border.width:2
    border.color:secondaryColor
    anchors.centerIn:parent
    visible:busy
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
}