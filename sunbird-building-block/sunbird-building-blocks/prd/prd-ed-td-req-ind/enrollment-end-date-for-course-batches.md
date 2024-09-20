# Enrollment-end-date-for-course-batches

Introduction \*\*Purpose: \*\*

When creating a batch, course mentor can define the batch’s start date and end date.

* Batch start date is the date when the batch commences i.e., the date when the users’ in the batch can start consuming the course content.
* Batch end date is the date when the batch ends i.e., the date when the users’ course progress stops getting updated.

However, in the current context, a course mentor cannot define an enrollment window for a batch during which enrollments are allowed. An enrollment window is the time period during which users can enroll into a batch. Post this window no new enrollments are allowed. Users’ who have enrolled into the batch during this window can consume and complete the course content before the batch end date.

This capability would allow the state to manage multiple course batches simultaneously.

JTBD

| **Who is the user and what is the user trying to do which is currently a struggle**                                            | **What is the context** | **Functional Goal**                                                    |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------- | ---------------------------------------------------------------------- |
| State admin, when administering a course batch, would not want new users to enroll into the course batch after a certain date. | Course administration   | _Ability for course mentors to define enrollment end date for batches_ |

Requirement SpecificationsUse Case 1 OverviewThis use case deals with enabling course mentors to be able to add enrollment end dates to open batches. This will provide flexibility to the state to run multiple open batches for the same course and also manage enrollments better.

User Story 1As a course mentor I want to be able to define an enrollment end date to the batch so that no new enrollments are allowed in the batch after the enrollment end date.

Main Scenario(s)

Scope: Open batchesScenario 1: Course mentor sets the enrollment end date for a batch, when creating the batch.

| Srl. No. | User Action                                                                                                                                                                 | Expected Result                                                                                                                                                                                                                                                                                                                                          |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | Course mentor, when creating a open batch, sets the enrollment end date, completes the other mandatory fields in the ‘Create Batch’ form and clicks on create batch.        | Batch should be created if the following validations are successful: Enrollment end date should be less than or equal to batch end date, if batch end date has a valid value;Enrollment end date should be greater than or equal to batch start date;If the above validations fail then appropriate error messages are to be shown to the course mentor. |
| 2        | Course mentor, when creating a open batch, leaves the enrollment end date blank completes the other mandatory fields in the ‘Create Batch’ form and clicks on create batch. | Batch should be created successfully. Enrollment end date is not set for the batch                                                                                                                                                                                                                                                                       |
| 3        | Enrollment end date is greater than equal to current date:Users clicks on enroll to enroll into an open batch.                                                              | User enrolls into the batch successfully                                                                                                                                                                                                                                                                                                                 |
| 4        | Enrollment end date is past date:Enrollment to the open batch is not enabled.                                                                                               | User cannot enroll into the batch as enrollment to the open batch is disabled                                                                                                                                                                                                                                                                            |
| 5        | Enrollment end date is blank:User clicks on enroll to enroll into an open batch                                                                                             | Since the enrollment end date is blank the current logic of batch expiry date should drive user enrollments. Hence no changes needed.                                                                                                                                                                                                                    |

Scenario 2: Course mentor updates the enrollment end date for a batch, when updating the batch

| Srl. No. | User Action                                                                                                                       | Expected Result                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| -------- | --------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | Course mentor, when updating an open batch, updates the enrollment end date in the Update Batch’ form and clicks on update batch. | Batch should be updated if the following validations are successful: Enrollment end date can be updated irrespective of whether it is in the past or future. For eg., let’s say today is 17th June. For a batch the enrollment end date was set to14th June. Now the mentor can change this date from 14th June to 20th June. Similarly if the batch enrollment end date was set to 18th June. The mentor can update this to any date in the future but not to a past date.Updated enrollment end date is not in the past Updated enrollment end date should be less than batch end date, if batch end date has a valid valueUpdated enrollment end date should be greater than or equal to batch start date;If the above validations fail then appropriate error messages are to be shown to the course mentor. |
| 2        | Enrollment end date is greater than or equal to current date:Users clicks on enroll to enroll into an open batch.                 | User enrolls into the batch successfully                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| 3        | Enrollment end date is past date:Enrollment is disabled to the Open batch                                                         | User enrollment is disabled                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

Exception ScenariosN/A

Wireframes

[https://invis.io/6ZSJAMPWD8X](https://invis.io/6ZSJAMPWD8X)

For Future ReleaseN/A

JIRA Ticket ID

[SB-13073 System JIRA](https://browse/SB-13073)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

User Story 2 (Portal)As a user, I want to be able to enroll into an open batch which has enrollment end date and consume course content.

Main Scenario(s)

Scenario 1:User trying to enroll into an open batch which has enrollment end date.

| Srl. No. | User Action                                                                                | Expected Result                                                                            |
| -------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| 1        | If the batch does not have an enrollment end date                                          | No changes to the existing process                                                         |
| 2        | If the batch has an enrollment end date, and the end date is in the past                   | User is not allowed to enroll.                                                             |
| 3        | If the batch has an enrollment end date, and the end date is current date or in the future | Batch is made available for enrollment. User can click on enroll to enroll into the batch. |

Exception Scenarios **Note:** Any changes done to the course in the draft state should not impact the live version of the course until the course is published.

Wireframes[https://invis.io/6ZSJAMPWD8X](https://invis.io/6ZSJAMPWD8X)

For Future ReleaseN/A

JIRA Ticket ID[SB-13075 System JIRA](https://browse/SB-13075)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

User Story 3 (Mobile App)As a user, I want to be able to enroll into an open batch which has enrollment end date and consume course content.

Main Scenario(s)

Scenario 1:User trying to enroll into an open batch which has enrollment end date.

| Srl. No. | User Action                                                                                | Expected Result                                                                            |
| -------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| 1        | If the batch does not have an enrollment end date                                          | No changes to the existing process                                                         |
| 2        | If the batch has an enrollment end date, and the end date is in the past                   | User enrollment is disabled.                                                               |
| 3        | If the batch has an enrollment end date, and the end date is current date or in the future | Batch is made available for enrollment. User can click on enroll to enroll into the batch. |

Exception Scenarios **Note:** Any changes done to the course in the draft state should not impact the live version of the course until the course is published.

Wireframes[https://invis.io/6ZSJAMPWD8X](https://invis.io/6ZSJAMPWD8X)

For Future ReleaseN/A

JIRA Ticket ID[SB-13077 System JIRA](https://browse/SB-13077)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                                                                           | Description                                                                                                                       | Language(s)/ Locales Required                                           |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Mention the UI Element that requires localization. e.g. Label, Button, Message, etc. | Provide the exact details of the element that requires localization. e.g. User ID, Submit, 'The content is currently unavailable' | Mention all the languages or locales for which localization is required |
| Label                                                                                | Static text 'Enrollment ends on' in the batch description shown to end users                                                      |                                                                         |
|                                                                                      |                                                                                                                                   |                                                                         |

Telemetry RequirementsN/A

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements | Load/Volume Requirements | Security / Privacy Requirements |
| ----------------------------------------- | ------------------------ | ------------------------------- |
|                                           |                          |                                 |

1. Courses can have upto 5 active batches running in parallel
2. Each open batch can have participants upwards of 1L

\| | | | | |

Impact on other Products/SolutionsN/A

\| | |

Impact on Existing Users/Data N/A

Key MetricsN/A

\| | |

***

\[\[category.storage-team]] \[\[category.confluence]]
