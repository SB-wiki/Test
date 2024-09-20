# Trace-ability-of-request-across-subsystems

#### Problem Statement

There should be a way to filter a user request across subsystem. Currently there is no consistent and unified way to filter a particular request across subsystem. This makes it difficult to trace a particular request once it leaves sunbird.&#x20;

[SB-10762 System JIRA](https://browse/SB-10762)

#### Solution Approach&#x20;

To enable filtering of logs across subsystem there must be a way to pass and receive a unique id in headers for all the REST call by the sunbird to other system (ex. content-service). Additionally any incoming call should also be logged for that particular header to make it consistent and for the logs to be filterable.

The header field should be embedded in all subsequent logs by all subsystems.

#### &#x20;Problem Statement&#x20;

What header fields can be used for tracing a request.

#### Solution Approach&#x20;

Below are the two headers which would be used for tracing

* X-Device-ID  (currently in use)
* X-Log-Level  (new)
* X-msgid (existing)

\*\*X-Device-ID \*\*

Requests coming into sunbird has X-Device-ID in the header, This header value would be attached to request context and will be printed in all the logs for request as the field ' _did_ '.

falseexample\[play] {"eid":"BE\_LOG","ets":1556861743364,"mid":"Sunbird.1556861743364.61994a57-9c67-4ab5-b221-c31b1d91fb8d","ver":"1.0","context":{"pdata":{"ver":"1.0","id":"Sunbird"\}},"edata":{"eks":{"level":"INFO","msgId":"dfffe12b-ff84-4086-b140-2f8bc6e7c4fc","message":"BaseController:actorResponseHandler:apply: operation = textbookTocUpload","did":"device-id-12345"\}}}

Any request going outside the sunbird system should include the header X-Device-ID, so that other system and component can log it too.

**X-Log-Level**

This is a header field which if received would set the log level for the request.

It can be passed to the other systems in the header for any outbound request.

The concern with including this header is that it can be misused to generate immense amount of unnecessary logs. This concern can be mitigated by controlling it's implementation based on some environment variable.

**X-msgId** &#x20;

X-msgId if not received from header is generated as UUID and is used to uniquely identify the logs of request within sunbird. This is already printed in log as ' _msgId_ ' .

It can also be passed in the header for outgoing request.

#### Problem Statement

Currently logging level is being set by log4j.properties file. There should be a way to configure log level by environment variable.

#### Solution Approach

There should be an environment variable defining log level ( _sunbird\_default\_log\_level_ ) . This value will supersede the properties file level at the time of deployment.

***

\[\[category.storage-team]] \[\[category.confluence]]
