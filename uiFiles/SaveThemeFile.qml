import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import QtMultimedia

Recticle{
    property string path
    clicks.onClicked:{
        diadia.open()
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