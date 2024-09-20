# Contextual-request-for-Android-permissions

IntroductionAround 5-15% of users tend to skip providing one (or more) permissions to access camera, storage and microphone via the mobile app. In keeping with best practices, we will now inform users about why certain permissions are needed and if they choose to still reject permission requests, they will be asked for the permission at the time it is needed.

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* As a user, I am asked for permissions at launch and not told why. The permissions look intimidating, so I choose not to accept the requests. I'd like to know why I'm asked for certain permissions.
* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  Mostly at home, though likely to be used in school or in transit

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

OverviewAs a user, I'd like to know why certain permissions are asked so I understand whether to provide access or not.

Overall Process Workflow[https://invis.io/6SRV1MSD43H](https://invis.io/6SRV1MSD43H)

As a user, I'd like to be informed about the permissions needed instead of directly being asked for itWhen the user launches the app, before anything else, they're first asked for permissions. Going forward, we'll ask for permissions just before they're needed - and inform users about why that is so.

Main Scenario - Asking for permissions at launchReplace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                                                                                                                       | Expected Result                                                                          |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
|          | User installs app and launches it                                                                                                                                                 | User sees splash screen, and then sees language selection. NO permissions are requested. |
|          | User selects a language and moves to next screen.                                                                                                                                 | User sees user-type selection screen.                                                    |
|          | User selects the type of user and presses 'Continue'.                                                                                                                             | User is shown the permissions information screen.                                        |
|          | User reads the reasoning and taps 'Give Access'                                                                                                                                   | User is asked for each of the permissions, and responds to them all.                     |
|          | If user has granted access to Camera, the user is taken to the onboarding QR scan page;If not, the user is taken to the manual onboarding page (directly skips the QR Scan page). | Life goes on.                                                                            |

Alternate Scenario 1 - User doesn't grant access to any of the permissions during onboardingReplace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                                                                                                                                                  | Expected Result                                                                                                                                                                 |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Since user hasn't granted Camera access, user is taken to manual onboarding page.                                                                                                                            | User sees the B/M/C selection screen.                                                                                                                                           |
|          | User provides their B/M/C and clicks continue.                                                                                                                                                               | User lands on the Library page.                                                                                                                                                 |
|          | User goes in anywhere and downloads content.                                                                                                                                                                 | Content is downloaded onto device (Storage within app folder doesn't require the permission).                                                                                   |
|          | User goes into 'Downloads' and taps on Settings; or taps on the toast message that says 'Running low on memory, move content to SD card'.                                                                    | User sees a popup asking to grant access to storage.                                                                                                                            |
|          | If user provides access to storage, user is taken to storage settings;If user denies access to storage, the bottom toast message shows 'Unable to access storage as permission was denied (Settings button)' | In first scenario, user can change storage to SD card.In second scenario, if user taps on 'Settings', they are taken to the Settings > Permissions page within the Sunbird app. |
|          | If user is in Settings > Permissions page within the app, user can tap anywhere on the row with a particular permission request (text or toggle icon seen on the right).                                     | User is taken to the Android settings page for THAT app. If they change any permissions here, it reflects when they return to Settings > Permission within the app.             |
|          | User does nothing, and returns to app and taps on QR scan button.                                                                                                                                            | User sees the popup asking to grant access to camera. (Following steps are similar to the above scenario for storage).                                                          |
|          | User plays a content that has Record and Play functionality within.                                                                                                                                          | Straightforward play of content happens satisfactorily.                                                                                                                         |
|          | User taps on 'Record' within the content.                                                                                                                                                                    | Nothing happens, as the permission hasn't been provided (scenario handled later as an additional user-story, due to Canvas dependencies).                                       |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                | Expected Handling                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| -------- | ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User has granted access to permissions, and after many days, disables permission for Camera      | When user taps on QR scan button, they see the Camera permission request popup. If it was set on permanently deny, then they see the error toast message that can redirect them to Settings.                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | User has granted access to permissions, and after many days, disables permission for Storage     | If data storage was on internal storage, no immediate impact. If they attempt to enter Settings within 'Downloads' tab, they see the Storage permission popup.If data storage was on external storage / SD card, when app is launched, they see the Storage permission request popup. If user denies / permanently denies, the storage is automatically changed to internal storage. User is likely to see no downloaded content, since all that was downloaded is in SD card.If user later provides access to SD card and attempts to move existing content to SD card - our current process of merging content comes into effect. |
|          | User has granted access to permissions, and after many days, disables permission for Microphone. | When user taps on 'Record' inside content, nothing happens. (Will be handled as part of other story).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

Wireframes[https://invis.io/4RRYAQ5YA2Q](https://invis.io/4RRYAQ5YA2Q)

For Future ReleaseGranting of permissions while a content is being played, will be handled in a later release (For e.g., microphone access).

JIRA Ticket ID[SB-12268 System JIRA](https://browse/SB-12268)

\<Use Case 1 - User Story 2> OverviewRepeat the entire Section and its corresponding subsections to elaborate the next user story in the use case. Repeat the section as many times as required.&#x20;

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element               | Description                                          | Language(s)/ Locales Required   |
| ------------------------ | ---------------------------------------------------- | ------------------------------- |
| All Permission titles    | Permission titles (e.g. Camera, Microphone, Storage) | All supported Sunbird languages |
| All permission bodies    | All explanations of why the permission is required   | All supported Sunbird languages |
| Permission denial toasts | All failure messages                                 | All supported Sunbird languages |

Telemetry Requirements

| Event Name                                           | Description                                                                                                                                                                                         | Purpose                                                                                                                          |
| ---------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Onboarding permission display                        | When the user sees the list of various permissions requested, and the reason for it.                                                                                                                | To keep track of how many first time users arrive at the permissions request page.                                               |
| Permission request popup display                     | Whenever a permission isn't provided, and is needed for an upcoming action (additional params: permission name)                                                                                     | To know how many devices are in a situation where they're asked for a permission beyond onboarding.                              |
| Android permission popup display                     | When we request for a permission and Android displays a popup (addn params: permission name)                                                                                                        | To know how many users were redirected to the Android permission popup.                                                          |
| Android permission popup response                    | When we receive acceptance/rejection via the Android request (addn params: permission name, accepted/rejected)                                                                                      | To know how the user responded to the request.                                                                                   |
| Feature inaccessible toast display                   | When a permission is rejected, and user can't use the feature (addn params: permission name, current page)                                                                                          | To know where the user received a failed message, and to see frequency of the same.                                              |
| Tapped on Setting from toast                         | When user taps on 'Settings' text in toast (addn params: permission name, current page)                                                                                                             | To know if the user took an active step towards enabling a permission.                                                           |
| Arriving at Settings > Permissions                   | When user lands on Permissions page within app (addn params: previous page (Settings / Library / Downloads etc.)                                                                                    | To know if user landed on the permissions page from Main menu > Settings, or from an error toast message.                        |
| Tapping on a permission's status in Permissions page | When user interacts with a permission's status in the permissions page (addn params: permission name, its current status on/off )                                                                   | To know if user attempts to change the permission status manually                                                                |
| Status update of permissions page                    | When user goes to the Android permissions page, and returns after changing some permissions (addn params: list of \[permission name, new status on/off ] ONLY if those permission statuses changed) | To know if user successfully changed any statuses directly in Android settings and returned back to the Permissions page in app. |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements      | Load/Volume Requirements | Security / Privacy Requirements |
| ---------------------------------------------- | ------------------------ | ------------------------------- |
| No page should take more than a second to load | NA for single device     | NA for single device            |
|                                                |                          |                                 |

Impact on other Products/Solutions

| Product/Solution Impacted        | Impact Description |
| -------------------------------- | ------------------ |
| Only has an impact on mobile app | -                  |
|                                  |                    |

Impact on Existing Users/Data&#x20;

| User/Data Impacted                                                                                                                            | Impact Description                |
| --------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| Existing users will see permission request popups only if they have disabled certain permissions and those are required for an upcoming task. |  Request popup will be displayed. |
|                                                                                                                                               |                                   |

Key Metrics

| Srl. No. | Metric                                                                         | Purpose of Metric                                                                                       |
| -------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
|          | % of devices that grant access vs. cancel for now during onboarding            | To see what % of users deny permissions at the onboarding stage.                                        |
|          | % of devices that grant access vs. cancel at the time of action (e.g. QR Scan) | To see what % of users deny permissions when the request was initiated by their own action.             |
|          | % of devices that go to Settings to change it, when error message is seen      | To notice if dire effect of their actions prompt users to give access to certain permissions after all. |

***

\[\[category.storage-team]] \[\[category.confluence]]
