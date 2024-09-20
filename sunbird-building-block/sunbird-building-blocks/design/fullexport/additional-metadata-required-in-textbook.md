# Additional-Metadata-required-in-Textbook

### Overview

In view of providing better experience for devices which run on a low configuration and/or low bandwidth, to the **offline modes** - mobile and desktop apps, the following is decided :

**1.** Addition of **hierarchy.json** file inside the ecar, which consists of the minimum required data in hierarchical structure, for viewing content in the apps mentioned.

**2.** Two new metadata fields are added into the existing metadata :

**i.**   totalCompressedSize - Size of the Textbook in compressed/zipped format

**ii.** totalUncompressedSize - Size of the Textbook in uncompressed format

&#x20;   The above fields are required to determine the **available disk space** of the user for downloading app-related content.

### Ecar Structure

EcarFolder&#x20;

\| \_ \_ \_ \_ \_ manifest.json

\| \_ \_ \_ \_ \_ hierarchy.json

\| \_ \_ \_ \_ \_ other folders

### Sample Hierarchy Json

```js
{  
   "ownershipType":[  
      "createdBy"
   ],
   "publish_type":null,
   "keywords":[  
      "QA_Content",
      "games",
      "colors"
   ],
   "channel":"in.ekstep",
   "questions":[  

   ],
   "language":[  
      "English"
   ],
   "mimeType":"application/vnd.ekstep.content-collection",
   "variants":{  

   },
   "body":null,
   "objectType":"Content",
   "children":[  
      {  
         "parent":"do_11277291820240896019",
         "identifier":"do_112772918447374336110",
         "lastStatusChangedOn":"2019-05-30T10:59:06.408+0530",
         "code":"textbookunit_0",
         "visibility":"Parent",
         "index":1,
         "mimeType":"application/vnd.ekstep.content-collection",
         "createdOn":"2019-05-30T10:59:06.408+0530",
         "versionKey":"1559194146408",
         "depth":1,
         "children":[  
            {  
               "parent":"do_112772918447374336110",
               "identifier":"do_112772918447521792113",
               "lastStatusChangedOn":"2019-05-30T10:59:06.426+0530",
               "code":"textbooksubunit_0",
               "visibility":"Parent",
               "index":1,
               "mimeType":"application/vnd.ekstep.content-collection",
               "createdOn":"2019-05-30T10:59:06.426+0530",
               "versionKey":"1559194146426",
               "depth":2,
               "name":"U1.1",
               "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
               "contentType":"TextBookUnit",
               "status":"Live",
               "compatibilityLevel":1,
               "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
               "pkgVersion":1.0,
               "leafNodesCount":0,
               "downloadUrl":null,
               "variants":null
            }
         ],
         "name":"U1",
         "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
         "contentType":"TextBookUnit",
         "status":"Live",
         "compatibilityLevel":1,
         "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
         "pkgVersion":1.0,
         "leafNodesCount":0,
         "downloadUrl":null,
         "variants":null
      },
      {  
         "parent":"do_11277291820240896019",
         "identifier":"do_112772918447423488111",
         "lastStatusChangedOn":"2019-05-30T10:59:06.414+0530",
         "code":"textbookunit_1",
         "visibility":"Parent",
         "index":2,
         "mimeType":"application/vnd.ekstep.content-collection",
         "createdOn":"2019-05-30T10:59:06.414+0530",
         "versionKey":"1559194146414",
         "depth":1,
         "children":[  
            {  
               "parent":"do_112772918447423488111",
               "identifier":"do_112772918447546368114",
               "lastStatusChangedOn":"2019-05-30T10:59:06.429+0530",
               "code":"textbooksubunit_1",
               "visibility":"Parent",
               "index":1,
               "mimeType":"application/vnd.ekstep.content-collection",
               "createdOn":"2019-05-30T10:59:06.429+0530",
               "versionKey":"1559194146429",
               "depth":2,
               "name":"U2.1",
               "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
               "contentType":"TextBookUnit",
               "status":"Live",
               "compatibilityLevel":1,
               "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
               "pkgVersion":1.0,
               "leafNodesCount":0,
               "downloadUrl":null,
               "variants":null
            }
         ],
         "name":"U2",
         "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
         "contentType":"TextBookUnit",
         "status":"Live",
         "compatibilityLevel":1,
         "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
         "pkgVersion":1.0,
         "leafNodesCount":0,
         "downloadUrl":null,
         "variants":null
      },
      {  
         "parent":"do_11277291820240896019",
         "identifier":"do_112772918447464448112",
         "lastStatusChangedOn":"2019-05-30T10:59:06.419+0530",
         "code":"textbookunit_2",
         "visibility":"Parent",
         "index":3,
         "mimeType":"application/vnd.ekstep.content-collection",
         "createdOn":"2019-05-30T10:59:06.419+0530",
         "versionKey":"1559194146419",
         "depth":1,
         "children":[  
            {  
               "parent":"do_112772918447464448112",
               "identifier":"do_112772918447554560115",
               "lastStatusChangedOn":"2019-05-30T10:59:06.430+0530",
               "code":"textbooksubunit_2",
               "visibility":"Parent",
               "index":1,
               "mimeType":"application/vnd.ekstep.content-collection",
               "createdOn":"2019-05-30T10:59:06.430+0530",
               "versionKey":"1559194146430",
               "depth":2,
               "children":[  
                  {  
                     "parent":"do_112772918447554560115",
                     "identifier":"do_112772918447562752116",
                     "lastStatusChangedOn":"2019-05-30T10:59:06.431+0530",
                     "code":"textbooksubsubunit_2",
                     "visibility":"Parent",
                     "index":1,
                     "mimeType":"application/vnd.ekstep.content-collection",
                     "createdOn":"2019-05-30T10:59:06.431+0530",
                     "versionKey":"1559194146431",
                     "depth":3,
                     "children":[  
                        {  
                           "ownershipType":[  
                              "createdBy"
                           ],
                           "parent":"do_112772918447562752116",
                           "code":"test.pdf.1",
                           "keywords":[  
                              "colors",
                              "games"
                           ],
                           "channel":"in.ekstep",
                           "questions":[  

                           ],
                           "language":[  
                              "English"
                           ],
                           "mimeType":"application/pdf",
                           "idealScreenSize":"normal",
                           "createdOn":"2019-03-22T15:21:35.083+0530",
                           "usesContent":[  

                           ],
                           "contentDisposition":"inline",
                           "contentEncoding":"identity",
                           "lastUpdatedOn":"2019-03-22T15:21:35.083+0530",
                           "contentType":"Resource",
                           "dialcodeRequired":"No",
                           "identifier":"do_112724210033541120115",
                           "audience":[  
                              "Learner"
                           ],
                           "lastStatusChangedOn":"2019-03-22T15:21:35.083+0530",
                           "os":[  
                              "All"
                           ],
                           "visibility":"Default",
                           "index":1,
                           "mediaType":"content",
                           "osId":"org.ekstep.quiz.app",
                           "versionKey":"1553248295083",
                           "tags":[  
                              "colors",
                              "games"
                           ],
                           "idealScreenDensity":"hdpi",
                           "dialcodes":[  
                              "XKJFAK"
                           ],
                           "framework":"NCF",
                           "depth":4,
                           "concepts":[  

                           ],
                           "compatibilityLevel":1.0,
                           "name":"Ramp",
                           "status":"Draft",
                           "resourceType":"Read"
                        }
                     ],
                     "name":"U3.1.1",
                     "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
                     "contentType":"TextBookUnit",
                     "status":"Live",
                     "compatibilityLevel":1,
                     "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
                     "pkgVersion":1.0,
                     "leafNodesCount":1,
                     "downloadUrl":null,
                     "variants":null
                  }
               ],
               "name":"U3.1",
               "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
               "contentType":"TextBookUnit",
               "status":"Live",
               "compatibilityLevel":1,
               "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
               "pkgVersion":1.0,
               "leafNodesCount":1,
               "downloadUrl":null,
               "variants":null
            }
         ],
         "name":"U3",
         "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
         "contentType":"TextBookUnit",
         "status":"Live",
         "compatibilityLevel":1,
         "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
         "pkgVersion":1.0,
         "leafNodesCount":1,
         "downloadUrl":null,
         "variants":null
      }
   ],
   "usesContent":[  

   ],
   "contentEncoding":"gzip",
   "mimeTypesCount":"{\"application/pdf\":1,\"application/vnd.ekstep.content-collection\":7}",
   "contentType":"TextBook",
   "item_sets":[  

   ],
   "lastUpdatedBy":"Ekstep",
   "identifier":"do_11277291820240896019",
   "audience":[  
      "Learner"
   ],
   "publishChecklist":null,
   "visibility":"Default",
   "toc_url":"https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_11277291820240896019/artifact/do_11277291820240896019_toc.json",
   "contentTypesCount":"{\"TextBookUnit\":7,\"Resource\":1}",
   "childNodes":[  
      "do_112772918447554560115",
      "do_112772918447521792113",
      "do_112772918447374336110",
      "do_112724210033541120115",
      "do_112772918447562752116",
      "do_112772918447423488111",
      "do_112772918447546368114",
      "do_112772918447464448112"
   ],
   "mediaType":"content",
   "osId":"org.ekstep.quiz.app",
   "lastPublishedBy":"Ekstep",
   "version":2,
   "rejectReasons":null,
   "tags":[  
      "QA_Content",
      "games",
      "colors"
   ],
   "lastPublishedOn":"2019-05-30T10:59:30.299+0530",
   "concepts":[  

   ],
   "name":"YO",
   "rejectComment":null,
   "publisher":"EkStep",
   "status":"Live",
   "code":"org.ekstep.feb16.story.test01",
   "publishError":null,
   "methods":[  

   ],
   "description":"Text Book in English for Class III",
   "idealScreenSize":"normal",
   "createdOn":"2019-05-30T10:58:36.486+0530",
   "contentDisposition":"inline",
   "lastUpdatedOn":"2019-05-30T10:59:06.860+0530",
   "dialcodeRequired":"No",
   "lastStatusChangedOn":"2019-05-30T10:58:36.486+0530",
   "os":[  
      "All"
   ],
   "flagReasons":null,
   "libraries":[  

   ],
   "pkgVersion":1.0,
   "versionKey":"1559194146860",
   "idealScreenDensity":"hdpi",
   "depth":0,
   "framework":"NCF",
   "compatibilityLevel":1.0,
   "leafNodesCount":1
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
