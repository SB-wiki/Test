# DIKSHA-Usage-Report

_Instructions to use this template:_

1. \_Use this template to write the Product Requirements Document (PRD) for a single User JTBD or Initiative. \_
2. _Each workflow within the PRD will correspond to an Epic in JIRA. Each User Story will correspond to a Story in JIRA that will be part of the Epic._
3. \_Each section in the template has instructions, with examples explaining the type of content to be written in that section. \_
4. _You may start typing into the section by eliminating the instructional text, or delete the instructional text after you have entered all content for the section._
5. _Repeat from section \<Use Case 1> Overview for every use case in the User JTBD or Initiative_

IntroductionThis report provides details of DIKSHA usage in terms of QR code Scans, Content Downloads, and Content Play. All the graphs show the usage status per day. This report is updated every day. The data and dashboards are state specific.

JTBDUse this section  to elaborate on:

* **Jobs To Be Done:** As a state admin, I want to have a look at various aspects of ETB such as consumption failures, etc.
* **User Personas:**  The logged-in users who have State Admin role, Report Viewer role can access this report.
* **System or Environment:**  Works on for desktops with Chrome browser only.

Requirement SpecificationsThis report will have 2 fields i.e; graph and Table. Below are the details

1. **Graphs**
   1. **QR Code Scans per day:** This graph shows total no of QR code scans, per day.
   2. **% Failed QR code scans per day:** This graph shows the percentage of faild QR code scans, per day.
   3. **Content Download per day:** This graph shows the total number of content downloaded (from app), per day.
   4. **Content Plays (Portal and APP) per day:** This graph shows the total no of times contents are played (on Portal and App), per day.&#x20;
   5. **Hours of content played per day:** This graph shows the total number of hours for which content are played (on Portal and App), per day.
2. \*\*Table \*\*

| Date | Total QR Scans | Successful  QR Scans | Failed Scans | Percentage (%) of Failed QR Scans | Total Content Downloads | Total Content Plays on App | Total Devices that played content on App | Content Play Time on App (in hours) | **Total devices that played content on Portal:** | Total-Content Plays on Portal | Content Play Time on Portal (in hours) | Total Content Plays | Total Content Play Time (in hours) |
| ---- | -------------- | -------------------- | ------------ | --------------------------------- | ----------------------- | -------------------------- | ---------------------------------------- | ----------------------------------- | ------------------------------------------------ | ----------------------------- | -------------------------------------- | ------------------- | ---------------------------------- |
|      |                |                      |              |                                   |                         |                            |                                          |                                     |                                                  |                               |                                        |                     |                                    |

**Description:** This report provides details of Diksha usage in terms of QR code Scans, Content Downloads, and Content Play, All the graphs show usage status per day. This report is updated every day. &#x20;

**Data Fields**

**Date:**  Date when data is captured.

**Total QR Scans:** Total number of scans for the particular day

Logic:  Total no. of scans done on QR codes which are allocated to the specific state (irrespective of whether the QR code is linked to a Textbook or not)

NOTE : Total scans (successful + Failed)  should be calculated based on the QR code linked to that state tenant and not by the device location.

**Successful  QR Scans:** Total number of QR code scans which rendered content successfully upon scan

Logic: Scans of the QR Codes where: QR Code is present in a Textbook created in the state tenant AND the textbook section to which QR Code is mapped has content linked in it.

**Failed Scans:** Total number of scans for which the user did not get any linked content

Logic: QR Code is allocated to the state but not present in any of the Textbooks OR QR Code is present in a Textbook created in the state tenant AND the Textbook section to which QR Code is mapped has NO content linked in it

If the same QR Code is linked in multiple Textbooks and in one of the Textbook if there is content and in rest of the books if there is no content, then also it should be considered as Failed scan.

If the QR code is linked to multiple textbooks and in any of the book, if there is no content then only it is considered as Failed scan.

As the same QR code is used in all textbooks, the failed scan count should be only considered once (same QR code)

**Percentage (%) of Failed QR Scans:**   Percentage of failed scans

Logic: Failed Scans /  Total QR Scans

**Total-Content Downloads:** Total number of contents downloaded on a specific day

Logic: The content is downloaded either by scanning a state-specific QR code OR accessed through a Textbook created in the state tenant (by navigating from the Textbook). If a content is downloaded directly through a search, then it is NOT counted.

**Total number of Content Plays on App:** Total number of contents played on the App (which includes both online content plays and downloaded content plays)

Logic: Total no of times content is played (online or downloaded content) where the content is played either by scanning a state-specific QR code OR accessed through a Textbook created in the state tenant (by navigating from the Textbook). If a content is accessed and played either directly through a search OR from Recently Viewed section in App, then it is NOT counted. If same content is played multiple times, all the plays are included in the total count.

\*\*Total unique devices that played content on App: \*\* Overall in how many devices did the content has been played.

Logic: Unique count of devices which played a content - for all the content calculated in the logic detailed in " **Total number of Content Plays on App"**

**Total time of Content Play on App (in hours):**

Logic: Total  time (in hours) spent on a content play - for all the content calculated in the logic detailed in " **Total number of Content Plays on App"** &#x20;

**Total number of Content Plays on Portal:** Total number of content played on the portal

Logic: Total number of contents played where the content is played either by searching a state-specific QR code OR accessed through a Textbook created in the state tenant (by navigating from the Textbook). If a content is accessed and played either directly through a search then it is NOT counted. If same content is played multiple times, all the plays are included in the total count.

\*\*Total unique devices that played content on Portal: \*\* Overall in how many devices did the content has been played.

Logic:  Unique count of devices which played a content - for all the content calculated in the logic detailed in " **Total number of Content Plays on Portal"**

**Total time of Content Play on Portal (in hours):**

Logic: Total time spent (in hours) on a content play - for all the content calculated in the logic detailed in " **Total number of Content Plays on Portal"**

**Total number of Content Plays:** Total no of content played both on App and the Portal

Logic:  **Total number of Content Plays on App** +  **Total number of Content Plays on Portal**

**Total time of Content Play including both app and portal (in hours):**

Logic:  **Total time of Content Play Time on App (in hours)** +  **Total time of Content Play Time on Portal (in hours)**

Note:

* **The report should be generated on a daily basis with the previous day data.**
* **In this report, all the values should be generated based on QR code scans or ETB which are linked to that specific state.**
* **This report should not be generated based on the device location.** \*\* \*\*

#### Logic for Metrics

QR Scans

* Data Source: denormed-telemetry/raw in Azure
* State Attribution: dialcodedata.channel
* Total QR Scans:&#x20;
  * Failed QR Scans + Successful QR Scans
* Successful QR Scans:
  * eid = SEARCH
  * edata.filters.dialcodes IS NOT NULL
  * edata.size > 0
* Failed QR Scans:
  * eid = SEARCH
  * edata.filters.dialcodes IS NOT NULL
  * edata.size = 0
* Percentage (%) of Failed QR Scans:
  * Failed QR Scan \* 100 / Total QR Scans

Content Downloads

* Data Source: denormed-telemetry/raw in Azure
* State Attribution: Textbook Channel (Computed by mapping the content identifier to a textbook hierarchy snapshot)
* Total Content Downloads:
  * eid = INTERACT
  * edata.subtype = ContentDownload-Success
  * context.pdata.id = prod.diksha.app

Content Plays

* Data Source: denormed-telemetry/summary in Azure
* State Attribution: Textbook Channel (Computed by mapping the object.rollup.l1 to textbook hierarchy snapshot)
* Total Content Plays on App:
  * dimensions.pdata.id IN \["prod.diksha.app", "prod.diksha.portal"]&#x20;
  * dimensions.mode = play
  * dimensions.type = content
  * count(dimensions.sid)
* Total Devices that played content on App:
  * dimensions.pdata.id = prod.diksha.app
  * dimensions.mode = play
  * dimensions.type = content
  * countDistinct(dimensions.did)
* Content Play Time on App (in hours):
  * dimensions.pdata.id = prod.diksha.app
  * dimensions.mode = play
  * dimensions.type = content
  * sum(edata.eks.time\_spent)/3600
* Total-Content Plays on Portal:
  * dimensions.pdata.id = prod.diksha.portal
  * dimensions.mode = play
  * dimensions.type = content
  * count(dimensions.sid)
* Total devices that played content on Portal:
  * dimensions.pdata.id = prod.diksha.portal
  * dimensions.mode = play
  * dimensions.type = content
  * countDistinct(dimensions.did)
* Content Play Time on Portal (in hours):
  * dimensions.pdata.id = prod.diksha.portal
  * dimensions.mode = play
  * dimensions.type = content
  * sum(edata.eks.time\_spent)/3600
* Total Content Plays:
  * Total Content Plays on App + Total-Content Plays on Portal
* Total Content Play Time (in hours):
  * Content Play Time on App (in hours) + Content Play Time on Portal (in hours)

JIRA Ticket ID[SB-13068 System JIRA](https://browse/SB-13068)

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element | Description | Language(s)/ Locales Required |
| ---------- | ----------- | ----------------------------- |
| NA         | NA          | NA                            |
|            |             |                               |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                                     | Description                                                       | Purpose                                                      |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------------ |
| Mention the event that will generate telemetry and which needs to be captured. | Provide event details. e.g. clicking upload for textbook taxonomy | Provide a reason why the event telemetry should be captured. |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements | Load/Volume Requirements | Security / Privacy Requirements |
| ----------------------------------------- | ------------------------ | ------------------------------- |
| NA                                        | NA                       | NA                              |
|                                           |                          |                                 |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted | Impact Description |
| ------------------------- | ------------------ |
| NA                        | NA                 |
|                           |                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted | Impact Description |
| ------------------ | ------------------ |
| NA                 | NA                 |
|                    |                    |

Key Metrics

***

\[\[category.storage-team]] \[\[category.confluence]]
