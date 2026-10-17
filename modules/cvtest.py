import cv2
import os

def getLines(imagePath:str):
    #Read image
    image = cv2.imread(imagePath)

    #Grayscale image
    grayscale = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    #Treshold image
    tresh = cv2.adaptiveThreshold(grayscale, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 31, 10)

    hmm = cv2.imwrite("C:/Users/cream/Documents/AiProjectClass12/the_threshold2.png",tresh)
    #Get horizontal lines
    horizontals = (tresh > 0).sum(axis=1)

    #Get regions of text
    ylines = []
    in_line = False

    for y,pixels in enumerate(horizontals):
        if pixels > 10 and in_line == False:
            start = y
            in_line = True
        elif pixels < 10 and in_line == True:
            end = y
            in_line = False

            if end - start > 5:
                ylines.append((start,end))

    lines = []
    padding = 10

    for y_start,y_end in ylines:
        line_tresh = tresh[y_start:y_end,:]

        verticals = (line_tresh > 0).sum(axis=0)
        xs = [x for x,pixels in enumerate(verticals) if pixels > 0]

        x_start = min(xs)
        x_end = max(xs)

        lines.append((x_start - padding,
                      y_start - padding,
                      x_end + padding,
                      y_end + padding))

    return lines

#Wait till user closes all windows or presses a key

def main():
    lines = getLines("handwritten-check-ocr.png")
    """output = cv2.imread("image.png")
    for x_start, y_start, x_end, y_end in lines:
        cv2.rectangle(output,(x_start,y_start),(x_end,y_end),(255,0,0),2)
    
    cv2.imshow("Final gay ultimate specimen", output)
    cv2.waitKey(0)
    cv2.destroyAllWindows()"""

if __name__ == "__main__":
    main()