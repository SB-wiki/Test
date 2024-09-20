# Programs-portal-for-Controlled-Crowdsourcing

_Instructions to use this template:_

1. \_Use this template to write the Product Requirements Document (PRD) for a single User JTBD or Initiative. \_
2. _Each workflow within the PRD will correspond to an Epic in JIRA. Each User Story will correspond to a Story in JIRA that will be part of the Epic._
3. \_Each section in the template has instructions, with examples explaining the type of content to be written in that section. \_
4. _You may start typing into the section by eliminating the instructional text, or delete the instructional text after you have entered all content for the section._
5. _Repeat from section \<Use Case 1> Overview for every use case in the User JTBD or Initiative_

IntroductionTo run a program an adopter needs a lot of content for capacity building of their personnel. Any ongoing program would have content already existing in paper or digital form. In order to enable the adopter to collate, curate, organise, and distribute content we will build a programs portal that will allow them to define scope of their program, contribution mode, content types, user roles and other details.&#x20;

Need to build following capabilities for Test Prep

1. Ability to launch a new program
2. Configure program URL with a human readable slug
3. Configure scope of program by creating textbooks and tagging them to program ID (manual)
4. Configure logic for linking content to textbook structure in this new program
5. Configure question set template (blue print) for this program

Need to build following capabilities for Teacher & Student Enablement

1. Ability to contribute different types of content by different set of users. For example, School 1-10 contribute Explanation and School 7-15 contribute Lesson Plan
2. Support for uploading PDF and MP4 as various content types, such as Explanation, Experiential, Lesson Plan, Concept Map, etc
3. Configure logic for these content types to be linked to textbook structure
4. Configuring different menu items for each content type
5. Configuring workflow for PDF & MP4. These will not have same workflow as questions

Types of Contribution Models : Controlled Crowdsourcing & Workshop

JTBDUse this section  to elaborate on:

* **Jobs To Be Done:** &#x20;
  1. Contributor / Reviewer should be able to contribute all content types through on single portal
  2. Adopter / tenant would like to launch contribution portal aligned with a purpose driven programme to transform education in the State.
* **User Personas:** This program would involve following user personas
  * Contributor : A school teacher, a well performing school teacher who has shown great performance in a subject / class.
  * Reviewer : A subject matter expert who is capable to reviewing content in a particular subject and judge its accuracy & relevance
  * Curator : Textbook owner will play the role of curator to finalise content that will be linked to the textbook
  * Textbook owner : Person responsible for ensuring content in a textbook is relevant, high quality, and available for all required chapters
  * Project owner : Person who will coordinate and ensure completion of project on time
* **System or Environment:**  All users are expected to use laptop or computers with minimum 2 GB RAM, Windows 7 or above, and on Chrome browser.

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

Contribute all content types OverviewContributor should be able to navigate upto 4 levels on Textbook units and contribute any of the content types at each level opened for contribution. Supported content types are Lesson Plan, Explanation Content, Experiential Content, and Concept Map

Contribute all content types Overall Process WorkflowSelect Textbook > Select Chapter > Chapter level dashboard (View all units in this chapter with content types) > Contribute > Select content type >&#x20;

* If Practice Set → allow user to create any question type and submit practice set for review, and edit when content is in draft / rejected state
* If Lesson Plan / Explanation / Experiential → show upload page where user can upload, submit for review, and edit when content is in draft / rejected state&#x20;

Contribute all content types - Contributor workflow OverviewContributor will be able to contribute all types of content using tools provided. Following are the details of each content type and the tools required for them.

Practice setContributor should be able to create a practice set using questions of different types. (Question types available to a user are configured by administrator when setting up the contribution portal)

At present all available question types should be available by default for a contributor to create Practice Set. (When setting up Contribution portal, admin should be able to configure specific content types such as MCQ Practice Set where only MCQ is available for that tool)

Questions are create in QuML format. For each question type, creation & consumption plugins are available along with QuML schema definition in the Assessment Model.

This is changing from the current model where contributor is creating questions > reviewers is reviewing questions > curator is selecting & publishing practice set which is linked to the textbook chapter. In the new model, contributor contributes practice set > reviewer reviews practice set > curator is selecting which practice set to link to textbook. As per the new model, the user might see multiple practice set per chapter.

Explanation / Lesson Plan / Experiential contentContributor should be able to upload Lesson Plan / Explanation / Experiential in PDF or MP4 format. These file sizes are limited to 50 MB today. Contributor should be able to contribute more than one lesson plans by following the steps again.&#x20;

Contribute Practice Set / Lesson Plan / Explanation / Experiential Replace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action                                  | Expected Result                                                                                                                                            |
| -------- | -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | Login to contribution portal using Google ID | User is able to sign in using their signed in Google ID, user is provided with Contributor role, and is taken to Class, Subject selection screen           |
| 2        | Select Class, Subject                        | User is able to select Class, Subject from the scope configured for contribution. On success, user is show a list of textbooks for selected Class, Subject |
| 3        | Select Textbook                              |                                                                                                                                                            |

\<Alternate Scenario 1>Replace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action | Expected Result |
| -------- | ----------- | --------------- |
|          |             |                 |
|          |             |                 |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

Wireframes[https://whimsical.com/Mkw724DYoFyWrvNPxSUX7U](https://whimsical.com/Mkw724DYoFyWrvNPxSUX7U)&#x20;

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Textbook Setup for Contribution OverviewTextbook owner should be able to create textbooks with upto 4 level of units, tag topics to each unit wherever required, mark specific units for contribution, and open the textbook for contribution.

Textbook Setup for Contribution Overall Process WorkflowUsers with Textbook creation rights

\<Use Case 1 - User Story 1> OverviewReplace the text within < > in the heading above with the name of the use case and the name of the first user story. Provide a high-level overview of the user story here. Each user story is further elaborated in its sub-sections. The principles to bear in mind while writing a user story are: 1) it comprehensively captures a unique feature or functionality that a user can accomplish using the system 2) it encapsulates a single unit of functionality 3) it corresponds to one JIRA story 4) it is accomplished in one release. If, in a rare case, the functionality of a user story needs to be developed iteratively, the story should contain the Minimum Viable Product (MVP) content within the 'Main Scenario' section. All functionality to be developed in future releases, should be part of the 'For Future Release' section. Whenever the functionality is taken up for a release, it should become part of the 'Main Scenario' section. The 'Main Scenario' section should always be in sync with the current system functionality if the story is released. Scenarios detailed for the User Story are part of the acceptance criteria of the story.

Replace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action | Expected Result |
| -------- | ----------- | --------------- |
|          |             |                 |
|          |             |                 |

\<Alternate Scenario 1>Replace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described.To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action | Expected Result |
| -------- | ----------- | --------------- |
|          |             |                 |
|          |             |                 |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

Wireframes[https://whimsical.com/Mkw724DYoFyWrvNPxSUX7U](https://whimsical.com/Mkw724DYoFyWrvNPxSUX7U)&#x20;

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

\<Use Case 1 - User Story 2> OverviewRepeat the entire Section and its corresponding subsections to elaborate the next user story in the use case. Repeat the section as many times as required.&#x20;

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                                                                           | Description                                                                                                                       | Language(s)/ Locales Required                                           |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Mention the UI Element that requires localization. e.g. Label, Button, Message, etc. | Provide the exact details of the element that requires localization. e.g. User ID, Submit, 'The content is currently unavailable' | Mention all the languages or locales for which localization is required |
|                                                                                      |                                                                                                                                   |                                                                         |

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
