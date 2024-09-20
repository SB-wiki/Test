# Enabling-print-of-content-from-consumption-clients

IntroductionAs a teacher or student, I would like to print the questions so I can take the test offline.

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* As a user, I might not be comfortable with taking a test online. I might instead prefer the feel of pen and paper, or even want to print multiple copies so as to share with others.
* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  Most likely to happen at home/office, where there's access to a  printer

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

OverviewWhen a user wishes to print questions, they should be able to do so from the consumption clients.

Overall Process Workflow

1. User decides to print questions (and answers).
2. User opens the relevant content.
3. User clicks on Print (PDF)
4. The consumption interface shows a loading bar while the print material is being downloaded/prepared.
5. Once ready, the content is opened in an appropriate PDF viewer (from which it can be printed).

OverviewAs a user, I would like to print some content so that I can take a test offline on pen and paper. I might also wish to only print the questions, and not the solutions (so that I can distribute the paper in my class).

Main Scenario

| Srl. No. | User Action                                                                                                                      | Expected Result                                                                                                                                                                                                                              |
| -------- | -------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User clicks on a content                                                                                                         | Content details page opens                                                                                                                                                                                                                   |
|          | User clicks the 'Print' button:a. For a content that's downloaded.b. For a content that's not yet downloaded.                    | a.User sees a PDF content open up in a compatible app that can load PDFs.b. User sees a loading view, where they wait for the PDF to get downloaded to the device (ideally to cache).User sees the PDF open up automatically after download. |
|          | User decides to print content (all pages or maybe a selection of pages, if they just want some of it - e.g. just the questions). | \<Out of scope - since we don't control the PDF viewer>                                                                                                                                                                                      |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                                      | Expected Handling                                                                                                                                                                                                            |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Content doesn't support a printable format (e.g. Videos, regular worksheets etc.)                                                                      | The content details page should **NOT** show a print button. This is going to ONLY be shown for QML type content in this release (2.5.0-2.7.0).                                                                              |
|          | Device is not connected to the internet, and content isn't downloaded on device, but user taps on print                                                | User should see a toast message saying that internet is required for this action.                                                                                                                                            |
|          | Device is connected to the internet, content isn't downloaded, and user taps on print - while the content is being downloaded, the device goes offline | User should see the progress of the download so far, and when disconnected - if connection is not established for more than 30 seconds, the download should auto-cancel and a toast message for failure should be displayed. |
|          | Device attempts to print, but there's not enough space on disk                                                                                         | User should see a toast message for failure, saying there's insufficient space on disk.                                                                                                                                      |

Wireframes[https://invis.io/3JUJ5GDVZPU](https://www.google.com/url?q=https://invis.io/3JUJ5GDVZPU\&sa=D\&source=hangouts\&ust=1572044177111000\&usg=AFQjCNGm1Q8G3xTi-SJWOUPbtB4pjOq0Gg)

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-15397 System JIRA](https://browse/SB-15397)

Localization Requirements

| UI Element                | Description | Language(s)/ Locales Required |
| ------------------------- | ----------- | ----------------------------- |
| Labels, buttons, messages | All text    | All supported languages       |
|                           |             |                               |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                         | Description                                                                            | Purpose                                                                       |
| ------------------------------------------------------------------ | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| Open testprep content                                              | To know when user opens a testprep content                                             | To know when user opens a testprep content                                    |
| Print displayed                                                    | To know if print option is displayed to the user                                       | To know whether any awareness is generated that the user should interact with |
| Print clicked (addn params: downloaded already?)                   | To know if user clicked on print (and to know if the printable PDF is already present) | To know if user interacted with the print button, if made visible to them     |
| Print loading initiated                                            | To know if server request was sent (because device was online)                         | To know if connection was established with server for file                    |
| Print loading completed                                            | To know if file loading completed                                                      | To know if the file was completely received at destination                    |
| File opened (either because it's downloaded, or loading completed) | To know if file opened                                                                 | To know if an attempt was made by the app to open the file                    |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                 | Load/Volume Requirements | Security / Privacy Requirements |
| --------------------------------------------------------- | ------------------------ | ------------------------------- |
| Visual responses to click should be immediate (<1 second) |                          |                                 |
|                                                           |                          |                                 |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted                                                     | Impact Description                                 |
| ----------------------------------------------------------------------------- | -------------------------------------------------- |
| Specify the name of the product/solution on which this use case has an impact | Explain how the product/solution will be impacted. |
|                                                                               |                                                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted        | Impact Description                                         |
| ------------------------- | ---------------------------------------------------------- |
| Existing users            | Users might notice a new button visible, to print content. |
| Existing content archives | Content now include metadata for the PDF links             |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                                                    | Purpose of Metric                                                                                                |
| -------- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
|          | Funnel of users opening testprep content, to printing it. | This metric shows how frequently people are likely to print contentUnique devices that ( Launch testprep content |
|          |                                                           |                                                                                                                  |

***

\[\[category.storage-team]] \[\[category.confluence]]
