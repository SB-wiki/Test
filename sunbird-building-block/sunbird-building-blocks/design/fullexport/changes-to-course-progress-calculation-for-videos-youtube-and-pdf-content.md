 **Background:-**   The majority of the support tickets indicate that users have a problem with course progress. They report that they have played the video or viewed the document multiple times but the progress is stuck.

Issue link:- [https://project-sunbird.atlassian.net/browse/SH-120](https://project-sunbird.atlassian.net/browse/SH-120)

 At scale, supporting these queries is super difficult. Hence, the decision to implement standard progress measurement techniques used by other course platforms at scale.

 **Requirement:-**  Following changes are suggested to be applied to resources in the context of curriculum courses and teacher training (TPD courses) in both mobile app & portal:

a) Videos & Audios - youtube/mp4/webm: 

Please mark the progress as done, if the user plays 20% of the video OR drags the video to the end

b) PDF resources - 

Please mark the progress as done if the user reaches the last page in the document or end telemetry event is generated


## Proposed Solution: 

## Solution -1
 **_Add a new property in the edata of the end event as a “completionStatus“, which will be the boolean value of ‘TRUE' / 'FALSE’_** 

Existing telemetry end event edata


```json
"edata": {
		"type": "content",
		"mode": "play",
		"pageid": "sunbird-player-Endpage",
		"summary": [{
			"progress": 27,
			
		}],
		"duration": 134.983
	}
```
Proposed telemetry end event edata


```
"edata": {
		"type": "content",
		"mode": "play",
		"pageid": "sunbird-player-Endpage",
		"summary": [{
			"progress": 27,
			"completionStatus": true
		}],
		"duration": 134.983
	}
```
Currently, we are getting the content-progress once the user reached the end page. Each render plugin having the contentProgress() method which will return the progress of the content.

In the same way, we will write one method in a base class named “getCompletionStatus“, that will return the true/false boolean value. All the plugins will inherit this method from the base class and override this method.


```js
endTelemetry: function () {
		if (this.sleepMode) return
		if (TelemetryService.instance && TelemetryService.instance.telemetryStartActive()) {
			var telemetryEndData = {}
			telemetryEndData.stageid = getCurrentStageId()
			telemetryEndData.progress = this.contentProgress()
			telemetryEndData.completionStatus = this.getCompletionStatus() // new method()
			console.info("telemetryEndData", telemetryEndData)
			TelemetryService.end(telemetryEndData)
		} else {
			console.warn("Telemetry service end is already logged Please log start telemetry again")
		}
	},
```
For each renderer plugin having a different process to calculate the content-progress


*  **PDF:** -  Once the user visits the page, we are pushing the page number to the stageIdarray. once the user reached the end page this getCompletionStatus()method will call and if the last page of the pdf is visited then it will return the “true“ value and the progress will be as it is. 


*  **Video:-** For video content if the current duration is the same as the total duration, that means the user is at the endpoint of the video, and getCompletionStatus()will return a true value. if not it will return a false value. and progress will remain the same. 



 **Solution: 2**  **Send extra information about the content visited by the user as a “stats“ in a** summary **data** 

Existing telemetry end event edata


```json
"edata": {
		"type": "content",
		"mode": "play",
		"pageid": "sunbird-player-Endpage",
		"summary": [{
			"progress": 27,
			
		}],
		"duration": 134.983
	}
```


Proposed telemetry end event data for  **PDF** content


```
{
  "duration": 134.983,
  "mode": "play",
  "pageid": "sunbird-player-Endpage",
  "summary": [
    {
      "progress": 27
    },
    {
      "stats":[{
      	"contentType": "application/pdf" // mimeType of the content
      	"totalPages": "10",             // Totoal number of page count
      	"visitedPages": [1,4,6],        // Visited Page numbers 
      	"isEndpageVisited" : true       //  boolean
      }]
    }
  ],
  "type": "content"
}
```
Proposed telemetry end event data for  **Video**  content


```json
{
  "duration": 134.983,
  "mode": "play",
  "pageid": "sunbird-player-Endpage",
  "summary": [
    {
      "progress"      : 27
    },
    {
      "contentType"   : "application/x-mpegURL" 
    },
    {
      "contentLength" : xyz.  pages(pdf) || seconds(video) || number of slids(ECML)
    },
    {
      "visitedPages"  :  [1,4,6],        // Visited Page numbers (pdf) 
    },
    {
      "timespent"     : 134.983
    }
  ],
  "type": "content"
}
```


 **Solution: 3:** 
### The generic Summary object: 
We have an existing  **END**  event that sends the player summary as an array of objects. we can add more property to it based on the content MIME type which can send a rich player summary in END event. 

 Properties of the  **summary**  array in  END event  



|  **Property**  |  **Type**  |  **Description**  | 
|  --- |  --- |  --- | 
|  **progress**  | Number | This is the actual progress calculated by the player | 
|  **endpageseen**  | Boolean | “true“ if the user visited player end page  | 
|  **visitedcontentend**  | Boolean | “true“ if the user visited the content end page | 
|  **totallength**  | Number | The total length of content  | 
|  **visitedlength**  | Number | The max-content length covered by the user | 
|  **totalintrections**  | Number  | Total number of interactions triggered by the player while consuming content | 
|  **duration**  | Number | Total time spent on the content player to play the content(includes pause time as well) | 



 **Additional Property-based on MIME-type** 

PDF:



|  **Property**  |  **Type**  |  **Description**  | 
|  --- |  --- |  --- | 
|  **totalseekedlength**  | Number | Total seek pages by the user, this tells count of pages the user has been seeking in the PDF | 

VIDEO:



|  **Property**  |  **Type**  |  **Description**  | 
|  --- |  --- |  --- | 
|  **totalseekedlength**  | Number | Total seek seconds by the user, this tells count of seconds the user has been seeking the video. | 

ECML:



|  **Property**  |  **Type**  |  **Description**  | 
|  --- |  --- |  --- | 
|  **totalscore**  | Number | Total score achieved by the user in a Quiz, currently supported for  **ECML** having Quiz | 
|  **maxscore**  | Number | Total score allocated to Quiz, currently supported for  **ECML** having Quiz | 
|  **maxattempts**  | Number | Maximum attempt a user is allowed to take  a QUIZ, currently supported for  **ECML** having Quiz | 
|  **attemptnumber**  | Number | Current attempt number for the current  user, currently supported for  **ECML** having Quiz | 
|  **totalscore**  | Number | Total score achieved by the user in a Quiz, currently supported for  **ECML** having Quiz | 





EPUB:



|  **Property**  |  **Type**  |  **Description**  | 
|  --- |  --- |  --- | 
|  **totalseekedlength**  | Number | Total seek pages by the user, this tells count of pages the user has been seeking in the EPUB | 



Measuring Unit and Availability of the property based on MIME-type 





|  |  **PDF**  |  **VIDEO**  |  **EPUB**  |  **ECML**  | 
| Percentage  | Percentage | Percentage | Percentage | 
| Boolean | Boolean | Boolean | Boolean | 
| Boolean | Boolean | Boolean | Boolean | 
| Number of pages  | Length in seconds | Number of pages | Number of stages | 
| Number of pages | Length in seconds | Number of pages | Number of stages | 
| Number | Number | Number | Number | 
| In seconds | In seconds | In seconds | In seconds | 
| Number | In seconds | Number | Not available | 
| Not available | Not available | Not available | Number | 
| Not available | Not available | Not available | Number | 
| Not available | Not available | Not available | Number | 
| Not available | Not available | Not available | Number | 
|  --- |  --- |  --- |  --- |  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
|  --- | 
| Percentage  | Percentage | Percentage | Percentage | 
| Boolean | Boolean | Boolean | Boolean | 
| Boolean | Boolean | Boolean | Boolean | 
| Number of pages  | Length in seconds | Number of pages | Number of stages | 
| Number of pages | Length in seconds | Number of pages | Number of stages | 
| Number | Number | Number | Number | 
| In seconds | In seconds | In seconds | In seconds | 
| Number | In seconds | Number | Not available | 
| Not available | Not available | Not available | Number | 
| Not available | Not available | Not available | Number | 
| Not available | Not available | Not available | Number | 
| Not available | Not available | Not available | Number | 

currently, following fields   _progress_ ,  _endpageseen_  and visitedcontentend,  has been used to calculate custom progress

 **Sample formula to calculate custom progress:** Below pseudo-code explains how to calculate custom progress 


```
if 
    endpageseen OR visitedcontentend
        print customProgress = 100
else
        print customProgress = progress
endif
```

### Limitation/Challenges: 

* For worksheet having only 1 slide & 10 questions in it, then by opening & closing of the content will send progress as 100. Also totallength & maxvisitedlength as 1.


* Video → relaying the of the same video by dragging the seek bar has to verify thoroughly



 **JavaScript sample code** 


```js
function calculateProgress(endpageseen,visitedcontentend, progress){
	var customProgress = 0;
	if ( endpageseen ||  visitedcontentend ) {
		customProgress = 100
	} else {
		customProgress = progress
	}
	return customProgress;
}
```


Sample JSON structure of the summary event 


```json
{
  "edata": {
    "duration": 47.804,
    "mode": "play",
    "pageid": "sunbird-player-Endpage",
    "summary": [
      {
        "progress": "Number"
      },
      {
        "endpageseen": "Boolean"
      },
      {
        "visitedcontentend" : "Boolean"
      },
      {
        "totallength": "Number"
      },
      {
        "visitedlength": "Number"
      },
      {
        "totalinteractions": "Number"
      },
      {
        "duration": "Number"
      },
      {
        "totalseekedlength": "Number"
      },
      {
        "totalscore": "Number"
      },
      {
        "maxscore": "Number"
      },
      {
        "maxattempts": "Number"
      },
      {
        "attemptnumber": "Number"
      }
    ],
    "type": "content"
  }
}
```






*****

[[category.storage-team]] 
[[category.confluence]] 
