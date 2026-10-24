from dotenv import load_dotenv
from openai import OpenAI,OpenAIError
from pydantic import BaseModel
import os

import base64

def encode_img(path:str):
    with open(path,"rb") as img_filr:
        return base64.b64encode(img_filr.read()).decode("utf-8")

def log_output(fileName:str, text:str):
    with open(fileName,"a") as outFile:
        outFile.write(text)

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

class Model:
    def __init__(self,key:str,url:str,model:str):
        self.client = OpenAI(api_key=key) if url == "" else OpenAI(api_key=key,base_url=url)
        self.model = model

    def preprocessImage(self,path):
        self.imagePath = path
        self.endImg = encode_img(path)

    def checkError(self,errorCode:int) -> str:
        match(errorCode):
            case 429:
                return ""
        return str("None")
    
    def getText(self):
        try:
            extension = os.path.basename(self.imagePath).split('.')[-1]
            response = self.client.chat.completions.parse(
                model=self.model,
                messages=[
                    {
                        "role":"user",
                        "content":[
                            {
                                "type":"text",
                                "text":"""What text is in the image. ONLY give me the identified text FROM TOP TO BOTTOM, 
                                LEFT TO RIGHT and the bounding boxes where the text appears and nothing else."""
                            },
                            {
                                "type":"image_url",
                                "image_url":{
                                    "url":f"data:image/{extension};base64,{self.endImg}"
                                }
                            }
                        ]
                    }
                ],
                timeout=600,
                response_format=resultFormat
            )
        
            answer = response.choices[0].message.parsed
            return answer
        except OpenAIError as e:
            if not e.body:
                return str(e)
            if not e.body[0]["error"]:
                return e.body[0]
            errorList = e.body[0]["error"]
            error = f"Error : {errorList['message']},\nError code : {e.code},\nAdditional info : {self.checkError(int(errorList["code"]))}"
            return error

if __name__=="__main__":
    load_dotenv()
    geminiKey = os.getenv("GEMINI_API_KEY")
    geminiUrl = "https://generativelanguage.googleapis.com/v1beta/openai/"
    modelName = "gemini-3.5-flash"

    client = Model(geminiKey,geminiUrl,modelName)
    client.preprocessImage(input("Enter file path: "))
    answer = client.getText()
    print(answer)
    final_text = ""
    for i in answer.detects:
        final_text += "\n"+i.text
    log_output("testing.txt", final_text)