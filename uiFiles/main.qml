import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Effects

ApplicationWindow {
    id:window
    visible:true
    width:650
    height:650
    title: "gay"

    property string mainColor:"#000000"
    property string secondaryColor:"#ffffff"
    property string gifLocation:"C:/Users/cream/Documents/AiProjectClass12/uiFiles/animationAssets/hmm.gif"
    property string videoLocation:"C:/Users/cream/Documents/AiProjectClass12/uiFiles/animationAssets/yeayae.mp4"
    property string fileLocation:"Select file bro"
    property real gay:1
    property QtObject backend
    property string fonfam:"deko"
    property bool busy:false
    property var opacityValue:0.7
    property var videoOpacity:0.7
    property bool showEffects:true //Show background video and effects
    property bool coloringEnabled:false //Color video and gif to secondary color
    property real hPadding:120
    property real vPadding:50
    

    x: (screen.desktopAvailableWidth - width - hPadding)/2
    y: (screen.desktopAvailableHeight - height - vPadding)/2

    flags: Qt.FramelessWindowHint | Qt.Window

    color:"transparent"

    MouseArea{
        property int prevX: 0
        property int prevY: 0
        anchors.fill: parent
        onPressed: {prevX=mouse.x; prevY=mouse.y}
        onPositionChanged:{
            var deltaX = mouse.x - prevX;
            window.x += deltaX;
            prevX = mouse.x - deltaX;

            var deltaY = mouse.y - prevY
            window.y += deltaY;
            prevY = mouse.y - deltaY;
        }
    }

    Rectangle{
        id:backgroundRect
        width:parent.width-hPadding
        height:parent.height-vPadding
        anchors.bottom:parent.bottom
        anchors.right:parent.right
        color:secondaryColor
        opacity:opacityValue
    }

    Rectangle{
        width:parent.width-hPadding-4
        height:parent.height-vPadding-4
        anchors.centerIn:backgroundRect
        color:mainColor

        AnimatedImage{
            id:animatedGif
            anchors.fill:parent
            source: "file:///"+gifLocation
            visible:showEffects&&!coloringEnabled
        }
        MultiEffect{
            anchors.fill:parent
            source:animatedGif
            colorizationColor:secondaryColor
            colorization:1
            visible:showEffects&&coloringEnabled
        }

        Item{
            anchors.fill:parent
            clip:true
            Video{
                id:vid
                source: videoLocation
                height:parent.height
                anchors.centerIn:parent
                autoPlay:true
                opacity:videoOpacity
                loops:MediaPlayer.Infinite
                visible:showEffects
            }
        }

        ColumnLayout{
            anchors.fill:parent
            //anchors
            spacing:5

            Fileselector{
                opacity:opacityValue
                implicitWidth:parent.parent.width-50
                Layout.alignment:Qt.AlignCenter
                miku:"Pick Image"
            }
            Plaintext{
                opacity:opacityValue
                Layout.alignment:Qt.AlignCenter
                implicitWidth:parent.parent.width-50
                height:1
                miku:fileLocation
            }
            DetectText{
                opacity:opacityValue
                implicitWidth:parent.parent.width-50
                Layout.alignment:Qt.AlignCenter
                miku:"Detect text"
            }
            RowLayout{
                Layout.fillWidth:true
                Layout.alignment:Qt.AlignCenter
                
                DetectedTextLabel{
                    id:final
                }
                Saveticle{
                    opacity:opacityValue
                    Layout.alignment:Qt.AlignRight
                }
            }

            Imagicle{
                id:finalImage
                implicitWidth:parent.parent.width-50
                opacity:opacityValue
                Layout.alignment:Qt.AlignCenter
                fills:Image.PreserveAspectFit
                height:390
                Recticle{
                    width:40
                    height:width
                    kaiuki.text:"edit"
                    kaiuki.font.pixelSize:10
                    anchors.left:parent.left
                    anchors.top:parent.top
                    opacity:opacityValue
                    clicks.onClicked:{
                        values.visible = true
                    }
                }
            }
        }
        LoadingWindow{}
        FontColorAndSlider{
            id:values
            height:100
            width:300
            visible:false
        }
        CustomizationWindow{
            id:customize
            height:300
            width:300
            visible:false
        }
        ModelWindow{
            id:modelWindow
            visible:false
            width:250
            height:200
        }
        ErrorWindow{
            id:errorWindow
        }
        Connections{
            target:backend

            function onBusySignal(state){
                busy=state
            }
            function onSetText(textString){
                final.foundText = textString
                finalImage.miku = ""
                finalImage.luka = ""
                finalImage.luka = Qt.resolvedUrl("displayFile.png")
            }
            function onErrorSignal(errorMessage){
                errorWindow.visible = true
                errorWindow.errorText = errorMessage
            }
        }
    }

    ColumnLayout{
        width:hPadding
        height:vPadding*3
        anchors.left:parent.left
        y:parent.y+vPadding
        spacing:2
        Recticle{
            width:hPadding-10
            height:vPadding-10
            kaiuki.text:customize.visible?"Click 2 close":"Change Theme"
            kaiuki.font.pixelSize:10
            Layout.alignment:Qt.AlignTop | Qt.AlignHCenter
            clicks.onClicked:{
                customize.visible = !customize.visible
            }
        }
        SaveThemeFile{
            width:hPadding-10
            height:vPadding-10
            kaiuki.text:"Save theme"
            kaiuki.font.pixelSize:10
            Layout.alignment:Qt.AlignTop | Qt.AlignHCenter
        }
        OpenThemeFile{
            width:hPadding-10
            height:vPadding-10
            kaiuki.text:"Open theme"
            kaiuki.font.pixelSize:10
            Layout.alignment:Qt.AlignTop | Qt.AlignHCenter
        }
    }

    RowLayout{
        width:vPadding*2
        height:vPadding
        anchors.top:parent.top
        anchors.right:parent.right
        spacing:2
        Layout.fillHeight:false

        Recticle{
            width:vPadding-10
            height:width
            kaiuki.text:"-"
            kaiuki.font.pixelSize:10
            Layout.alignment:Qt.AlignCenter
            clicks.onClicked:{
                window.showMinimized()
            }
        }

        Recticle{
            width:vPadding-10
            height:width
            kaiuki.text:"X"
            kaiuki.font.pixelSize:10
            Layout.alignment:Qt.AlignCenter
            clicks.onClicked:{
                window.close()
            }
        }
    }
    Recticle{
        width:hPadding-10
        height:vPadding-10
        kaiuki.font.pixelSize:10
        anchors.bottom:parent.bottom
        x:parent.x+5
        kaiuki.text:modelWindow.visible?"Click 2 close":"Change Model"
        clicks.onClicked:{
            modelWindow.visible = !modelWindow.visible
        }
    }
}