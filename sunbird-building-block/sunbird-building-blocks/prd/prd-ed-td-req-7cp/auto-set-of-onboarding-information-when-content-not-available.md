# Auto-set-of-onboarding-information-when-content-not-available

IntroductionAs a user, I wish to consume relevant content as quickly as possible after installing the app. If the DIAL code is not linked to content, I see a popup telling me that content isn't available - and I'm anyway forced to either scan or enter my details manually. It would be nice if my profile information is automatically set based on the DIAL code I just scanned, even if there's no content linked to it (we atleast know the book that it's associated with).

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* When a user scans a DIAL code for which there is no content, they are shown a book results page with the 'Content coming soon' popup. As a user, I should atleast have my profile information set up because of the scan, so that I can browse the content that is present.
* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  Most likely to be used at home, occasionally in school premises.

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

OverviewAs a user who scans a code within a book, I'd like to be able to see content that's relevant to me. The closest that's possible should be enabled for me, if the code I scanned doesn't have any content linked to it.

Overall Process Workflow

1. User scans a DIAL code.
2. User sees a popup saying 'Content is coming soon'.
3. User closes the popup, to see the library page - with the board, medium and class automatically set.
4. User might continue to scan other DIAL codes, and find / not get results, based on whether the DIAL code is linked to content or not.
5. OR the user might choose to navigate via the library and find books relevant for them.

OverviewAlready covered in overview above.

Main ScenarioUser scans a DIAL code that is linked to a book, but doesn't have any content associated with it.

| Srl. No. | User Action                                                                             | Expected Result                                                                                                                                                                      |
| -------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|          | User scans DIAL code (which has no content associated within it, but is part of a book) | User is taken to the library page, with the board/medium/class auto-set based on the board/medium/class of the book. The user also sees the relevant coming soon message in a popup. |

Alternate Scenario 1 - User scans a DIAL code that isn't linked to any bookAssuming a DIAL code is available, but not linked to any textbook.

| Srl. No. | User Action                                                   | Expected Result                                                                            |
| -------- | ------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
|          | User scans DIAL code (which has no book associated within it) | User remains on the onboarding page, and sees the relevant coming soon message in a popup. |

Alternate Scenario 2 - User scans a DIAL code that's linked to multiple books and have content linked to itTitle is self-explanatory.

| Srl. No. | User Action                                                        | Expected Result        |
| -------- | ------------------------------------------------------------------ | ---------------------- |
|          | User scans DIAL code (which has multiple books associated with it) | If the books are from: |

1. the same board, medium, and class:
   1. Set the board/medium/class automatically, and show the multiple books page.
   2. If user presses BACK here, they are taken to the library with that board/medium/class.
2. different boards, mediums or classes:
   1. Wait for user to open a book, and based on the book opened - set the board / medium / class automatically. The user sees the flattened results page (since the book has content).
   2. If the user presses BACK here, they're taken to the book results page.
   3. If they press BACK again, they are taken to the library with that board/medium/class set.

|

Alternate Scenario 3 - User scans a DIAL code that's linked to multiple books and the books don't have content linked to itTitle is self-explanatory.

| Srl. No. | User Action                                                        | Expected Result        |
| -------- | ------------------------------------------------------------------ | ---------------------- |
|          | User scans DIAL code (which has multiple books associated with it) | If the books are from: |

1. the same board, medium, and class (Can move to future release if complex):
   1. Set the board/medium/class automatically.
   2. The user is immediately taken to the library with that board/medium/class (since none of those linked books have content). User is shown the relevant 'Content coming soon' popup.
2. different boards, mediums or classes:
   1. Wait for user to open a book, and based on the book opened - set the board / medium / class automatically.
   2. The user is immediately taken to the library with that board/medium/class (since the linked book doesn't have content). User is shown the relevant 'Content coming soon' popup.

|

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

WireframesAttach wireframes of the UI, as developed by the UX team for screens required for this story  &#x20;

For Future ReleaseIf multiple books are linked to the same DIAL code, if it's not possible to identify that all of them will result in 0 content at the respective nodes - the Coming Soon message should be populated. Leaving this for later, as I suspect this is going to be a wee bit more complicated.

JIRA Ticket ID[SB-13149 System JIRA](https://browse/SB-13149)

Localization RequirementsN/A

| UI Element                                                                           | Description                                                                                                                       | Language(s)/ Locales Required                                           |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Mention the UI Element that requires localization. e.g. Label, Button, Message, etc. | Provide the exact details of the element that requires localization. e.g. User ID, Submit, 'The content is currently unavailable' | Mention all the languages or locales for which localization is required |
|                                                                                      |                                                                                                                                   |                                                                         |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name      | Description                                   | Purpose                                                                                                 |
| --------------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Auto-set of BMC | Automatically set the Board, Medium and Class | To differentiate the users who manually provide their BMC from the users who have it set automatically. |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements              | Load/Volume Requirements             | Security / Privacy Requirements |
| ------------------------------------------------------ | ------------------------------------ | ------------------------------- |
| Would like for this to happen ASAP (within 1 second?). | N/A since it's a mobile app use-case |                                 |
|                                                        |                                      |                                 |

Impact on other Products/SolutionsN/A

| Product/Solution Impacted                                                     | Impact Description                                 |
| ----------------------------------------------------------------------------- | -------------------------------------------------- |
| Specify the name of the product/solution on which this use case has an impact | Explain how the product/solution will be impacted. |
|                                                                               |                                                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted | Impact Description                        |
| ------------------ | ----------------------------------------- |
| No                 | This only impacts new users / reinstalls. |
|                    |                                           |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric      | Purpose of Metric                                                                                      |
| -------- | ----------- | ------------------------------------------------------------------------------------------------------ |
|          | FTUE funnel | To see the % of users who go on to complete the core experience on the day of install                  |
|          | BMC funnel  | To see the % of users from various BMC combinations, to see their FTUE completion rates and retention. |

***

\[\[category.storage-team]] \[\[category.confluence]]
