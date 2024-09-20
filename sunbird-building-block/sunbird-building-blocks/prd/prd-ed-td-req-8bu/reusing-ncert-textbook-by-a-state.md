# Reusing-NCERT-Textbook-By-a-State

IntroductionOne of the themes of ETB is enabling multiple states and boards across the system to adopt and reuse ETBs published by a publisher.

NCERT is publishes books. They also have QR codes printed and digital content linked to it. NCERT is creating corresponding ETBs on DIKSHA. Many states use the NCERT books as is in their curriculum. All those states can potentially reuse the same ETBs. This document details various use cases of states adopting and reusing NCERT ETBs..&#x20;

In this document, where ever it is mentioned as a "State", it includes any other board like CBSE as well.

JTBD

* **Jobs To Be Done 1:** As a textbook creator of a state, I want to reuse one or more NCERT textbooks my state and want it to open for state user consumption.
* **Jobs to be Done 2 -** As a user of a state, I want to consume NCERT textbooks content reused in my state

Requirement Specifications

### Use Case 1: Adopt NCERT Textbooks by a State "as is"

This use case details the requirements of states being able to adopt Live NCERT ETBs, "as is" without any modifications to its metadata, ToC, QR codes and linked content.

States are not allowed to make any changes. Same instance of ETB is used by the states and hence any changes to the NCERT ETB should automatically get reflected to all the states adopting it.

#### Creation (non self-service)

This flow describes how a state can specify the list of textbooks that they would like to reuse as it is. Currently this can happen only through a back end script.

* Once NCERT is onboarded, framework assigned, content/textbooks & QR codes are imported, linked and published, its textbooks can be reused by other state.
* State specifies list of NCERT textbooks it wants to reuse in a csv (with columns: do\_id) along with details of state and textbook creator's credentials.
* Back-end team will upload the information and the textbooks will be tagged as reused by the state with state's board tagged to it. To reiterate, reused TB is not a new instance of NCERT textbook, rather it is essentially the source book with same do\_id.

JIRA Ticket ID[SB-15417 System JIRA](https://browse/SB-15417)

#### Consumption

Once one or more NCERT textbooks are tagged for reuse by a state, there are following ways to consume the content:

Scan QR code from NCERT textbook (from DIKSHA App)Display linked content to the QR code. Once user plays the content and comes back to Library page, in case Board is not set, display a popup that asks user to select the Board.

User selects the states's board and goes to library page (from DIKSHA App)Display the NCERT textbooks reused by the state along with any other textbooks created by the state.

Enter NCERT QR code on DIKSHA portal Display linked content to the QR code.

Access NCERT DIKSHA page and explore content (d[iksha.gov.in/ncert/explore](http://diksha.gov.in/ncert/explore)).View NCERT textbooks and content first before viewing other content

Search textbooks and filter by the state's BoardShow up NCERT textbooks reused by the state.

User opens explore page from the state's DIKSHA page on portalThe imported NCERT textbooks are shown along with any other textbooks created by the state first (sort order).

JIRA Ticket ID[SB-15418 System JIRA](https://browse/SB-15418)

### Use Case 2: Adopt NCERT Textbook by a State by tagging state framework specific mediums

The first use case, Adopt NCERT Textbooks by a State "as is" - details requirements of states adopting the NCERT ETBs as it is without any changes.

However there is a use case where NCERT ETB would be used by teachers and students of a different medium of a state. For example an ETB of Class 7, English Subject in English Medium of NCERT could be used as English Subject ETB in both English Medium and Gujarati Medium Class 7 in Gujarat. In this case, when a teacher or student from Gujarat Board, Class 7, Gujarati Medium (with these values set in their her) access Library page in Mobile App, she should see the adopted NCERT ETB under English Subject. The same should work when someone searchers and filters ETBs by Gujarat Board, Class 7, Gujarati Medium.

User Story: State adopts a list of NCERT ETBs tagged to Mediums in their K-12 curriculum framework

| Srl. No. | User Action                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | Expected Result                                                                                                                                                                                                                    |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | State user provides list of Textbook ids along with Mediums to which each Textbook has to be tagged under their Board.Medium values can be more than one and are separated by commas.Following is the file format: [https://docs.google.com/spreadsheets/d/1YbVZvTx2l1iH8XLjkNZ2Retr3pGQLPjCz74WWc4FIhU/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1YbVZvTx2l1iH8XLjkNZ2Retr3pGQLPjCz74WWc4FIhU/edit?usp=sharing)The file is shared with implementation team for updating. | Implementation team creates a script to update the information through the back end using platform API.Once updated successfully, all the given ETBs will be accessible to the users as described in the Consumption user stories. |

#### Assumptions

1. The adopted ETB always points to the latest Live version of the corresponding NCERT ETB.
2. All ETBs being adopted are in Live state. API will throw error in case the ETBs are not in Live state
3. Adopted textbooks are not shown in the Workspace of any user in the state tenant - as of now. This would get changed once the adoption is enabled through front end
4. Medium(s) are mandatory (at least 1) to be given for each ETB (Textbook) id.
5. Tagging of "Medium" by a state adopting a textbook is specific to the Board and framework to which it is being adopted. For example, say an NCERT English Subject, Class 7 ETB is adopted by Gujarat and is tagged to "Gujarati" medium in "Gujarat State Board". Say, Maharashtra State Board also has Gujarati medium in its framework. Now, a user with Maharashtra State Board, Class 7. Gujarati medium profile should NOT see the NCERT ETB in the library page under English Subject.
6. "Subject", "Grade" and all other metadata are as it is inherited from NCERT ETB.
7. The values provided are always updated (not appended to existing values). For example, say an NCERT English Subject, Class 7 ETB is adopted by Gujarat and is tagged to "Gujarati" medium in "Gujarat State Board". Next time say the same textbook id is adopted again and tagged to "English" medium in "Gujarat State Board". Then the tagging of "Gujarati" medium will get overridden by "English" medium for that board.

#### Error Scenarios in Input csv

1. Textbook id given in the input file is incorrect or it is not in Live status
2. There is no Board or Medium given in the input file for a textbook
3. Board or Mediums given in the input file do not exist in the framework of the state that is adopting the textbooks

Any of these errors will be reported back to the initiator by implementation team.

User Story: Consumption of NCERT adopted textbooks by tagging to state framework specific mediums

| Srl. No. | User Action                                                                                                                     | Expected Result                                                                                                         |
| -------- | ------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
|          | DIKSHA App library page: When user selects the state board, medium, grade , subject                                             | The adopted books should be displayed under corresponding mediums, classes and subjects as tagged by adopted textbooks. |
|          | DIKSHA App Search and Filter - When a user searches for textbooks and filters on state board, medium, grade , subject           | The adopted books should be displayed under corresponding mediums, classes and subjects as tagged by adopted textbooks. |
|          | DIKSHA Portal Library page of the State - When user (anonymous or signed in) goes to the library page of state on DIKSHA portal | The adopted textbooks should be shown.                                                                                  |
|          | DIKSHA Portal Search and Filter - When a user searches for textbooks and filters on state board, medium, grade, subject.        | The adopted books should be displayed under corresponding mediums, classes and subjects as tagged by adopted textbooks. |

### Use Case 3: Adopt NCERT Textbooks by a State with different metadata values

While use case 2, "Adopt NCERT Textbook by a State by tagging state framework specific mediums" is specifically to enable tagging of state framework specific mediums, this use case is to enable tagging of other metadata values that are state specific - such as name, description, icon, subject, grade.

Some states, reprint NCERT textbooks by just changing the textbook name and cover (icon). In this scenario, if users see NCERT icon and name in the corresponding ETB, it may confuse them. To avoid this, following functionality has to be enabled.

While adopting NCERT textbooks in system, state should be allowed to provide a different set of metadata values - such as Name, Description, Icon as per the state tenant. However the main body of the textbook (TOC, Linked Contents, Linked QR codes)  should not be changed. It should continue to point to the NCERT textbook. Any changes to the textbook body of NCERT textbook should automatically reflect in the state adopted textbook.

When a state adopts an NCERT textbook, the board will be changed to the state board. All other metadata will by default have values of NCERT textbook. Once a textbook is adopted by a state, any change to the metadata of the NCERT textbook will not reflect on the adopted textbook. It will only reflect to consumption experience of adopted textbook in state tenant.

The adoption of NCERT textbook by a state happens as a back end script run by implementation team (NOT Self-Service).

User Story: State adopts a list of NCERT ETBs tagged to Mediums, Subject, Grade in their K-12 curriculum framework and providing state specific Name, Description and Icon

| Srl. No. | User Action                                                                                                                      | Expected Result |
| -------- | -------------------------------------------------------------------------------------------------------------------------------- | --------------- |
|          | State user provides list of Textbook ids along with following details for each Textbook that has to be tagged under their Board. |                 |

1. Textbook Id of NCERT textbook to be adopted
2. Board, Medium, Grade, Subject, Name, Description, Icon - These are state specific values of the state that is adopting the books

Medium, Grade, Subject values can be more than one and are separated by commas.Following is the file format: [https://docs.google.com/spreadsheets/d/1YbVZvTx2l1iH8XLjkNZ2Retr3pGQLPjCz74WWc4FIhU/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1YbVZvTx2l1iH8XLjkNZ2Retr3pGQLPjCz74WWc4FIhU/edit?usp=sharing)The file is shared with implementation team for updating. | Implementation team creates a script to update the information through the back end using platform API.Once updated successfully, all the given ETBs will be accessible to the users as described in the Consumption user stories. |

#### Assumptions

1. The adopted ETB always points to the latest Live version of the corresponding NCERT ETB.
2. All ETBs being adopted are in Live state. API will throw error in case the ETBs are not in Live state.
3. Adopter details - Adoption should be tagged to a valid user in the state tenant with Textbook Reviewer role.
4. Adopted textbooks are not shown in the Workspace of any user in the state tenant - as of now. This would get changed once the adoption is enabled through front end
5. All the fields are mandatory to be given for each ETB (Textbook) id. If a state doesn't want to change any of the values, they still have to copy the values from NCERT textbook and provide it.
6. Tagging of Medium, Grade, Subject by a state adopting a textbook is specific to the Board and framework to which it is being adopted. For example, say an NCERT English Subject, Class 7 ETB is adopted by Gujarat and is tagged to "Gujarati" medium, "Cass 8" in "Gujarat State Board". Say, Maharashtra State Board also has Gujarati medium in its framework. Now, a user with Maharashtra State Board, Class 8, Gujarati medium profile should NOT see the NCERT ETB in the library page under English Subject.
7. Name, Description, Icon are specific to State.
8. The values provided are always updated (not appended to existing values). For example, say an NCERT English Subject, Class 7 ETB is adopted by Gujarat and is tagged to "Gujarati" medium in "Gujarat State Board". Next time say the same textbook id is adopted again and tagged to "English" medium in "Gujarat State Board". Then the tagging of "Gujarati" medium will get overridden by "English" medium for that board. Any update will be similar to creating a new version, users have to be notified about the updated values.
9. Any change to the metadata - M, G. S, Name, Description, Icon of original NCERT ETB does not impact adopted instance of such books in state
10. Any update to the ToC, QR Codes, linked content in NCERT automatically reflect into state adopted instances

#### Error Scenarios in Input csv

1. Textbook id given in the input file is incorrect or it is not in Live status
2. One or more fields in the input file for a textbook are empty
3. Board, Medium, Grade, Subject values given in the input file do not exist in the framework of the state that is adopting the textbooks
4. All validation of Name, Description, Icon for any textbook will be applied

Any of these errors will be reported back to the initiator by implementation team.

User Story: Adopted NCERT textbook consumption for states&#x20;

Sideloading of multi-tagged books(Mobile app & Desktop Aapp): [https://project-sunbird.atlassian.net/browse/SB-16146](https://project-sunbird.atlassian.net/browse/SB-16146)Support consumption experiences for multi-tagged books (Mobile app): [https://project-sunbird.atlassian.net/browse/SB-17653](https://project-sunbird.atlassian.net/browse/SB-17653)Support consumption experiences for multi-tagged books (Portal): [https://project-sunbird.atlassian.net/browse/SB-17764](https://project-sunbird.atlassian.net/browse/SB-17764)Consumption experiences for different cover page and name (all consumption channels): [https://project-sunbird.atlassian.net/browse/SB-17766](https://project-sunbird.atlassian.net/browse/SB-17766)Hiding the board filter on publisher tenant pages (Portal): [https://project-sunbird.atlassian.net/browse/SB-17763](https://project-sunbird.atlassian.net/browse/SB-17763)

\| |

For Future ReleaseTag Textbooks for Reuse through Portal  \*\*Tag Textbooks for Reuse \*\*

* States are to be facilitated for reusing the entire NCERT textbook as it is.
* An option can be provided under workspace for the same called " **Reuse Textbook** ". Upon clicking on it, user should be redirected to a page to search the textbooks to be reused.
* TB creator should be able to search the textbooks tagged for "Medium", "Grade", "Subject" and "Published By" (published by field which has the state name).
* The list of values to be shown in “Published By” can be configured at DIKSHA level. To start with, only NCERT to be configured.
* Upon providing the search parameters and clicking on "Search", a list of textbooks should render with following fields - Textbook Name, Medium, Grade, Subject, Published By
* There should be a check box for each textbook row, also there should be an " **Reuse** " button
* User should be able select single or multiple check boxes (for textbooks) and upon clicking on " **Reuse** ", all such selected textbooks should be reused in state.
* In case there are many textbooks falling under search criteria, appropriate pagination should be enabled
* Once NCERT textbooks are reused by a state, they are tagged to that state's board and searching textbooks using the state board should show up the reused textbooks. When NCERT textbooks are deleted, the tagging should be removed.

**Viewing Reused Textbooks**

* There should be an option , " **Delete Textbooks** " for the TB creator to view the previously reused textbooks. This option can be provided on the same landing page which is rendered when user clicks on "Reuse Textbook" from work pace
* User should be able to filter reused textbooks on the basis of -  "Medium", "Grade", "Subject" and "Published By" (published by field which has the state name).
* Textbook list should appear with following fields - Textbook Name, Medium, Grade, Subject, Published By
* User can just view these TBs but cannot make any changes at all.
* However TB creator should be provided an option to delete such TBs at any point of time as required.
* Again the list should appear with checkbox for each textbook row.
* There should be a button called " **Delete** "
* User should be able to select textbooks from checkbox and if clicks on "Delete", all such textbooks should be deleted from state.
* In case number of textbooks rendered are too many, Appropriate pagination should be enabled

### Reports (\<in JFM'20>)

Reports can be populated across following parameters:

* Scans
* Plays
* Downloads

Above parameters will be counted on the basis of Geographical location (or user profile details) of the users/device.&#x20;

Following reports shall be populated:

* Daily Usage Metrics
* QR code status
* ETB creation status

Parameters for above reports will remain same as per current reports. There will be no district level reporting.

For counting the report numbers following points should be considered:

* \*\*When NCERT textbook is only used in NCERT \*\* means there is no reuse of such TBs. In this case any activity (for scan, play or download) will increase numbers for NCERT only.
* **When NCERT textbook is reused by another state** and the consumption (scan, play, download) is done by that state user only. The consumption is attributed to a state when the device location is from the state

Localization RequirementsN/A

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                                     | Description                                                       | Purpose                                                      |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------------ |
| Mention the event that will generate telemetry and which needs to be captured. | Provide event details. e.g. clicking upload for textbook taxonomy | Provide a reason why the event telemetry should be captured. |

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
