import sys
import os
from dotenv import load_dotenv
from modules.AiOCRHandler import Model,log_output
from PySide6.QtWidgets import QApplication
from PySide6.QtGui import QFontDatabase
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QTimer,QObject,Signal,Slot,QThreadPool,QRunnable
from PIL import ImageDraw,Image,ImageFont

load_dotenv()

#Google API keys and stuff, change only model
defaultKey = os.getenv("GEMINI_API_KEY")
defaultBaseUrl = "https://generativelanguage.googleapis.com/v1beta/openai/"
defaultModelName = "gemini-3.5-flash-lite"
verificationKey = os.getenv("VERIFICATION_KEY")

#Initialize actual app loop
app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load("uiFiles/main.qml")

#Fonts used by the app
QFontDatabase.addApplicationFont("uiFiles/fonts/deko.ttf")

#Default worker signal
class workerSignal(QObject):
    finished = Signal(bool)

#Load/Save themes
defaultThemValues = ['#000000',
              "#FFFFFF",
              "C:/Users/cream/Documents/AiProjectClass12/uiFiles/animationAssets/hmm.gif",
              "C:/Users/cream/Documents/AiProjectClass12/uiFiles/animationAssets/yeayae.mp4",
              "0.7"]

def setThemeValues(path:str):
    with open(path) as themes:
        themValues = themes.readlines()
        if themValues[7].strip() != verificationKey:
            print("Invalid file theme found.")
            themValues = defaultThemValues
    themes.close()

    engine.rootObjects()[0].setProperty("mainColor",themValues[0].strip())
    engine.rootObjects()[0].setProperty("secondaryColor",themValues[1].strip())
    engine.rootObjects()[0].setProperty("gifLocation",themValues[2].strip())
    engine.rootObjects()[0].setProperty("videoLocation",themValues[3].strip())
    engine.rootObjects()[0].setProperty("opacityValue",float(themValues[4].strip()))
    engine.rootObjects()[0].setProperty("videoOpacity",float(themValues[5].strip()))
    engine.rootObjects()[0].setProperty("coloringEnabled",bool(themValues[6].strip()))

def saveThemeValues(path:str,mainColor,secondaryColor,gifLocation,videoLocation,opacity,videoOpacity,coloringBool):
    with open(path,"w") as f:
        f.writelines(mainColor+"\n")
        f.writelines(secondaryColor+"\n")
        f.writelines(gifLocation+"\n")
        f.writelines(videoLocation+"\n")
        f.writelines(str(opacity)+"\n")
        f.writelines(str(videoOpacity)+"\n")
        f.writelines(str(coloringBool)+"\n")
        f.writelines(verificationKey+"\n")
    f.close()

#Multithreading ability from pyside6
class Worker(QRunnable):
    def __init__(self,func,*args,**kwargs):
        super().__init__()
        self.func = func
        self.args = args
        self.kwargs = kwargs
        self.signals = workerSignal()

    @Slot()
    def run(self):
        self.func(*self.args,**self.kwargs)
        self.signals.finished.emit(True)

#Actual backend class
class Backend(QObject):
    #Signals/Functions fired to communicate from python backend to frontend
    busySignal = Signal(bool, arguments=["state"])
    setText = Signal(str,arguments=["textString"])
    color = "#FFFFFF"
    font = ImageFont.truetype("uiFiles/fonts/deko.ttf",20)

    def __init__(self):
        super().__init__()
        self.poolroom = QThreadPool()
        self.model = Model(defaultKey,defaultBaseUrl,defaultModelName)  #Change model provider

    def starts(self):   #Unused
        self.model = Model()
        self.setLoading(False)

    def setLoading(self,busy:bool):     #Show loading screen
        self.busySignal.emit(busy)

    def done(self):     #When background task is complete it runs this function
        self.setLoading(False)

    def getFinalTextAndImage(self):     #Get the text from image and draw bounding boxes on image
        finalText = ""
        answers = self.model.getText()
        
        self.drawImage = Image.open(self.imgPath)
        draw = ImageDraw.Draw(self.drawImage)
        width,height = self.drawImage.size
        
        for i in answers.detects:
            x1 = i.rect.x1 * width/1000
            y1 = i.rect.y1 * height/1000
            x2 = i.rect.x2 * width/1000
            y2 = i.rect.y2 * height/1000

            coords = [x1,y1,x2,y2]
            draw.rectangle(coords, outline=self.color, width=2)
            draw.text((coords[0], coords[1]), i.text, fill=self.color,stroke_width=1,font=self.font)
        
            finalText += i.text + "\n"

        self.drawImage.save("uiFiles/displayFile.png")
        self.setText.emit(finalText)
        self.setLoading(False)

    @Slot(str) #Functions triggered when communicating from frontend to backend
    def setImageLocation(self,arg):
        slave = Worker(self.model.preprocessImage,arg)
        slave.signals.finished.connect(self.done)
        self.poolroom.start(slave)
        self.imgPath = arg

    @Slot()
    def saveFile(self):
        if hasattr(self,"drawImage"):
            self.drawImage.show("Press Ctrl+S to save")

    #Unused function start
    @Slot(str)
    def start(self,arg):    #Unused
        self.setLoading(True)
        slave = Worker(self.starts)
        self.poolroom.start(slave)

    @Slot(float,str)
    def setTextStyle(self,pixelSize,textColor):
        self.color = textColor
        self.font = ImageFont.truetype("uiFiles/fonts/deko.ttf",round(pixelSize,1))

    @Slot(str,str,str)
    def setModelValues(self,modelName,baseUrl,apiKey):
        if apiKey == "default(free api key)" or apiKey == "":
            apiKey = defaultKey
        if modelName == "":
            modelName = defaultModelName
        if baseUrl == "":
            baseUrl = defaultBaseUrl
        self.model = Model(apiKey,baseUrl,modelName)

    @Slot(str)
    def getTextButtonPressed(self,arg):
        if hasattr(self.model,"imagePath"):
            slave = Worker(self.getFinalTextAndImage)
            self.poolroom.start(slave)

    @Slot(str)
    def openThemeFile(self,arg):
        if arg != "":
            setThemeValues(arg)

    @Slot(str,str,str,str,str,float,float,bool)
    def saveTheme(self,path,mainColor,secondaryColor,gifLocation,videoLocation,opacity,videoOpacity,coloringBool):
        saveThemeValues(path,mainColor,secondaryColor,gifLocation,videoLocation,opacity,videoOpacity,coloringBool)
    
backend = Backend()

if not engine.rootObjects():
    sys.exit(-1)

engine.rootObjects()[0].setProperty("backend",backend)
setThemeValues("testing.txt")

sys.exit(app.exec())