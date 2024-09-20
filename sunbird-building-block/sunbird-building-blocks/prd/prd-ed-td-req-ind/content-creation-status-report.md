# Content-Creation-Status-Report

IntroductionThis document describes requirements for Content Creation Status Report. This report is for organizations to track the status of their content creation activities with respect to ETB.

State ETB Admin will view the report on a weekly basis to know how many content have been created, how many are in review state and how many are published. Using this data, they would drive creators and reviewers to complete as per the plan.

This report has already been shared with several states as an ad-hoc report and they have been using it.

JTBD

* **Jobs To Be Done:** As a content admin of a tenant, I want to track the status of the content created in my tenant
* **User Personas:**  The logged-in users who have Report Viewer role in the system.
* **System or Environment:**  Works on for desktops with Chrome browser only.

Requirement Specifications

### Admin Dashboards Page

Admin dashboards page will have a new Report in the Reports list menu in the left side called "Content Creation Status Report" at the end of the list.

Content Creation Status Report

| Board | Medium | Grade | Subject | Content Id | Content name | Status | Created On | Pending in current status since | Created By |
| ----- | ------ | ----- | ------- | ---------- | ------------ | ------ | ---------- | ------------------------------- | ---------- |
|       |        |       |         |            |              |        |            |                                 |            |
|       |        |       |         |            |              |        |            |                                 |            |

* The report will include all the content of the tenant
* Each Row of this report will be one content
* Content is sorted by Medium, Grade, Subject, Content Name (in that order)
* Name of the downloaded CSV file is <>\_Content\_Creation\_Status
* The report is generated on a weekly basis and shows the status at the time of the generation

### Graphs

Following graphs are shown on the Content Creation Status Report page:

1. Content Creation Status: Class-Wise
2. Content Creation Status: Subject-Wise

These graphs are similar to Class-wise, Subject-wise bar graphs for Textbooks, displayed in ETB Creation Status Reports page on Dashboards page. Instead of the Textbooks, the numbers show Contents in the specific category.

Localization RequirementsNA

Telemetry Requirements

| Event Name                               | Description                                                                        |
| ---------------------------------------- | ---------------------------------------------------------------------------------- |
| Open Content Creation Status Report Page | This event is generated when a user opens this report page from dashboard page     |
| Download Report                          | This event is generated when a user clicks on "Download Report" option in the page |

Non-Functional Requirements

| Performance / Responsiveness Requirements                                                                       | Load/Volume Requirements                         | Security / Privacy Requirements |
| --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | ------------------------------- |
| Page should be loaded in less than 2 secsReport should work correctly for English and Non-English Content Names | Report should work for at least 50.000 contents. | NA                              |

Jira Ticket[SB-16763 System JIRA](https://browse/SB-16763)

Impact on other Products/SolutionsNA

Impact on Existing Users/Data NA

Key Metrics

| Srl. No. | Metric                                                           | Purpose of Metric                                        |
| -------- | ---------------------------------------------------------------- | -------------------------------------------------------- |
|          | Number of users accessing the Report page downloading the report | Track the effectiveness of features through their usage. |

***

\[\[category.storage-team]] \[\[category.confluence]]
