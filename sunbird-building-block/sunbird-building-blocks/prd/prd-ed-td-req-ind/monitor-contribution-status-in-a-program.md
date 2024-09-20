# Monitor-Contribution-Status-in-a-Program

IntroductionThis document describes requirements related to "Monitor Contribution Status" of Textbooks in a Program. Following diagram depicts L1 and L2 flows of the overall program driven content sourcing flow.

[https://miro.com/app/board/o9J\_ky31DBw=/?moveToWidget=3074457347134589331](https://miro.com/app/board/o9J\_ky31DBw=/?moveToWidget=3074457347134589331)

JTBD

* \*\*Jobs To Be Done: \*\* As a Program Admin, I want to monitor the status of content contribution to the textbooks in the scope of the Program
* **User Personas:**  The logged-in users who have State Admin role, Report Viewer role, Book Creator role, Book Reviewer role can access this report.
* **System or Environment:**  Works on for desktops with Chrome browser only.

Requirement SpecificationsTwo reports defined below will help tracking the progress of content contribution for a specific Program scope.

**Key Points applicable to all reports:**

* Reports will include the latest information about all the Textbooks in the current scope of the Program.
* Provide the ‘ **As On** ’ status with aggregated information on specific attributes.
* The reports need to show only the version of that Textbook that is in the Program.
* All Reports detailed in following sections are extensions to the existing ETB Creation Reports that are showing up in portal dashboards page. All columns from existing ETB Creation Report should have the same functionality.
* Additional Columns are related to the number of contents categorized across the Content Types. These are the Content Types configured in the Program
* Each of the Report is downloaded as a CSV file with the given columns.
* This report should be updated on a real-time basis.
* This report is available only in the program dashboard. &#x20;

### Reports Page

All the Reports and Graphs are accessed from "Reports" page of a Program. It is accessible by Program Admin, Report Viewer, Textbook Creators and Textbook Reviewers.

Reports Page displays Graphs and following options: "Download Summary Report" and "Download Detailed Reports".

Clicking on "Download Summary Report", downloads Summary Report as CSV

Clicking on "Download Detailed Report", downloads Detailed Report as CSV

#### Wire-frames

![Program Summery Report](<../../../../PRD/prd-ed-td-req-ind/images/storage/image (1).png>)

Summary Report

| Text Book Id | Medium | Grade | Subject | Text Book Name | Textbook Status | Created On | Last Updated On | Total content linked | Total QR codes with content linked | Total QR Codes with no linked content | Total number of leaf nodes | Number of leaf nodes with no content | Live        | Review           | Draft      | Live | Review | Draft | Live | Review | Draft | Live | Review | Draft | Live | Review | Draft | Live | Review | Draft |
| ------------ | ------ | ----- | ------- | -------------- | --------------- | ---------- | --------------- | -------------------- | ---------------------------------- | ------------------------------------- | -------------------------- | ------------------------------------ | ----------- | ---------------- | ---------- | ---- | ------ | ----- | ---- | ------ | ----- | ---- | ------ | ----- | ---- | ------ | ----- | ---- | ------ | ----- |
|              |        |       |         |                |                 |            |                 |                      |                                    | Explanation Resource                  | Experiential Resource      | Practice Question Set                | Lesson Plan | Learning Outcome | Focus Spot |      |        |       |      |        |       |      |        |       |      |        |       |      |        |       |
|              |        |       |         |                |                 |            |                 |                      |                                    |                                       |                            |                                      |             |                  |            |      |        |       |      |        |       |      |        |       |      |        |       |      |        |       |
|              |        |       |         |                |                 |            |                 |                      |                                    |                                       |                            |                                      |             |                  |            |      |        |       |      |        |       |      |        |       |      |        |       |      |        |       |

* The report will include all the Textbooks which are in the specific Program scope
* Each Row of this report will be one Textbook
* Textbooks are sorted by Medium, Grade, Subject, Textbook Name (in that order).
* Name of the downloaded CSV file is <>\_<>\_Summary
* Total QR Codes with content linked - These are the number of QR Codes in the Textbook with one or more content linked to the corresponding unit or its children
* Total QR Codes with no content linked - These are the number of QR Codes in the Textbook with no content linked to the corresponding unit or its children
* Total number of leaf nodes - Total number of units in the textbook without any unit under it
* Number of leaf nodes with no content - Total number of units in the textbook without any unit under it and with no content linked to it

Detailed Report

| Text Book Id | Medium | Grade | Subject | Textbook Name | Textbook Status | Level 1 Name | Level 2 Name | Level 3 Name | Level 4 Name | QR Code | Number of contents | Live                 | Review                | Draft                 | Live        | Review           | Draft      | Live | Review | Draft | Live | Review | Draft | Live | Review | Draft | Live | Review | Draft |
| ------------ | ------ | ----- | ------- | ------------- | --------------- | ------------ | ------------ | ------------ | ------------ | ------- | ------------------ | -------------------- | --------------------- | --------------------- | ----------- | ---------------- | ---------- | ---- | ------ | ----- | ---- | ------ | ----- | ---- | ------ | ----- | ---- | ------ | ----- |
|              |        |       |         |               |                 |              |              |              |              |         |                    | Explanation Resource | Experiential Resource | Practice Question Set | Lesson Plan | Learning Outcome | Focus Spot |      |        |       |      |        |       |      |        |       |      |        |       |
|              |        |       |         |               |                 |              |              |              |              |         |                    |                      |                       |                       |             |                  |            |      |        |       |      |        |       |      |        |       |      |        |       |
|              |        |       |         |               |                 |              |              |              |              |         |                    |                      |                       |                       |             |                  |            |      |        |       |      |        |       |      |        |       |      |        |       |

* The report will include all the Textbooks which are in the specific Program scope
* Each Row of this report will be one Node in the Textbook. This will be same as in current detailed report of ETB Creation Status Report
* All the Textbooks are sorted by Medium, Grade, Subject, Textbook name, Textbook chapter index level (in that order).
* Name of the downloaded CSV file is <>\_<>\_Report
* Level 1, Level 2, Level 3, Level 4 Names - Names of the Textbook Units at level 1, 2, 3 and 4

**Sample Report**

**250250**

Localization RequirementsNA

Telemetry Requirements

| Event Name               | Description                                                                                                                                                                     |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Open Reports Page        | This event is generated when a user opens Reports page in a Program. Apart from common set of data, Program Id should be captured in the event.                                 |
| Download Summary Report  | This event is generated when a user clicks on "Download Summary Report" option in the Reports page. Apart from common set of data, Program Id should be captured in the event.  |
| Download Detailed Report | This event is generated when a user clicks on "Download Detailed Report" option in the Reports page. Apart from common set of data, Program Id should be captured in the event. |

Non-Functional Requirements

| Performance / Responsiveness Requirements                              | Load/Volume Requirements                                                                                   | Security / Privacy Requirements |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------- |
| Report should work correctly for English and Non-English Textbook ToCs | The report should work for same number of textbooks and sizes as ETB Creation Reports in current dashboard | NA                              |

Jira Ticket[SB-16762 System JIRA](https://browse/SB-16762)

Impact on other Products/SolutionsETB Creation Reports will continue as it is for all configured Tenants.

Impact on Existing Users/Data NA

Key Metrics

| Srl. No. | Metric                                  | Purpose of Metric                                        |
| -------- | --------------------------------------- | -------------------------------------------------------- |
|          | Number of users downloading the Reports | Track the effectiveness of features through their usage. |

***

\[\[category.storage-team]] \[\[category.confluence]]
