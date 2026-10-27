import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Rectangle{
    color:mainColor
    anchors.centerIn:parent

    border.width:2
    border.color:secondaryColor

    ColumnLayout{
        anchors.fill:parent
        RowLayout{
            Layout.alignment:Qt.AlignCenter
            height:parent.height/2
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Color:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            TextField{
                id:colorValue
                Layout.alignment:Qt.AlignLeft
                text:secondaryColor
                width:parent.width/2
                font:fonfam
                color:secondaryColor
                background:Rectangle{
                    color:"transparent"
                    border.width:2
                    border.color:secondaryColor
                }
            }
        }
        RowLayout{
            Layout.alignment:Qt.AlignCenter
            height:parent.height/2
            Text{
                Layout.alignment:Qt.AlignRight
                text:"fontSize:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            Slider{
                id:pixelValue
                Layout.alignment:Qt.AlignLeft
                width:parent.width/2
                from:1
                value:20
                to:50
                background:CustomSlider{}
                handle:CustomSliderHandle{}
                ToolTip {
                    visible: pixelValue.pressed
                    parent: pixelValue
                    text: pixelValue.value.toFixed(1)
                }
            }
        }
    }
    Recticle{
        anchors.horizontalCenter:parent.horizontalCenter
        y:110
        width:120
        height:40
        kaiuki.font.pixelSize:10
        kaiuki.text:"Save and close"
        clicks.onClicked:{
            backend.setTextStyle(pixelValue.value,colorValue.text)
            parent.visible = false
        }
    }
}