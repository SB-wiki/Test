# Implementation-Design-for-Notification-Service

\| 1.12.0 | | [SB-8955 System JIRA](https://browse/SB-8955) | | DRAFT | | Loganathan shanmugam

\| | [Notification Service](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/654409823/Notification+Service) | |  Loganathan shanmugam  |

| @QA                                           |
| --------------------------------------------- |
| ---                                           |
| ---                                           |
| ---                                           |
| ---                                           |
| ---                                           |
| ---                                           |
| 1.12.0                                        |
| [SB-8955 System JIRA](https://browse/SB-8955) |
| DRAFT                                         |
| Loganathan shanmugam                          |

\| | [Notification Service](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/654409823/Notification+Service) | |  Loganathan shanmugam  | | @QA |

**Implementation Architecture**

![](<../../../../Design/FullExport/images/storage/Notification-Service (5).png>)

The above figure  illustrates the components of notification service.Notification Service should be implemented with the following technical stacks:

Nodejs-Express (Typescript)&#x20;

Kafka Scheduler

Samza Processor

**Sequence Diagram**

![](<../../../../Design/FullExport/images/storage/Notifcation Scheduling & Delivery Sequence (6).png>)

**Components Description** Notification Service contains the following blocks.

* Route Handler
* Middle-ware
* Service
* Kafka Producer Adaptor&#x20;
* Templates

Route HandlerRoute handler receives the incoming request for a particular route and forwards it to service layer after validation.

MiddlewareMiddleware is responsible for validating the authorisation and  request data and should throw the error response if the request is invalid.

**Service** Service part of notification scheduler  is responsible for pushing the request data as notification messages into the Kafka queue(to specific topic based on priority) and responding the client with appropriate success message.

**Templates** Templates should be managed by Notification Service as local file or as the cloud file.Format of the template file should be json with following format:

```js
[{
"name": "WELCOME_MSG",
"templateText": "Hi $firstName ,<p> welcome to Sunbird.Please <a href='$loginLink'>Click here</a> to login to your account.</p>",
"fields":["firstName","loginLink"],
"mandatoryFields":["firstName","loginLink"]
}]] ]></ac:plain-text-body></ac:structured-macro><p class="auto-cursor-target"><br /></p><ac:structured-macro ac:name="info" ac:schema-version="1" ac:macro-id="4a65fa55-0102-4d33-9b53-e96838810436"><ac:parameter ac:name="title">**Note</ac:parameter><ac:rich-text-body><p>The templates file storage settings (cloud or local) should be configured in the environment variables.If the storage type is cloud like S3 then respective credentials for accessing them should also configured.</p></ac:rich-text-body></ac:structured-macro><p class="auto-cursor-target"><br /></p><h3><strong>Samza Stream Processor</strong></h3><p>Samza Message Processor will read messages from Kafka queue and send them with appropriate broadcast adapters (email,sms etc).Also in-case of failures in sending message it will push that  back into Kafka`s failed topics after maximum number of retries or message expiry.</p><p><strong style="font-size: 16.0px;"><br />API Specs</strong></p><p>To create a notification through notification service client should make the request in following format:</p><p class="auto-cursor-target"><br /></p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="bafdb9b1-b2ca-4ce2-bfbc-9e77f8b33297"><ac:parameter ac:name="language">js</ac:parameter><ac:plain-text-body><![CDATA[POST notification/v1/create
{
"request":
  {"recipients":["recipient_1@domain.com","recipient_2@domain.com","recipient_N@domain.com"],
   "broadcastType":"email",
  "templateName":"WELCOME_EMAIL",
  "messageData":[{"data1":"recipient_1"},{"data1":"recipient_2"},{"data1":"recipient_N"}],
  "priority": "normal" // "immediate" ,"normal"
  "expiry" : "1543395622"
  }
}
```

**Response** \*\* Success \*\*

```js
{
  "id": "sunbird.notification.create",
  "ver": "v1",
  "ts": "2018-11-28 14:25:10",
  "params": {
    "resmsgid": null,
    "msgid": "",
    "err": "",
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "id": "96ec6fa4-e8d5-4c43-b8c8-0e2dea2cd77f"
  }
}
```

\*\* Error  \*\*

```js
{
  "id": "sunbird.notification.create",
  "ver": "v1",
  "ts": "2018-11-28 14:27:37",
  "params": {
    "resmsgid": null,
    "msgid": "",
    "err": "REQUIRED_PARAMS_MISSING",
    "status": "REQUIRED_PARAMS_MISSING",
    "errmsg": "messageData is required"
  },
  "responseCode": "CLIENT_ERROR"
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
