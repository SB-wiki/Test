# SUNBIRD.ED-DASHBOARDS-2.0

IntroductionThis PRD addresses the following jobs for Dashboards:

* Configuration settings for Reports
* Dynamic filters for dashboards
* Introduction of new dashboards that provide capability for analysis by District:

1. Users Report
2. QR Code analysis
3. Content Usage&#x20;

JTBD

* **Jobs To Be Done:** States and administrators have a need to drive usage targets. This will require administrators to be able to measure usage by district, and assign action items to people at a district level in order to improve usage.
  * There are no dashboards that report metrics split by districts as of today. The dashboards need to provide dynamic capability to users in terms of being able to filter for a specific time range, specific region(s) of choice etc.
* **User Personas:** Users with the 'Report\_Viewer' role. Typically admin users and bureaucrats in the state who will want to monitor usage numbers and drive actions based on these - such as driving officials to increase usage in specific districts/ schools.&#x20;

Requirement SpecificationsReport Configurations:This story lists the additional configurations that need to be made available for each Report::

* The ability to specify what tenants a Report should be enabled for (None, All, Tenant1, Tenant2 etc.) - the report should show only in tenants that it is enabled for
* Ability to specify what tabs the report should show - Graph / Table 1 / Table 2 etc.
* Dynamic filters that need to be enabled at the (report + Tab) level - Filters for Time / District (col. 'x' in the data table). Filters could be different for diff. reports as well as different for different tabs in the same filter . &#x20;
* Set as a report configuration, which location value the report should use - Device profile (IP based) or User Profile (Org association based)
* &#x20;

These configurations are to be made by the implementation team when the report is set up

Dynamic Filters:Some reports will require filtering capabilities so that users can narrow down the data set to their time period/ region of interest. Filters should apply to both the graph tab as well as the 'Table' tabs. Once the filter is set by the user, both the graph and the table should reflect the new values as per the filters.

The filter should also provide a 'Reset Filter' capability that removes all filter conditions applied to the filter.&#x20;

Filters should be configurable at a \[Report + Tab] level, so that different filters can be set for charts/ tables shown in different tabs.

The current fields that are likely to be used for filtering data include:

* Time Range (Start Date - End Date) : The filter should be bound by the first date and the last date available in the underlying data
* Geographical region : The parameters for filtering could be City or District \[multi-select]
* User Role : Student / Teacher / Undeclared \[multi-select]
* Access Point : Portal / App

New Dashboard :: Users Report by District

The users report will be used to keep track of the number of distinct users on the platform (portal + app). The unique device ID (Context\_did) field will be used as a proxy for a unique user count.&#x20;

This data will be required to get generated daily.

The report will have both the total number as well as the day-wise distribution available.&#x20;

The variables for this report dataset include:

| Field                                                             | Druid Dimension                                                        |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------- |
| Date                                                              | ets                                                                    |
| Unique User ID                                                    | uid                                                                    |
| State                                                             | device\_loc\_state                                                     |
| City (multi select - C1, C2, C3..... , all)                       | device\_loc\_city                                                      |
| District (multi select - D1, D2, D3..... , all)                   | device\_loc\_city                                                      |
| Access Point (App, Portal, Both)                                  | context\_pdata\_id                                                     |
| User Type (Validated State user, Self signed up user, Guest, All) | actor\_type = "User" & (context\_channel = custodian OR tenant org ID) |
| Role (Teacher, Student, Both)                                     | user\_type                                                             |
|                                                                   |                                                                        |
|                                                                   |                                                                        |
|                                                                   |                                                                        |
|                                                                   |                                                                        |
|                                                                   |                                                                        |
|                                                                   |                                                                        |

This report will use the IP based location (device profile)

City and State will be made available from IP resolution. In case the state has provided the City-District mapping, the District information will also be available. If not, the District fields will not have any values.

The report will provide filters for the users to be able to slice data based on the following parameters:

**City, District, Access Point, User Type, Role**

### Wireframes

Attach wireframes of the UI, as developed by the UX team for screens required for this story  &#x20;

**JIRA Ticket ID** Report Configurations : [SB-11418 System JIRA](https://browse/SB-11418)

Dynamic Filters : [SB-11624 System JIRA](https://browse/SB-11624)

Users Report by District: [SB-11626 System JIRA](https://browse/SB-11626)

\<Use Case 1 - User Story 2> OverviewRepeat the entire Section and its corresponding subsections to elaborate the next user story in the use case. Repeat the section as many times as required.&#x20;

Telemetry RequirementsThe dashboard page needs to be instrumented in order to measure aspects such as number of visits to the page, which reports are being viewed, how many times etc. See link to Jira ticket

[SB-10574 System JIRA](https://browse/SB-10574)

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                |                                                                                               |                                                                     |

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
