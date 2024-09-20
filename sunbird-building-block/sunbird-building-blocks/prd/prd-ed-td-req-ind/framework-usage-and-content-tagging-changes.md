# Framework-Usage-and-Content-Tagging-Changes

IntroductionFrameworks have been defined and used for tagging content, for more than a year now. Based on current use cases, there are certain limitations and problems that are popping up based on how they are used currently. Hence there is  a need to re look at it and do certain changes to make it more effective for the current requirements.

Following section details the issues with current system

Problem AreasProblem 1: Framework values - Complete Curriculum vs. ETB ScopeWhen a state onboards, one of the first things they create is the Framework. A State Framework defines the state “Board” and its “Curriculum/Syllabus”. It consists of the set of values for Board, Classes, Mediums, Subjects and Topics in the curriculum.  The question is should the State Framework include entire set of Classes, Medium, Subjects in their curriculum or only those that are in their current ETB scope? If Framework includes only the set of values in current ETB scope, there are two issues:

1. The Framework doesn’t reflect the true curriculum of the state board. Each time there is a change scope, it needs to be updated
2. The same framework is used for Teacher Training solution. Teachers who take trainings will have a profile with their classes, subjects filled in. There may be teachers taking trainings that are in classes outside ETB scope. For example ETB scope may be Classes 9 and 10.  But teachers across Class 1 to 10 may be taking trainings. They will not be able to update correct class values in their profiles.

If Framework includes the entire set of values of state curriculum, there is the following issue:

1. Consumption experience is impacted. When a user tries to look for ETB content, they will see options for the Classes and Subjects that do not have any textbooks or content. This results in dissatisfaction as user would expect content for them.

Problem 2: Tagging of content reused by multiple statesCurrently, when a content is created, it is mandatory to tag it with Board, Class(es), Medium(s), Subject(s).  This information is used in two ways:

1. User can filter content for specific Board, Class, Medium, Subject. System uses the tagging on content for this.
2. When consuming content, the Content Card displays these values and they are also displayed in the content details page&#x20;

Significant amount of content is used across states, where the same content is linked to textbooks from multiple states.  This is also likely to increase in future.&#x20;

Let us take an example scenario: A content created by Maharashtra is tagged to MH Board, Maths, Class 8, English medium. Say it is reused by AP in its Class 7, Maths, English medium textbook. The issues to be addressed are:

1. How to enrich tagging with this additional information? Say, if an AP user filters for Maths, Class 7, English medium content this content should appear.
2. What should be shown to an AP user in the content card or content details page? Showing the MH Board, Maths, Class 8 isn’t any use to the user.

Problem 3: Tagging of content coming from a content providerApart from states creating their own content, there are many content providers that provide their content for one or more states to use. Some content providers are Khan Academy, Meghshala, Akshara.  Each of the content providers has a tenant. Now the question is, how to tag the content from these content providers?&#x20;

1. What Framework should be used? The content is not specific to one Board. So tagging to a Board doesn’t really make sense.&#x20;
2. Subject and Medium are easy to tag. Class will depend on the Board, it can be a high level tagging.
3. Tagging to a Topic/Subtopic is the most useful tagging. But this cannot be restricted to Topic/Subtopic of one specific Framework (Board).

JTBD

* \*\*Jobs To Be Done: \*\* This impacts multiple jobs to be done.
  * State Content Teams and Content PMU - Creating and Tagging Content by a non-state Content Provider
  * Teachers and Students - Consuming ETB content by navigating through Textbooks
  * State Admin and PMU teams - Tracking ETB Creation and Usage Reports
  * State Teachers - Providing their details in Profile

Requirement SpecificationsTo address the problems described in the Introduction section above, certain changes need to be made in the current system. Following sections describe the detailed specs of the required changes.

1. Creating and Tagging Content by a non-state Content Provider
2. Defining current ETB Scope

1\. Creating and Tagging Content by a non-state Content Provider OverviewCurrently any framework configured to a tenant has Board as one of its categories. However, as described in the Introduction section, a non-state content provider may have content that is not specific to any board. In this case, they would only want to tag content with Medium, Subject, Class(s), Topic(s) and Sub-topic(s). System should support and handle this during creation, consumption (displaying content details) and discovery.

Process Workflow

1. A "K-12 Spine Framework" is defined that consists of Subject, Medium, Class, Topics and Subtopics as its categories. The base for these values comes from NCERT curriculum and extended with additional topics and subtopics that are not part of NCERT curriculum.
2. A non-state Content Provider comes with content not specific to any board. A tenant is created for the provider and Spine Framework is configured as the default framework.
3. Any user of the tenant logs in and creates content using Content Editor or Content Upload. Content is tagged to a Subject, Medium and one or more Classes, Topics and Subtopics in the Spine Framework.
4. The content created is available for other states to link to their textbooks. It is available to be made as part of MVC content. It can also be searched through Textbook editor using Subject, Medium, Class, Topic and Subtopic.&#x20;
5. The content is consumed by users through a Textbook, when it is linked. The content is also consumed by users through search and filter.

User Story 1 - Configuring Spine FrameworkConfigure Spine Framework for the first timeA "K-12 Spine Framework" will consist of following categories:

1. Subject list
2. Medium list
3. Class list
4. Topic and Subtopic hierarchy

This will be provided by Content PMU. Like any other framework, it needs to be updated in the system by implementation team through backend. Each Subject and Class combination will have a Topic and Subtopic hierarchy defined. There may be some topics that are not linked to any Class but only to a Subject. There is no scenario where topics are not linked to any Subject.

Update Spine FrameworkContent PMU will be updating Spine Framework periodically if required to add new Subjects or Topic/Subtopics. The backend update process should support this. The changes are:

1. Adding new Topics or Subtopics to existing Subject, Class combination
2. Adding new Subjects along with topic, subtopics for the new Subject (with a class combination)

User Story 2 - Configure a Content Provider tenant with the K-12 Spine FrameworkWhen a tenant is created for a content provider, it can be configured with the "K-12 Spine Framework" as part of tenant configuration. The process of doing it remains same, it is done by implementation team through backend.

User Story 3 - Create and Modify content using K-12 Spine FrameworkCreate or upload a resource through portal

1. User logs into content providers tenant (configured with K-12 Spine Framework) as a content creator.
2. The user creates goes to work-space and creates a resource or uploads a resource.
3. The Edit Details page only contains Subject, Medium, Class, Topics fields to configure. They function as per the framework definition. Subject, Medium and Class are mandatory and Topics field is optional.
4. User can update the details and save content successfully.
5. The content can be reviewed and published successfully.

Upload content through backend bulk uploadCurrent bulk upload process should support content from non-state content provider to bulk upload content tagged to K-12 Spine Framework (without board).

Modify content&#x20;

1. Users can modify content that is tagged to K-12 Spine Framework successfully and republish

All functionality related to creating and modifying content such as preview, limited sharing, collaboration etc. should work as is for content tagged to K-12 Spine Framework.

User Story 4 - Search and link content that is tagged to K-12 Spine Framework to Textbooks in different tenantsLink Content to Textbook section through Textbook editorA Textbook creator logs in to a state tenant (that has Board configured) and opens textbook editor and can do the following actions:

Content SuggestionsContent suggestions in textbook editor should display any content tagged to K-12 Spine Framework if it matches class. subject, medium, topics of the textbook section as per the current logic.

View All of Content SuggestionsWhen user searches for content in View All screen, content tagged to K-12 Spine Framework should appear if it matches metadata as per current logic.

When user filters search results using Subject, Medium, Class, the content tagged to K-12 Spine Framework should get filtered correctly based on the metadata.

Search and Add ResourceWhen user searches for content in Add Resource screen, content tagged to K-12 Spine Framework should appear if it matches metadata as per current logic.

When user filters search results using Subject, Medium, Class, the content tagged to K-12 Spine Framework should get filtered correctly based on the metadata.

Add ResourceContent tagged to K-12 Spine Framework selected by above three methods should be successfully added to a textbook section. User should be able to save and publish Textbook with the linked content.

Link Content to Textbook section through CSV UpdateA Textbook creator logs in to a state tenant (that has Board configured) and opens textbook editor.

CSV is created with content from a content provider using K-12 Spine Framework mapped to one or more textbook sections.

User updates textbook through CSV Update. The content is successfully linked to the right textbook sections.&#x20;

User saves and publishes content successfully.

User Story 5 - Consuming Content that is tagged to K-12 Spine FrameworkSearch and Filter Content

1. User goes to Library page on Portal and selects certain Class, Subject, Medium combination, no Board is selected. Content tagged to corresponding Class, Subject, Medium in K-12 Spine Framework should be displayed in the results.
2. User goes to Library page on Portal and selects a Board, Class, Subject, Medium combination. No content from K-12 Spine Framework is displayed in the results because that content is not tagged to any Board.
3. User searches for content on Portal Library page. Content tagged to K-12 Spine Framework is displayed based if it matches the search string (using existing logic)
4. User searches for content in Mobile app. Content tagged to K-12 Spine Framework is displayed based if it matches the search string (using existing logic)
5. User filters search results (in Portal or Mobile app) using certain Class, Subject, Medium combination, no Board is selected. Content tagged to corresponding Class, Subject, Medium in K-12 Spine Framework should be displayed in the results.
6. User filters search results (in Portal or Mobile app) using certain Board, Class, Subject, Medium combination. Content tagged to corresponding Board, Class, Subject, Medium corresponding to K-12 Framework of the Board should be displayed in the results.No content from K-12 Spine Framework is displayed in the results because that content is not tagged to any Board.

View Content Details

1. In both Portal and Mobile, when user goes to content details page of content tagged to K-12 Spine Framework, the Board value shows empty.

All other content consumption scenarios such as playing, downloading, QR code scans etc. work as per the current behavior.

JIRA Ticket ID[SB-13525 System JIRA](https://browse/SB-13525)

Localization RequirementsN/A

Telemetry RequirementsN/A

Non-Functional RequirementsN/A

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted     | Impact Description                                                                                                                                                                                                               |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Content Creation, Consumption | Content creation and consumption should support tagging content to K-12 Spine Framework that doesn't have any Board configured.The functionality for content tagged to a state K-12 Framework (with Board) should work as it is. |
| ETB Reports and Dashboards    | All ETB dashboards should work as per currently functionality for both content tagged to State Framework and K-12 Spine Framework that is used in ETB.                                                                           |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted                      | Impact Description                                                                                                                                                                                         |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Existing content from Content Providers | Content from some content providers may have to be migrated to new K-12 Spine framework, in which case Board for that content needs to be removed. A separate ticket will be created for this if required. |
|                                         |                                                                                                                                                                                                            |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                                               | Purpose of Metric                                                   |
| -------- | ---------------------------------------------------- | ------------------------------------------------------------------- |
| 1        | Number of content created using K-12 Spine Framework | This gives a measure of business value achieved using this feature. |
|          |                                                      |                                                                     |

2\. Defining current ETB Scope

**Overview** As described in introduction, currently the state framework comprise of the entire curriculum values which means all the values of Medium, Grade, Subject & topics. Also the same is being rendered in all the scenarios like user profile, content/TB creation or consumption. However state ETB scope may not consist of the entire curriculum but certain subset values (for Medium, Grade Subject) out of entire curriculum for which state wants to energize the textbooks. Hence we need to capture the ETB scope separately (as a different object/framework) and need to customize the rendering of the entire framework or just ETB scope values, depending upon the different scenarios.

**Process Workflow**

1. **Configure State Curriculum Framework** - State provides complete state curriculum (all the values of Medium, Grade, Subject, Topics & sub topics) & state specific K-12 framework is assigned to its tenant.
2. **Define ETB Scope** - State provide its ETB scope definition which includes Medium, Grade, Subject values for which textbooks to be created and QR codes are to be linked to these TBs. These values (ETB Scope) has to be separately captured as an object/framework.
3. **Display** either the complete framework values or just ETB scope values depending upon the different scenarios

**User Story 1 - Configure Complete State Curriculum Framework** Configure curriculum Framework for the first timeState need to provide "Board" and entire state curriculum values for the following:

1. Subject list
2. Medium list
3. Class list
4. Topic and Subtopic hierarchy

This will be provided by Content PMU.  Each Subject and Class combination will have a Topic and Subtopic hierarchy defined. There may be some topics that are not linked to any Class but only to a Subject. There is no scenario where topics are not linked to any Subject.

State specific, K-12 framework is assigned to state instant. All these allocation would be done from the back-end by implementation team. At this point of time, providing topic/sub topic values are not mandatory. However whenever they are provided, they are added to curriculum framework.

\*\*Update curriculum framework \*\*

Content PMU will be updating curriculum Framework periodically if required to add new Subjects or Topic/Subtopics. The backend update process should support this. The changes are:

1. Adding new Topics or Subtopics to existing Subject, Class combination
2. Adding new Subjects along with topic, subtopics for the new Subject (with a class combination)

**User Story 2 - Define ETB Scope** **Configure ETB scope for the first time for a year/time period**

State provides the ETB scope definition for the given academic period. ETB scope is nothing but details of

* Medium List
* Grade List
* Subjects List

for which textbooks are to be created & to be energized (linked to QR codes & content). Of course ETB scope would be a sub set of entire curriculum framework defined. ETB scope has to be separately captured so that its values can be rendered wherever required. ETB scope will also be defined from the back-end by implementation team. There can be only one scope definition for an instant for a given year/time period.

**Update ETB Scope:**

Content PMU may update ETB scope if required to add new Subjects or Topic/Subtopics. The back-end update process should support this. The changes are:

1. Adding new Topics or Subtopics to existing Subject, Class combination
2. Adding new Subjects along with topic, subtopics for the new Subject (with a class combination)

**User Story 3 - Display filter values (Either for entire curriculum framework or for ETB scope) for different scenarios** In this user story, we would define the different user scenarios and which framework values to be displayed for them, whether the entire curriculum framework or just  ETB scope values.

**User profile** **:** In case of user profile, **display the entire curriculum framework values**  because the same framework is used for Teacher Training solution. Teachers who take training will have a profile with their classes, subjects filled in. There may be teachers taking trainings that are in classes outside ETB scope.

**Creation:**

* **Textbook Creation:** For textbook creation, filters should only \*\*display ETB scope values \*\* because textbooks are only created for the scope defined by the state.&#x20;
* **Resource Creation :** However resource can be created irrespective of the scope defined by the state. Hence **entire** **curriculum framework values should be displayed** in filters while creating resources.

**Consumption:**

* **At Mobile library page -** Mobile library page consumption is default limited to textbooks hence filters (Class, Medium) should **only display ETB scope values** because textbooks are only created for the scope defined by the state.
* **Filter in library on portal -** At portal user can search for textbook as well as content and content can be created irrespective of ETB scope. Thus Filters at portal library page should **display the entire curriculum framework values.**
* **Search results + Filters (Portal & Mobile) -** Since this page is the extension of the previous page, filters at this page should also **display the entire curriculum framework values.**

**Reports:** Reports are strictly limited to ETB scope hence only **ETB scope values are required to be displayed** in filters.

JIRA Ticket ID[SB-13526 System JIRA](https://browse/SB-13526)

Localization RequirementsNA

Telemetry RequirementsNA

Non-Functional RequirementsNA

Impact on other Products/SolutionsImpact on the user profile, creation and consumption has been defined in the use case itself.

Impact on Existing Users/Data NA

Key Metrics

| Srl. No. | Metric                                                | Purpose of Metric |
| -------- | ----------------------------------------------------- | ----------------- |
| 1        | Number of resources tagged to ETB scope values        |                   |
| 2        | Number of resources tagged to out of ETB scope values |                   |

***

\[\[category.storage-team]] \[\[category.confluence]]
