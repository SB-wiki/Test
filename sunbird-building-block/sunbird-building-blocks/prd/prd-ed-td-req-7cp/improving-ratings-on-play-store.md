# Improving-ratings-on-Play-Store

IntroductionThe mobile app is facing a classic middle-man problem, where users associate the quality of the content inside as the quality of the app itself. They then proceed to give it a low rating on the Play Store. This can lead to a downward spiral, where a low rating tends to reduce the number of installs and users spread the message of poor quality through word of mouth.

Given that a significant number of the bad ratings are because of empty book nodes, since the latter can't be avoided due to the printing cycles - it would be good to help set expectations with end-users so they are less disgruntled and impatient with the pace of content addition to the Sunbird instance. Letting them know WHY there's so many empty nodes should help with this.

In addition, there's a large % of users who do enjoy using the app and who might not be aware that their rating is important to everyone on the Play Store (every drop counts). Bringing these users to the Play Store can help bolster the rating, and thereby improve perception of app value.

Finally, app ratings are currently hard to contextualize from the Play Console, since all app ratings are available with no information of tenant and sub-segments. Providing a means to identify a group rating within the app helps contextualize the app ratings based on user segments, and thereby identify what relief is best applied to which segment. This should help increase app quality perception amongst multiple user segments, as we cater to the specific problems that affect their group's experience.

JTBD

* \*\*Jobs To Be Done: \*\* As a Sunbird instance or tenant within, I would like to know how my users perceive the quality of my offering and improve upon it. In addition, I would like for the maximum number of users to experience our app and decide for themselves the value the app provides.
* **User Personas:**   [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  Mostly at home, likely to be a couple of days (or more) after install so as to make a proper judgment of the value within the app.

Requirement SpecificationsThis section consists of requirement specifications for specific use cases in the User JTBD. The requirements for each use case are elaborated in detail through sub-sections for:

* Use case overview
* Overall process workflow
* Associated user stories&#x20;
* Non-functional requirements
* Localization requirements &#x20;
* Telemetry requirements
* Dependencies
* Impact on other products
* Impact on existing data &#x20;

Request of app experience rating after adequate experienceWe attempt to get the user's rating of the app after they've had some time to experience the app and let us know their thoughts.

Overall Process WorkflowWe give a couple of days to the user to get a sense of the value derived from the app, and after they've performed a core action within the app (e.g. playing a content), we ask them if they wish to rate us on the store. For users who give us a poor rating (most of which is going to be related to unavailable content), we direct them to the support page - where we attempt to address their concerns. Otherwise, we send the user to the Play Store to provide a rating.

The Sunbird app admin can then analyze the average ratings of weekly/monthly installs to understand the rating provided by various user segments within the app. They can then focus on improving the experience for those user segments.

As a Sunbird app admin, I want users to give me their opinion of the app, so I can decide where to focus for a better user experience The flow would be as mentioned in the process workflow above. Users are asked to rate their experience after a predefined time duration has elapsed after their install.

Main Scenario - Rate the app after durationReplace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                                                                                                                                                                                                             | Expected Result                                                                                                                                                            |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Ram opens the app after time (For now, configure to 2 days)                                                                                                                                                                                                             | Ram will play a content                                                                                                                                                    |
|          | Ram plays a content and returns to the mobile app                                                                                                                                                                                                                       | Ram has completed a core action for which they'd opened the app. Ram is NOT shown the dialog asking for content rating.                                                    |
|          | Ram is asked if he'd like to share his app experience in a manner visually distinct from content rating popup.                                                                                                                                                          | Ram says 'Yes' instead of ('Never' or 'Later')                                                                                                                             |
|          | If Ram says 'Later', we wait again for time                                                                                                                                                                                                                             | Ram becomes more willing to rate his app experience                                                                                                                        |
|          | Ram is asked to rate his experience on a scale of 1-5                                                                                                                                                                                                                   | Ram selects a ratingRam's rating is stored in our device database.                                                                                                         |
|          | <p>If Ram provides a rating below 4, Ram is apologized to - and asked if we can help resolve his concerns with the app. There are two ways:</p><ul><li>Look at the Support FAQ, and see if there's a known answer.</li><li>Send a support request right away.</li></ul> | If Ram selects 'Support request', we initiate the 'Support request' flow with a minor change in subject to indicate that this was initiated due to the request for rating. |
|          | Ram sends the mail                                                                                                                                                                                                                                                      | We thank Ram for his support, and will reach out to him within a couple of days.                                                                                           |
|          | If Ram provides a rating >= 4, then his experience is quite good.                                                                                                                                                                                                       | We take Ram to the Play Store to share his rating with others.                                                                                                             |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                    | Expected Handling                                                                                                     |
| -------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------- |
|          | Shyam has given us a rating, and then uninstalled and reinstalled the app.           | The app identifies that this device has already provided a rating before, and therefore doesn't show the popup again. |
|          | Shyam is actively using the app for a week after install, but has never gone online. | The app waits for a time when the user is online, and only then asks for their experience.                            |

Wireframes[https://invis.io/2WRG3VO8RZ7](https://invis.io/2WRG3VO8RZ7)

For Future ReleaseDisgruntled users are requested to rate their experience after more time has passed. Assuming they're still using the app, it would be good to know how their experience is now.

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element | Description                                                                                                                                                                                                                  | Language(s)/ Locales Required |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| Messages   | The message that is shown to the user after a core experience, to know what they feel about the app.Message asking the user if we can help better their experience (by reading FAQ or sending a support request immediately) | All supported languages.      |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                             | Description                                                                                                                                                             | Purpose                                                              |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| User becomes a valid candidate         | The moment the user completes a core value within the app (e.g. playing a content).                                                                                     | To know the start of the app rating funnel                           |
| User rating invite (count of instance) | The moment the user is shown a popup asking if they'd like to  rate the app. We specifically also track which time this question has been asked (first, second..  nth). | To know how many users see this popup                                |
| User invite response                   | The response that the user provides (Yes / Later / Never)                                                                                                               | To know how frequently users accept to rate the app vs. not          |
| User star rating                       | The star rating shared by the user                                                                                                                                      | To know what rating the user gives (and thereby context of the user) |
| User rating helpful acknowledgement    | The user is shown an apology with an intent to fix experience at the earliest.                                                                                          | To see how many users are having a bad experience.                   |
| User selected FAQ section              | The user's click on FAQ section                                                                                                                                         | To know how many users go towards the FAQ vs. initiates a mail.      |
| User was sent to Play Store            | The users who've given the app a good rating                                                                                                                            | To bolster the quality rating on the Play Store                      |
|                                        |                                                                                                                                                                         |                                                                      |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements | Load/Volume Requirements | Security / Privacy Requirements                                   |
| ----------------------------------------- | ------------------------ | ----------------------------------------------------------------- |
| Immediate                                 | Across all users         | User id and device id is sent to the FAQ/support email if needed. |
|                                           |                          |                                                                   |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted | Impact Description |
| ------------------------- | ------------------ |
| N/A                       | N/A                |
|                           |                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted                              | Impact Description                                                                                                                                               |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Very few users who have provided a prior rating | Since some users would have provided ratings of their own intent, they are likely to see a rating popup again - and they can choose to say 'Never' set a rating. |
|                                                 |                                                                                                                                                                  |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                                        | Purpose of Metric                                                                                |
| -------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------ |
|          | Funnel of rating                              | This helps us understand what % of our users are willing to rate the app                         |
|          | Comparitive analysis of ratings across states | This helps understand which segment of user (B/M/C/S) is underperforming compared to the median. |

***

\[\[category.storage-team]] \[\[category.confluence]]
