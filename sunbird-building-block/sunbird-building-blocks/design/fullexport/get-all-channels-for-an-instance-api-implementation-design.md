# Get-all-Channels-for-an-instance---API-Implementation-Design

There should be an API available to get all the available channels of an instance which will be helpful for effective content filtering based on channels.

The request structure of the api should be like below:

\*\*POST   \*\* _/v1/channel/list_

```
{
 "request" : {
  "status" : "all" // possible values can be 'active' , 'all' 
 }
}
```

Api should return the response similar to following format&#x20;

```
{
  "result" : {
    "response": "SUCCESS",
    "channels" : ['channel1','channel2','channelN']
  }
}
              
```

Note:

If the user needs only the active channels, he can set the 'status' value to 'active' in the request ,but it will impact on the content filtering scenarios.

***

\[\[category.storage-team]] \[\[category.confluence]]
