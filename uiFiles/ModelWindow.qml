import QtQuick
import QtQuick.Controls
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
                text:"Model:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            TextField{
                id:modelName
                Layout.alignment:Qt.AlignLeft
                text:"gemini-3.5-flash-lite"
                implicitWidth:parent.width/1.4
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
            Layout.alignment:Qt.AlignCenter
            height:parent.height/2
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Base url:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            TextField{
                id:baseUrl
                Layout.alignment:Qt.AlignLeft
                text:"https://generativelanguage.googleapis.com/v1beta/openai/"
                implicitWidth:parent.width/1.5
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
            Layout.alignment:Qt.AlignCenter
            height:parent.height/2
            Text{
                Layout.alignment:Qt.AlignRight
                text:"Api key:"
                font.family:fonfam
                width:parent.width/2
                color:secondaryColor
            }
            TextField{
                id:apiKey
                Layout.alignment:Qt.AlignLeft
                text:"default(free api key)"
                implicitWidth:parent.width/1.45
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
    Recticle{
        anchors.horizontalCenter:parent.horizontalCenter
        y:parent.height+10
        width:120
        height:40
        kaiuki.font.pixelSize:10
        miku:"Save and close"
        clicks.onClicked:{
            backend.setModelValues(modelName.text,baseUrl.text,apiKey.text)
            parent.visible=false
        }
    }
}