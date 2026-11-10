import QtQuick.Dialogs
import QtQuick
import QtQuick.Controls
import QtMultimedia

Recticle{
    transitionDurations:120
    clicks.onClicked:{
        backend.getTextButtonPressed(kaiuki.text)
    }
}