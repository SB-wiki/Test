# Users-can-take-multiple-assessments-as-part-of-their-course-(Assessments-V1.0)

IntroductionAs a course mentor

I want to ensure that the attendees take assessments as part of the course

So that I can assess how attendees are faring with respect to the course, and take corrective action as needed.&#x20;

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* As an example, the states launch courses with specific targeted goals, and they would need to assess whether teachers have understood the course material in order to take forward learnings to their classrooms. They'd also like to incentivise teachers by awarding them with certificates when they score well, which they can use for career progression.&#x20;
* **User Personas:** Government school teacher
* **System or Environment:**  In school or at home

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

Overview

Workflow A user launches the course → Enrolls for the course → Starts taking the course

In every module, the user starts playing content → reaches the assessment → Goes through the instructions → Takes each question → Can skip through certain questions → Finally submits the assessment → Is shown the score and can retake the assessment → Sees updated progress

OverviewToday, the course progress is updated as soon as the user opens and closes a practice sheet. This is an inaccurate representation of the user's progress in the course - as the user is expected to go through the practice questions to internalise the concept.&#x20;

The initial set of states will take practice sheets forward as their mode of assessments. The practice set scores will no longer be considered in the assessment score report.&#x20;

| Srl. No. | User Action                                                                                                          | Expected Result                                                                                                              |
| -------- | -------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user opens up a practice sheet as part of the course and closes it without going through it completely             | His/her course progress is not updated, and when he/she resumes the course - they are taken to the practice sheet again      |
| 2        | The user completes the practice sheet by either answering or skipping the questions in the sheet                     | His/her course progress is updated, and they can see that their worksheet is marked completed when they look at their course |
| 3        | The user opens up an ECML content which has practice questions as part of it, and they don't complete the questions  | Their progress is only updated once he/she either attempts or skips all the questions embedded in the ECML content           |

WireframesNA

JIRA Ticket ID[SB-14841 System JIRA](https://browse/SB-14841)

\<Users can take assessments as part of their course - Mobile App> OverviewAs part of the course curriculum, the state can choose to administer assessments that they can use to gauge whether the teachers have understood the training material. These are graded assignments, and the score is tracked by the course mentor, so that supplemental material can be provided as needed.&#x20;

**Scope**

* Assessments can be at the overall course level or at every module level. These assessments will be created with content type = worksheets, and added to the course.&#x20;
* Course assessments can have multiple configurations - assessment due date, no. of attempts allowed, answer key available or not, score to be provided at the end or not. These will be configured by the creator while setting up the course. Accordingly, the users experience should be modified.
* While scores are provided at every assessment level, the overall score (pass % of the assessment) is the average of the best scores in all assessments in a course.&#x20;
* Every attempt of the assessment is a fresh attempt, and the user cannot see previously chosen answers.&#x20;
* Going with the guest first approach of the mobile app, assessments can be downloaded and taken offline, and the score will show locally. When the user connects to the internet, the progress and the score will be synched.&#x20;

**Assumption**

* Since the assessment experience is being built into the player, assessments will be available on the portal as part of the TOC, and the user experience once the user clicks on the assessment will be the same as that of the mobile app. So no separate ticket is required for the mobile app.

| Srl. No. | User Action                                                               | Expected Result                                                                                                                                                                                                                                                                                     |
| -------- | ------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user is viewing the course TOC                                          | He/she is shown the assessments at the end of the modules as a separate line item                                                                                                                                                                                                                   |
| 2        | He/she finishes watching the content right before the assessment          | They are shown a prominent CTA to take the assessment, and the date by which they need to complete it                                                                                                                                                                                               |
| 3        | The user opens up the assessment                                          | They are shown an introduction slide for the assessment which covers the last date, no. of attempts, criteria to receive a certificate, and general instructions                                                                                                                                    |
| 4        | They begin taking the assessment                                          | They are shown one question at a timeThey are not shown any feedback on the answer as soon as they answer the questionThey are provided an option to submit the assessment at the very end with information on how many questions they've attempted and how many they've skipped (i.e not answered) |
| 5        | They submit the assessment                                                | They are shown the score they've receivedThey have an option to retake the assessmentTheir course progress is updated to include the assessmentThey are shown an option to answer key, clicking on which - shows them a message that they will be sent the answer key                               |
| 6        | They do not submit the assessment                                         | They can go back and forth and change their answers (i.e. tapping on go-back takes the user back to the last question they answered) Their course progress is not updated to include the assessment                                                                                                 |
| 7        | They try to take the assessment after it has expired or the batch is over | The assessment is marked as expired in the TOC, but the user can opt to take itThey are shown a message that they can take the assessment but their score won't be updated                                                                                                                          |

Wireframes[https://whimsical.com/5vkq2FHRgq5ucsW9UaS16R](https://whimsical.com/5vkq2FHRgq5ucsW9UaS16R)

[https://invis.io/D7TZ1PNXUTK](https://invis.io/D7TZ1PNXUTK)

JIRA Ticket ID[SB-14829 System JIRA](https://browse/SB-14829)

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                                              | Description                                                             | Language(s)/ Locales Required              |
| ------------------------------------------------------- | ----------------------------------------------------------------------- | ------------------------------------------ |
| Messages when assessment is expired or course has ended | Explanations that progress will not be updated/ score won't be recorded | All languages in the mobile app and portal |
|                                                         |                                                                         |                                            |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name               | Description                                                                                                                          | Purpose                                                                                                        |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| Begin assessment         | Start event when a user begins the assessment with the attempt no.                                                                   | To identify that the user has attempted the assessment, and how many attempts it takes to clear the assessment |
| End assessment           | End event when a user hits on submit on the assessment                                                                               | A way to distinguish between submitted attempts vs. trials from the user                                       |
| Assess events            | Every submission to a question should record whether the user submitted answer was correct, incorrect or skipped (i.e. not answered) | To provide question level reporting to the state to identify learning gaps in specific areas                   |
| Submission of assessment | When a user submits the assessment, their final score should be recorded along with the attempt no.                                  | To provide reports on how many times users attempt assessments, and whether they improve on future attempts    |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                                                                                             | Load/Volume Requirements | Security / Privacy Requirements                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ | ------------------------------------------------------------------- |
| The entire assessment content should load for users within 4 secEvery question should load within 2 sec - even when the question is being retrieved with the previous selected answer |                          | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                                                                                       |                          |                                                                     |

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
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
