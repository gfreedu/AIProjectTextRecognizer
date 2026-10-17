#import libraries:
from transformers import TrOCRProcessor, VisionEncoderDecoderModel
from PIL import Image
import modules.easyeasy as easyeasy

class model:
    def __init__(self):
        #Image processor that converts image to numbers and cleans data:
        model_name = "microsoft/trocr-base-handwritten"
        self.processor = TrOCRProcessor.from_pretrained(model_name)
        #Actuall model:
        self.OCRmodel = VisionEncoderDecoderModel.from_pretrained(model_name)
        self.image = Image.open("image.png")

    def imageToText(self)->str:
        answer = []

        for cropingArea in self.lineCoords:
            #The area of the box
            crop = self.image.crop(cropingArea).convert("RGB")

            #Process image into numbers:
            pixel_values = self.processor(images=crop, return_tensors = "pt").pixel_values

            #Answer from the model:
            answer_ids = self.OCRmodel.generate(pixel_values)

            #Get the answer in the form of text:
            text_answer = self.processor.batch_decode(answer_ids,skip_special_tokens=True)[0]
            answer.append(text_answer)

        return answer

    def setImage(self,imagePath:str='image.png'):
        #Raw image:
        self.image = Image.open(imagePath).convert("RGB")
        
        #BoundingBoxes of lines:
        self.lineCoords = easyeasy.getLines(imagePath)

def main():
    new = model()
    new.setImage()
    answer = new.imageToText()
    print("Answer:\n",answer)

if __name__ == "__main__":
    main()