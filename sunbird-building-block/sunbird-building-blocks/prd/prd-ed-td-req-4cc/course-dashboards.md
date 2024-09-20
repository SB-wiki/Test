# Course-Dashboards

IntroductionAP would be launching 3 online courses in the last week of May for their teachers. All these teachers would be on-boarded by the end of March and would use SSO to access DIKSHA. State has articulated the need to have a dashboard which the state admins can use to monitor the health of this program. State admin would in-turn present these dashboards to their higher ups (Director & Commissioner).This is needed to be enabled and handed over to the state by 25th May '19.

JTBD

| **Who is the user and what is the user trying to do which is currently a struggle**                                                                                                                                                | **What is the context** | **Functional Goal**                                                                                  | **Emotional/Social Goal**                                          |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| State Admin, who is launching online training programs, does not have know about the adoption and usage of the online training program and hence struggles to provide timely interventions to drive the adoption and usage metrics | Online Training         | _Ability for state to view the adoption, usage and completion of training programs launched by them_ | _Recognition for ensuring the success of online training programs_ |

Use Case - OverviewProvide information to the state to monitor the below metrics at state, district & course level:

a) program adoption (measured by course enrollments) and

b) course usage (measured by course completions & avg time spent)

Hence the need to capture the below information:

a) total no. of courses launched

b) total no. of enrollments in these courses (this should include numbers only from the respective tenant)

c) total no. of completions (this should include numbers only from the respective tenant)

d) average time spent (this should be calculated include numbers only from the respective tenant)

Epic JIRA Ticket ID:[SB-11183 System JIRA](https://browse/SB-11183)

Overall Process WorkflowStep1: Program team to share the list of courses and the course batches which are in-scope for the dashboard with the analytics team.

Step2: Analytics team to extract the relevant information per the defined frequency for the provided courses and course batches.

Step3: Implementation team to render the dashboard visualisation.

User Story 1 - Course Enrollment ReportAs a state admin, I want to be able to view the number of enrolments for the courses (for all districts and by district) launched by my state so that I can work with the respective district officers to drive enrolments.

All the reports in this story need to be updated on a daily basis.

Report 1:Purpose of this report is to show the course wise enrollment numbers.

How are course enrollments calculated?

* Users from any tenant can enrol into an open course batch. In this report only include teachers who belong to the same tenant ID as the report viewer’s tenant id.

Report title: Enrollment Report by Course

X-axis: No. of enrollments

Y-axis: Course Name

Within each bar graph in the course show the total number of enrollments for that course. Provide raw information in a table format which can be downloaded

Sample Report: . Also show the count of enrollments per course within the bar graph.

![](<../../../../PRD/prd-ed-td-req-4cc/images/storage/Screen Shot 2019-03-22 at 10.17.24 AM.png>)

Report 2:Purpose of this report is to show the enrollments by course as a timeline graph.&#x20;

Report title: Enrollment Timeline Report by Course

X-axis: Should have week ending dates for the last 30 days

Y-axis: No. of enrollments

Raw information in a tabular format needs to be provided which can be downloaded.

In this report only include teachers who belong to the same tenant ID as the report viewer’s tenant id.

Report 3:Purpose of this report is to show the enrollments by district.

Report title: Enrollment Report by District

X-axis: No. of enrollments

Y-axis: District Name&#x20;

Within each bar graph show all the 3 course enrolments. Each individual course has an unique color.

Raw information in a tabular format needs to be provided which can be downloaded.

In this report only include teachers who belong to the same tenant ID as the report viewer’s tenant id.

Sample Report: . Also show the count of enrollments per course within the bar graph.

![](<../../../../PRD/prd-ed-td-req-4cc/images/storage/Screen Shot 2019-03-22 at 10.46.08 AM.png>)

Exception ScenariosIn the scenario where a state teacher has district information not mapped, please tag all of them to 'Others' District. Show this district in the 'Enrollment by District' report.

JIRA Ticket ID[SB-11301 System JIRA](https://browse/SB-11301)

User Story 2 - Course Timespent ReportAs a state admin, I want to be able to view the average time spent by the enrolled teachers on the courses (for all districts and by district) so that I can understand the usage of the courses

All the reports in this story need to be updated on a weekly basis.

Report 1Purpose of this report is to show time spent by the teachers on the courses. Average time spent is calculated by: (Total time spent on the course by teachers from the state/no. of enrollments from state)

Report title: Time Spent Report by Course

X-axis: Time Spent (Mins)

Y-axis: Course Name

Raw information in a tabular format needs to be provided which can be downloaded.

Sample Report: . Also show the count of enrollments per course within the bar graph.

![](<../../../../PRD/prd-ed-td-req-4cc/images/storage/Screen Shot 2019-03-22 at 11.16.40 AM.png>)

In this report only include teachers who belong to the same tenant ID as the report viewer’s tenant id.

Report 2Purpose of this report is to show average time spent on the courses at district level. Use the same formula used in report 1 to arrive at average time spent number.

Report title: Time Spent Report by District

X-axis: Avg time spent (mins)

Y-axis to have individual district names organised alphabetically

Within each bar graph show the time spent for all the 3 courses.&#x20;

Raw information in a tabular format needs to be provided which can be downloaded.

Sample Report: . Also show the count of enrollments per course within the bar graph.

![](<../../../../PRD/prd-ed-td-req-4cc/images/storage/Screen Shot 2019-03-22 at 11.25.44 AM.png>)

In this report only include teachers who belong to the same tenant ID as the report viewer’s tenant id.

JIRA Ticket ID[SB-11303 System JIRA](https://browse/SB-11303)

User Story 3 - Course Completion ReportAs a state admin, I want to be able to view the number of enrolled teachers who have completed the course (for all districts and by district) so that I can work with the respective district officers to drive completion

All the reports in this story need to be updated on a weekly basis.

Report 1Purpose of the report is to provide course completion count by course. Any teacher with course progress as 100% is deemed to have completed the course.&#x20;

Report title: Course Completion Report by Course

X-axis: No. Of teachers who have completed the course

Y-axis: Course Name

Within each bar graph in the course show the total number of teachers who have completed the course

Raw information in a tabular format needs to be provided which can be downloaded.

Sample Report: . Also show the count of enrollments per course within the bar graph.

![](<../../../../PRD/prd-ed-td-req-4cc/images/storage/Screen Shot 2019-03-22 at 11.53.22 AM.png>)

Report 2Purpose of this report is to provide course completion count by district. Any state teacher who does not have district mapped in their profile need to be tagged to 'Others' district and shown in this report.

Report title: Course Completion Report by District

X-axis: No. of teachers who have completed the course

Y-axis: District Name

Within each bar graph show course wise completion. Each individual course has an unique color.

Raw information in a tabular format needs to be provided which can be downloaded.

![](<../../../../PRD/prd-ed-td-req-4cc/images/storage/Screen Shot 2019-03-22 at 12.00.57 PM.png>)

JIRA Ticket ID[SB-11304 System JIRA](https://browse/SB-11304)

Localization Requirements

| UI Element | Description | Language(s)/ Locales Required |
| ---------- | ----------- | ----------------------------- |
| None       |             |                               |
|            |             |                               |

Telemetry Requirements

| Event Name                | Description                                                                                             | Purpose                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| Click on 'Download' event | All the above reports will also have a 'Download' button to allow state admin to download the raw data. | By tracking this event we would like to track the usage of download feature. |

Non-Functional Requirements

| Performance / Responsiveness Requirements                                                                                               | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective.                          | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
| These reports are rendered on portal and hence should be compatible with the browsers and devices that are compatible with the portal.  |                                                                                               |                                                                     |
| The data that is shown in this dashboards should match with the data on the Course dashboard published to the course mentors.           |                                                                                               |                                                                     |

Impact on other Products/Solutions

| Product/Solution Impacted                                                     | Impact Description                                 |
| ----------------------------------------------------------------------------- | -------------------------------------------------- |
| Specify the name of the product/solution on which this use case has an impact | Explain how the product/solution will be impacted. |
|                                                                               |                                                    |

Impact on Existing Users/Data&#x20;

| User/Data Impacted | Impact Description |
| ------------------ | ------------------ |
| None               |                    |
|                    |                    |

Key Metrics

| Srl. No. | Metric             | Purpose of Metric                                |
| -------- | ------------------ | ------------------------------------------------ |
| 1        | Course enrollments | track course adoption                            |
| 2        | Course completions | track course completion metric                   |
| 3        | Time spent         | track on an average the time spent on the course |

***

\[\[category.storage-team]] \[\[category.confluence]]
