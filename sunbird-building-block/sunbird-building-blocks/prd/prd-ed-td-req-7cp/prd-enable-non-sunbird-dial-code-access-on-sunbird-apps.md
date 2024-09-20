# PRD---Enable-non-Sunbird-DIAL-code-access-on-Sunbird-apps

IntroductionProvide a brief description of the context and overview of the User JTBD or Initiative.&#x20;

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* As a user, I want to access digital content relevant to what I'm studying, on a Sunbird app.
* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  At home or school

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

OverviewAs a user with access to a book that had it's own QR/text codes (generated outside of Sunbird, to any other source), I should be able to find relevant content on the Sunbird app

Overall Process Workflow

1. User opens a book that doesn't use Sunbird QR/text codes, and has its own.
2. User scans the non-Sunbird QR code, or enters the text code.
3. User sees relevant content linked to that code on Sunbird platform.
4. Rest of flow is as per current Sunbird QR scan flow.

Scan code OverviewUser scans a QR code using the scanner from the Sunbird app, and finds content relevant to it on the Sunbird instance.

Main Scenario

| Srl. No. | User Action                                                                                 | Expected Result                                  |
| -------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------ |
|          | User scans either non-Sunbird QR code which is supported in our system or Sunbird DIAL code | User sees list of content linked to this QR code |
|          | User clicks on a content from this list                                                     | Similar response to scanning a Sunbird DIAL code |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                                                                                                                                                                                                                                                                                  | Expected Handling                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User is a new user who is not yet onboarded (i.e. profile details is not set), and user scans:a. non-Sunbird QR code which is in a Sunbird book that doesn't have a board, medium, class in it.b. non-Sunbird QR Code which is in a Sunbird book that has no primary board, but is reused by multiple boards.c. Sunbird QR code which is in a Sunbird book with either of the two use cases above. | After content is completed, and user presses BACK from the DIAL results page OR exits the app and launches again, user is taken to the onboarding page where BMC has to be entered.                                                                                                                                                                                                                                                                                                                                                               |
|          | User is a new user who is not yet onboarded (i.e. profile details is not set), and user scans:a. non-Sunbird QR code the Sunbird book of which has only ONE board, (one or more) mediums and classes in it.                                                                                                                                                                                        | After content is completed, and user presses BACK from the DIAL results page OR exits the app and launches again, user is taken to the library page (because onboarding details is set with the board, medium(s) and class(es). (This is as per current consumption experience).                                                                                                                                                                                                                                                                  |
|          | User is a new user who is not yet onboarded (i.e. profile details is not set), and user scans:a. non-Sunbird QR code linked to multiple books on the platform.                                                                                                                                                                                                                                     | After user sees the book selection page, and selects a book - based on the book selected, the BMC is set for the user (if the board is just one).Therefore, if the user returns back from DIAL results page OR exits the app and launches again, user is taken to the library page (because onboarding is completed).If the book selected had no board or multiple boards set, when the user presses BACK from the DIAL results page or exits the app and launches again, the user is taken to the onboarding page where BMC needs to be entered. |
|          | QR code scanned is not a Sunbird specific DIAL code (e.g. link format is different, or the code is not 6 characters)                                                                                                                                                                                                                                                                               | Just because the code is not in the current DIAL code format, should not be a reason to reject it as invalid. Links that are not understood locally by the client app, should be sent to the server for validation and acceptable response.                                                                                                                                                                                                                                                                                                       |

WireframesN/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-14669 System JIRA](https://browse/SB-14669)

Enter code OverviewUser enters the text under the QR code in their book, into the Sunbird portal / desktop app, and the relevant content should be displayed.

Main Scenario

| Srl. No. | User Action                                                                                  | Expected Result                                  |
| -------- | -------------------------------------------------------------------------------------------- | ------------------------------------------------ |
|          | User enters either non-Sunbird QR code which is supported in our system or Sunbird DIAL code | User sees list of content linked to this QR code |
|          | User clicks on a content from this list                                                      | Similar response to scanning a Sunbird DIAL code |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                              | Expected Handling                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| -------- | ------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Exceptions from 'Scan code' section apply here as well.                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | Code entered is not a Sunbird specific DIAL code (e.g. it is not 6 characters) | Just because the code is not in the current DIAL code format, should not be a reason to reject it as invalid. Text that are not understood locally by the client app, should be sent to the server for validation and acceptable response.The hint text (to enter 6 character code) should not be changed just because non-Sunbird codes are being supported now. The 6-digit code is still the primary code format, and far more users are likely to see and identify with this). |

WireframesN/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-14669 System JIRA](https://browse/SB-14669)

ETBv2 Library listing OverviewUser lands on the library screen of the Sunbird app, and the relevant linked **TEXTBOOKS** should be displayed. If the user sideloaded the same books without an internet connection also, for the relevant board, medium and class combination, the books should be displayed.

Main Scenario

| Srl. No. | User Action                                                                                                                                                               | Expected Result                                                                                                                                                                                                                                                                                             |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | a. User launches the mobile app and has a particular BMC (Board, Medium, Class) combination in the library.b. User opens the portal and selects a BMC from the dropdowns. | User sees list of content linked to this BMC combination for the library. The conditions of listing would be:a. The book has the same BMC set.b. The book doesn't have the same primary board, but has the current board in its list of alternate boards (E.g. NCERT books don't have a primary board set). |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                        | Expected Handling                                  |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
|          | User sideloads a book that doesn't have a primary board set, but in its list of alternate boards, the current selected board is present. | For the corresponding BMC, this book will show up. |

WireframesN/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-16146 System JIRA](https://browse/SB-16146)

ETBv1 Explore listing OverviewUser lands on an explore page that is in the ETBv1 format for a tenant, and sees the 'Popular books, stories, worksheets' configuration. However, the tenant might not have an associated primary board (E.g. NCERT).

Main Scenario

| Srl. No. | User Action                                                      | Expected Result                                                                                                                                                                                          |
| -------- | ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | a. User launches the portal and goes to the tenant explore page. | a. Since there is no board set for this tenant, the 'Select Board' dropdown should not be visible.b. Content from the tenant should show first in the categories, similar to other tenant explore pages. |

Describe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          | N/A               | N/A               |

WireframesN/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-16147 System JIRA](https://browse/SB-16147)

Library Search OverviewWhen user attempts a search, content search should include the board from the alternate boards list. If user belongs to a particular state, and performs a search for a subject - if an independent tenant's book/content has the state's board in it's alternate board list - this should show up as an early result in the search.

Main Scenario

| Srl. No. | User Action                                                                                                                                                                                                                       | Expected Result                                                                                                                                                                            |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|          | a.    i. User launches the mobile app and has a particular BMC (Board, Medium, Class) combination in the library.      ii. User opens the portal and selects a BMC from the dropdowns.b. User performs a search for some content. | User gets results that matches closest with their board, medium, class and subject preferences. This also includes close results that have boards matching from the alternate boards list. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          | N/A               | N/A               |

WireframesN/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-16148 System JIRA](https://browse/SB-16148)

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element | Description                                   | Language(s)/ Locales Required |
| ---------- | --------------------------------------------- | ----------------------------- |
| N/A        | Current supported localization is sufficient. | N/A                           |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name | Description                                                                                                                     | Purpose |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------- | ------- |
| N/A        | Current supported telemetry is sufficient. Links scanned/codes entered will continue to come in telemetry as it does currently. |         |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements | Load/Volume Requirements | Security / Privacy Requirements |
| ----------------------------------------- | ------------------------ | ------------------------------- |
| Same as currently.                        | Same as currently.       | Same as currently.              |
|                                           |                          |                                 |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted    | Impact Description                                                                    |
| ---------------------------- | ------------------------------------------------------------------------------------- |
| Portal, Mobile, Desktop apps | Non-Sunbird codes will also be supported now, towards content on the Sunbird service. |
|                              |                                                                                       |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted           | Impact Description                                               |
| ---------------------------- | ---------------------------------------------------------------- |
| Users on old versions of app | It is alright if the new code formats aren't supported on these. |
|                              |                                                                  |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric | Purpose of Metric |
| -------- | ------ | ----------------- |
|          | N/A    | Same as current   |
|          |        |                   |

***

\[\[category.storage-team]] \[\[category.confluence]]
