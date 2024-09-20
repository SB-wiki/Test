# Assessment-Score-Report

IntroductionCurrently, there is an existing dashboard to monitor the course progress. This dashboard has to be enhanced to include the Assessment score details of users per batch within a Course. Also there are couple of enhancements to be done to the existing course dashboard for a more user intuitive and seamless experience

When Courses are launched in a state, there should be a mechanism for the state to monitor the quality of content at question level. State would want to gauge the chapters that were easy for users to consume versus contents that were difficult. Each unit/chapter in every course in general has an Assessment associated with it Hence, one way of understanding the content quality would be to see the Assessment scores of users in each course. This would give some insights on whether the chapter was interesting/complicated/easy so that additional help/guidance may be provided to those users who are stuck in one or more chapter/unit to complete the same. Also, State would want to update the contents to make it more easy when it is launched next time

&#x20;JTBD

| **Who is the user and what is the user trying to do which is currently a struggle**                                                                                                                                                  | **What is the context** | **Functional Goal**                                                             | **Emotional/Social Goal**                                             |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- | ------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| State Admin, who launches online training programs, does not know which unit/content is complicated versus unit that is easy. Hence find it difficult to provide guidance/help to teachers who are struggling to complete the course | Online Training         | _Ability for the state to view the scores of Assessment associated with unit/s_ | _Help/Guide teachers to complete the complicated units in the course_ |

Use Case - OverviewTo enable State to monitor the Assessment scores of users with in a batch for a Course

To include "External ID" to the existing grid view

To rename "Download" to "Progress Report"

**Epic JIRA Ticket ID:**

[SB-13497 System JIRA](https://browse/SB-13497)

User Story 1- Assessment Score ReportAs a State Admin, I would want to be able to download "Score Report" for a batch within a Course, So that I can identify the pain points through the Assessment score and help/guide the teachers with course completion

\*\*Pre-conditions: \*\*

1. The logged in user has access to view course dashboard
2. Batch is not expired
3. Logged in user has clicked "View Course Dashboard" from the course TOC

**Acceptance criteria:**

Verify that the user is able to

Main work flow

1. View a new link called "Score Report"
2. Download "Score Report" as a CSV
3. View the below details in the CSV&#x20;
   1. External ID&#x20;
   2. User ID
   3. User Name
   4. Email ID
   5. Mobile Number
   6. Organisation Name
   7. District Name
   8. School name
   9. Assessment Name (This refers to the Worksheet/Question set which in turn could have multiple questions)
   10. Display all the Assessment names in the course. Also, show the maximum possible score for each Assessment to the user on the UI. If the Course has "x" Assessments in total, "x" columns should be displayed
   11. Display individual score for each Assessment under the corresponding Assessment name. Formula - (Number of correct answers\*max score per question)/Total number of Questions (attempted + un attempted)\*max score for each question
   12. Score for a an Assessment is always the latest score&#x20;
   13. Score for a question is also, always the latest score
   14. The score for any question within the Assessment, that is not attempted is considered as zero
   15. Total Score - Sum of all individual Assessment scores (Eg: 2/3+3/4+2/3=7/10)&#x20;
   16. Rename the existing "Download" link to "Progress Report". All the other functionalities related to this report remains the same&#x20;

**Alternate work flow**

None

**Exceptional Workflow**

If any of these fields do not have a value leave it as blank in the CSV file

Refer the below sheet for score calculation for different scenarios ("New" sheet)

[https://docs.google.com/spreadsheets/d/14pzsIdnVo0pk1HaRX5TX2WQaPGpAjmVwGg5f0J1x1-0/edit#gid=0](https://docs.google.com/spreadsheets/d/14pzsIdnVo0pk1HaRX5TX2WQaPGpAjmVwGg5f0J1x1-0/edit#gid=0)

UI Reference:

**JIRA Ticket ID**

[SB-13498 System JIRA](https://browse/SB-13498)

User Story 2 - Include "External ID" to the existing Course dashboard grid viewAs a State Admin, I would want to add "External ID" to the existing course dashboard grid view, So that i can get more targeted information to drive completions

**Pre-conditions:**

1. The logged in user has access to view course dashboard
2. Logged in user has clicked "View Course Dashboard" from the course TOC

**Acceptance criteria:**

**Main work flow**

Verify that&#x20;

1. "External ID" is added to the current grid view. External ID is the state ID provided by state for a teacher. This will be available if a user is on boarded through SSO or API. For a self signed up user, this field would be blank &#x20;
2. "External ID" is the first column in the grid view&#x20;

**Alternate Workflow**

None

**Exceptional Workflow**

&#x20;      If this field do not have a value, leave it as blank in the CSV file.

**JIRA Ticket ID**

[SB-13530 System JIRA](https://browse/SB-13530)

User Story 3 - Updates to Score Report **JIRA Ticket ID**

**System JIRAkey,summary,type,created,updated,due,assignee,reporter,priority,status,resolution2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSB-14867**

**Context:**

User’s Score report for a course, was implemented as part of SB-13498. The scores were calculated for question set/s and the latest attempted score was displayed as part of the report.

However now that, a new content type called "Self-Assess” has been introduced, there are some minor changes to done as part of the report. The scores of “Question set” will no more be included as part of the Score report. Instead, the scores of content type “Self-Assess” alone will be included as part of the Score report

As a State Admin, I would want to have access to scores of self assessment/s of all users within a batch of a course, So that I can get some insights on the quality of the contents within a course

**Acceptance criteria:**

**Pre-conditions:**

1. The logged in user has access to view course dashboard
2. Batch is not expired
3. User has clicked "Score Report"

**Acceptance criteria:**

Verify that:

1. The report gets downloaded as a CSV file
2. The score of content type "Self-Assess” alone are considered in the score calculation
3. The score of Question set (content type - Resource) are not considered in the score calculation
4. The score of a Self-Assess is considered only when the user clicks “submit”
5. The below information are displayed as part of the Score report
   1. External ID, User ID, User Name, Email Address, Mobile Number, Organisation Name, District Name, School name (The generic information of the user that gets displayed in the report remains the same)
   2. Self Assess Name - The score of the Assessment is displayed (A course can have one or multiple self assessments, though in reality there could be only one. If there is more than one Assessment, scores of all the Assessments are displayed)
   3. Total Score - This is the sum of all Self Assess scores.
6. Score for a Self assessment is always the best score

**UI Design**

![](../../../../PRD/prd-ed-td-req-4cc/images/storage)Please refer the below sheet for examples

[https://docs.google.com/spreadsheets/d/1UzNQ4lNOsEunrU11wNXH6dWhskTI\_OsV4UlY-wmSaj0/edit#gid=0 - You don't have permissions to view](https://docs.google.com/spreadsheets/d/1UzNQ4lNOsEunrU11wNXH6dWhskTI\_OsV4UlY-wmSaj0/edit#gid=0)

### User Story 4 - Assessment Score to show in % in the CSV

**JIRA Ticket ID**

**System JIRAkey,summary,type,created,updated,due,assignee,reporter,priority,status,resolution2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSB-16674**

**Context**

The current Score report when downloaded converts the text/score into date format. Also, we have the actual score and the maximum score displayed one below the other (eg: 4/10), which is not a very good user experience. The State would want to do various computations with the scores to make timely and meaningful decisions. Hence this score information needs to be displayed in %, so that the State Admin can interpret the score easily

**As a State Admin, I would want the score to be displayed in %, So that it is easier for me to interpret easily and make meaningful decisions**

**Pre-conditions**

1. Logged in user has access to view Dashboard
2. Batch is selected
3. User has clicked "Score Report"

**Acceptance criteria**

**Verify that**

Main workflow

1. The user's individual Assessment score is displayed in percentage
   1. Formula - (Assessment score/Max Score)\*100
2. The user's total score is displayed in percentage
   1. Formula - (Sum of all Assessment scores/Sum of all Max scores)\*100

Exceptional workflow

1. The earlier score reports generated in x/y format should also get converted and rounded off

Localization Requirements

| UI Element | Description | Language(s)/ Locales Required |
| ---------- | ----------- | ----------------------------- |
| None       |             |                               |
|            |             |                               |

Telemetry Requirements

| Event Name                                        | Description                                                                                                          | Purpose                                                                                                            |
| ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| Click "Score Report" in the course dashboard page | Mentor can download the report by clicking on 'Download Assessment Score Report" button in the course dashboard page | This data will tell us how many users are actually clicking on this button to download the Assessment Score Report |
|                                                   |                                                                                                                      |                                                                                                                    |
|                                                   |                                                                                                                      |                                                                                                                    |
|                                                   |                                                                                                                      |                                                                                                                    |

Non-Functional Requirements

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                |                                                                                               |                                                                     |
|                                                                                                                |                                                                                               |                                                                     |

Impact on other Products/Solutions

| Product/Solution Impacted | Impact Description |
| ------------------------- | ------------------ |
| None                      |                    |
|                           |                    |

Impact on Existing Users/Data&#x20;

| User/Data Impacted | Impact Description |
| ------------------ | ------------------ |
| None               |                    |
|                    |                    |

Key Metrics

| Srl. No. | Metric | Purpose of Metric |
| -------- | ------ | ----------------- |
|          |        |                   |
|          |        |                   |
|          |        |                   |

***

\[\[category.storage-team]] \[\[category.confluence]]
