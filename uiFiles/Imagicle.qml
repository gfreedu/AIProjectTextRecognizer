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

    Flickable{
        anchors.fill:parent
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.HorizontalAndVerticalFlick 
        clip:true

        contentWidth: neru.width
        contentHeight: neru.height

        Image{
            fillMode:Image.PreserveAspectFit
            source:"file:///C:/Users/cream/Documents/AiProjectClass12/image.png"
            id:neru
            width: sourceSize.width
            height: sourceSize.height
            cache:false
            asynchronous:false
        }
        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
        }

        ScrollBar.horizontal: ScrollBar {
            policy: ScrollBar.AsNeeded
        }
    }

    Text{
        id:teto
        anchors.centerIn:parent
        text:"Waiting!"
        font.pixelSize:12
        font.family:fonfam
        color:secondaryColor
    }
}