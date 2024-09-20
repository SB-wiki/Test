# \[Design]-Beacon-events-for-logging-large-telemetry-error-data

**Introduction** This wiki exlplains about the use of Beacon events to log sunbird telemetry error data.

**Background** Logging error telemetry need to be made effective by sending only error message to telemetry error API and rest of the error stacktrace should be logged through Beacon APIs.

**Problem Statement**  At present incase of any error we are logging entire error object data which includes error message and stacktrace in telemetry error event.Sometimes the size of the stacktrace is large which creates the load in the telemetry APIs.If we are not logging the stacktrace it will be diffcult to track the error with only error messages and also we need to reproduce the error inorder to fix it.

**Solution #1** This solution involves following steps:

Log Telemetry error event with stacktrace error object data and send remaining info through beacon API

When there is an error which needs to be logged ,send telemetry event with event object similar to the one below,

```js
{
  "edata": {
    "err": "", // Required. Error code
    "errtype": "CONTENT", // Required. Error type classification - "SYSTEM", "MOBILEAPP", "CONTENT"
    "stacktrace": {"id":MID,"message":"stack trace message"}, // Required. Detailed error data/stack trace
    "pageid": "", // Optional. Page where the error has occured
    "object": OBJECT, // Optional. Object on which the error occured
    "plugin": PLUGIN // Optional. Plugin in which the error occured
  }
}
```

As per above exmple the stacktrace object should contains 2 values **id**  and **message** .The **id**  should be the message-id(mid) and **message**  should be the error message.Now once the error telemetry is logged,we should send the entire stacktrace to beacon API.

**Solution #2** This solution involves following steps:

Log Telemetry error event with only error message

When there is an error which needs to be logged ,send telemetry event with event object similar to the one below,

```js
{
  "edata": {
    "err": "", // Required. Error code
    "errtype": "CONTENT", // Required. Error type classification - "SYSTEM", "MOBILEAPP", "CONTENT"
    "stacktrace": "stack trace error message", // Required. Detailed error data/stack trace
    "pageid": "", // Optional. Page where the error has occured
    "object": OBJECT, // Optional. Object on which the error occured
    "plugin": PLUGIN // Optional. Plugin in which the error occured
  }
}
```

Send error Stacktace Info to Beacon API The beacon request structure should be gnerated  like the following format,

```js
{
 "request": {
  "id": UUID, //optional
  "mid": MID,
  "type": "error",
  "subtype": "", //optional
  "data": "Error: no content found!
    at http://localhost:3000/app/scripts/framework/service/content-service.js:144:15
    at Object.ajaxSettings.success (http://localhost:3000/app/scripts/framework/service/iservice.js:44:4)
    at i (http://localhost:3000/app/bower_components/jquery/dist/jquery.min.js:2:27983)
    at Object.fireWith [as resolveWith] (http://localhost:3000/app/bower_components/jquery/dist/jquery.min.js:2:28749)
    at A (http://localhost:3000/app/bower_components/jquery/dist/jquery.min.js:4:14203)
    at XMLHttpRequest.<anonymous> (http://localhost:3000/app/bower_components/jquery/dist/jquery.min.js:4:16491)",
   "ver": 1.0,
   "message": "", //optional
   "ets": 1553249142215
  }
}


```

Here in above example, the value of the param **mid**  should be the MID generated in previous step for telemetry error event ,and by using the same id as part of beacon data we can able to correlate both the logged telemetry error data and subsequent stacktrace send through beacon API.

Editor/Player Side Implementation

We need to implement a library called  **BeaconServiceLibrary** which should expose the method to send beacon message by processng the input js object.

```js
org.ekstep.services.BeaconServiceLibrary = new (org.ekstep.services.iService.extend({
 url:'beacon_api_endpoint',
 sendBeaconEvent : function(eventObject){  
  var data = { request: {
    "id": UUID,
    "mid": eventObject.mid,
    "type": eventObject.type,
    "subtype": eventObject.subType, //optional
    "data": eventObject.data,
   	"message": eventObject.message, //optional
    "ets": 
  }};
  navigator.sendBeacon(this.url,data);
 }
})
```

The url param of above example is the beacon endpoint url which should be provided by configuration or context data.

**Conclusion** Hence we can reduce the size of error telemetry data with the help of Beacon APIs.Also the stacktrace which will be helpful to track the error occurence also logged.

***

\[\[category.storage-team]] \[\[category.confluence]]
