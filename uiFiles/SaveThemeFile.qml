import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle{
    property alias kaiuki:teto
    width:80
    height:70
    color:"transparent"

    Rectangle{
        id:yea
        width:parent.width
        height:parent.height
        property real ofseter:0

        color:mainColor
        border.width:2
        border.color:secondaryColor

        Behavior on y{
            NumberAnimation{
                duration:120
            }
        }
        Text{
            id:teto
            anchors.centerIn:parent
            text:"Hi!"
            font.pixelSize:36
            font.family:fonfam
            color:secondaryColor
        }
    }

    ParallelAnimation {
        id: rotateAnim

        ColorAnimation {
            target: yea
            property: "color"
            to: secondaryColor
            duration:200
        }
        ColorAnimation {
            target: teto
            property: "color"
            to: mainColor
            duration:200
        }
    }
    ParallelAnimation {
        id: rotateAnimEnd

        ColorAnimation {
            target: yea
            property: "color"
            to: mainColor
            duration:200
        }
        ColorAnimation {
            target: teto
            property: "color"
            to: secondaryColor
            duration:200
        }
    }

    MouseArea{
        hoverEnabled:true
        anchors.fill:parent
        onEntered: {
            yea.y=-2
            rotateAnim.start()
        }
        onExited: {
            yea.y=0
            rotateAnimEnd.start()
        }
        onClicked: {
            diadia.open()
        }
        
    }

    FileDialog{
        id:diadia
        title:"Select File"
        nameFilters: ["Text files (*.txt)"]
        fileMode:FileDialog.SaveFile
        onAccepted:{
            path = selectedFile.toString().replace(/^(file:\/{3})/,"")
            backend.saveTheme(path,mainColor,secondaryColor,gifLocation,videoLocation,opacityValue,videoOpacity,coloringEnabled,showEffects)
        }
        onRejected:{
            path = ""
        }
    }
}