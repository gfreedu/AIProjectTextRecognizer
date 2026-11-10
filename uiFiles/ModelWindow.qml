import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Rectangle{
    property alias miku:movementTranslate

    id:mainRect
    color:mainColor
    anchors.centerIn:parent
    opacity:0

    border.width:2
    border.color:secondaryColor

    width:250
    height:200
    visible:opacity===0?false:true

    ColumnLayout{
        anchors.fill:mainRect
        anchors.margins:8
        RowLayout{
            spacing: 1
            Layout.fillWidth:true
            Layout.preferredHeight:mainRect.height/3
            Text{
                Layout.alignment: Qt.AlignRight
                horizontalAlignment: TextInput.AlignHCenter
                text:"Model:"
                font.family:fonfam
                Layout.preferredWidth:mainRect.width/2
                color:secondaryColor
            }
            TextField{
                id:modelName
                text:"gemini-3.5-flash-lite"
                Layout.fillWidth:true
                font.family:fonfam
                background:Rectangle{
                    color:"transparent"
                    border.width:2
                    border.color:secondaryColor
                }
                color:secondaryColor
                placeholderTextColor:Qt.lighter(secondaryColor)
                selectionColor:Qt.darker(secondaryColor)
            }
        }

        RowLayout{
            Layout.fillWidth:true
            Layout.preferredHeight:mainRect.height/3
            spacing: 1
            Text{
                Layout.alignment: Qt.AlignRight
                horizontalAlignment: TextInput.AlignHCenter
                text:"Base url:"
                font.family:fonfam
                Layout.preferredWidth:mainRect.width/2
                color:secondaryColor
            }
            TextField{
                id:baseUrl
                text:"https://generativelanguage.googleapis.com/v1beta/openai/"
                Layout.fillWidth:true
                font.family:fonfam
                background:Rectangle{
                    color:"transparent"
                    border.width:2
                    border.color:secondaryColor
                }
                color:secondaryColor
                placeholderTextColor:Qt.lighter(secondaryColor)
                selectionColor:Qt.darker(secondaryColor)
            }
        }

        RowLayout{
            Layout.fillWidth:true
            Layout.preferredHeight:mainRect.height/3
            spacing: 1
            Text{
                Layout.alignment: Qt.AlignRight
                horizontalAlignment: TextInput.AlignHCenter
                text:"Api key:"
                font.family:fonfam
                Layout.preferredWidth:mainRect.width/2
                color:secondaryColor
            }
            TextField{
                id:apiKey
                text:"default(free api key)"
                Layout.fillWidth:true
                font.family:fonfam
                background:Rectangle{
                    color:"transparent"
                    border.width:2
                    border.color:secondaryColor
                }
                color:secondaryColor
                placeholderTextColor:Qt.lighter(secondaryColor)
                selectionColor:Qt.darker(secondaryColor)
            }
        }
    }
    transform:Translate{
        x:-30
        id:movementTranslate
        Behavior on x{
            NumberAnimation{
                duration:200
            }
        }
    }
    Behavior on opacity{
        NumberAnimation{
            duration:150
        }
    }
    Recticle{
        anchors.horizontalCenter:mainRect.horizontalCenter
        y:mainRect.height+10
        width:120
        height:40
        kaiuki.font.pixelSize:10
        kaiuki.text:"Save and close"
        clicks.onClicked:{
            backend.setModelValues(modelName.text,baseUrl.text,apiKey.text)
            parent.opacity = 0
            movementTranslate.x = -30
        }
    }
}