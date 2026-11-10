import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import QtMultimedia

Recticle{
    property string path:""

    clicks.onClicked:{
        diadia.open()
    }

    FileDialog{
        id:diadia
        title:"Select File"
        nameFilters: ["Text files (*.txt)"]
        onAccepted:{
            path = selectedFile.toString().replace(/^(file:\/{3})/,"")
            backend.openThemeFile(path)
        }
        onRejected:{
            path = ""
        }
    }
}