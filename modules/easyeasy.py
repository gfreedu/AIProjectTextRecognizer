import easyocr
import numpy as np

def getLines(imagePath:str="image.png")->list:
    reader = easyocr.Reader(['en'],gpu=False,recognizer=False)
    result,_ = reader.detect(imagePath)

    area = []

    for box in result[0]:
    
            x_start = box[0]
            x_end = box[1]
            y_start = box[2]
            y_end = box[3]
    
            area.append((x_start, y_start, x_end, y_end))

    return area

if __name__=="__main__":
    print(str(getLines()))