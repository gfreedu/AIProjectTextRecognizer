import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Effects

Rectangle{
    width:300
    height:300
    anchors.centerIn:parent
    color:mainColor
    border.width:2
    border.color:secondaryColor

    Image{
        id:sourceImage
        source:Qt.resolvedUrl("animationAssets/error.png")
        anchors.fill:parent
        visible:false
    }
    MultiEffect{
        width:150
        height:width
        anchors.centerIn:parent
        source:sourceImage
        colorizationColor:secondaryColor
        colorization:1
        visible:true
        opacity:0.5
    }
    ScrollView{
        id:scrolls
        anchors.fill:parent
        TextArea{
            id:final
            anchors.fill:parent
            placeholderText:"prepare thyself"
            background:Rectangle{
                color:"transparent"
            }
            color:secondaryColor
            placeholderTextColor:Qt.lighter(secondaryColor)
            font.family:fonfam
            selectionColor:Qt.darker(secondaryColor)
        }
        
        background : Rectangle{
            color:"transparent"
        }
    }

    Recticle{
        anchors.horizontalCenter:parent.horizontalCenter
        y:parent.height+10
        width:120
        height:40
        kaiuki.font.pixelSize:10
        miku:"Close"
        clicks.onClicked:{
            parent.visible = false
        }
    }
}