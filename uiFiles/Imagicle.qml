import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle{
    id:yea
    property real ofseter:0
    property real aglet:0
    property alias miku:teto.text
    property alias luka:neru.source
    property alias fills:neru.fillMode

    width:80
    height:70
    color:mainColor
    
    border.width:2
    border.color:secondaryColor

    Text{
        id:teto
        anchors.centerIn:parent
        text:"Waiting!"
        font.pixelSize:12
        font.family:fonfam
        color:secondaryColor
    }
    Image{
        id:neru
        width:parent.width-4
        height:parent.height-4
        anchors.centerIn:parent
        cache:false
        asynchronous:false
    }
}