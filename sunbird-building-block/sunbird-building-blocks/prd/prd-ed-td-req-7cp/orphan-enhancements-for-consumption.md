# Orphan-enhancements-for-consumption

IntroductionThis PRD covers minor enhancements that aren't directly related to existing PRDs.

Personas and environmentUse this section  to elaborate on:

* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  Could be at home, or at school.

Library Display for signed-in users to tenants without boardJTBD + Overview \*\*Job To Be Done: \*\* As a signed-in user from a tenant without a board, I should be able to see content in the library (preferably from my tenant) and not a blank page.

Overall Process Workflow

1. Ram signed in to a tenant without a board (e.g. NCERT).
2. Ram launches the mobile app
3. Ram should see relevant content for the particular medium and class combination that's currently highlighted. Content from his tenant should be shown first for the section that are displayed.

### Overview

Same as above.

Main Scenario

| Srl. No. | User Action                                                   | Expected Result                                                                                                                                                                                                                                                                                                                                                                                                              |
| -------- | ------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User signs into tenant from mobile app                        | User lands on library page, and if B/M/C details aren't provided yet, then user is requested for these.In this scenario, user lands on a popup where the framework only has medium and class (no board).                                                                                                                                                                                                                     |
|          | User sees a popup with just medium and class requested on it. | User selects medium and class and taps submit.                                                                                                                                                                                                                                                                                                                                                                               |
|          | User lands on the library page.                               | User sees the list of subjects across all boards from the currently selected medium and class combination with books for those subjects. Since the soft and hard filters can't be mixed, for now we'll include channel as a hard filter. As a result of this, only books from this tenant/channel will show up in the library for mobile. The books from his tenant should show first, if available in each subject section. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                          | Expected Handling                                                                                                                   |
| -------- | ---------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
|          | There might be subjects that do not have content from the user's tenant for that medium/class combination. | For that subject, other books that match the medium/class/subject combo will be displayed (in whatever order selected by platform). |
|          |                                                                                                            |                                                                                                                                     |

WireframesN/A

For Future ReleaseN/A

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element | Description | Language(s)/ Locales Required |
| ---------- | ----------- | ----------------------------- |
| N/A        | N/A         | N/A                           |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name | Description | Purpose |
| ---------- | ----------- | ------- |
| N/A        | N/A         | N/A     |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements | Load/Volume Requirements | Security / Privacy Requirements |
| ----------------------------------------- | ------------------------ | ------------------------------- |
| Page should load within 3 seconds.        | N/A                      | N/A                             |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted | Impact Description |
| ------------------------- | ------------------ |
| N/A                       |                    |
|                           |                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted | Impact Description |
| ------------------ | ------------------ |
| N/A                |                    |
|                    |                    |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric | Purpose of Metric |
| -------- | ------ | ----------------- |
|          | N/A    |                   |

JIRA Ticket ID[SB-16320 System JIRA](https://browse/SB-16320)

END OF TICKET | END OF TICKET | END OF TICKET |

\<Use Case 2> JTBD + Overview \*\*Job To Be Done: \*\* In this context, explain the current process for which this is an alternative or pain-point that this seeks to eliminate. Also, elaborate the substantial gain or business value that the solution brings in.

Replace the text within < > in the heading above with the name of the use case and provide a high-level overview of the use case for the JTBD or Initiative&#x20;

Replace the text within < > in the heading above with the name of the use case. Insert a diagram in the space below to depict the typical workflow for the envisaged use case. To do so, create the diagram in any editor and save as an image. Insert the image below. &#x20;

\<User Story 1> OverviewReplace the text within < > in the heading above with the name of the use case and the name of the first user story. Provide a high-level overview of the user story here. Each user story is further elaborated in its sub-sections. The principles to bear in mind while writing a user story are: 1) it comprehensively captures a unique feature or functionality that a user can accomplish using the system 2) it encapsulates a single unit of functionality 3) it corresponds to one JIRA story 4) it is accomplished in one release. If, in a rare case, the functionality of a user story needs to be developed iteratively, the story should contain the Minimum Viable Product (MVP) content within the 'Main Scenario' section. All functionality to be developed in future releases, should be part of the 'For Future Release' section. Whenever the functionality is taken up for a release, it should become part of the 'Main Scenario' section. The 'Main Scenario' section should always be in sync with the current system functionality if the story is released. Scenarios detailed for the User Story are part of the acceptance criteria of the story.

Replace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action | Expected Result |
| -------- | ----------- | --------------- |
|          |             |                 |
|          |             |                 |

\<Alternate Scenario 1>Replace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action | Expected Result |
| -------- | ----------- | --------------- |
|          |             |                 |
|          |             |                 |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

WireframesAttach wireframes of the UI, as developed by the UX team for screens required for this story  &#x20;

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                                                                           | Description                                                                                                                       | Language(s)/ Locales Required                                           |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Mention the UI Element that requires localization. e.g. Label, Button, Message, etc. | Provide the exact details of the element that requires localization. e.g. User ID, Submit, 'The content is currently unavailable' | Mention all the languages or locales for which localization is required |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                                     | Description                                                       | Purpose                                                      |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------------ |
| Mention the event that will generate telemetry and which needs to be captured. | Provide event details. e.g. clicking upload for textbook taxonomy | Provide a reason why the event telemetry should be captured. |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted                                                     | Impact Description                                 |
| ----------------------------------------------------------------------------- | -------------------------------------------------- |
| Specify the name of the product/solution on which this use case has an impact | Explain how the product/solution will be impacted. |
|                                                                               |                                                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted                                                  | Impact Description                           |
| ------------------------------------------------------------------- | -------------------------------------------- |
| Specify whether existing users or data is impacted by this use case | Explain how the users/data will be impacted. |
|                                                                     |                                              |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |

JIRA Ticket ID

END OF TICKET | END OF TICKET | END OF TICKET |

***

\[\[category.storage-team]] \[\[category.confluence]]
