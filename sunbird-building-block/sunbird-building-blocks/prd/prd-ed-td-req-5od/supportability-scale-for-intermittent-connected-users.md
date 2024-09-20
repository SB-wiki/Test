# Supportability-@-scale-for-intermittent-connected-users

IntroductionOwing to the difficulty of supporting pure offline machines at scale through a support desk, the goal is to improve the offline app setup and recovery mechanisms so that they are self-manageable. The first step in this direction is to provide support mechanisms for intermittently connected devices which use the desktop app.&#x20;

This feature touches on the below two capabilities:&#x20;

* Adding in how-to segments in the app
* Ability for users to report an issue with relevant diagnostic information

JTBD

* \*\*Jobs To Be Done: \*\* As a teacher using the desktop app, I want to be able to reach out for help if I'm stuck while using the app.&#x20;
* **User Personas:** Government school teacher, student, cluster rep
* **System or Environment:**  Primarily in school, with intermittent connectivity on desktops and laptops

\<Story: Users seek out help videos and FAQs when they're stuck on a specific problem> Overview

| Srl. No. | User Action                              | Expected Result                                                                                       |
| -------- | ---------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 1        | User launches the app for the first time | They are provided an introductory tour on how to get content onto the app (only 2 steps in the tour)  |
| 2        | They select the Help section             | Irrespective of whether they are online or offline                                                    |

1. They are provided access to a set of videos which help them understand the key actions on the app
2. They are provided with a set of FAQs on the desktop app

\| | 3 | They choose to view the videos | They can navigate through all 4 videos by seeing the title of the videos and an icon which enables them to play | | 4 | They choose to read through the FAQs | They have a section available where the most frequently asked questions are listed with their responsesThey can also provide input as to whether they are satisfied or not with the feedback (which is sent to the server along with telemetry)  |

\<Alternate Scenario 1>

| Srl. No. | User Action                                                                  | Expected Result                                                                                               |
| -------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| 1        | The user indicates that they are not satisfied with the answer to an FAQ     | They can provide a reason as to why, and their response is synched to the server (along with telemetry)       |
| 2        | They try and input a long text specifying the reason for not being satisfied | The text should be capped at a 1000 characters, and it should be synched to the server (along with telemetry) |
| 3        | They input feedback in a vernacular language                                 | The text should be capped at a 1000 characters, and it should be synched to the server (along with telemetry) |

Exception Scenarios

| Srl. No. | Error / Exception                                       | Expected Handling                                                                                  |
| -------- | ------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| 1        | When the user submits a reason, the device goes offline | The telemetry with this reason should be stored locally, and synched with the internet when needed |

Wireframes[https://projects.invisionapp.com/share/4RULE2KHF5K#/screens](https://projects.invisionapp.com/share/4RULE2KHF5K#/screens)

JIRA Ticket ID[SB-15372 System JIRA](https://browse/SB-15372)

\<Story: Users raise support tickets when they do not find a sufficient information in the app> Overview

| Srl. No. | User Action                                                                      | Expected Result                                                                                                                        |
| -------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | User is reading through the FAQ section, and they don't find their query handled | They can scroll down to a section which says "Other issue"                                                                             |
| 2        | They click on "Other Issue"                                                      | They are shown a form which contains a field for email ID, issue description (limited to a 1000 characters)                            |
| 3        | They type in their concern and submit                                            | A ticket gets sent to freshdesk along with diagnostic information (device ID, device specifics, email ID of the user and description)  |

Note: Any further communication with the user on the issue will happen via email (as it is assumed that the user has logged into their email on their phone)

\<Alternate Scenario 1>

| Srl. No. | User Action                                             | Expected Result                                                                                                                                                                                                                        |
| -------- | ------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | The user submits a support ticket when they are offline | They are shown a message indicating that they are offline, and that they can send an email to the if they'd like to reach them or connect the device to the internet to raise the ticketThe ticket details is logged in the telemetry  |

Wireframes

[https://whimsical.com/6WoBhKLyNZxrxJUj7fRav2](https://whimsical.com/6WoBhKLyNZxrxJUj7fRav2)

[https://projects.invisionapp.com/share/4RULE2KHF5K#/screens](https://projects.invisionapp.com/share/4RULE2KHF5K#/screens)

JIRA Ticket ID

[SB-15373 System JIRA](https://browse/SB-15373)

Localization RequirementsThe entire FAQ segment can be translated - and depending on the interface language choice made by the user, they will be able to view the FAQs in that respective language.&#x20;

Telemetry Requirements

| Event Name                                       | Description                                                                                                                                                                                               | Purpose                                                                                                       |
| ------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Click on Help                                    | Interact event when the user clicks on Help                                                                                                                                                               | To figure out how intuitive the desktop app is by measuring how many users reach out for help                 |
| Click on Help Videos                             | Interact events on each of the videos in the help section along with details of which video is clicked                                                                                                    | To figure out which areas the user seems to be struggling with                                                |
| Click on FAQs                                    | Interact event for the FAQ section, along with details on which question was clicked                                                                                                                      | To figure out which areas the user seems to be struggling with                                                |
| Clicks on satisfied or dissatisfied with the FAQ | Interact events which indicate whether the user clicked on Yes or No for the question of being satisfied with the FAQIf they click No, the event should also contain the explanation provided by the user | To figure out which areas the user sought out help for, and where we haven't provided a sufficient resolution |
| Raise support ticket                             | Interact events to figure out whether the user attempted to raise a support ticket                                                                                                                        | To figure out which areas the user sought out help for                                                        |
| Submitted support ticket                         | Interact event that confirms the user submitted the support ticket (with the body of the ticket - just in case it never made it to freshdesk)                                                             | To figure out which areas the user sought out help for                                                        |

Non-Functional Requirements

| Performance / Responsiveness Requirements | Load/Volume Requirements | Security / Privacy Requirements                                |
| ----------------------------------------- | ------------------------ | -------------------------------------------------------------- |
| All pages should load within 3-4 seconds  |                          | Email ID provided by the user should be encrypted as it is PII |
|                                           |                          |                                                                |

Key Metrics

| Srl. No. | Metric                                                                       | Purpose of Metric                                                                                                                                                  |
| -------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1        | No. of devices raising support ticketsNo. of tickets raised/device           | To measure the overall intuitiveness of the desktop app, and to take necessary steps towards making it more intuitive                                              |
| 2        | No. of devices interacting with FAQNo. of times a device interacts with FAQs |                                                                                                                                                                    |
| 3        | No. of devices interacting with help videos                                  |                                                                                                                                                                    |
| 4        | Questions which are popular                                                  | To understand popularity of questions to reorder them, and to potentially work on making those areas of functionality more intuitive (if it is related to the app) |

***

\[\[category.storage-team]] \[\[category.confluence]]
