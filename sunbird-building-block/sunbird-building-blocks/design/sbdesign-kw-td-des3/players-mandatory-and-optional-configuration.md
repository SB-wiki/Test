
## Introduction
Currently, to play the contents we need to pass all the config data to the player. In this config there are some mandatory and options fields. This wiki explains those mandatory and optional fields.

[KN-63 System JIRA](https:///browse/KN-63)


## PDF player configuration
The following configuration is required to play the pdf content in player


1. context(Optional) : Additional data to the content


1. config (Optional) : Config object data to content play


1. metadata (Required) : Metadata gives a complete information about the content.




```
pdfPlayerConfig = {
    context?: Context;
    config?: Config;
    metadata: {
      _metadataObject_    // Some of the metadata fields are required. Mentioned in below 3.Metadata section
    }             
}
```
1. Context (Optional): Context is an optional property for player config, if we want to send the context - the following table shows what are the fields is required to send the context.

Sample context object interface:
```
{
      mode?: string;
      authToken?: string;
      sid?: string;
      did?: string;
      uid?: string;
      channel: string;
      pdata: Pdata;
      contextRollup?: ContextRollup;
      tags?: string[];
      cdata?: Cdata[];
      timeDiff?: number;
      objectRollup?: ObjectRollup;
      host?: string;
      endpoint?: string;
      dispatcher?: object;
      userData?: {
          firstName?: string;
          lastName?: string;
      };
}
```




|  |  **Property name**  |  **Description**  |  **Optional/Required**  |  **Without field**  |  **Comment**  |  **Default**  |  **Code changes required**  | 
|  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
| 1 | channel | it is an string containing unique channel name. | Required minLength=1 | telemetry validation error | Default can be set from player side.   _Telemetry sdk will set by default_  “in.ekstep" | "in.ekstep" | Yes | 
| 2 | env | It is an string containing Unique environment where the event has occurred | Required | telemetry validation error | Content player set it by default to “contentplayer" | "contentplayer" | No | 
| 3 | pdata | Producer data. It is an object containing id, version and pid. | Required
```
{
	id: "in.ekstep",
	ver ? : "1.0",
	pid ? : ""
}
```
 | telemetry validation error | Default can be set from player side.   _Telemetry sdk will set by default_ { id: "in.ekstep", ver: "1.0", pid: "" } | { id: "in.ekstep", ver: "1.0", pid: "" } | Yes | 
| 4 | mode | To identify preview used by the user to play/edit/preview | Optional | "play" |  _Telemetry sdk will set by default_  as "play" | "play" | No | 
| 5 | sid | It is an string containing user session id. | Optional | sid = uid   |  _Telemetry sdk will set by default_  as "uid" | "uid" | No | 
| 6 | did | It is an string containing unique device id. | Optional | It will generate from telemetry sdk |  _Telemetry sdk will set by default_   using fingerPrintJs | [fingerPrintjs2](https://github.com/Valve/fingerprintjs2) | No | 
| 7 | uid | It is an string containing user id. | Optional | actor.id = did ? did : "anonymous"  |  _Telemetry sdk will use_ did _as default_  | "anonymous" | No | 
| 8 | authToken | It is an string to send telemetry to given endpoint (API uses for authentication) | Optional | show warning in console | Player will set default "" | "" | Yes | 
| 9 | contextRollup | Defines the content rollup data | Optional | {} | Its a optional field in telemetry | {} | No | 
| 10 | objectRollup | Defines the content object data | Optional | {} | Its a optional field in telemetry | {} | No | 
| 11 | tags | It is an array. It can be used to tag devices so that summaries/metrics can be derived via specific tags. Helpful during analysis | Optional | \[] | Its a optional tags data | \[] | No | 
| 12 | cdata | It is an array. Correlation data. Can be used to correlate multiple events. Generally used to track user flow | Optional
```
[ {"type", "id"}] 
```
 | \[] | This is an optional but - if we are passing the type and id is required. | \[] | No | 
| 13 | host | It is an string containing API endpoint host. | Optional | "" | Content Player set it as "" and  _Telemetry sdk will set by default_  as “https://api.ekstep.in" | “https://api.ekstep.in“ | No | 
| 14 | endpoint | It defines the endpoint | Optional | "" | Content Player set it as “/data/v3/telemetry“ | /data/v3/telemetry | No | 
| 15 | userData | Defines the user first name and last name | Optional | User first and lastname will not show in endpage | Default can be set from player side. | 
```
{ "firstName": "anoymous","lastName": ""}
```
 | Yes | 
| 16 | dispatcher | Dispatcher is required to receive the player events. . | Optional | The parent will not see the player events. | 
```
dispatcher: {
        dispatch(event) {
          console.log(`Events from dispatcher: ${JSON.stringify(event)}`);
        }
      }
```
 | "" | No | 


### 2. Config (Optional)
All the configuration can be set by default from player side so this config object can be optional

sample config object interface:
```
"config"?: { 
    "sideMenu"?: { 
      "showShare"?: boolen; // show/hide share button in side menu. default value is true
      "showDownload"?: boolen; // show/hide download button in side menu. default value is true
      "showReplay"?: boolen; // show/hide replay button in side menu. default value is true
      "showExit"?: boolen; // show/hide exit button in side menu. default value is false
      "showPrint"?: boolen; // show/hide print button in side menu. default value is true
    }
  }
```


|  **Property name**  |  **Description**  |  **Optional/Required**  |  **Default**  | 
|  --- |  --- |  --- |  --- | 
| share | It is boolen value to show and hide share button in sidemenu | optional | true | 
| download | It is boolen value to show and hide download button in sidemenu | optional | true | 
| print _(only for pdf, epub)_  | It is boolen value to show and hide print button in sidemenu | optional | true _(only for pdf, epub is true)_  | 
| reply | It is boolen value to show and hide reply button in sidemenu | optional | false | 
| exit | It is boolen value to show and hide exit button in sidemenu | optional | false | 


### 3. Metadata (Required)
Metadata gives a complete information about the content.

Based on the isAvailableLocally property player will be playing the content online or offline.

Sample metadata object interface:
```
"metadata": { 
    "identifier": string;
      "name": string;
      "artifactUrl": string;
      "streamingUrl"?: string;
  }
```


In metadata the following properties are mandatory to play the content in  **ONLINE play** .



|  **Property name**  |  **Description**  |  **Without field**  |  **optional/Required**  |  **Comment**  | 
|  --- |  --- |  --- |  --- |  --- | 
| identifier | It is string of uniq content id | Unable to load the content error | Required | Its a unique content id so Its a required to log the telemetry and other data against contnet | 
| Name | It is string to represent the name of the content or pdf | Unable to load the content error | Required | Its a required to show the name of the pdf while loading the pdf. | 
| streamingUrl | It is string url. |  Unable to load the content error | Required but optional if the artifactUrl is present | It is optional field. This is required if you want to load the streaming pdf url | 
| artifactUrl | It is a string url | Unable to load the content error | Required but optional if streamingUrl is preset | It is required to load the pdf file. | 
|  |  |  |  |  | 



Sample metadata object interface in offline play:
```
"metadata": { 
    "identifier": string;
      "name": string;
      "artifactUrl": string;
      "basePath": string; // should requird to play offline
      "baseDir?": string;
      "streamingUrl"?: string;
  }
```


Following properties are mandatory to play the content  **OFFLINE play** .



|  **Property name**  |  **Description**  |  **Without field**  |  **Optional/Required**  |  **Comment**  | 
| baseDir | It is string to represent the base path of the pdf file | Required but optional if basePath is present | It is required to load the pdf file. | 
|  --- |  --- |  --- |  --- |  --- | 
|  --- | 
| Name | It is string to represent the name of the content or pdf | Unable to load the content error | Required | Its a required to show the name of the pdf while loading the pdf. | 
| isAvailableLocally | It is a boolen value which indicate the content is locally available  | Content will not load offline | Required | It is required to know - the content is downloaded and can be play offline | 
| artifactUrl | It is a string url |  Unable to load the content error | Required | It is required to load the pdf file. | 
| basePath | It is string to represent the base path of the pdf file | Unable to load the content error | Required but optional if baseDir is present | It is required to load the pdf file. | 
| baseDir | It is string to represent the base path of the pdf file | Required but optional if basePath is present | It is required to load the pdf file. | 





*****

[[category.storage-team]] 
[[category.confluence]] 
