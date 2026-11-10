import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import QtMultimedia

Recticle{
    property string path:""
    width:80
    height:70
    transitionDurations:120

    FileDialog{
        id:diadia
        title:"Select Image!!!"
        onAccepted:{
            path = selectedFile.toString().replace(/^(file:\/{3})/,"")
            fileLocation=path
            backend.setImageLocation(path)
            busy = true
        }
    }

    clicks.onClicked:{
        diadia.open()
    }
}