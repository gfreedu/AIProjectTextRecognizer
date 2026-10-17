import QtQuick
import QtQuick.Controls

Rectangle {
    x: parent.leftPadding + (parent.horizontal ? parent.visualPosition * (parent.availableWidth - width) : (parent.availableWidth - width) / 2)
    y: parent.topPadding + (parent.vertical ? parent.visualPosition * (parent.availableHeight - height) : (parent.availableHeight - height) / 2)

    implicitWidth: 15
    implicitHeight: 15

    border.width: parent.pressed ? width/2 : 1
    border.color: secondaryColor

    Behavior on border.width { SmoothedAnimation {} }
}
