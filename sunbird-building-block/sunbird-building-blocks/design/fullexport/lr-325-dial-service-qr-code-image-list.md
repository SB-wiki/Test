# LR-325--DIAL-Service-QR-Code-Image-List

## Introduction

This wiki explains the design for fetching QR code images via DIAL Service

## Background & Problem Statement

At the moment LERN Batch Service is connecting to cassandra ‘dialcodes.dialcode\_images’ table for fetching QR Code Image URLs and also resolve image BLOB URL which is currently relative path. Ideally this information should be fetched from DIAL service owned by Knowlg BB as this keyspace is owned by knowlgBB. Hence, an API is to be developed where an image or multiple QR code Images information can be fetched from DIAL service.

![](<../../../../Design/FullExport/images/storage/LERN DESIGN Diagram.drawio.png>)

## Design

To resolve above problem,

**Solution 1:** New API can be published in DIAL Service (\{{host\}}/api/dialcode/v2/image/list) which will accept request in below format, reads data from cassandra ‘dialcodes.dialcode\_images’ table and provides response in below format. Number of QR Codes as input to be controlled via a configuration 'qrimage\_request\_limit'.

![](<../../../../Design/FullExport/images/storage/LERN DESIGN Diagram.drawio (1).png>)

```json
{
    "request": {
        "dialcodes": ["Q1I5I3"]
    }
}
```

```json
{
    "id": "sunbird.dialcode.images.list",
    "ver": "3.0",
    "ts": "2023-02-01T12:16:52Z+05:30",
    "params": {
        "resmsgid": "505bce18-1feb-44c3-91c3-07b8324de4f9",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "count": 1,
        "qrcodeImagesInfo": [
            {
                "filename": "0_Q1I5I3",
                "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
                "config": {},
                "createdOn": null,
                "dialcode": "Q1I5I3",
                "publisher": null,
                "status": 0,
                "url": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/in.ekstep/0_Q1I5I3.png"
            }
        ]
    }
}
```

**Solution 2:** Image URL can be updated to Elastic search document of the DIAL code available in ElasticSearch ‘dialcodes’ index when the DIAL code was generated. This can be achieved when the image is generated in the ‘qrcode-image-generator' flink job.

**However** , syncing of already generated QR codes’ image URLs has to be done for existing adopters. This requires enhancement of the DIAL code Sync job.

Sync Jenkins job should be able to update the DIAL Code document to Elastic Search by reading DIAL code details from ‘dialcode\_store.dial\_code’ table and imageURL details from 'dialcodes.dialcode\_images’ table.

![](<../../../../Design/FullExport/images/storage/LERN DESIGN Diagram.drawio (4).png>)End DIAL Search Response:

```
{
    "id": "api.dialcode.search",
    "ver": "1.0",
    "ts": "2023-02-10T07:27:58.021Z",
    "params": {
        "resmsgid": "71184750-a914-11ed-873f-c57d91aaac2a",
        "msgid": "7116e7c0-a914-11ed-bfb1-85731013bbc1",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "dialcodes": [
            {
                "dialcode_index": 12996935,
                "identifier": "Q1I5I3",
                "channel": "012463759411712074",
                "batchcode": "do_31372904974902081878",
                "generated_on": "2023-02-09T02:27:58.947+0000",
                "objectType": "DialCode",
                "status": "Draft",
                "imageUrl": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/in.ekstep/0_Q1I5I3.png"
            }
        ],
        "count": 1
    }
}
```

## LERN Batch Service code update:

Remove the database connection and connect to DIAL Service for the image information in ‘QRCodeDownloadManagementActor.java’. Rest of the code flow (request and response) will remain intact.

***

\[\[category.storage-team]] \[\[category.confluence]]
