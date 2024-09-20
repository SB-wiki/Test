# PRD---DIAL-Scan-results-v2

IntroductionAs a teacher/student, I would like to see content linked to a DIAL code in my book in a structured format. If there is a lot of content (For e.g. a textbook level DIAL code), it would be good to select a chapter to jump to the content most relevant to me.

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* User scans a DIAL code, and wants to consume content contextual to what they're studying at the moment. If the user scans a book-level code or a code which has a lot of branches and content under it, then it's hard to find the right content that I want right now. As a user, I'd like to quickly find the most relevant content from the current scan for me to consume right away.
* **User Personas:**   [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student)
* **System or Environment:**  Mostly home, some likelihood of being in school.

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

OverviewAs a user, I might scan a QR code and find a lot of content linked to it. It would be good to see it categorized neatly, so I can quickly jump to the section most relevant to me.

Overall Process Workflow

1. User scans a DIAL code with a lot of content attached to it.
2. User sees the list of content associated with the DIAL code.
3. User taps on the Select Chapter row.
4. User sees the relevant sections associated with this DIAL code only.
5. User taps on the section of interest and the user is taken to the start of that section in the flattened DIAL result.

Single Unit linked to DIAL - OverviewUser scans a high-level DIAL Code and wants to jump to a specific sub-section within that.

Main Scenario

| Srl. No. | User Action                                                               | Expected Result                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| -------- | ------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User scans DIAL code (preferably at a level as close to root as possible) | User sees a flattened set of DIAL results.                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | User taps on 'Select Chapter'                                             | User sees the section of the TOC directly under this DIAL code only.The closest node/sub-section of the first fully visible content card is highlighted, and visible atleast a couple of rows from the top of the screen. (This rule can be ignored if there aren't enough rows to fill the screen)Each top-level chapter has separators, and the corresponding header styles should apply based on section. **The 'SELECT CHAPTER' UI inside the textbook should also be exactly the same as this.** |
|          | User selects one of the section headers                                   | The user is taken to the first content within the section header immediately.                                                                                                                                                                                                                                                                                                                                                                                                                         |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                           | Expected Handling                                                                                                                                                                               |
| -------- | ------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User taps on a section that's 'Coming Soon' | User should be taken back to the flattened results DIAL screen at the exact same offset as before, and a popup with the tenant specific 'Coming soon' message for the book should be displayed. |

Wireframes[https://projects.invisionapp.com/share/48TSWGCJNSM#/screens/383355930](https://projects.invisionapp.com/share/48TSWGCJNSM#/screens/383355930)[https://projects.invisionapp.com/share/48TSWGCJNSM#/screens/383356056](https://projects.invisionapp.com/share/48TSWGCJNSM#/screens/383356056)

For Future ReleaseA results screen that looks exactly in the same format, whether you opened the textbook or scanned the DIAL code.

JIRA Ticket ID[SB-14404 System JIRA](https://browse/SB-14404)

Multiple Units, Books or Content linked to DIAL - OverviewUser scans a high-level DIAL Code which is linked to:

* Collection/book units from different collections/books.
* Multiple books/collections
* Content from different collections/books.
* Any permutations of the above (book units and books, books and individual content etc.)

For history, refer to **PRD - ETB Consumption**

Main Scenario

| Srl. No. | User Action                                           | Expected Result                                                                                        |
| -------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
|          | User scans DIAL code that is linked to multiple books | User sees an intermediate results page - which has the list of books that are linked to the DIAL code. |
|          | User selects one of the books                         | User sees the flattened list of content as per above story.                                            |
|          | User presses BACK                                     | User sees the intermediate results page.                                                               |

Alternate Scenario 1 - Multiple book units linked to DIAL code

| Srl. No. | User Action                                                                              | Expected Result                                                                                                                                                                                                                                         |
| -------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User scans DIAL code that is linked to textbook units within two or more different books | User sees the intermediate results page - which has the list of books that are linked to the DIAL code. Since the DIAL code is linked to a textbook unit within each book, the title of the respective textbook units is displayed under the book card. |
|          | User selects one of the books                                                            | User sees the flattened list of content from the linked textbook unit. (If this is a mobile/desktop app, then the spine is downloaded in the background).                                                                                               |
|          | User presses BACK                                                                        | User sees the intermediate results page.                                                                                                                                                                                                                |

Alternate Scenario 2 - Multiple resources linked to DIAL code

| Srl. No. | User Action                                                                                   | Expected Result                                                                                                                                                                                                                               |
| -------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User scans DIAL code that is linked to individual contents within two or more different books | User sees the intermediate results page - which has the list of books that are linked to the DIAL code. Since the DIAL code is linked to a resource within each book, the title of the respective resources is displayed under the book card. |
|          | User selects one of the books                                                                 | User sees the content details page for that specific content that's linked. (If this is a mobile/desktop app, then the spine is downloaded in the background).                                                                                |
|          | User presses BACK                                                                             | User sees the intermediate results page.                                                                                                                                                                                                      |

Alternate Scenario 3 - Multiple types of content linked to DIAL code

| Srl. No. | User Action                                                                                                            | Expected Result                                                                                                                                                                                                                                                                                              |
| -------- | ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|          | User scans DIAL code that is linked to a resource from one book, a textbook unit from a second book, a third book etc. | User sees the intermediate results page - which has the list of books that are linked to the DIAL code. Since the DIAL code is linked to a textbook unit from one book and a resource from another, the title of the respective textbook unit/resource is displayed under the book card for those two books. |
|          | User selects one of the books                                                                                          | a. If linked to a textbook unit or a book - User sees the flattened list of content from the linked textbook unit.b. If linked to a content - User sees the content details page.(If this is a mobile/desktop app, then the spine is downloaded in the background).                                          |
|          | User presses BACK                                                                                                      | User sees the intermediate results page.                                                                                                                                                                                                                                                                     |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                | Expected Handling                                                                                                                                                                                                                                                                                                                          |
| -------- | ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|          | User taps on a book unit from the intermediate results page, but the unit that's linked is empty | User sees the relevant 'Content Coming Soon' popup. Closing it will continue to show the intermediate results page.                                                                                                                                                                                                                        |
|          | DIAL code is linked to a book and to a course                                                    | Keep calm and don't panic. This is **NOT** supposed to happen. Even so, just show the intermediate results page with the book style cards. For the course result, show the title of it in the book title, and if there is no subject for this - show the topic (if available) in the subject's place. If there is a class, show the class. |

Wireframes

[https://projects.invisionapp.com/share/T9UJ3U6AMPW#/screens/390240895](https://projects.invisionapp.com/share/T9UJ3U6AMPW#/screens/390240895)

For Future ReleaseN/A

JIRA Ticket ID[SB-16184 System JIRA](https://browse/SB-16184)

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element | Description                 | Language(s)/ Locales Required |
| ---------- | --------------------------- | ----------------------------- |
| Labels     | Labels for 'Select Chapter' | All supported languages       |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                                                               | Description                                        | Purpose                                                                                                         |
| -------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Landed on DIAL results page (addn attribs: DIAL code, count of nodes, content)                           | Landed on Flattened DIAL results page              | To know how many users landed on a flattened DIAL results page, and the average count of results that users see |
| Tapped on Select Chapter (addn attribs: DIAL code, count of nodes, index of highlighted node)            | Initiated the display of the ToC for the DIAL code | To know how many people attempt to open the ToC                                                                 |
| Tapped on a node from the ToC (addn attribs: DIAL code, index of tapped node, index of highlighted node) | Selected a chapter/sub-section from the ToC        | To know for a DIAL code if there's a pattern of which node tends to get selected more often                     |
| Tapped on back button (addn attribs: DIAL code, UI/device)                                               | Attempted to go back                               | To know how often users choose not to change the chapter                                                        |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                            | Load/Volume Requirements                                                                                                                                                                                         | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Tapping on 'Select Chapter' should open the page immediately (<0.5s) | <p>250 content in the book, with nodes with the following structure:10 chapters</p><ul><li><p>5 sections in each</p><ul><li><p>5 sub-sections in each</p><ul><li>1 content in each</li></ul></li></ul></li></ul> | Provide security and privacy requirements for an effective Use Case |
|                                                                      |                                                                                                                                                                                                                  |                                                                     |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted | Impact Description |
| ------------------------- | ------------------ |
| N/A                       | N/A                |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted | Impact Description                                             |
| ------------------ | -------------------------------------------------------------- |
| Existing users     | Users will now see a Select Chapter when they scan a DIAL code |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric           | Purpose of Metric                    |
| -------- | ---------------- | ------------------------------------ |
|          | DIAL scan funnel | Unique devices that (visited the app |
|          |                  |                                      |

***

\[\[category.storage-team]] \[\[category.confluence]]
