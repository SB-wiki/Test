# SB-16500-Design-document-for-sending--certificate-of-achievement--notification-in-user-service

* [Problem statement:](sb-16500-design-document-for-sending-certificate-of-achievement-notification-in-user-service.md#problem-statement:)
* [Solution](sb-16500-design-document-for-sending-certificate-of-achievement-notification-in-user-service.md#solution)
* [Solution](sb-16500-design-document-for-sending-certificate-of-achievement-notification-in-user-service.md#solution)
* [Solution 3: ](sb-16500-design-document-for-sending-certificate-of-achievement-notification-in-user-service.md#solution-3: )

### Problem statement: [SB-16500](https://project-sunbird.atlassian.net/browse/SB-16500)

Currently with the user-service we are able to send notifications to either mobile or email but not both. Now we need to send notifications to email and mobile if the user contains both.

Endpoint : user/v1/notification/email

Request body:

```js
{
    "request": {
        "subject": "test.",
        "body": "This is to inform there is a new batch going to be started on 28/06/2019. Please login and start consuming it.This is to inform there is a new batch going to be started on 28/06/2019. Please login and start consuming it.https://dev.sunbirded.org",
        "recipientPhones": [
            "9663890445",
            "9972403110"
        ],
        "mode": "sms",
        "recipientUserIds": [
            "874ed8a5-782e-4f6c-8f36-e0288455901e"
        ]
    }
}
```

### Solution 1 :

Request body contains "mode" param.

It can be specified to value "\["sms","email","fcm","otp"]" , so system can send notifications to both mobile and email for the corresponding user, if the user contains both else it will either send notification to mobile or email which is present in the system.

Request body:

```js
{
    "request": {
        "subject": "test.",
        "body": "This is to inform there is a new batch going to be started on 28/06/2019. Please login and start consuming it.This is to inform there is a new batch going to be started on 28/06/2019. Please login and start consuming it.https://dev.sunbirded.org",
        "mode": "all",
        "recipientUserIds": [
            "874ed8a5-782e-4f6c-8f36-e0288455901e"
        ]
    }
}


```

In this case learner service it-self triggers the notifications.

| Pros                                                                                | Cons                                                                                       |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| It might be quite fast response since there will be no other network call involved. | It seems not a good approach since we already have a system which is performing this task. |

### Solution 2 :

As we have the notification-service for sending notifications, we can use the same for sending the notifications.

As soon as learner-service collects the cumulative user data for sending notifications, it can triggered to notification service which takes care for sending notifications.

We need to handle if the notification service itself is down. It can handled this by pushing this event information into kafka message system, but in this scenario system can sent as success message from learner-service. We already have a samza notification-job running which will take care of processing this request.

| Pros                                                                                                              | Cons                                                                                               |
| ----------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| It is good for maintainability since everything regarding notification is centralised in the notification service | It might be little delay but ok, since an extra network call is needed to send actual notification |
| It has retry mechanism since it have Kafka support.                                                               | Need to handle if the notification-service is down.                                                |
|                                                                                                                   | learner-service need to make two call                                                              |

1. For sending email notification
2. For sending sms notification

|

### Solution 3:&#x20;

&#x20;Currently course service is making call to send notification. Same service can make two api call one for sending email based notification and another sms based notification.

| Pros                                                                                     | Cons                                                                            |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| Minimal changes required by user-service , they need to add new email/sms template only  | Caller need to make two call of same endpoint , by passing different attribute. |
|                                                                                          |                                                                                 |

Other observations:

As of now we are using same endpoint for sending notifications to mobile and email, but the endpoint giving a wrong picture "user/v1/notification/email" as it is mean to send notification to email but we using this same for sending notifications to mobile also.

It will be better if we use "user/v1/notification" with param mode with following values

mode: "sms" for sending sms to mobile

mode: "email" for sending emails

mode: "email, sms" for sending notifications to both email/mobile

***

\[\[category.storage-team]] \[\[category.confluence]]
