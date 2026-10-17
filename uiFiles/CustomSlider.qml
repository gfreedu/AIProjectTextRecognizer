import QtQuick
import QtQuick.Controls

Rectangle {
    x: (parent.width  - parent) / 2
    y: (parent.height - height) / 2

    implicitWidth: parent.horizontal ? 150 : 5
    implicitHeight: parent.horizontal ? 5 : 150

    width: parent.horizontal ? parent.availableWidth : implicitWidth
    height: parent.horizontal ? implicitHeight : parent.availableHeight

    color: secondaryColor
}