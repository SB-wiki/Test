# Licensing-and-Attribution-for-Courses

IntroductionThis document details out the licensing, copyright, credits and attribution details that are to be shown in courses. The main intent of these changes is to make sure:

a) we are compliant with the legal requirements &

b) both ETB and TPD capture the standard set of inputs from the authors and display the relevant information

Requirement SpecificationsUse Case 1 OverviewThis use case deals with the additional attributes that are to be entered by the author when creating a course and how to show these to the users who are consuming the course.

User Story 1 (Portal) **Scenario 1:** A new course is created on DIKSHA. Course content (Resources) is authored by state teachers.

**Scenario 2:** A new course is created on DIKSHA. Course content (Resources) belongs to 3rd party content providers.

**Scenario 3:** A new course is created on DIKSHA. Course content (Resources) is a mixture of 3rd party content and state owned content

In all these scenarios following details are to be provided by the creator when creating the course: (these are the new fields to be introduced in the course meta data form API)

1. Course Author - The person or organization who has authored the content. If the author herself is creating the content on DIKSHA, she can give her name. But if a different person has created the content and do not have access to DIKSHA, the person creating the content on DIKSHA should provide the original author’s name. This is a free flowing text and is mandatory.
2. Rename 'OWNER' to 'COPYRIGHT' **:**
3. Show the license information at the bottom of the form. This is a label

Please refer to the below snapshot on the new fields in the form API.

![](<../../../../PRD/prd-ed-td-req-ind/images/storage/Form Changes\_\_1561703663\_182.73.165.66.jpg>)

In the portal view, in the course ToC page needs to show the following:

1. **Author** - As provided by creator during creation of the content
2. **Published on DIKSHA by** - This is the tenant name in which the content is created and published
3. **Feedback email ID** - Tenant specific email ID
4. **License**  - CC BY 4.0
5. **View course credits** - Should be a clickable link. Clicking the link will open and show copyright and Attributions entered by the author

**Note - No changes to the information shown in the courses card**

Resource details page will show the following: **No changes needed**

Exception ScenariosFor older courses which do not have values for any of the above fields (Author or feedback email ID) then do not show them

Wireframes for courses portal ToC page

[https://docs.google.com/presentation/d/1iv4ufVFARQZRHOOd8aEdSfoDNwyPHWU9k6ERMnO32ec/edit#slide=id.g5cdc4a8a4e\_0\_0](https://docs.google.com/presentation/d/1iv4ufVFARQZRHOOd8aEdSfoDNwyPHWU9k6ERMnO32ec/edit#slide=id.g5cdc4a8a4e\_0\_0)

For Future ReleaseN/A

JIRA Ticket ID

[SB-13121 System JIRA](https://browse/SB-13121)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

User Story 2 (Mobile)Course details page will show the following under About when the user clicks on 'Read More':

a) Remove 'CLASS', 'SUBJECT', 'MEDIUM'

b) Include AUTHOR, PUBLISHED ON DIKSHA BY, LICENSE, COPYRIGHT

1. **Author** - As provided by creator during creation of the content
2. **Published on DIKSHA by** - This is the tenant name in which the content is created and published
3. **License**  - CC BY 4.0&#x20;
4. **Copyright** -&#x20;

**Note - No changes to the information shown in the courses card**

Resource details page will show the following: No changes to resource page

Exception ScenariosFor older courses which do not have values for any of the above fields (Author or feedback email ID) then do not show them

Wireframes

For Future ReleaseN/A

JIRA Ticket ID

[SB-13123 System JIRA](https://browse/SB-13123)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

### User Story 3 (Show derived source information on the Portal when a course is copied)

As a State Admin, when a course is copied for use, I would want the original source details to be made available to the end users during consumption on the portal, So that the legal requirements are compliant and also source details made available to the user

Acceptance criteria:

Verify that:

1. In addition to the existing licensing details, the below source information is displayed in the course TOC page (from the copied course)

This content is derived from:

Content:

Author of Source Content :

License Terms:

Published on DIKSHA by: ”

Exception ScenariosNone

Wireframes

[https://projects.invisionapp.com/share/3WTXH40VC5F#/screens](https://projects.invisionapp.com/share/3WTXH40VC5F#/screens)

For Future ReleaseN/A

JIRA Ticket ID

[SB-14670 System JIRA](https://browse/SB-14670)

### User Story 4 (Show derived source information on the mobile app when a course is copied)

As a State Admin, when a course is copied for use, I would want the original source details to be made available to the end users during consumption on the mobile app, So that the legal requirements are compliant and also source details made available to the user

Acceptance criteria:

Verify that:

1. In addition to the existing licensing details, the below source information is displayed in the course TOC page (from the copied course)

"This content is derived from:

Content:

Author of Source Content :

License Terms:

Published on DIKSHA by: \<Published on Diksha (value of the source course)>”

Exception ScenariosNone

Wireframes

For Future ReleaseN/A

JIRA Ticket ID

[SB-14698 System JIRA](https://browse/SB-14698)

### User Story 5 - Include Attributions for courses on the mobile app

As a State Admin, I would want the list of persons/organizations who contributed to the course to be displayed on the mobile app, So that legal requirements are compliant & also ensure that the standard set of inputs from the authors are captured and displayed appropriately

Acceptance criteria:

Verify that:

1. The list of persons/organizations who contributed to the course appears in the attributions section in the mobile app during consumption

Exception ScenariosFor older courses which do not have values for any of the above fields , then do not show them

Wireframes

For Future ReleaseN/A

JIRA Ticket ID

[SB-14697 System JIRA](https://browse/SB-14697)

User Story 6 - Ability to select the appropriate license from the DLL, during course creationJIRA Ticket ID[SB-15980 System JIRA](https://browse/SB-15980)

**Context:**

Currently DIKSHA supports only one license when a content is created or uploaded onto DIKSHA. However, NCERT and content providers like Khan Academy have different license types (such as CC-BY-SA, CC-BY-SA-NC etc.). Hence it is required that DIKSHA support multiple types of licenses for content. However all the licenses should comply to CC framework. A content creator within a state should be able to select the appropriate license for the course while creating a course (though a course consists of multiple contents and each content could correspond to a specific license).

**Update added on 11th Dec 2019**

A part of the requirement is already done as part of Resources and hence the only thing left now would be to add a static text at the bottom of the screen

**As a Course creator, I would want to be able to see a static consent text during course creation, So that i am aware that by selecting the license type, i am providing my consent for the same**

**Acceptance criteria:**

**Pre-conditions:**

1. Logged in user has access to create a course
2. Logged in user is in the process of course creation and is in the Edit details screen

**Verify that:**

**Main Workflow:**

1.  There is a static text at the bottom as following -

    “By creating any type of content on DIKSHA, you consent to publish it under the Creative Commons License Framework <[https://creativecommons.org/licenses/](https://creativecommons.org/licenses/)> Please choose the applicable

**Exception Workflow**

None

Wire frame[https://projects.invisionapp.com/share/UJV0Z34A29W#/screens/395497416](https://projects.invisionapp.com/share/UJV0Z34A29W#/screens/395497416)

For Future Release

N/A

User Story 7 - Show updated license details for a course on portal, during consumptionJIRA Ticket ID[SB-15367 System JIRA](https://browse/SB-15367)

**Context:**

A course is a collection of many contents/resources and currently DIKSHA supports only one license. However a content could be from Khan Academy, NCERT, etc.,in which case the license terms are different for different contents. Hence it is required that DIKSHA supports multiple types of licenses for content. The course creator could choose/tag a specific license type for a course and the same should be made available to the user on the portal during consumption

**As a user, I would want to be able to see the license details of the course on portal, So that i am aware of the correct license information of the course i consume**

**Acceptance criteria:**

**Pre-conditions**

The logged in/guest user is in the course TOC page

**Main workflow**

Verify that

1. The license details (License name + description(if available) + corresponding license link) selected by the course creator is made available to the user during consumption on the portal            Note: Description gets added from the back end for a license. If description is available, the same is shown to the user, else only the License name and the corresponding link are displayed

**Exception Workflow**

For existing courses, license value should be updated as per default license for its tenant (This would be part of the one time update)

Wire frame[https://projects.invisionapp.com/share/UJV0Z34A29W#/screens/395356119](https://projects.invisionapp.com/share/UJV0Z34A29W#/screens/395356119)

For Future Release

N/A

### User Story 7 - Show updated license details for a course on mobile, during consumption

JIRA Ticket ID **System JIRAkey,summary,type,created,updated,due,assignee,reporter,priority,status,resolution2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSB-15981**

**Context:**

A course is a collection of many contents/resources and currently DIKSHA supports only one license. However a content could be from Khan Academy, NCERT, etc.,in which case the license terms are different for different contents. Hence it is required that DIKSHA supports multiple types of licenses for content. The course creator could choose/tag a specific license type for a course and the same should be made available to the user on the mobile app during consumption

**As a user, I would want to be able to see the license details of the course on mobile app, So that i am aware of the correct license information of the course i consume**

**Acceptance criteria:**

**Pre-conditions**

The logged in/guest user has clicked "Credits & License Info" link in the "Training information" section

**Main Workflow**

**Verify that:**

1. The license details (License name + description(if available) + corresponding license link) selected by the course creator is made available to the user during consumption on the mobile app    Note: Description gets added from the back end for a license. If description is available, the same is shown to the user, else only the License name and the corresponding link are displayed

**Exception Workflow**

For existing courses, license value should be updated as per default license for its tenant (This would be part of the one time update)

Wire Frame[https://projects.invisionapp.com/share/UJV0Z34A29W#/screens/395356119](https://projects.invisionapp.com/share/UJV0Z34A29W#/screens/395356119)

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                                                                           | Description                                                                                                                       | Language(s)/ Locales Required                                           |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Mention the UI Element that requires localization. e.g. Label, Button, Message, etc. | Provide the exact details of the element that requires localization. e.g. User ID, Submit, 'The content is currently unavailable' | Mention all the languages or locales for which localization is required |
|                                                                                      |                                                                                                                                   |                                                                         |
|                                                                                      |                                                                                                                                   |                                                                         |

Telemetry RequirementsN/A

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements | Load/Volume Requirements | Security / Privacy Requirements |
| ----------------------------------------- | ------------------------ | ------------------------------- |
|                                           |                          |                                 |
|                                           |                          |                                 |

Impact on other Products/SolutionsN/A

\| | |

Impact on Existing Users/Data N/A

Key MetricsN/A

\| | |

***

\[\[category.storage-team]] \[\[category.confluence]]
