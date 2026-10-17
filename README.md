# AI Scanner for class 12 project

Class 12 AI project that takes image from the user sends it to **gemini** through the **openai sdk**  and gets the **text from the image**. Uses **QML** with **Pyside6**.

 Can handle *most* image formats as its an llm.
 
Do ***WHATEVER*** u like with this code. I dont think I will accept pull requests.

# Installation
Basic installation, recommend using **Python 3.x**

 1. Clone github repository
 2. Make a virtual environment using:
 `python -m venv .venv'`
 
 3. Install required libraries using:
 `pip install -r requirements.txt`
 4. Run main.py
 5. Done! U did it yay!!

# Files
Files include 3 main folders:

 1. **modules** : Location of all files used by main.py
 2. **testing_images** : Location of all tesitng images used to measure the capabilities of gemini flash 3.5 lite
 3. **uiFiles** : Location of all .qml files used to make the ui, including main.qml
 4. **requirements.txt** : All libraries used in the project

# AiOCRHandler.py

> Location : modules
> 
Location of AiOCRHandler.py which handles the model backend using the openai sdk has a class Model which handles communication witht the `base url`,`model` and `api_key` provided

# main.py

Handles **backend** communication from AiOCRHandler.py and `main.qml`.

# main.qml
> Location : uiFiles
> 
Handles frontend unifies all code from `uiFiles` into a single unified ui system.

 - CustomCheckBox.qml : Custom check box thats actually just a image button.

 - CustomizationWindow.qml : Handles changing theme and adds customization to the application which is very cool.

 - CustomSlider : Handles slider background and handle colours uses `QtQuick.Controls` hence giving the warning:
 `QML CustomSlider: The current style does not support customization of this control (property: "background" item: CustomSlider_QMLTYPE_25. Please customize a non-native style (such as Basic, Fusion, Material, etc). For more information, see: ` https://doc.qt.io/qt-6/qtquickcontrols2-customize.html#customization-reference

 - DetectedTextLabel.qml : The text area containing the text found by the model, it is inside a scroll view that i couldnt customize bcuz im lazy.

 - FileSelect.qml: Button that selects the image file.

 - Fileselector.qml: Template for buttons that open files.

 - FontColorAndSlider.qml : Handles how text on the image looks.
 
 - Imagicle.qml : Template for displaying animated and regular images.

- ModelWindow.qml : Handles the model settings required by the user.

- OpenThemeFile.qml : Button that opens a theme file and loads it.

- Plaintext.qml : Plain text template.

- Recticle.qml : Default custom button used by the application can only set text.

- SaveThemFile.qml : Save theme button.

- Saveticle.qml : Button that opens the image with rectangle bounding boxes around text in the image.

- displayFile.png : The file used to display final text and bounding boxes found.
