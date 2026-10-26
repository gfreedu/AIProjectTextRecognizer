import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle{
    id:yea
    property alias miku:teto.text
    width:80
    height:70
    color:"transparent"
    
    border.width:0

    Text{
        id:teto
        anchors.centerIn:parent
        verticalAlignment:Text.AlignTop
        text:"Waiting!"
        font.pixelSize:12
        font.family:fonfam
        color:secondaryColor
        fontSizeMode:Text.Fit
    }
}