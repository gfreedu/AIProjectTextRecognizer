import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import QtMultimedia

Recticle{
    property string path:""
    signal fileSelectedEvent()
    kaiuki.font.pixelSize:12

    clicks.onClicked:{
        diadia.open()
    }

    FileDialog{
        id:diadia
        title:"Select File"
        onAccepted:{
            path = selectedFile.toString().replace(/^(file:\/{3})/,"")
            fileSelectedEvent()
        }
        onRejected:{
            path = ""
        }
    }
}