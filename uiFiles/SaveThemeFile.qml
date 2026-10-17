import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle{
    id:yea
    property real ofseter:0
    property real aglet:0
    property alias kaiuki:teto
    property string path:""
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

    Text{
        id:teto
        anchors.centerIn:parent
        text:"Hi!"
        font.pixelSize:10
        font.family:fonfam
        color:secondaryColor
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
            parent.ofseter=-2
            rotateAnim.start()
        }
        onExited: {
            parent.ofseter=0
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
            backend.saveTheme(path,mainColor,secondaryColor,gifLocation,videoLocation,opacityValue,videoOpacity,coloringEnabled)
        }
        onRejected:{
            path = ""
        }
    }
}