
### Kafka Topic
QR code image generation request will be published and consumed from a separate kafka topic

ENV.qrimage.request




### Message Format

```
{
  "eid": "BE_QR_IMAGE_GENERATOR",
  "processId": "3b369c35-2b79-40ec-a3e0-3d0306fc0388",
  "objectId":"contentid/channel",
  "dialcodes": [
    {
      "data": "https://diksha.gov.in/dial/ABCDEF",
      "text": "ABCDEF",
      "id": "ABCDEF_1543568148",
      "location":"cloudPublicUrl"
    },
    {
      "data": "https://diksha.gov.in/dial/123456",
      "text": "123456",
      "id": "123456_1543568148"
    }
  ],
  "storage": {
    "container": "dial",
    "path": "channel/publisher/",
    "fileName": "do_112636984058314752121_Medium_Grade_Subject_timestamp"
  },
  "config": {
    "errorCorrectionLevel": "H",
    "pixelsPerBlock": 2,
    "qrCodeMargin": 3,
    "qrCodeMarginBottom": 1,
    "textFontName": "Verdana",
    "textFontSize": 11,
    "textCharacterSpacing": 0.1,
    "imageFormat": "png",
    "colourModel": "Grayscale",
    "imageBorderSize": 1,
	"imageMargin": 1
  }
}
```




*****

[[category.storage-team]] 
[[category.confluence]] 
