# Synchronisation-of-timestamp-param(ets)-of-telemetry-event-data-with-backend-for-Sunbird-Editors-and

### Background

With refercence to Point #13 of [SB-10789 System JIRA](https://browse/SB-10789)

We are sending timestamp parameter along with any telemetry event data(like  START,INTERACT,IMPRESSION) to log the time of occurrence of that particular event.But if the client device time is not valid or its older date same wrong time is reflecting in this timestamp data which makes the error on analysis of the system behaviour to the user at that particular moment.&#x20;

### Problem Statement

There should be an approach  to correct this timestamp error and the ets being passed should be in sync with server time, instead of sending the clients local time as ets param.This can be resolved by any of the following approaches.

## Proposed Solution:

### Solution #1: Overwriting the ets param at portal proxy level

&#x20;  As all the telemetry requests are passing through portal **('/action/data/v3/telemetry** ') we can override the ets param of request body through a middleware with portal instance local time and then forward the request to the telemetry endoint.

```js
app.all(['/content/data/v1/telemetry', '/action/data/v3/telemetry'],
  TSmiddleware.updateTimestamp,
  proxy(envHelper.TELEMETRY_SERVICE_LOCAL_URL, {
    limit: reqDataLimitOfContentUpload,
    proxyReqOptDecorator: proxyUtils.decorateRequestHeaders(),
    proxyReqPathResolver: (req) => require('url').parse(envHelper.TELEMETRY_SERVICE_LOCAL_URL + telemtryEventConfig.endpoint).path
  }))
```

```js
/** tsmiddleware.js **/
updateTimestamp: function(req,res,next){
 req.body.ets = new Date().getTime();
 next();
}
```

This solution will work for the telemetry requests passing through the portal proxy only.

### Solution #2: Fetching the initial time from server and calculate timestamp based on it

There should be some api to be added to the content service or LP which returns the current server timestamp:

```js
GET /config/v1/time
// Response data body
{
 'currentTime' : '2019-03-13 08:27:39',
 'timestamp': 1552453127008
}
```

When rendering the editor/player the above api should be called to get the servers time and a time difference should be calculated for client time and the variation should be added to global context variable(window.context.timeCorrection).So on triggering the telemetry events the ets should be calculated  based on local time and time correction value.

Hence the calculated time will be in sync with the local time.

**Conclusion**

Among the above 2 approcahes we prefer second one as the api can be reused in all client sides like portal,telemetry lib,mobile apps,editors,players etc.

***

\[\[category.storage-team]] \[\[category.confluence]]
