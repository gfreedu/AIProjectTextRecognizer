import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Effects

Rectangle{
    property alias errorText:final.text
    width:300
    height:300
    anchors.centerIn:parent
    color:mainColor
    border.width:2
    border.color:secondaryColor
    visible:false
    opacity:0

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
            text:"This shouldnt be visible right now..."
            background:Rectangle{
                color:"transparent"
            }
            wrapMode:TextArea.Wrap
            color:secondaryColor
            placeholderTextColor:Qt.lighter(secondaryColor)
            font.family:fonfam
            selectionColor:Qt.darker(secondaryColor)
        }
        
        background : Rectangle{
            color:"transparent"
        }
    }

    // Entering animations
    Behavior on opacity {
        NumberAnimation{
            duration:120
        }
    }

    onVisibleChanged:{
        if(visible){
            opacity = 1
            bounceTranslate.y = 30
            bounceAnimation.start()
        }else{
            opacity = 0
        }
    }

    transform: Translate{
        id:bounceTranslate
    }

    SpringAnimation{
        target:bounceTranslate
        id:bounceAnimation
        property:"y"
        to:0
        spring: 4
        damping: 0.2
    }

    // Exit animation
    NumberAnimation{
        target:bounceTranslate
        id:exitAnimation
        property:"y"
        to:30
        duration:120
        onFinished:{
            visible = false
        }
    }

    Recticle{
        anchors.horizontalCenter:parent.horizontalCenter
        y:parent.height+10
        width:120
        height:40
        kaiuki.font.pixelSize:10
        kaiuki.text:"Close"
        clicks.onClicked:{
            parent.opacity = 0
            exitAnimation.start()
        }
    }
}