# PRD---Support-@-Scale

IntroductionAs a consumer of the Sunbird clients, I would like to get some help on issues I face with the (web or mobile) app. This PRD covers the various use-cases around the same.

JTBD

* \*\*Jobs To Be Done: \*\* As a user, I might face issues with using the consumption clients (web or mobile app). The current way of resolving my questions would be to send a support request via email to the Sunbird instance owner. However, there may be multiple reasons why this isn't a satisfactory solution:
  * I might not know how to send an email (or what details should go into it).
  * I need an answer NOW, and the response from support will take some delay.
  * I might not know what to expect in the app, and I don't want to look dull by asking a question that may be obvious.
  * I might not be comfortable with phrasing my question in English, and thereby get an answer not relevant to my actual problem.
* 80% of the current negative ratings are due to the 'Content Coming Soon' message - users find this quite annoying.
* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)
* **System or Environment:**  Mostly at home, though likely to be used even at school or while in transit.

Use-case 1: Show an FAQ and an option to send in a support requestIt would be good to show the user an FAQ so they can get a response sooner than usual to a problem they might be facing.

In the case that the concern is not covered as part of the FAQ, provide a way to send in a custom support request.

Process WorkflowSupport receives direct support requests via the helpdesk, or indirect concerns via the Play Store ratings/review section. The more prominent issues are put together in the order of most critical/frequently asked with an answer for the same. They work with Documentation for the phrasing of the question and answers, and for the localization into the supported languages.

The end users, when facing an issue, will click on the burger menu of the main tabs and select 'Support' from there. They will then proceed to go through the FAQ. If they don't see any that matches their query, they'll tap on 'Other support request' and proceed to send an email to the support team.

As documentation team, I should be able to add a Q\&A to the current FAQ, so the FAQ is always updated[SB-11832 System JIRA](https://browse/SB-11832)The documentation team gets a new/updated Q\&A from the support team and has to add it to the current edition. They also need to localize it wherever needed.

Main Scenario - Adding Q\&A(s)

| Srl. No. | User Action                                                                     | Expected Result                                                             |
| -------- | ------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
|          | Ram receives Q\&A(s) from support team to add to existing list.                 | Ram acknowledges the request.                                               |
|          | For each Q\&A, Ram chooses the position in the FAQ, adds it there and saves it. | The FAQ gets updated with the new question(s) at the intended position(s).  |

Alternate Scenario 1 - Removing Q\&A(s)

| Srl. No. | User Action                                                                        | Expected Result                                             |
| -------- | ---------------------------------------------------------------------------------- | ----------------------------------------------------------- |
|          | Ram receives input from support team to remove question(s) that's no longer valid. | Ram acknowledges the request.                               |
|          | Ram chooses the Q\&A(s) to remove and saves it.                                    | The FAQ gets updated with the selected question(s) removed. |

Alternate Scenario 2 - Modifying Q\&A(s)

| Srl. No. | User Action                                                                   | Expected Result                                             |
| -------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------- |
|          | Ram receives input from support team to modify Q\&A(s).                       | Ram acknowledges the request.                               |
|          | One by one, Ram chooses the Q\&A(s) to update, makes the change and saves it. | The FAQ gets updated with the selected question(s) updated. |

Exception Scenarios

| Srl. No. | Error / Exception                                                                                                                                                                                                                                                                   | Expected Handling                                                                                                                   |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
|          | <p>Shyam is in the midst of adding/editing/removing/saving Q&#x26;A(s), and one of the following happens:</p><ul><li>Closes the window by mistake.</li><li>Internet connection is lost.</li><li>System goes unresponsive/hangs.</li><li>System returns a failure to save.</li></ul> | Old Q\&A should persist.                                                                                                            |
|          | <p>Shyam is in the midst of saving Q&#x26;A(s), and one of the following happens while awaiting acknowledgement of save:</p><ul><li>Internet connection goes weak.</li></ul>                                                                                                        | System should try till server response is received for 30 seconds. If no response received, system should return a failure to save. |

WireframesN/A - expecting this to be handled via simple(existing?) internal tooling.

For Future ReleaseSeparate sites for web app /mobile app (as there may be app-specific FAQ listed there). Solution should be future proof, so that when newer mobile app versions are released, existing mobile apps continue to see the latest FAQ.

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

As a consumer, I should be able to see the existing FAQ[SB-11833 System JIRA](https://browse/SB-11833)The consumer has a concern, and visits the support section to resolve it.

When the user is raising custom support requests, 50% of the time as per current data, the requests are blank. This may be because the user doesn't know how to send a support ticket, and is probably new to concept of sending a support request (or even how to send an email for that matter).

Main Scenario - User visits the FAQ and finds relevant Q\&A(s)

| Srl. No. | User Action                                                                                                                                                  | Expected Result                                                          |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
|          | <p>Ram visits the Help &#x26; Support section:</p><ul><li>Mobile: Taps on burger menu and clicks 'Help'</li><li>Web: Taps on 'Help Centre' button </li></ul> | Ram is taken to the Help & Support section that is consumption specific. |
|          | Ram sees an appropriate question and taps on it.                                                                                                             | The question expands to display the answer.                              |

Alternate Scenario 1 - User doesn't find relevant Q\&A(s)

| Srl. No. | User Action                                               | Expected Result                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| -------- | --------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Ram taps on 'Other issue'.                                | Ram sees a popup informing user about details of the support needed.They are also informed that a mail will be initiated which the user has to send.                                                                                                                                                                                                                                                                                               |
|          | Ram enters the details in the box and taps 'Write email'. | An email gets initiated via the default mail app with the title ' support request - '.The device-specific details for the app are attached in the mail.The text entered by user is sent to the Sunbird instance via telemetry/API.To address is auto-populated as per configuration.The mail has the following format:"From: , , , **Ticket summary** **More details (If needed, provide more information or attach a screenshot of the issue)** " |

Exception Scenarios

| Srl. No. | Error / Exception                                                                                                                                               | Expected Handling                                                                                                                                                                             |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | <p>Shyam taps on 'Help &#x26; Support', and one of the following happens:</p><ul><li>Internet connection is lost.</li><li>Device was already offline.</li></ul> | User should see a toast message saying 'Internet needed to see help information'.                                                                                                             |
|          | Shyam is browsing the FAQ and closes the window by mistake.                                                                                                     | Shyam is returned to the current tab on the app.                                                                                                                                              |
|          | Shyam taps on 'Help & Support', and internet connectivity is very weak.                                                                                         | System continues to try to access the relevant page for 10 seconds. At the end of it, auto-closes and returns to the app showing the toast message 'Internet needed to see help information'. |

Wireframes **UI Design Mobile**

Invision: [https://invis.io/GSRDY645BDW](https://invis.io/GSRDY645BDW)

**UI Design Desktop**

Invision: [https://invis.io/JZREZV3ATN2](https://invis.io/JZREZV3ATN2)

For Future ReleaseThe weak internet connectivity exception above could be implemented later if it takes beyond a half-day to implement. If so, it should be left as an MVP now (error 404 page). If this approach is taken, the user should NEVER see an empty support/FAQ page.

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

As a consumer, I should be able to give feedback whether the existing FAQ was satisfactory or notThe consumer saw an existing FAQ relevant to what they were looking for, and want to give feedback on whether it's useful or not.

Main Scenario - User saw the FAQ and wants to give feedback

| Srl. No. | User Action                                     | Expected Result                                                                                                                                                                                                                                                                                                        |
| -------- | ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Ram reads the FAQ and sees the feedback section | Ram considers giving feedback on whether he's satisfied or not.                                                                                                                                                                                                                                                        |
|          | Ram taps on 'Yes' or 'No'.                      | <p>Whether yes or no, telemetry is generated for that question as feedback with the said user ID and device ID.</p><ul><li>If yes, the user is thanked for their response.</li><li>If no, the user sees an optional text box in which to give feedback (sent via telemetry) on the response to the question.</li></ul> |

Exception Scenarios

| Srl. No. | Error / Exception                                                                                      | Expected Handling                                                                                                                                                    |
| -------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Shyam taps on 'Yes' or 'No', and internet connection is lost.                                          | The visual feedback is shown to the user, but relevant telemetry is stored offline to be sent when the internet returns.                                             |
|          | Shyam taps on 'Yes' or 'No', and internet connectivity is very weak.                                   | System continues to try to send telemetry for 10 seconds. At the end of it, stores telemetry offline to be sent when internet is strong enough to send successfully. |
|          | Shyam keeps typing on and on and on, writing an essay on why FAQs need to have a lot more information. | System shows that no text is getting updated once we cross 1000 characters.                                                                                          |
|          | Shyam gives feedback in Tamil, or other vernacular language.                                           | System stores the text as received (subject to the 1000 character limit), and we see the text as the user intended when analyzing data.                              |

Wireframes[https://projects.invisionapp.com/share/GSRDY645BDW#/screens/356379655](https://projects.invisionapp.com/share/GSRDY645BDW#/screens/356379655)

For Future ReleaseN/A.

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Use-case 2: Content Coming soon

Use Case 2 - Contextual 'Coming Soon' messageSince a tenant is unlikely to have comprehensive digital content, there is going to be a need for a placeholder message for empty textbook units. The current 'Content is coming soon' message is too generic. A hypothesis we have is that since there's no 'due-date' mentioned, users keep returning to see if content has arrived. Constant display of such a message frustrates the user, and they direct their anger and disappointment towards the app. The goal here is to:

* Provide a due-date, so that an expectation is set with the user about when to receive content for a particular node.
* For the user who still has frustrations about why there's so many empty nodes, a short explanation in the FAQ about why it was important to print QR codes in books in the first place (due to long update/publish cycles in the physical world), even if it meant having many nodes empty for the better part of a year.

Process WorkflowImplementation approaches tenants for custom 'Coming Soon' messages to be displayed to users for empty nodes, a catch-all message for a book, or a catch-all message at the level of the tenant. This is then added into the system. Based on the detail up to which the tenant goes, the message is packaged with the book (to enable offline support as well), or with tenant specific information packaged with the app. The book or the tenant specific information can be updated from time to time, which results in the app eventually getting the updated information without having to upgrade the app.

When the node is filled with atleast one content, the message is anyway not displayed.

As implementor, I should be able to add a 'Coming Soon' message at a tenant-specific level, so that any empty node/textbook unit can show a message specific to the tenant under whom the book was createdThe implementation team will reach out to tenants to obtain catch-all tenant-specific 'Coming Soon' messages. This is then updated by the tenant onto the Sunbird instance.

Main Scenario - Implementation team receives a tenant-specific 'Coming Soon' messageReplace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                            | Expected Result                                      |
| -------- | -------------------------------------------------------------------------------------- | ---------------------------------------------------- |
|          | Implementation requests tenant for 'Coming Soon' message for all content by the tenant | Tenant provides a 'Content Coming Soon' message.     |
|          | Implementation team updates the message in a tenant-specific configuration.            | The config is saved successfully in a live location. |

Alternate Scenario 1 - Implementation team doesn't receive a tenant-specific 'Coming Soon' messageReplace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                               | Expected Result                                      |
| -------- | ----------------------------------------------------------------------------------------- | ---------------------------------------------------- |
|          | Implementation sets a generic 'Coming Soon' message at the level of the Sunbird instance. | The config is saved successfully in a live location. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                                                                                                                                                                              | Expected Handling                                                                                                                   |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
|          | <p>Shyam is in the midst of adding/editing/removing/saving 'Coming Soon' messages, and one of the following happens:</p><ul><li>Closes the window by mistake.</li><li>Internet connection is lost.</li><li>System goes unresponsive/hangs.</li><li>System returns a failure to save.</li></ul> | Old 'Coming Soon' configuration should persist.                                                                                     |
|          | <p>Shyam is in the midst of saving the 'Coming soon' message, and one of the following happens while awaiting acknowledgement of save:</p><ul><li>Internet connection goes weak.</li></ul>                                                                                                     | System should try till server response is received for 30 seconds. If no response received, system should return a failure to save. |
|          | Shyam@TenantA decides that they don't want to use the tenant-specific message they gave.                                                                                                                                                                                                       | System should be able to remove the tenant-specific config for TenantA.                                                             |

WireframesN/A - expecting this to be handled via simple(existing?) internal tooling.

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

As a creator, I should be able to add a 'Coming Soon' message at a node-specific level, so that the node (and their empty child nodes that don't have a 'Coming Soon' message) can show that messageIt's a matter of time before tenants realize that a tenant-level message isn't fair to its users, and will result in many modifications of the same over the course of months. At that moment, they will wish to provide tenant-specific messages at the level of a book, or better yet at the level of textbook nodes (based on the certainty they wish to go to).

Main Scenario - Adding/updating a 'Coming Soon' message at the level of textbook nodesReplace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                    | Expected Result                                                     |
| -------- | -------------------------------------------------------------- | ------------------------------------------------------------------- |
|          | Ram edits the textbook details.                                | The textbook details page opens up for editing.                     |
|          | Ram enters the 'Coming Soon' message at the level of the book. | The 'Coming Soon' message is stored at the root level for the book. |
|          | Ram enters the 'Coming Soon' message at a node under the root. | The 'Coming Soon' message is stored at the node.                    |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                                                                                                                                                                                                                                                                                           | Expected Handling                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Shyam doesn't provide a message at the level of the book.                                                                                                                                                                                                                                                                                                                                                   | The field shows a greyed-out 'hint text' which is a copy of the tenant-specific message.                                                                                                                                                                                                                                                                                                                                                           |
|          | Shyam provides a message at the root level of the book, and opens a child node.                                                                                                                                                                                                                                                                                                                             | The field shows a greyed-out 'hint text' which is a copy of the root-level message.                                                                                                                                                                                                                                                                                                                                                                |
|          | <p>Shyam provides a message at:</p><ul><li>The root level of the book</li><li><p>One of the immediate children C1</p><ul><li>It's children C11 and C12</li></ul></li><li><p>Not for the sibling C2</p><ul><li><p>Provides for it's children C21 and C22</p><ul><li>Not for the child C211</li><li>Provides for the child C212</li></ul></li></ul></li></ul><p>Then doesn't fill any content in the book</p> | Wherever there's an empty message at a node-level, it shows a greyed-out 'hint text' which is a copy of its parent's message.If the parent-node message was also empty, it derives the greyed-out 'hint text' that the parent-node is displaying.The tenant catch-all is the tenant-specific message that's shared at a config level.The final catch-all is the Sunbird-instance message that's shared at a config level (which CAN NOT be empty). |

WireframesN/A. Assuming this is a simple row that can be added under the node title, in the node details.

For Future ReleaseN/A.

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

As a consumer, I should see a tenant-specific 'Coming Soon' message when I scan a DIAL code or attempt to open an empty textbook unitAs a user who's scanning a DIAL code (either on web/mobile), or opening a empty textbook unit in the mobile app - I should be shown a message letting me know when the content is expected to come and the responsible entity for it.

Main Scenario - Scanning a DIAL codeReplace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                           | Expected Result                                                   |
| -------- | ----------------------------------------------------- | ----------------------------------------------------------------- |
|          | Ram scans a DIAL code (that doesn't have any content) | Ram should see the relevant 'Coming Soon' message for the tenant. |

Alternate Scenario 1 - Opening an empty nodeReplace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                          | Expected Result                                                   |
| -------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------- |
|          | Ram opens a book on the mobile app, and taps on a node that doesn't have any content | Ram should see the relevant 'Coming Soon' message for the tenant. |

Alternate Scenario 2 - User wants to raise a complaint about so many 'Content Coming Soon'Replace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                        | Expected Result                                                                                                                                                                                                                                                                     |
| -------- | ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Ram opens the 'Help & Support' tab                                                 | Ram should see the FAQ.                                                                                                                                                                                                                                                             |
|          | First FAQ that Ram sees is 'Why am I always seeing that 'Content is coming soon'?' | Ram clicks on that FAQ.Ram sees that books have a once-in-three-years update cycle, and therefore how it's important to print the codes in the book even if it means that it's empty. Also that the tenant is doing their best to ensure there are as less empty nodes as possible. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                | Expected Handling                                                                                                   |
| -------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
|          | Shyam's tenant-admin didn't provide a tenant-specific 'Coming Soon' message                                                      | The Sunbird instance level 'Coming Soon' message should be displayed to Shyam.                                      |
|          | Shyam has been offline since he installed the app, and hasn't gotten any 'Coming Soon' message updates in six months.            | Shyam's Sunbird app continues to show the 'Coming Soon' message at the tenant-level that was packaged with the app. |
|          | Shyam remains offline and imports a book for a tenant that he doesn't have on his mobile app, and opens an empty node within it. | Shyam's app will show the Sunbird-instance 'Coming Soon' message that was packaged with the app.                    |

Wireframes[https://projects.invisionapp.com/d/main#/console/16608430/354067150/preview](https://projects.invisionapp.com/d/main#/console/16608430/354067150/preview)

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

As a consumer, I should see a node-specific 'Coming Soon' message when I scan its DIAL code or attempt to open that empty textbook unitAs a user who's scanning a DIAL code (either on web/mobile), or opening a empty textbook unit in the mobile app - I should be shown a message specific to that node, letting me know when the content is expected to come and the responsible entity for it.

Main Scenario - Scanning a DIAL codeReplace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                           | Expected Result                                                  |
| -------- | ----------------------------------------------------- | ---------------------------------------------------------------- |
|          | Ram scans a DIAL code (that doesn't have any content) | Ram should see the relevant 'Coming Soon' message for that node. |

Alternate Scenario 1 - Opening an empty nodeReplace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                          | Expected Result                                                  |
| -------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------------- |
|          | Ram opens a book on the mobile app, and taps on a node that doesn't have any content | Ram should see the relevant 'Coming Soon' message for that node. |

Alternate Scenario 2 - User scans/opens a node that doesn't have a node specific message but has a textbook specific 'Content Coming Soon' messageReplace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                                                         | Expected Result                                                                                                                                                                                                                                                                                                      |
| -------- | ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Ram scans a DIAL code (that doesn't have any content, and no node-specific message) | Ram should see the 'Coming Soon' message that's configured for the parent.If the parent doesn't have a 'Coming Soon' message, then he should see of the parent above that.So on and so forth, until he either gets the tenant-specific 'Coming Soon' message or the Sunbird-instance specific 'Coming Soon' message. |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                                                                                                           | Expected Handling                                                                                                                                                      |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Shyam's tenant-admin didn't provide a book-specific 'Coming Soon' message and all the nodes are empty. Each node has a custom 'Coming Soon' message, except for the root-level of the book. | The tenant-level 'Coming Soon' message should be displayed to Shyam.If that's missing, then the Sunbird-instance specific 'Coming Soon' message is displayed to Shyam. |

Wireframes[https://projects.invisionapp.com/d/main#/console/16608430/354067150/preview](https://projects.invisionapp.com/d/main#/console/16608430/354067150/preview)

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                  | Description                                                                    | Language(s)/ Locales Required                                           |
| --------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------------------------------------- |
| All FAQ                     | All FAQ listed in the page                                                     | All languages supported on the mobile/web app for the Sunbird instance. |
| Content Coming Soon message | Only the Content Coming Soon message at the Sunbird instance and tenant level. | All languages supported on the mobile/web app for the Sunbird instance. |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                             | Description                                                                                | Purpose                                                                                                                                                                                                                                                       |
| -------------------------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Click on 'Burger menu'                 | Clicking on the burger menu                                                                | To know how many users open the burger menu                                                                                                                                                                                                                   |
| Clicking on 'Help & Support'           | Clicking on the support page                                                               | To know how many users go to the support page                                                                                                                                                                                                                 |
| Landing on FAQ page                    | Landing on the FAQ page                                                                    | To know how many users actually saw a FAQ page (and didn't lose out due to interrmittent/no connectivity).                                                                                                                                                    |
| Clicking on an FAQ                     | Clicking on one of the FAQs listed on the page                                             | To know which FAQ is most read.                                                                                                                                                                                                                               |
| Clicking on 'Other request'            | Not finding a satisfactory FAQ and sending a custom request                                | To find how many users that land on FAQ page still feel the need to send in custom requests.                                                                                                                                                                  |
| Cllicking on 'Create Mail'             | Initiating a support request mail.                                                         | To find how many users that attempt to send in a custom request actually go ahead to initiating it on their mail client.                                                                                                                                      |
| Clicking on Yes/No feedback            | Clicking on the 'Yes'/'No' feedback buttons that displays within the FAQ                   | To know whether an FAQ is helpful enough or not                                                                                                                                                                                                               |
| Unhelpful FAQ comment                  | Textual description of the comment provided for the FAQ Section where the user tapped 'No' | To know what users want more from the question displayed.                                                                                                                                                                                                     |
| Seeing a 'Content Coming Soon' message | Display of 'Content Coming Soon' message to the user                                       | To know which 'Content Coming Soon' message (node id should be sufficient) is displayed to the user most frequently. If tenant/Sunbird-instance level, that additional info should be available as well. (tenant id, and sunbird-instance id should do fine). |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                  | Load/Volume Requirements      | Security / Privacy Requirements                             |
| ---------------------------------------------------------- | ----------------------------- | ----------------------------------------------------------- |
| FAQ page should load within 10 seconds                     | Simultaneous use by 5% of DAU | Device ID and user ID should be available in the telemetry. |
| 'Content Coming Soon' message to be displayed immediately. | N/A                           | N/A                                                         |
|                                                            |                               |                                                             |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted | Impact Description                                                                                                   |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| ETB Book sizes            | Book sizes are likely to increase due to additional 'Content Coming Soon' messages.                                  |
| Courses                   | If courses team wishes, the same tenant configuration could be extended to them for 'content coming soon' messaging. |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted | Impact Description                                                                                                                    |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------- |
| No users impacted  | Since the current apps use a static 'Content Coming Soon' message and a specific email to send to, this won't negatively impact them. |
|                    |                                                                                                                                       |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric        | Purpose of Metric                                                                                                                                                                                                   |
| -------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Funnel of FAQ | To see how often people visit the FAQ, and it's impact on retentionTo see how often people visit FAQ over the first week/month, and beyond.To see which FAQ are most popular, to modify the order of the questions. |
|          |               |                                                                                                                                                                                                                     |

***

\[\[category.storage-team]] \[\[category.confluence]]
