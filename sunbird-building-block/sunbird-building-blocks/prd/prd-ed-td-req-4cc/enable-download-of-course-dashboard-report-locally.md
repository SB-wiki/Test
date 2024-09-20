# Enable-download-of-course-dashboard-report-locally

IntroductionCourse mentor can view the course dashboard and can also download the report as a csv file. Currently when the course mentor clicks on download, the csv file is sent to the registered email address of the course mentor. Most of the course mentors have mobile numbers but do not have active email IDs. Hence the need to allow this download on the requestors' local machine.

User Story 1 - OverviewAs a course mentor I want to be able to download course dashboard report locally so that I can apply filters and carry out data analysis around course enrollment and completion metrics.

Scenario: Course mentor navigates to course dashboard, selects the batch for which they want to view the report (in case they are assigned as mentors to multiple batches) and clicks on download.

| Srl. No. | User Action                                                 | Expected Result                                                                                                                                                                                                                |
| -------- | ----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1        | Course mentor clicks on download - download is successful   | File download is initiated as a parallel process;User can continue with their activities on DIKSHA;User is notified once the download is complete;                                                                             |
| 2        | Course mentor clicks on download - download is unsuccessful | File download is initiated as a parallel process;User can continue with their activities on DIKSHA;User is notified that ‘Download has failed. Please try again after sometime’;                                               |
| 3        | Course mentor clicks on download multiple times             | When the download button is clicked for the first time the download is initiated;When the user clicks on download button for the second time then the user is notified that ‘Download in-progress. Please try after sometime’. |

WireframesN/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-11943 System JIRA](https://browse/SB-11943)Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name | Description                                | Purpose                                                      |
| ---------- | ------------------------------------------ | ------------------------------------------------------------ |
| Download   | Capture the click event of download button | This event will help us understand the usage of this feature |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                                                                                                                                                                | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective.                                                                                                                                           | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
| Batch size (<10k): Download time should be less than 10 secs;Batch size (10k-50k): Download time should be less than 20 secs;Batch size (50k -1L):Download time should be less than 60 secs;Batch size (>1L):Download time should be less than 120 secs; |                                                                                               |                                                                     |

Impact on other Products/SolutionsWe are deprecating the feature to send the download via email to the course mentors. Instead enabling the download to happen locally on the requestor's machine.

Impact on Existing Users/Data N/A

Key MetricsN/A

***

\[\[category.storage-team]] \[\[category.confluence]]
