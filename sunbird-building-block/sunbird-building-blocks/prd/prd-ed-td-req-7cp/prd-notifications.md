# PRD---Notifications

IntroductionNotifications are an excellent way of giving users external reminders to open the app. While intrinsic motivation to use the app is always preferred, in the early days of usage, external motivation is usually required to build the habit of usage. One scalable form of doing so is by using notifications.

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* As a user, I'd like learn/teach better, which is why I installed the Sunbird app in the first place. However, I would like some help to ensure I continue to use it.
* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  Mostly at home.

Mobile push notifications overviewThe following section primarily deals with setting up of mobile push notifications (specifically on Android, for now).

Mobile notifications - Overall Process Workflow

1. As a user, I install the application and launch it.
2. The device registers with Sunbird servers to receive notifications from the latter. Any permissions needed to enable this are requested from the user.
3. The device requests to listen on particular topics, to receive broadcast notifications.
4. Whenever the Sunbird instance wishes to broadcast notifications to a topic, all devices subscribed to it are informed.
5. Whenever the Sunbird instance wishes to send notifications to a target set of devices, only those devices will be informed.
6. In the cases above, my notifications are maintained in a notifications drawer that I can access at any time from the app.
7. I also can see a notification banner for every new notification that I'm receiving from the Sunbird service.
8. From time to time, renewal of device registration with Sunbird servers to receive notifications should be done.

Mobile notifications - As a Sunbird admin, I require to have the latest information to send notifications to the mobile deviceWhen the user launches the app on the mobile device, we need to send any updates to the server in order to send push notifications reliably.

Main ScenarioUser launches the mobile app, and updated notification token (if any) is shared with server.

| Srl. No. | User Action              | Expected Result                                                                                                                                                                                                                                                            |
| -------- | ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User launches mobile app | Device checks to see if the token to send notifications has expired, and sends an update accordingly.The updated token is stored in the device database, in a sufficiently encrypted/protected format.If the language in app has changed, it is stored in device database. |

Alternate Scenario 1 - User doesn't launch the mobile app, and the token expires but the local notification system is still activeWhen the local notification system is activated, the device checks if the token has expired, and if so sends the update to the server.

| Srl. No. | User Action                                                          | Expected Result                                                                                        |
| -------- | -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
|          | User doesn't act, but receives a local notification to open the app. | App wakes up, checks if the notification token has expired, and sends an update to server accordingly. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                          | Expected Handling                                                                                                                                                                                                                                                                                |
| -------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|          | App launches, but device is offline.                                                       | The app attempts to send the notification token to server, but since there's no acknowledgement - it remembers to do so when connection is established with the server.                                                                                                                          |
|          | App sends notification token update to the server, but no acknowledgement is received.     | App waits for a TTL (10 minutes for now - as app session might still be active), and tries again.                                                                                                                                                                                                |
|          | Local notification/alarm wakes the app up, but device is offline and update can't be sent. | The app waits for a TTL (randomly selected between 12-24 hours) and tries again. Using a random selection, since the server can get flooded with update calls since almost all mobile devices are synced to the right time and the local notification can happen for all devices simultaneously. |
|          | App language was sent to server, but no acknowledgement was received.                      | The app waits until it is launched again, and resends the app language to the server.                                                                                                                                                                                                            |

WireframesN/A

For Future ReleaseBunching of notifications into a single summary notification to be displayed within the Android notifications drawer.

JIRA Ticket ID[SB-12276 System JIRA](https://browse/SB-12276)

Mobile notifications - As a Sunbird admin, I should be able to broadcast a notification to usersAs a Sunbird admin, there might be important information that needs to be broadcast to all users (e.g. Sunbird instance will be down next week between 9-11 AM). I should be able to inform all users about it.

Main ScenarioSunbird admin sends the broadcast notification to all users.

| Srl. No. | User Action                                                                   | Expected Result |
| -------- | ----------------------------------------------------------------------------- | --------------- |
|          | Admin uploads parameters for the notification in various supported languages: |                 |

1. Title
2. Body
3. Icon (optional)
4. Banner image (optional)
5. Action link (optional)
   1. Update app - Play Store link
   2. Course registered/started - Course ID
   3. Try content - Content ID
   4. Book updated - Book ID
   5. FAQ updated - FAQ page(+section ID)
   6. Survey request - Google Form link ( **EXTERNAL URL** )
   7. Informational video - YouTube link ( **EXTERNAL URL** )

\| Notification (payload) is ready and validated. | | | Sunbird admin sends broadcast notification on a topic | All devices subscribed to that topic should receive the notification, in their app language.Sunbird admin gets mail with the details of the target audience, and notification payload along with notification ID. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                        | Expected Handling                                                                                            |
| -------- | -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
|          | Notification is sent, but device is offline.                                                             | No action needed as this is handled automatically by GCM (until expiry of message).                          |
|          | Notification is sent, but sending fails (due to expired message, since device was offline for too long). | No action for now. We'll consider handling this in a later release.                                          |
|          | Notification is sent, but sending fails (due to expired token)                                           | No action for now. Device sends updated token at next launch, and notifications after that should work fine. |

WireframesAttach wireframes of the UI, as developed by the UX team for screens required for this story  &#x20;

For Future ReleaseN/A

JIRA Ticket ID[SB-10684 System JIRA](https://browse/SB-10684)

Mobile notifications - As a Sunbird admin, I should be able to target notifications to a set of users (v1)As a Sunbird admin, there might be important information that needs to be broadcast to a subset of users (e.g. Specific tenant users can now access Courses from dd-mmm). Only these users should be informed.

Main ScenarioSunbird admin sends the broadcast notification to all users.

| Srl. No. | User Action                                                       | Expected Result                                     |
| -------- | ----------------------------------------------------------------- | --------------------------------------------------- |
|          | Sunbird admin opens the Notifications UI.                         | Admin sees the various filters that can be applied. |
|          | Admin selects applicable filters, under the following categories: |                                                     |

1. Origin
   1. User account that uses this device
   2. Board
   3. Medium
   4. Class
   5. User-type
   6. Guest
   7. Teacher
   8. Student
   9. SignedIn
   10. Teacher
   11. Others
   12. State Signed In
   13. Geolocation
2. Dates
   1. First seen date (age of device)
   2. Last seen date OR&#x20;
3. User enters a list of comma separated device ids in a textbox.

\| Admin sees count of devices that match such a criteria. | | | Admin uploads parameters for the notification in various supported languages (similar to broadcast notification popup). | Notification (payload) is ready and validated. | | | Sunbird admin sends notification to target devices. | All target devices should receive the notification.Sunbird admin gets mail with the sender account of the notification, (filter details for the target audience) or (count of specific devices that were targeted), and notification payload along with notification ID.  | | | Sunbird admin requests for report for a notification ID. | Sunbird admin sees the notification ID, count of targeted unique devices, (latest count of) unique devices that were sent the notif, (latest count of) unique devices that received the notif, (latest count of) unique devices that launched app with the notif, (latest count of) unique devices that interacted with the notif via the in-app UI. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                             | Expected Handling                                                                                                                                        |
| -------- | ----------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Profile on device had other details, but wasn't synced as device was offline.                                                 | Notification is delivered anyway. The profile details are updated when new telemetry is received at server.                                              |
|          | Same logged in profile / guest profile is seen on multiple devices.                                                           | Latest device where user profile is seen receives the message.                                                                                           |
|          | Someone other than a Sunbird admin (without the required role) attempts to send a notification by visiting the page.          | The user sees an 'Access denied' page, and no notification can be sent by this user.                                                                     |
|          | Sunbird admin resends the notification with the same notification ID (with or without a change in payload, or target devices) | The notification gets replaced in end-users devices, and the in-app notification shows the updated notification, and not multiple versions of the notif. |

Wireframes[https://projects.invisionapp.com/share/4JTS64MHXBY#/screens/383165425](https://projects.invisionapp.com/share/4JTS64MHXBY#/screens/383165425)

For Future ReleaseAutomatic setting up of push notifications to target devices (E.g. sending notifications on day after install / one week after install)

JIRA Ticket ID[SB-10685 System JIRA](https://browse/SB-10685) [SB-14339 System JIRA](https://browse/SB-14339)

Mobile notifications - As a Sunbird admin, I should be able to target notifications to a set of users (v2)As a Sunbird admin, there might be important information that needs to be broadcast to a subset of users (e.g. Specific tenant users can now access Courses from dd-mmm). Only these users should be informed.

Main ScenarioSunbird admin sends the broadcast notification to all users.

| Srl. No. | User Action                                                       | Expected Result                                     |
| -------- | ----------------------------------------------------------------- | --------------------------------------------------- |
|          | Sunbird admin opens the Notifications UI.                         | Admin sees the various filters that can be applied. |
|          | Admin selects applicable filters, under the following categories: |                                                     |

1. Origin
   1. User account that uses this device
   2. Board
   3. Medium
   4. Class
   5. User-type
   6. Guest
   7. Teacher
   8. Student
   9. SignedIn
   10. Teacher
   11. Others
   12. State Signed In
   13. Geolocation
2. Dates
   1. First seen date (age of device)
   2. Last seen date OR&#x20;
3. User enters a list of comma separated device ids in a textbox.

\| Admin sees count of devices that match such a criteria. | | | Admin uploads parameters for the notification in various supported languages (similar to broadcast notification popup). | Notification (payload) is ready and validated. | | | Sunbird admin sends notification to target devices. | All target devices should receive the notification.Sunbird admin gets mail with the sender account of the notification, (filter details for the target audience) or (count of specific devices that were targeted), and notification payload along with notification ID.  | | | Sunbird admin requests for report for a notification ID. | Sunbird admin sees the notification ID, count of targeted unique devices, (latest count of) unique devices that were sent the notif, (latest count of) unique devices that received the notif, (latest count of) unique devices that launched app with the notif, (latest count of) unique devices that interacted with the notif via the in-app UI. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                    | Expected Handling                                                                                           |
| -------- | -------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
|          | Profile on device had other details, but wasn't synced as device was offline.                                        | Notification is delivered anyway. The profile details are updated when new telemetry is received at server. |
|          | Same logged in profile / guest profile is seen on multiple devices.                                                  | Latest device where user profile is seen receives the message.                                              |
|          | Someone other than a Sunbird admin (without the required role) attempts to send a notification by visiting the page. | The user sees an 'Access denied' page, and no notification can be sent by this user.                        |
|          |                                                                                                                      |                                                                                                             |

WireframesAttach wireframes of the UI, as developed by the UX team for screens required for this story  &#x20;

For Future ReleaseAutomatic setting up of push notifications to target devices (E.g. sending notifications on day after install / one week after install)

JIRA Ticket ID

Mobile notifications - As a user, I should receive a notification on my deviceAs a user, I would like to be notified when there's an important update from the Sunbird instance I use. I might also welcome the occasional nudges to try out new and exciting content, or information about new app versions that are available.

Main ScenarioUser receives a notification from server.

| Srl. No. | User Action                                                                                                                                                                              | Expected Result            |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
|          | <p>(Optional) User notices new notification in mobile notifications drawer. This can include:</p><ul><li>Icon</li><li>Text</li><li>Banner image</li><li>Action Bar (, DETAILS)</li></ul> | User taps on notification. |
|          | User taps on:                                                                                                                                                                            |                            |

1. General notification body
2. Action bar ( button)
3. Action bar (DETAILS button)

\| As per action:

1. User is taken to the notification panel inside app, and the corresponding notification is highlighted.
2. User is directly taken to the action (e.g. App on Play Store page, content details page, courses page, External URL etc.)

\| | | If the user doesn't arrive via the device notifications drawer, then the user launches the app. | User sees the notification icon highlighted. | | | User taps on notification icon. | User sees the latest new notifications.Whenever user closes the notification panel, all indications of new notifications are removed and they are marked as read. | | | User taps on a notification that has an action associated (or directly on the action itself) | User takes the action (e.g. goes to Play Store, content details/courses page, External URL etc.) | | | User swipes left/right on notification | Notification is removed from inside the app drawer. | | | User taps on 'Clear' on top of notification panel. | All notifications are cleared from device. If any are there in the Android notifications drawer, those are also removed. | | | User presses back button (on device/screen), or taps on bottom nav bar. | Notification panel is closed (and if bottom tab is tapped, that is opened). |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                                                                             | Expected Handling                                                                                                                                                                                                                                                                                                                          |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|          | User is on an older version of Android, which requires permission to be requested.                                                                                                            | The user sees a permissions info popup mentioning why notifications are useful, and the general permissions flow comes into effect.If user denies permission, the notification token is not updated on server side and the device can't be contacted. (This can also happen if user disables notifications from the Android app settings). |
|          | User receives multiple notifications with the same content                                                                                                                                    | Only the latest version should be kept.                                                                                                                                                                                                                                                                                                    |
|          | User receives an erroneous notification (assume spelling mistake), and later receives the correct notification (I'm assuming we have some sort of notification IDs to fix old notifications). | The updated notification is only kept on the device.                                                                                                                                                                                                                                                                                       |
|          | User sends a notification by mistake, and then sends a blank notification (with the same notif ID) to remove it.                                                                              | The notification doesn't show up in the app's notification drawer.                                                                                                                                                                                                                                                                         |
|          | User receives an erroneous notification, then goes offline (during which the corrected notification arrives).                                                                                 | User sees the erroneous notification.When they go online, they will see an updated notification in their notification panel - which shows the corrected notification (erroneous notification has been updated).                                                                                                                            |

Wireframes[https://zpl.io/VqlB7Qm](https://zpl.io/VqlB7Qm)

For Future ReleaseN/A

JIRA Ticket ID[SB-12278 System JIRA](https://browse/SB-12278)

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element   | Description                                     | Language(s)/ Locales Required                     |
| ------------ | ----------------------------------------------- | ------------------------------------------------- |
| Notification | Notification title, message, action items, icon | Relevant languages supported by Sunbird instance. |
|              |                                                 |                                                   |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                             | Description                                                                   | Purpose                                       |
| -------------------------------------- | ----------------------------------------------------------------------------- | --------------------------------------------- |
| Notification received (client, server) | This is used to track that notification was received on device.               | So we can see % of devices that get notified. |
| Notification not delivered (server)    | This is used to understand why the notification wasn't successfully delivered | % of devices that have various issues:        |

1. Time out of notification send
2. Delivery token has expired
3. User has uninstalled app
4. Others

\| | Launch via notification (client) | Used to track how often users launch the app via the Android notification | % of users who launch via notifications | | Action via notification (client) | Used to track how often users take the direct action via the Android notification | % of users who take direct action via Android notif. | | More details via notification (client) | Used to track how often users want to see more before they act. | % of users who want further details from Android notif. | | Tap on notification icon in app (client) | To see how often users pay attention to it (addn params: icon highlighted or not) | % of users who tap on the notifications icon in app | | Tap on CTA in the notification (client) | To see how often users act on notifications (addn params: tap on notif general body, or on CTA bar) | % of users who act on CTA requested | | Notification panel closed | To see how users close the notifications panel (addn params: tapping back, device back, tap on specific tab (e.g. library/courses etc.) | % of users who leave notifications tab via the different means | | Notification cleared | To see how often users clear notification by swiping (addn params: left , right swipe) | % of users who clear notifications by swiping. | | All notifications cleared | To see how often users clear notifications by doing a blanket sweep | % of users who clear all notifications at one shot. | | | | | | **Server Telemetry requirements** | | | | Visited notification page | To see how often notification page is visited by admins | | | Initiated notification type (broadcast/targeted), new or revised (if revised, provide notif ID) | To see what type of notification is initiated more (addn params: notif ID, broadcast / targeted) | | | Provided target filters for targeted notif | To see what % of the total audience are targeted (addn params: notif ID, filter selected params, count of target audience) | | | Provide channel(s) for broadcast notif | To see what % of total audience can received the broadcast (addn params: notif ID, channel list) | | | Image successfully uploaded for notif | To know the type of notif that's being sent out (addn params: notif ID, banner/thumb, language) | | | Notification payload finalized | To know the details of a notif that's about to be sent out (addn params: notif ID, type of notif (text | thumb | banner), text of notif, CTA text, addn info (e.g. content ID, URL etc.) ) | | | Notification sent | To know when notification was sent (addn params: notif ID) | | | | | |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                | Load/Volume Requirements                                                                          | Security / Privacy Requirements                                                                 |
| -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| Push notification messages should not expire upto 2 weeks (\~95% of devices come online within 2 weeks). | Platform should be able to handle upto 20% of total active installs coming online within an hour. | Push notification tokens to be sufficiently encrypted as these constitute personal information. |
| Notifications that are older than 3 months are automatically discarded.                                  |                                                                                                   |                                                                                                 |

Impact on other Products/Solutions

| Product/Solution Impacted | Impact Description                                                                                                 |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| Sunbird mobile app        | More notifications that are sent, the potential to flood the mobile app with notifications.                        |
| Sunbird server            | When broadcast notifications are sent, many users might open the app and cause a flood of requests on the servers. |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted | Impact Description                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------- |
| Existing users     | Users will begin to receive push notifications, and see a notifications panel within the app. |
| Existing users     | Users might be asked for additional permissions if notifications permission is needed.        |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                          | Purpose of Metric                                                                                            |
| -------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------ |
|          | Notification sending funnel     | This is used to understand what % of notifications are being successfully delivered to the audience.Notif ID |
|          | Notification consumption funnel | This is used to understand what % of delivered notifications are resulting in the intended output.Notif ID   |

***

\[\[category.storage-team]] \[\[category.confluence]]
