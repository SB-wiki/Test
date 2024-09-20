# Course-enrollment-&-consumption-via-QR-codes

Introduction **Purpose:** The current course enrollment mandates that teachers search for the course and then click on enroll, to enroll into the course.

Primary problem with this approach is that the course discovery becomes tedious and since the online courses are not mandatory this may lead to a significant drop in teacher enrollment.

Course enrollment and consumption via QR code scan will enable:

1. teachers to easily access specific courses, enroll and consume the course content
2. state to efficiently communicate the list of courses to be consumed by teachers by printing and distributing a course catalog with the corresponding QR codes.

JTBD

| **Who is the user and what is the user trying to do which is currently a struggle**                                                          | **What is the context**       | **Functional Goal**                                                              |
| -------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- | -------------------------------------------------------------------------------- |
| Teachers, when enrolling and accessing online course content, struggle to search and discover the specific course which they need to enroll. | Course discovery & enrollment | _Ability for teachers to scan a QR code and enroll/consume course content_       |
| State admin in their teacher outreach campaign struggles to communicate which courses teachers should enroll and complete.                   | Outreach campaign             | _Ability for the state to disseminate course related information in an easy way_ |

**User Personas:**

Teachers - these are the end users who login (state SSO/state on-boarded) to access the platform and consume the course content.

State admin - these are the users who are responsible for the successful launch of the course(s) which includes publishing of courses and running outreach programs/campaigns to drive the course enrollment & completion metrics.&#x20;

**System or Environment:**

_Portal:_

1. Min. internet speed (download): 1 Mbps
2. Time to load any webpage (first meaningful paint): 3 seconds
3. Max. time for any webpage to be interactive (consumption side): 5 seconds
4. Max time to load a content slide in player (streaming/online play): 3 seconds
5. Accessibility (basic level): All images with alt tags
6. Cross-browser support: Chrome 50 + (desktop + mobile), UC Web (mobile only), Firefox (desktop only)
7. Resolution:
8. Active devices per day:  _70,000 (Predicted - 200,000 to 500,000)_
9. Concurrent users:  400 requests/sec, concurrent logins

_Mobile App:_

1. Time taken to show book details after downloading spine: <3 seconds
2. Time taken to show ‘Play’ after downloading content: <3 seconds

Use Case OverviewEnable teachers to be able to enroll and consume course by scanning the appropriate course QR code. Hence the need to enable:

1. Linking of QR code to a course from the backend
2. Course enrollment via QR code scan
3. Course consumption & completion via QR code scan

Epic JIRA Ticket ID:[SB-11660 System JIRA](https://browse/SB-11660)

Overall Process WorkflowReplace the text within < > in the heading above with the name of the use case. Insert a diagram in the space below to depict the typical workflow for the envisaged use case. To do so, create the diagram in any editor and save as an image. Insert the image below. &#x20;

User Story 1As a state admin I want to associate a course with a QR code so that I can print the course QR code in a course catalog and distribute it to all the teachers in the state.

Main ScenarioAssociation of a QR code to a course will be done from the backend by a API. API(s) will be used to carry out the following functions:

1. Generate a QR code
2. Link the generated QR code to a course
3. Remove course association with the QR code
4. Update QR code by linking a new course

Note:

* these QR codes will be generated using the DIAL infra thereby providing the flexibility to dynamically update course(s) linked to these QR codes.
* QR code can have more than a single course or a resource linked to it.

Pre-requisites:

To associate a course to a QR code:

* Course has to be published

| Srl. No. | User Action                                        | Expected Result                                  |
| -------- | -------------------------------------------------- | ------------------------------------------------ |
| 1        | Generate a QR code                                 | The necessary QR code is generated               |
| 2        | Link a course to the QR code                       | Specific course is now linked to the QR code     |
| 3        | Remove the link between the course and the QR code | QR code does not have the specific course linked |
| 4        | Link one more course to the QR code                | QR code should be linked to both the courses     |

Alternate ScenariosNone

Exception Scenarios _**QR code does not have course linked to it**_

Should show the same behaviour as happens for ETB resources

WireframesN/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-11661 System JIRA](https://browse/SB-11661)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

User Story 2 **Mobile Consumption**

As a teacher I want to scan the QR code from my mobile device to enroll into a course.

As a teacher, enrolled into the course, I want to scan the QR code from my mobile device to consume the course content.

Main ScenarioTeachers should be able to use the course QR code as one of the point of entry to:

1. enroll into the course
2. consume the course content
3. complete the course

| **Srl. No.** | **User Action**                                                   | **Expected Result**                                                                                                                                                                                                                                                                                             | **Pre-requisites**                                                                                                                                                                             |
| ------------ | ----------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1            | Logged in teacher scans course QR code from DIKSHA app            | Show the course card;Teacher clicks on the course card;Navigates to course details page;Clicks on Enroll;Chooses the batch to enroll;Enrolled into the batch;Course is now shown in ‘My courses’ section;                                                                                                       | Teacher signs in via state SSO/self-sign up/state on-boarded;Teacher scans from DIKSHA app;Course is linked to the QR code;Course has an open batch;Teacher is not enrolled in the batch;      |
| 2            | Logged in & enrolled teacher scans course QR code from DIKSHA app | Show the course card;Teacher clicks on the course card;Navigates to course details page;Clicks on Resume/Start (depending on whether they have consumed the course content or not);Teachers’ course progress is captured;If the course is completed then the course name is displayed in the user profile page; | Teacher signs in via state SSO/self-sign up/state on-boarded;;Teacher scans from DIKSHA app;Course is linked to the QR code;Course has an open batch;Teacher is already enrolled in the batch; |
| 3            | Not logged in teacher scans course QR code from DIKSHA app        | Show the course card;Clicks on the course card;Teacher is asked to sign-in;Teacher signs-in; (State SSO/self-sign up/state on-boarded)Teacher is taken to the course details page;\<Course enroll and consume workflows will be as per point 1 & 2 listed above)                                                | Teacher is not signed in to DIKSHA app;Teacher scans from DIKSHA app;Course is linked to the QR code;Course has an open batch;Teacher is not enrolled into the batch;                          |
| 4            | Not logged in teacher scans course QR code from a different app   | Will be taken to the course details page in the mobile web view;Clicks on enroll;Teacher is asked to sign-in;Teacher signs-in; (State SSO/self-sign up/state on-boarded)Teacher is taken to the course details page;\<Course enroll and consume workflows will be as per point 1 & 2 listed above)              | Teacher does not scan from DIKSHA app;Course is linked to the QR code;Course has an open batch;Teacher is not enrolled into the batch;                                                         |

Alternate Scenarios **If there are more than one content type, let’s say multiple courses are linked to the QR code?**

When the teacher scans the QR code, show all the courses linked to the QR code

* Teacher clicks on the course: the flow should be per the proposed behaviour detailed in this document

**If there are more than one content type, let’s say a course and a textbook, is linked to the QR code?**

In this context, from the back end, a QR code will be mapped only to a course or multiple courses. When the teacher scans the QR code, the search result shows both the courses.

* Teacher clicks on any of the course card : the flow should be per the existing behaviour

**If the Course do id linked to the QR code is updated?**

When the teacher scans the QR code, show the updated course do id. A new do id translates into a new course. Hence, the subsequent enrollment and consumption behaviour will replicate the behaviour outlined in this document.

Exception Scenarios **Can a QR code be linked to a course and a text book?**

This is not a valid scenario. Care will be taken to ensure that the QR code for courses will not be linked to textbooks

_**QR code does not have course linked to it**_

Should replicate existing ETB behaviour

_**If the course does not have an open batch**_

After the teacher clicks on ‘Enroll to course’, the behaviour should be per the existing logic i.e., show no batches found message

_**If the course has an open batch and an invite-only batch**_

After the teacher clicks on ‘Enroll to course’, the behaviour should be per the existing logic i.e., show only the open batch

_**If the course has only invite-only batches**_

After the teacher clicks on ‘Enroll to course’, the behaviour should be per the existing logic i.e., show no batches found message

_**Which roles have access to consume courses when scanning course QR code?**_

There is no change to the existing behaviour.

Wireframes[https://projects.invisionapp.com/share/UNS1V2XJMDW#/screens/363899697](https://projects.invisionapp.com/share/UNS1V2XJMDW#/screens/363899697)

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-11662 System JIRA](https://browse/SB-11662)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

&#x20; User Story 3 **Portal Consumption**

As a teacher I want to enter the QR code of the QR code in the DIKSHA portal on my desktop/laptop to enroll into a course.

As a teacher, enrolled into the course, I want to enter the QR code of the QR code in the DIKSHA portal on my desktop/laptop to consume the course content.

Main Scenario **Portal Consumption:**

Teachers should be able to use the course QR code’s QR code as one of the point of entry to:

1. a) enroll into the course
2. b) consume the course content
3. c) complete the course

| **Srl. No.** | **User Action**                                                                        | **Expected Result**                                                                                                                                                                                                                                                                                                      | **Pre-requisites**                                                                                                                                              |
| ------------ | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1            | Logged in teacher enters the QR code of the  course in DIKSHA portal                   | Show the course card;Teacher clicks on the course card;Navigates to course details page;Chooses the batch to enroll;Enrolls into the batch;Course is shown in ‘My courses’ section;                                                                                                                                      | Teacher signs in via state SSO/self-sign up/state on-boarded;Course is linked to the QR code;Course has an open batch;Teacher is not enrolled in the batch;     |
| 2            | Logged in & enrolled teacher enters thec QR ode of the course QR code in DIKSHA portal | Show the course card;Teacher clicks on the course card;Course Resumes/Starts (depending on whether they have consumed the course content or not);Teachers’ course progress is captured;If the course is completed then the course name is displayed in the user profile page;                                            | Teacher signs in via state SSO/self-sign up/state on-boarded;Course is linked to the QR code;Course has an open batch;Teacher is already enrolled in the batch; |
| 3            | Not logged in teacher enters the QR code of the course in DIKSHA portal                | Show the course card;Clicks on the course card;Navigates to the course details page;Clicks on enroll - Teacher is asked to sign-in;Teacher signs-in; (State SSO/self-sign up/state on-boarded)Teacher is taken to the course details page;\<Course enroll and consume workflows will be as per point 1 & 2 listed above) | Course is linked to the QR code;Course has an open batch;                                                                                                       |

Alternate Scenarios **If there are more than one content type, let’s say a course and a textbook, is linked to the QR code?**

When the teacher scans the QR code, show both the course and textbook.

* Teacher clicks on the textbook: the flow should be per the existing behaviour
* Teacher clicks on the course: the flow should be per the proposed behaviour detailed in this document

**If the Course do id linked to the QR code is updated?**

When the teacher scans the QR code, show the updated course do id. A new do id translates into a new course. Hence, the subsequent enrollment and consumption behaviour will replicate the behaviour outlined in this document.

Exception Scenarios

_**QR code does not have course linked to it**_

Should show the same behaviour as happens for ETB resources

_**If the course does not have an open batch**_

In the course details page the behaviour should be per the existing logic i.e., show no batches found message

_**If the course has an open batch and an invite-only batch**_

In the course details page the behaviour should be per the existing logic i.e., show only open batches

_**If the course has only invite-only batches**_

In the course details page the behaviour should be per the existing logic i.e., show no batches found message

Wireframes

N/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-11663 System JIRA](https://browse/SB-11663)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Localization RequirementsNone

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name          | Description                                                                                                                                                                                                     | Purpose                                                                            |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| Course QR code scan | Event to capture the number of QR code scans registered against a QR code.Event to capture the number of QR code scans done b/w mobile app vs portal (via QR code) Event to capture the number of QR code scans | This data will enable us to measure the scale at which this functionality is used. |

Non-Functional Requirements

| Performance / Responsiveness Requirements      | Load/Volume Requirements | Security / Privacy Requirements |
| ---------------------------------------------- | ------------------------ | ------------------------------- |
| Load time of the QR code scan result < 3 secs. |                          |                                 |
|                                                |                          |                                 |

Impact on other Products/SolutionsNone

Impact on Existing Users/Data None

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                                                                                                                                                                                                                                                             | Purpose of Metric                                                                                                                                                                                   |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | <p>Portal + Mobile web + Mobile App: <strong>Course QR code scan ratio</strong> = no. of course QR code scans/total number of enrollments in that courseThis ratio to be monitored at the level of:</p><ul><li>individual course and</li><li>all courses</li></ul> | This metric will provide insights on whether teachers are scanning QR codes and if so, their usage. This metric will provide a objective feedback on the scale at which this functionality is used. |
|          |                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                     |

***

\[\[category.storage-team]] \[\[category.confluence]]
