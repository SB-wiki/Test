Size of the QR Code is determined by:


1. Length of the data to be encoded
1. Error correction level (L, M, Q, H)
1. Pixels per block
1. Margin (White space around QR code)

Following options can be provided to the user w.r.t the text embedded in the QR code image


1. Text to be embedded
1. Font Name
1. Font Size
1. Text Tracking(To control spacing between characters)

Following options can be provided to the user w.r.t the QR code image


1. Colour model of the image(RGB/CMYK)
1. Border size
1. File format of the QR image





| Parameter | Description | Mandatory/ Optional | Values Set | Default Value | 
|  --- |  --- |  --- |  --- |  --- | 
|  **data**  | Data to be encoded as QR image |  **Mandatory**  | - | - | 
|  **errorCorrectionLevel**  | Error correction level for the generated QR code | Optional | L, M, Q, H |  **H**  | 
|  **pixelsPerBlock**  | Number of pixels to be painted per bit-matrix encoded value | Optional | - |  **2**  | 
|  **margin**  | Number of pixels as margin for QR code | Optional | - |  **3**  | 
|  **text**  | Text to be embedded in QR image | Optional | - | - | 
|  **fontName**  | Font name of the text | Optional | - |  **Verdana**  | 
|  **fontSize**  | Font size of the text | Optional | - |  **11**  | 
|  **tracking**  | Tracking value to be set for TextAttribute.TRACKING | Optional | -0.1 to 0.3 recommended |  **0.1**  | 
|  **colourModel**  | Colour model of the QR image | Optional | RGB, CMYK |  **RGB**  | 
|  **borderSize**  | QR image border size in pixels | Optional | - |  **1**  | 
|  **imageFormat**  | File format of the QR image | Optional | - |  **PNG**  | 



Sample Values:


```
{
  "qrSpec": {
    "data": "http://www.sunbird.org/dial/2A42UH",
    "errorCorrectionLevel": "H",
    "pixelsPerBlock": 3,
    "margin": 3
  },
  "textSpec": {
    "text": "2A42UH",
    "fontName": "Verdana",
    "fontSize": 12,
    "tracking": -0.1
  },
  "imageSpec": {
    "imageFormat": "png",
    "colourModel": "CMYK",
    "borderSize": 2
  }
}
```






*****

[[category.storage-team]] 
[[category.confluence]] 
