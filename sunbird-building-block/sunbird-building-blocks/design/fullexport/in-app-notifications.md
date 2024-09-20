# In-app-notifications

**Problem Statement:** The broadcast message at the app launch will be used in the below following cases for ex -

Examples of use:

1. When Sunbird instance goes down, show a message about (the reason and) when it's going to come back up.
2. When Sunbird instance is going through a lot of issues, a message informing users about what the ongoing activity.
3. A general wishing the user about a festive day (e.g. Happy Diwali, Eid Mubarak, Merry Christmas etc.)
4. There can be other instances as well, where the need for usage of this feature can be used.

**Proposed Solution:**

1. The poll based approach was discarded because the app would poll every time an endpoint and check for the status of the system. It was discarded because it does not provide the handy features as provided by FCM, which is discussed in the below point.
2. FCM - With FCM there are many advantages which helps to build our requirement in a handy way -

* With FCM users can register and unregister to a topic.
* For our requirement, we can have users by default registered to one topic which can be called as “General”
* And also there can be other topics which users can register based on their needs.
* With FCM we can send messages which can be displayable or non-displayable, which will depend on the flag the payload contains.  &#x20;
* Non-displayable payloads could be for the app side to enable/disable a feature for a particular group of users, could be used for A/B testing.
* Using FCM we can set TTL for a message.
* For the users in the offline state would receive the notification when they come online and won't receive if the TTL is expired.

**Caveat:**

1. If the user registers to FCM after the message has been broadcasted then the new user will not get the notification that was sent before. The solution for this may be, the server can run a cron job for repeatedly sending messages

\*\*Discussion - \*\*

1. There will be tenant/channel based topics subscribed by the client.
2. By default, all clients subscribe to one topic.
3. And below will be the structure of payloads.

**Payload for display messages:** {

"actiontype": "display",

"notificationtype": "general/festive/downtime/others",

"notificationid": "1235",

"expiry": "34646millis",

"type": "cancellable/non-cancellable",

"channel": "channel-id",

"poster": "image-url",

"fields": \[

{

"language": "en",

"title": "Welcome to Sunbird!",

"msg": "Congratulations on downloading Sunbird, every child's best friend in their learning journey."

},

{

"language": "hi",

"title": "Welcome to Sunbird!",

"msg": "Congratulations on downloading Sunbird, every child's best friend in their learning journey."

}

]

}

**Payload for non-display messages:** {

"actiontype": "non-display",

"notificationtype": "enable-feature/disable-feature",

"notificationid": "1235",

"expiry": "34646millis",

"data": "free form string data"

}

```java
{
"id": "", // integer number
"type": "", // downtime - 1 / others - 2
"epoch": "", // This will be present only for server notifications, and 2016-08-29T02:40:33+0530 will be the format
"expiry": "", // This will be present only for server notifications and specified in minutes
"relative":, // This will be present only for local notification and it will be mentioned in integer, which specify number of hours after installation of app 
"poster": "", // Image URL for display
"actiondata": "", // Action data contains anything that is not present in the above parameters, like is the notification to be displayed or not, can be cancelled or not and any other data to be passed 
"translations": {
"en":{
"title": "Welcome to Sunbird!",
"msg": "Congratulations on downloading Sunbird, every child's best friend in their learning journey."
},
"hi":{
"title": "Welcome to Sunbird!",
"msg": "Congratulations on downloading Sunbird, every child's best friend in their learning journey."
}
}
}
```

After brainstorming and design discussion, the below JSON structure for notifications is agreed upon.

```
{
"id": 1, // id of the notification will be integer, which will be unique 
"type": 1, // Notification type will be integer - Their can different notification types, like DOWNTIME, GREETINGS, NON-DISPLAY and OTHERS 
"relativetime": 2, // Relative time will be integer and only for the Local notification to be shown from Mobile side, it will not be present in Server notification and it will be mentioned in integer, which specify     number of hours after installation of app, the notification has to be shown
"epoch":"", // Epoch will be present only for Server notifications, and the format of the epoch will be 2016-08-29T02:40:33+0530 
"expiry":"", // Expiry will be present only for Server notification, and it will be mentioned in integer, which specify number of minutes after the epoch time, notification expires
"actiondata":{} // action data contains all the information related to type of the notification, like poster url, translations, notification title
}
```

The data received in the **actiondata** will be with respective to the type of the notification, example, if the type is DOWNTIME, the client would expect the keys relevant to the DOWNTIME type of notification.

[https://projects.invisionapp.com/share/7BO6N68STCM#/screens/321764335](https://projects.invisionapp.com/share/7BO6N68STCM#/screens/321764335)&#x20;

[https://github.com/ekstep/Common-Design/wiki/Firebase-Cloud-Messaging(FCM)-Integration-with-sunbird](https://github.com/ekstep/Common-Design/wiki/Firebase-Cloud-Messaging\(FCM\)-Integration-with-sunbird)

[https://docs.google.com/document/d/1Nlt8TJFEgiJ4J0XMjgbvJnzyz0N0kY5yo4yYNN0reRI/edit#heading=h.qk7vq07zcl5t](https://docs.google.com/document/d/1Nlt8TJFEgiJ4J0XMjgbvJnzyz0N0kY5yo4yYNN0reRI/edit#heading=h.qk7vq07zcl5t)

&#x20;&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
