import QtQuick
import QtQuick.Controls.Basic

Imagicle{
    id:contorl
    property alias foundText:final.text
    implicitWidth:parent.parent.width-100
    miku:""
    border.width:1
    opacity:opacityValue

    ScrollView{
        id:scrolls
        anchors.fill:parent
        TextArea{
            id:final
            placeholderText:"prepare thyself"
            background:Rectangle{
                color:"transparent"
            }
            color:secondaryColor
            placeholderTextColor:Qt.lighter(secondaryColor)
            font.family:fonfam
            selectionColor:Qt.darker(secondaryColor)
        }
        
        background : Rectangle{
            color:"transparent"
        }
    }
}