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
        RowLayout{                          //Main color assignment
            Layout.alignment:Qt.AlignCenter
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Main color:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            TextField{
                id:mainColorValue
                Layout.alignment:Qt.AlignLeft
                text:mainColor
                width:parent.width/2
                background:Rectangle{
                    color:"transparent"
                    border.width:2
                    border.color:secondaryColor
                }
                color:secondaryColor
                placeholderTextColor:Qt.lighter(secondaryColor)
                font.family:fonfam
                selectionColor:Qt.darker(secondaryColor)
            }
        }
        RowLayout{                          //Secondary color
            Layout.alignment:Qt.AlignCenter
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Secondary color:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            TextField{
                id:secondaryColorValue
                Layout.alignment:Qt.AlignLeft
                text:secondaryColor
                width:parent.width/2
                background:Rectangle{
                    color:"transparent"
                    border.width:2
                    border.color:secondaryColor
                }
                color:secondaryColor
                placeholderTextColor:Qt.lighter(secondaryColor)
                font.family:fonfam
                selectionColor:Qt.darker(secondaryColor)
            }
        }
        RowLayout{                          //Opacity values
            Layout.alignment:Qt.AlignCenter
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Opacity:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            Slider{
                id:opacitySlider
                Layout.alignment:Qt.AlignLeft
                width:parent.width/2
                from:0
                value:opacityValue
                to:1
                background:CustomSlider{}
                handle:CustomSliderHandle{}
                ToolTip {
                    visible: opacitySlider.pressed
                    parent: opacitySlider
                    text: opacitySlider.value.toFixed(1)
                }
            }
        }
        RowLayout{                          //Video opacity value
            Layout.alignment:Qt.AlignCenter
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Video opacity:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            Slider{
                id:backgroundOpacitySlider
                Layout.alignment:Qt.AlignLeft
                width:parent.width/2
                from:0
                value:opacityValue
                to:1
                background:CustomSlider{}
                handle:CustomSliderHandle{}
                ToolTip {
                    visible: backgroundOpacitySlider.pressed
                    parent: backgroundOpacitySlider
                    text: backgroundOpacitySlider.value.toFixed(1)
                }
            }
        }
        RowLayout{                          //Show background video
            Layout.alignment:Qt.AlignCenter
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Show background:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            CustomCheckBox{
                id:showEffectCheckBox
                actuallyChecked:showEffects
                Layout.alignment:Qt.AlignLeft
            }
        }

        RowLayout{                          //Color the video
            Layout.alignment:Qt.AlignCenter
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Colour videos:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            CustomCheckBox{
                id:colorVidsCheckBox
                actuallyChecked:coloringEnabled
                Layout.alignment:Qt.AlignLeft
            }
        }

        RowLayout{                          //Select background video and gif
            Layout.alignment:Qt.AlignCenter
            FileSelect{
                id:videoButton
                Layout.alignment:Qt.AlignRight
                kaiuki.text:"Open video"
                width:100
                height:20
            }
            FileSelect{
                id:gifButton
                Layout.alignment:Qt.AlignLeft
                width:100
                height:20
                kaiuki.text:"Open gif"
            }
        }
    }
    Recticle{
        anchors.horizontalCenter:parent.horizontalCenter
        y:parent.height+10
        width:120
        height:40
        kaiuki.font.pixelSize:10
        miku:"Save and close"
        clicks.onClicked:{
            mainColor = mainColorValue.text
            secondaryColor = secondaryColorValue.text
            opacityValue = opacitySlider.value
            videoOpacity = backgroundOpacitySlider.value
            parent.visible = false
            showEffects = showEffectCheckBox.actuallyChecked
            coloringEnabled = colorVidsCheckBox.actuallyChecked
            videoLocation = videoButton.path == "" ? videoLocation : videoButton.path
            gifLocation = gifButton.path == "" ? gifLocation : gifButton.path
            backend.setTextStyle(20,secondaryColor)
        }
    }
}