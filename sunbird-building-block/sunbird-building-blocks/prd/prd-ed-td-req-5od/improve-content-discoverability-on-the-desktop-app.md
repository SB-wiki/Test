# Improve-content-discoverability-on-the-desktop-app

IntroductionField tests have shown that teachers struggle to:

* Find their textbooks when setup by someone else on the desktop app for use in class
* Find textbooks or content that they would like to download&#x20;
* Realise that they are online and can download content

Owing to this, there is a need to improve content discoverability on the desktop app.&#x20;

JTBD

* \*\*Jobs To Be Done: \*\*
  * As a teacher/student, I want to find my textbook quickly, So that I can view digital content that is linked to it.&#x20;
  * As a teacher at home, I want to find textbooks to download, So that I can take it with me to school on a pendrive.&#x20;
* **User Personas:** Government school teacher, student
* **System or Environment:**  At home with intermittent connectivity, At school with intermittent or no connectivity

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

OverviewTodays My Library page has a Recently Added section, and class-based categories. Teachers and students don't find this categorisation very intuitive, and hence end up trying to use filters, or scrolling through the recently added section in order to find the book that they are looking for. Teachers are also unable to rationalise the difference between their library and the browse online section.&#x20;

This story involves renaming My Library to My Downloads, adding subject based categories, an all downloads section and improving the filters to allow users to navigate between medium and class.&#x20;

| Srl. No. | User Action                                               | Expected Result                                                                                                                                                                                                                                           |
| -------- | --------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user installs the app and lands on My Downloads         | They see an empty page with an instruction to load content                                                                                                                                                                                                |
| 2        | They select the option to load content                    | They are shown 2 options - one to import from a pendrive and the other to download from the internet. If they are online, the online option is marked as recommended. If they are offline, the online option is disabled, with an explanation as to why.  |
| 3        | The user imports textbooks from a pendrive                | They see the textbooks listed under the respective class, medium and subject in the libraryThey also see the textbook listed under "All Downloads" sectionThey can export the content to a pendrive if they choose to                                     |
| 4        | The user imports an individual content from the pendrive  | They see that content listed only in the "All downloads" section, and not in the subject based categoriesThey can export the content to a pendrive if they choose to                                                                                      |
| 5        | The user comes online                                     | They see a message in the right hand side panel, indicating to them that they can download content nowIf they select that option - they are taken to the page where they can browse online                                                                |
| 6        | They download a specific content from the online section  | They are shown the same content in their My Downloads section, which follows the same rules as the importThey can export the content to a pendrive if they choose to                                                                                      |
| 7        | A user changes the board, medium or class through filters | They should be able to see books under subjects based on the criteria chosen by the user                                                                                                                                                                  |

\<Alternate Scenario 1>

| Srl. No. | User Action                                                            | Expected Result                                                                                        |
| -------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| 1        | A user clicks on Browse Online when there is no internet               | They are shown an empty page indicating that there is no internet, with an option to load content      |
| 1        | A user loads their Library page and they are on a machine with low RAM | Lazy loading should kick in to ensure the user sees some immediate feedback                            |
| 2        | A user loads more than 4 textbooks in a category                       | They are shown options to navigate through all the books, with books being ordered by the latest first |
| 3        | A user changes their interface language to Urdu                        | They are shown the My Library page in an RTL layout                                                    |

Wireframes[https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/389968608\_DIKSHA\_Desktop\_-\_Browse\_No\_Internet](https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/389968608\_DIKSHA\_Desktop\_-\_Browse\_No\_Internet)

JIRA Ticket ID[SB-15543 System JIRA](https://browse/SB-15543)

\<Improve the textbook details page so that a user can play the exact content they're looking for> OverviewBased on field studies, it is apparent that users struggle with the actions to perform on the textbook details page. This needs to be improved in order to&#x20;

* Ensure the user is shown the textbook TOC, and can easily navigate between chapters to get to the content they're looking for.
* Ensure the user can play content from the TOC - and that they can additionally download the content or copy it to an external source, should they choose to do so.
* Ensure the user can also download the entire textbook or copy the entire textbook to an external source, should they choose to do so.&#x20;

| Srl. No. | User Action                                                                         | Expected Result                                                                                                                                                                                                                                                                                                                                                                                 |
| -------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user opens up a textbook from either from their downloads or their online library | <p>They are shown the textbook details page, on which they see</p><ul><li>The TOC of the textbook, with the first unit expanded such that all content pieces were visible</li><li>The first content selected by default - and the user can choose to play the content</li><li>At the bottom of the TOC, they get access to the textbook level credits and licensing info </li></ul>             |
| 2        | They open up the textbook from their online library                                 | <ul><li>They are shown an option to download the whole textbook</li><li>When they view a specific content as part of the textbook, they are shown an option to download the content</li><li>After they've downloaded the textbook/content, they are provided an option to save the content to a pendrive, delete the content and update the content (if there is an update available)</li></ul> |
| 3        | They open up the textbook from their downloads                                      | <ul><li>They are provided an option to save the content to a pendrive, delete the content and update the content (if there is an update available)</li></ul>                                                                                                                                                                                                                                    |
| 4        | They download/share the entire textbook                                             | <ul><li>The entire textbook (including the TOC and all the content) is downloaded/shared</li></ul>                                                                                                                                                                                                                                                                                              |
| 5        | They download/share an individual content from within a textbook                    | <ul><li>The textbook TOC and that individual content are downloaded/shared</li></ul>                                                                                                                                                                                                                                                                                                            |
| 6        | They search for an individual content and download/share it                         | <ul><li>Only the individual content is downloaded/shared</li></ul>                                                                                                                                                                                                                                                                                                                              |
| 7        | They click on the 'Select Chapter' option on top                                    | <ul><li>The user views through a list of all the chapters and individual content falling under it.</li><li>They can choose a specific content from this TOC. </li></ul>                                                                                                                                                                                                                         |
| 8        | They click on the option to view some very specific type of content                 | <ul><li>They are shown only videos or interactive or documents as they choose in the TOC</li></ul>                                                                                                                                                                                                                                                                                              |

\<Alternate Scenario 1>

| Srl. No. | User Action                                                                                                          | Expected Result                                                                                                                  |
| -------- | -------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 1        | The user is offline while trying to play content online                                                              | They are shown a message on the player that they are currently offline, and they need to download the content to play it offline |
| 2        | The user is on a low bandwidth connection or a poor RAM machine and is trying to open the textbook                   | The textbook page slowly loads using lazy loading                                                                                |
| 3        | The user tries to play content from their online library when their network speed is very low (\~512Kbps and below)  | They are prompted to download the content instead of playing itThey can still choose to play the content anyway                  |

Wireframes[https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/395640539](https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/395640539)

JIRA Ticket ID[SB-15999 System JIRA](https://browse/SB-15999)

OverviewThe current search experience is localised to a particular page in the app - i.e a user can either search inside of their downloads or inside of the online library. This leads users to be confused, as they expect to be able to search throughout the app - owing to the mobile paradigm of how search works. Hence, search needs to be promoted to a global concept - with users being able to search with a keyword, and then have results across My Downloads and the online library show up.&#x20;

| Srl. No. | User Action                                        | Expected Result                                                                              |
| -------- | -------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| 1        | The user searches for content when they are online | They are shown results from both the online library and downloads if they match the keywords |
| 2        | The user searches for content when offline         | They are only shown results from their downloads if they match the keywords                  |

\<Alternate Scenario 1>

| Srl. No. | User Action                                                                                                                                      | Expected Result                                                                                                   |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| 1        | The user searches for content when they are online - but there are results available only from the online library                                | They are told that there are no downloaded results, but are shown the list of available content from the internet |
| 2        | The user searches for content when they are online - but no content (either from their online library or downloads) matches their search results | They are told to try another keyword                                                                              |
| 3        | The user is offline and is searching for content, but there are no results from their downloads                                                  | They are told that they need to come online to find matching results                                              |

Wireframes[https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/388450041](https://projects.invisionapp.com/share/GUU89XA7BQA#/screens/388450041)

JIRA Ticket ID[SB-16119 System JIRA](https://browse/SB-16119)

Telemetry Requirements

| Event Name                                                                                                                               | Description                                                                                                                                                                                                                                                     | Purpose                                                                          |
| ---------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| All existing telemetry events from previous workflows to be in place (for the UI redesign)                                               |                                                                                                                                                                                                                                                                 |                                                                                  |
| Search for keyword                                                                                                                       | The user's search with context of the word searched for, and the page from which the search originates                                                                                                                                                          | To understand the usage of search as a mechanism to find content                 |
| Selects search result                                                                                                                    | Interact event to indicate that user has clicked on a search result - and whether they have done it from their online results or local downloadsIf they've found the results from the internet, how many pages did they have to get through to find the content | To understand the effectiveness of current search as a mechanism to find content |
| Clicks on :download textbook,download content,share textbook,share content,delete textbook,delete content,update textbook,update content | Self explanatory                                                                                                                                                                                                                                                | To understand the usage of specific features                                     |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements            | Load/Volume Requirements | Security / Privacy Requirements |
| ---------------------------------------------------- | ------------------------ | ------------------------------- |
| All pages to load within 4 seconds                   |                          |                                 |
| Loader to be shown while retrieving any page results |                          |                                 |

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
