# Enable-Question-Sets-for-video-content

**Introduction**

Interactive Video is nothing but videos embedded with Question-sets. It is made to serve the purpose that the user will understand part of the video and answer the questions based on it. The following document explains the design and implementation to enable interactions in the video.

[SB-30516 System JIRA](https://browse/SB-30516)

**Key Design Problems:**

1. How to show Question-Sets on top of the video ?
2. Ensure proper view of the video and its functionalities along with the functionality of the Question-Sets.

**Design:**

![](<../../../../PRD/prd-ed-td-req-13iv/images/storage/Published Document.jpg>) **Solution:**

We are using the existing [Quml-Player library](https://github.com/project-sunbird/sunbird-quml-player) to implement the Question-Sets on top of the Video along with the Video player library.

primaryCategory: \*\* Interactive Video Question Set\*\*

* In the API response there is ‘result’ , which has ‘content’ that contains ‘interceptionType’ and ‘interceptionPoints’. The ‘interceptionPoints’ contains ‘items’ which is an array of objects containing the Question-Set information. The number of objects is the number of Question-Sets.

```
"content": {
      ...
      "interceptionType": "Timestamp",
      "interceptionPoints": {
        "items": [
          {
            "type": "QuestionSet",
            "interceptionPoint": 2,
            "identifier": "do_2135403630343946241444"
          },
          {
            "type": "QuestionSet",
            "interceptionPoint": 4,
            "identifier": "do_2135403696701276161449"
          }
        ]
      },
      ...
}
```

* Each object in ‘items’ has ‘type’ as ‘QuestionSet’ , an ‘interceptionPoint’ in seconds at which it appears in the video and ‘identifier’ which is the do\_id of the Question-Set.

Sample config link is [sunbird-video-player/data.ts at release-5.0.0 · project-sunbird/sunbird-video-player ](https://github.com/project-sunbird/sunbird-video-player/blob/release-5.0.0/src/app/data.ts)

* When ‘interceptionPoints’ are not available i.e. no Question-Sets are configured or ‘interceptionPoints’ is an empty object there will be no Question-Set markers on the Progress Bar will be visible and it will be treated as a normal video content.
* **Default behavior(not enabling Question-Sets)**
  * In this case , there is no need to configure any Question-Sets; the player will just show the video without any Question-Sets. (‘interceptionPoints’ is an empty object)

```
"content": {
      ...
      "interceptionPoints": { },
      ...
}
```

* **Custom changes(enabling Question-Sets)**
  * Here the Question-Sets are configured through the creation portal and the ‘interceptionPoints’ contains the required data.

```
"content": {
      ...
      "interceptionType": "Timestamp",
      "interceptionPoints": {
        "items": [
          {
            "type": "QuestionSet",
            "interceptionPoint": 2,
            "identifier": "do_2135403630343946241444"
          },
          {
            "type": "QuestionSet",
            "interceptionPoint": 4,
            "identifier": "do_2135403696701276161449"
          }
        ]
      },
      ...
}
```

\*\*Design Document \*\*

[**Screenshots**](https://photos.app.goo.gl/KjVbRLVPxpg5mJZ48)

**Player Events**

```
{
    "eid": "HEARTBEAT",
    "ver": "1.0",
    "edata": {
        "type": "VIDEO_MARKER_SELECTED",
        "currentPage": "videostage",
        "extra": {
            "questionSetId": "do_213272808198291456121",
            "type": "interactive-video",
            "interceptedAt": 80
        }
    },
    "metaData": {
        "actions": [
            {
                "play": 0
            },
            {
                "seeked": 51.27854
            },
            {
                "pause": 52.189359
            },
            {
                "play": 52.306999
            },
            {
                "pause": 80.256709
            },
            {
                "play": 80.256709
            },
            {
                "pause": 80.256709
            },
            {
                "seeked": 80.256709
            }
        ],
        "volume": [],
        "playBackSpeeds": [],
        "totalDuration": 137.56,
        "currentDuration": 80.256709,
        "transcripts": []
    }
}
```

**Telemetry Events**

Interact event:

```
{
	"eid": "INTERACT",
	"ets": 1657543890242,
	"ver": "3.0",
	"mid": "INTERACT:50f3d104080f5e3dea2e44b1eb912cb3",
	"actor": {
    	"id": "3c0a3724311fe944dec5df559cc4e006",
    	"type": "User"
	},
	"context": {
    	"channel": "505c7c48ac6dc1edc9b08f21db5a571d",
    	"pdata": {
        	"id": "prod.diksha.portal",
        	"ver": "3.2.12",
        	"pid": "sunbird-portal.contentplayer"
    	},
    	"env": "contentplayer",
    	"sid": "7283cf2e-d215-9944-b0c5-269489c6fa56",
    	"did": "3c0a3724311fe944dec5df559cc4e006",
    	"cdata": [
        	{
            	"id": "DaoAjYewHmiGZRBJymVeM5ioh1wSVwqi",
            	"type": "ContentSession"
        	},
        	{
            	"id": "v6984MlLx6L3x36FfSm8b2XoYCgEmF9u",
            	"type": "PlaySession"
        	},
        	{
            	"id": "2.0",
            	"type": "PlayerVersion"
        	}
    	],
    	"rollup": {
        	"l1": "505c7c48ac6dc1edc9b08f21db5a571d"
    	},
    	"uid": "anonymous"
	},
	"object": {
    	"id": "do_21310353608830976014671",
    	"ver": "2",
    	"type": "Content",
    	"rollup": {
        	"l1": "do_21310353608830976014671"
    	}
	},
	"tags": [
    	""
	],
	"edata": {
    	"type": "TOUCH",
    	"subtype": "",
    	"id": "video_marker_selected",
    	"pageid": "videostage",
    	"extra": {
        	"questionSetId": "do_213272808198291456121",
        	"type": "interactive-video",
        	"interceptedAt": 80
    	}
	}
}
```

Impression Event:

```
"edata":{"type":"workflow","subtype":"","pageid":"interactive-question-set","uri":""}}
```

Watch video on how to create an Interactive Video content on Portal [here](https://photos.app.goo.gl/sQJa34MCLw8VLvZD8).

***

\[\[category.storage-team]] \[\[category.confluence]]
