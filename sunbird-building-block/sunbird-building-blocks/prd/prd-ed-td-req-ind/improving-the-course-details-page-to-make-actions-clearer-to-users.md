# Improving-the-course-details-page-to-make-actions-clearer-to-users

IntroductionBy tracking the courses funnel on the mobile app, we realise that out of the 100% clicking on a specific course card, only 12% are clicking on enroll. Out of that, only 7% are completing the enrollment after signing in. These are fairly dismal numbers. While we see an increase in the numbers when the state makes courses mandatory, it isn't close to ideal.&#x20;

Post enroling, % of users starting the course, and resuming the course after starting is fairly dismal. Field research seems to prove that this is an issue with the intuitiveness of the page. Users are unable to understand what action to perform next when they look at the details page. This PRD tackles that.&#x20;

JTBD

* \*\*Jobs To Be Done: \*\* As the State who is launching a course for teachers, I want teachers to be able to enrol into the course easily, so that I can ensure they have taken the course in order to upskill themselves.&#x20;
* **User Personas:** Government School Teacher
* **System or Environment:**  At home or in school using their mobile phone&#x20;

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

< User chooses to enroll into the course - Overall Process Workflow>The state will launch courses by issuing QR codes on a circular. These circulars will be made available to teachers in schools via the circular. Teachers are expected to scan the QR code, enrol and take the course. On completion of the course, they will be provided with a certificate.&#x20;

Story OverviewThis story covers the details that a user should be shown in order to prompt them to enroll into the course.&#x20;

| Srl. No. | User Action                                                                                                          | Expected Result                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1        | A user scans the QR code for a course (which has only one batch) and lands on the course TOC page                    | They should be shown the course name, org name with a prominent CTA to enrol into the course (with a date by which they need to do so, if that batch has an enrolment end date) They will be shown the description of the course, the metadata (medium, class, subject) and legal info  (Author, Published on DIKSHA by, Licence terms and Copyright)They have the choice to see the TOC by clicking on a separate tab.  |
| 2        | A user opts to look at the TOC instead of the course details and clicks on any of the content pieces on the TOC page | They are prompted to enroll to continue looking at the content.                                                                                                                                                                                                                                                                                                                                                          |
| 3        | The user chooses to enroll                                                                                           | They are taken to the sign in page (if they haven't signed in already) OR They are taken to the TOC page after being enrolled into the course (if signed in)                                                                                                                                                                                                                                                             |

\<Alternate Scenario 1>

| Srl. No. | User Action                                                                                                                          | Expected Result                                                                                                                                                                                                                                                                  |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user is viewing the TOC page of a course which has multiple batches (upcoming and ongoing)                                         | The user is shown the TOC page (as above) with an additional detail of the number of batches available (it is not clickable) ordered by most recentThey are not shown the message to register by x date under the CTA to enroll                                                  |
| 2        | The user chooses to enroll                                                                                                           | They are first shown a list of batches, and asked which one they'd like to enroll into (same screen as today) When they enroll into the course, they are asked to sign in/up (if they haven't already)ORthey are taken to the TOC page after being enrolled if they've signed in |
| 3        | A user is viewing the TOC page of a course with multiple batches (some expired, and some ongoing/upcoming) and they choose to enroll | They are only shown ongoing and upcoming batches.They are not shown details of expired batches.                                                                                                                                                                                  |

Exception Scenarios

| Srl. No. | Error / Exception                                                 | Expected Handling                                                                                             |
| -------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| 1        | The user has scanned the QR code of a course with expired batches | The user is shown a message on the same page that the course isn't currently active, and to come back later.  |

JIRA Ticket ID[SB-13933 System JIRA](https://browse/SB-13933)

\<User story 2 - User can start/resume the course> Overview

This story covers the details that a user should be shown in order to start the course and complete it, once they have enrolled into it.&#x20;

| Srl. No. | User Action                                                     | Expected Result                                                                                                                                                                                                                          |
| -------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user has enrolled into a course and is on the TOC page        | They are shown the name of the course, the organisation and the course contents by defaultThey are shown a prominent CTA to start the course, and the detail of by when they need to complete the course (if the batch has an end date)  |
| 2        | The user chooses to start the course                            | The first content of the course is played                                                                                                                                                                                                |
| 3        | The user revisits the course after watching some of it earlier  | On the course details page, the user is shown a CTA to watch the next piece of content                                                                                                                                                   |
| 4        | The user selects the option watch the next piece of content     | If the user was mid way through watching a piece of content, the same content will be played againORIf the user completed the previous content, they are played the next content                                                         |
| 5        | The user goes back to the course details page                   | They see their progress in terms of how many content pieces they have completed, and how many are pendingThey can also see which content or unit is completed at a TOC level                                                             |
| 6        | The user completes the course and is on the course details page | They are shown a message that they have completed the courseThey can still continue to play content using the TOC, but they have no other prominent CTAs                                                                                 |

\<Alternate Scenario 1>

| Srl. No. | User Action                                                            | Expected Result                                                                                       |
| -------- | ---------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 1        | A user clicks on a content from the TOC instead of clicking on the CTA | The specific piece of content is played for the userThe TOC and their progress is updated accordingly |

Exception Scenarios

| Srl. No. | Error / Exception                                                                       | Expected Handling                                                                                                    |
| -------- | --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| 1        | The batch that the user has enrolled in has expired, and the user comes to the TOC page | They see a message while the course has ended, they can continue to take the course - but their progress is locked.  |

JIRA Ticket ID[SB-13933 System JIRA](https://browse/SB-13933)

Localization Requirements

| UI Element | Description                                                   | Language(s)/ Locales Required               |
| ---------- | ------------------------------------------------------------- | ------------------------------------------- |
| CTAs       | Register for courseStart watchingContinue watching Watch next | All languages supported by mobile app today |
| Labels     | Register by batches availableCourse contentsCourse details    | All languages supported by mobile app today |

Telemetry RequirementsNote: None of the context info should be captured in edata.extravalues as that field can't be indexed in DRUID.&#x20;

| Event Name                                 | Description                                                                                                                                                                                            | Purpose                                                                                                       |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------- |
| Enroll into course                         | The user clicks on Register for CourseThis should capture context details about the specific course the user tried to enroll into                                                                      | This is to track the number of users who show intent to register for the course as part of the courses funnel |
| Register for batch                         | The user chooses to register for specific batch if there is more than one batchThis should capture context details about the course and the batch the user has chosen                                  | This is to track behavior on a page where the user is offered more than one batch                             |
| Enrollment complete                        | Users who haven't signed in to SunbirdEd are forced to do so once they enrolOwing to this, we need to find out the number of users who actually completed the enrolment process                        | This is to compute the enrolment index, which is one of the TPD solution success metrics                      |
| Start course/Resume Course/Continue Course | Users who click on Start Course/Resume Course/Continue CourseThis should capture context details about the specific course the user has started/resumed/continuedThese are 3 different INTERACT events | This is to track the number of users who have started/continued/completed the course as part of the funnel    |
| Clicks course module                       | Users who click on any module on the TOC page                                                                                                                                                          | This is to track the number of users who click on the modules/sub-modules of a course                         |
| Clicks couse content from TOC              | Users who click on any content on the TOC page                                                                                                                                                         | This is to track the number of users who click on content from the TOC page                                   |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                |                                                                                               |                                                                     |

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
