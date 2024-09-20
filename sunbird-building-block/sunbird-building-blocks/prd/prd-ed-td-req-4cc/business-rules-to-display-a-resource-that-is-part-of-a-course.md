# Business-rules-to-display-a-Resource,-that-is-part-of-a-Course

IntroductionResources today can be used independently or linked to a Course for consumption. Sometimes it is noticed that the course name and resource name are the same and teachers wrongly consume the resource and assume that the course has been completed. In this case, the teacher actually completed consuming a Resource and not a Course. This causes confusion among the teachers. Also, resources meant to be part of a Course, some times loses the continuity and context when consumed as a Resource. Hence the best way to handle this would be to make a resource either available to all or course creators based on the intent

&#x20;JTBD

| **Who is the user and what is the user trying to do which is currently a struggle**                                                                                  | **What is the context** | **Functional Goal**                                                                                       | **Emotional/Social Goal**                                          |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Sometimes it is noticed that the course name and resource name are the same and teachers wrongly consume the resource and assume that the course has been completed. | Online Training         | _Ability to not show Resources that are part of a Course to all users (and show only to course creators)_ | _Help/Guide teachers to complete the course without any confusion_ |

Use Case - Overview

* To enable a Resource that is part of a course, to be visible only to the course creators
* To enable a Resource that is part of a course, to not be visible to other users (other than course creators)

**Epic JIRA Ticket ID:**

[SB-14679 System JIRA](https://browse/SB-14679)

User Story 1 - Restrict access to a Resource that is part of a course on portal As a Course creator, I do not want a resource that is part of a course to be visible to all users (except user with role “content creator”) during search on the portal,  so that the users get to search for a course appropriately

**Pre-conditions:**

1. A resource is a part of a published course
2. The user has access to search and consume Resource
3. The user searches for the resource from "Library" section

**Acceptance criteria:**

**Main work flow**

Verify that&#x20;

1. The user does not get any results after search

Note: There has to be an internal check done if a resource is a part of course or not. If yes, this should not be displayed to the users during search

**Alternate Workflow**

None

**Exceptional Workflow**

None      &#x20;

**JIRA Ticket ID**

[SB-14673 System JIRA](https://browse/SB-14673)

User Story 2 - Restrict access to a Resource that is part of a course on mobile appAs a Course creator, I do not want a resource that is part of a course to be visible to all users (except user with role “content creator”) during search on the mobile app, so that the users get to search for a course appropriately

**Pre-conditions:**

1. A resource is a part of a published course
2. The user has access to search and consume Resource
3. The user searches for the resource from "Library" section

**Acceptance criteria:**

**Main work flow**

Verify that&#x20;

1. The user does not get any results after search

Note: There has to be an internal check done if a resource is a part of course or not. If yes, this should not be displayed to the users during search

**Alternate Workflow**

None

**Exceptional Workflow**

None      &#x20;

**JIRA Ticket ID**

[SB-14674 System JIRA](https://browse/SB-14674)

User Story 3 - A Resource that is part of a course should be accessible to Course creatorsAs a Course creator, I would want a resource that is part of a course to be visible to me on the portal, so that i can use it in my course creation process

**Pre-conditions:**

1. A resource is part of a published course
2. The user has access to create course

**Acceptance criteria:**

**Main work flow**

Verify that&#x20;

1. The user is able to search and view the Resource from "library" tab
2. The user is able to use the resource in the course creation process

**Alternate Workflow**

None

**Exceptional Workflow**

None      &#x20;

**JIRA Ticket ID**

[SB-14677 System JIRA](https://browse/SB-14677)

Localization Requirements

| UI Element | Description | Language(s)/ Locales Required |
| ---------- | ----------- | ----------------------------- |
| None       |             |                               |
|            |             |                               |

Telemetry Requirements

| Event Name                                | Description                                           | Purpose                                                                                 |
| ----------------------------------------- | ----------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Search Resource that is part of a Course  | User searches for a resource that is part of a course | This event gives an idea of user count who searched for a resource rather than a course |
|                                           |                                                       |                                                                                         |
|                                           |                                                       |                                                                                         |
|                                           |                                                       |                                                                                         |

Non-Functional Requirements

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                |                                                                                               |                                                                     |
|                                                                                                                |                                                                                               |                                                                     |

Impact on other Products/Solutions

| Product/Solution Impacted | Impact Description |
| ------------------------- | ------------------ |
| None                      |                    |
|                           |                    |

Impact on Existing Users/Data&#x20;

| User/Data Impacted | Impact Description |
| ------------------ | ------------------ |
| None               |                    |
|                    |                    |

Key Metrics

| Srl. No. | Metric                                                   | Purpose of Metric                                                                                                         |
| -------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| 1        | Number of searches (resource that is marked to a course) | This metric will help to understand how many users search for resources tagged to a course instead of the actual course.  |
|          |                                                          |                                                                                                                           |
|          |                                                          |                                                                                                                           |

***

\[\[category.storage-team]] \[\[category.confluence]]
