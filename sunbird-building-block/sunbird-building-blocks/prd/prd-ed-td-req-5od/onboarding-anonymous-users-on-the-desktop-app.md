# Onboarding-anonymous-users-on-the-desktop-app

JTBD

* \*\*Jobs To Be Done: \*\*
  * **As a** teacher, \*\*I want \*\* to easily access content that is relevant to my teaching curriculum  **So that** I don't spend valuable class time searching for content.&#x20;
  * **As a** state administrator, \*\*I want \*\* to be informed about consumption patterns specifically in my state/district so that that I can drive consumption initiatives in my state&#x20;
* **User Personas:** Teacher, Student, Cluster Rep
* **System or Environment:**  Lab or classroom with a desktop/laptop and low/no internet connectivity&#x20;

Workflow![](<../../../../PRD/prd-ed-td-req-5od/images/storage/Desktop App User Flows (4).png>)

\<Story: User sets their profile information to get relevant content> OverviewThe current desktop application is generic for all states - and a user has to spend time filtering through a set of boards, mediums, classes and subjects every time they land on the app to get content that is relevant for them. Since a school is usually associated with only one board, the person setting up the app needs to input the preferences just once. Post that, teachers/students who are accessing the app just need to select their class and scroll through to their subjects to find relevant content. This saves the teacher/student time as they're shown content relevant to them.&#x20;

On the onboarding screen, the user has to fill their preferences in the order of Board → Medium → Class.&#x20;

This ensures that they easily find relevant content in their library.&#x20;

| Srl. No. | User Action                                            | Expected Result                                                                                                                                                                                                                                          |
| -------- | ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | User installs and launches the app for the first time  | They are shown a popup which forces them to enter their board, medium and classWhile a user can select only one board, they can select multiple medium, and multiple classesThis is a mandatory step that the user has to complete before moving forward |
| 2        | They enter their board, medium and class information   | They are taken to the library page where the filters reflect the choices made by the useri.e.                                                                                                                                                            |

1. the dropdowns reflect the framework corresponding to their board (instead of all boards)
2. their board, medium and class is pre-set, and they are shown subject-wise categories of the books/content present in their library

The "recently added" section is **not** updated based on the filters | | 3 | The user is on the library page | They can change their preferences of board, medium and class at any point of time to get the content from all subjects that are relevant to their selection |

Note:

* All frameworks should be packaged with the desktop app by default. The user's choice of board leads to the default framework being set to a specific one.&#x20;
* If there is an update to the framework, the update should sync from the server to the desktop app as and when it comes online.&#x20;
* The first choice made by the user at the time of onboarding will be remembered by the desktop app. Since there is no profile introduced yet, a user can always change their criteria from the filters, but cannot reset their overall preferences.

Wireframes[https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/388449490](https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/388449490)

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

\<Story: User enters their location information when they launch the app> OverviewIn order for state administrators to drive consumption initiatives for their respective states/districts, it is essential to capture the user's location details at the time they install and launch the app.&#x20;

| S.No. | User Action                                                              | Expected Result                                                                                                                                                                                       |
| ----- | ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1     | User completes onboarding after installing and launching the desktop app | They are asked to input or confirm their state and district(This is blank if the user isn't connected to the internet, and is defaulted to a state/district if the user is connected to the internet) |
| 2     | They input a state and district and confirm                              | They are taken to the library page                                                                                                                                                                    |

Note:

* All geolocation data is packaged with the desktop app. It should be updated in the local app if there is an update to the server as and when the app is connected to the internet.&#x20;
* There should be a mechanism to store the users location information and sync it to the server as and when the user comes online.
* There should also be a mechanism to transport this location information via telemetry if the user's app never comes online and the telemetry from that device is imported into another device.&#x20;

Overall business logic as per: \[\[Location Capture :: Device and User|Location-Capture----Device-and-User]]

Wireframes[https://invis.io/VAU8EMZJN4U](https://www.google.com/url?q=https://invis.io/VAU8EMZJN4U\&sa=D\&source=hangouts\&ust=1571664364125000\&usg=AFQjCNHKRNsBBvua4Edxtwg3ZnPuJ8op6g)

Localization Requirements

| UI Element                                   | Description                                      | Language(s)/ Locales Required             |
| -------------------------------------------- | ------------------------------------------------ | ----------------------------------------- |
| BoardMediumClass                             | Onboarding field names - self explanatory        | All languages supported by app and portal |
| State District                               | Location input fields - self explanatory         | All languages supported by app and portal |
| Title and instructional text for both popups | Explaining purpose of inputting this information | All languages supported by app and portal |

Telemetry Requirements

| Event Name           | Description                                                                                                                                                          | Purpose                                                                                                                                                  |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Onboarding viewed    | Event that informs the system that the user has viewed the onboarding popup                                                                                          | To measure drop-off owing to onboarding screen                                                                                                           |
| Onboarding completed | Event that informs the system that the user has completed onboarding (along with the values input by the user)                                                       | To use in reports to understand further usage divided by board (for. eg what is the play % of users who have onboarded to the desktop app with board =X) |
| Location popup views | Event that informs the system whether the user has viewed the location popup (with extra information around whether it was prefilled, and with which state/district) | To measure drop-off owing to location capture                                                                                                            |
| Location submitted   | Event that informs the system that the user has submitted his/her location details (with the values input by the user)                                               | To further dissect reports by state/district                                                                                                             |

Non-Functional Requirements

| Performance / Responsiveness Requirements                | Load/Volume Requirements | Security / Privacy Requirements |
| -------------------------------------------------------- | ------------------------ | ------------------------------- |
| Both popups should load and be actionable within 3-4 sec |                          |                                 |
|                                                          |                          |                                 |

Key Metrics

| Srl. No. | Metric                                      | Purpose of Metric                                                         |
| -------- | ------------------------------------------- | ------------------------------------------------------------------------- |
| 1        | No. of unique devices completing onboarding | To measure the overall drop-offs in the installation and trial experience |
| 2        | No. of unique devices submitting location   | To measure the overall drop-offs in the installation and trial experience |

***

\[\[category.storage-team]] \[\[category.confluence]]
