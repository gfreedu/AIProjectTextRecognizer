from dotenv import load_dotenv
from openai import OpenAI,OpenAIError
from pydantic import BaseModel
import os
import sys
import mimetypes
import pymupdf

import base64

def encode_file(path:str):
    with open(path,"rb") as filr:
        return base64.b64encode(filr.read()).decode("utf-8")

def log_output(fileName:str, text:str):
    with open(fileName,"a") as outFile:
        outFile.write(text)

def getTextFromPDF(file:str):
    doc = pymupdf.open(file)
    textFound = {}
    
    for i,page in enumerate(doc):
        if(page.get_images()):
            return "",-1
        textFoundOnPage = page.get_text()
        textFound[i] = textFoundOnPage if textFoundOnPage != "" else f"No text found on Page {i}."

    return textFound, 0

class point(BaseModel):
        x1:int
        y1:int
        x2:int
        y2:int

class structured(BaseModel):
    text:str
    rect:point

class resultFormat(BaseModel):
    detects: list[structured]

class pdfResultFormat(BaseModel):
    foundTexts: list[str]

class Model:
    def __init__(self,key:str,url:str,model:str):
        self.client = OpenAI(api_key=key) if url == "" else OpenAI(api_key=key,base_url=url)
        self.model = model

    def preprocessImage(self,path):
        self.imagePath = path
        self.endImg = encode_file(path)
    
    def getText(self):
        try:
            mimeType,_ = mimetypes.guess_type(self.imagePath)
            expectedResponse = resultFormat

            file_str = {
                "type":"image_url",
                "image_url":{
                    "url":f"data:{mimeType};base64,{self.endImg}"
                }
            }

            answer = ""

            defaultPrompt = """
                What text is in the image. ONLY give me the identified text FROM TOP TO BOTTOM, 
                LEFT TO RIGHT AND the bounding boxes where the text appears and nothing else.
                Group lines in a paragraph together.Add a new line character where needed.
            """
            pdfPrompt = """
                What text is in the pdf file? ONLY give me the identified text group it in pages.
            """

            if mimeType == "application/pdf":                                   #if application pdf
                textFoundInPDF, code = getTextFromPDF(self.imagePath)
                if code == 0:
                    return textFoundInPDF
                file_str = {
                    "type":"image_url",
                    "image_url":{
                        "url":f"data:application/pdf;base64,{self.endImg}"
                    }
                }
                defaultPrompt = pdfPrompt
                expectedResponse = pdfResultFormat

            response = self.client.chat.completions.parse(
                model=self.model,
                messages=[
                    {
                        "role":"user",
                        "content":[
                            {
                                "type":"text",
                                "text":defaultPrompt
                            },
                            file_str
                        ]
                    }
                ],
                timeout=600,
                response_format=expectedResponse
            )
        
            answer = response.choices[0].message.parsed
            return answer
        
        except OpenAIError as e:
            if not e.body:
                return str(e)
            if not e.body[0]["error"]:
                return e.body[0]
            errorList = e.body[0]["error"]
            error = f"Model Error : {errorList['message']},\nError code : {e.code}"
            return error

if __name__=="__main__":
    load_dotenv()
    geminiKey = os.getenv("GEMINI_API_KEY")
    geminiUrl = "https://generativelanguage.googleapis.com/v1beta/openai/"
    modelName = "gemini-3.5-flash"

    client = Model(geminiKey,geminiUrl,modelName)
    client.preprocessImage(input("Enter file path: "))
    answer = client.getText()
    final_text = ""

    if hasattr(answer,"detects"):
        for i in answer.detects:
            final_text += "\n"+i.text
    elif hasattr(answer,"foundTexts"):
        for i,textsFound in enumerate(answer.foundTexts):
            final_text += f"Page: {i+1}\n" + textsFound + "\n"
    else:
        for i,textsFound in answer.items():
            final_text += f"Page: {i+1}\n" + textsFound + "\n"
    print(final_text)