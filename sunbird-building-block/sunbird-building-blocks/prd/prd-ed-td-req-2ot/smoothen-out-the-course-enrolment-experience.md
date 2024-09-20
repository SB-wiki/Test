# Smoothen-out-the-course-enrolment-experience

**As a** teacher

**I want to** be able to enrol into the course assigned to me by the state without any friction

**So that** I can take the course.&#x20;

**Context**

The current courses experience on the mobile app has multiple points of friction - particularly in course discovery and enrolment. Data shows that out of 100% of users landing on the courses page, median clicks on enroll in course is around 17%, and median actual enrolments is around 13% out of that (these numbers are larger in the first week when the course is mandatory - they rest at 50% and 78%). Field studies point towards the current enrolment experience being the roadblock in this process. Hence, this story aims to fix that.

**Current experience:** Open a course -> Enroll -> Sign in/up -> Search for a course (!) -> Enroll again (!) -> Select a batch -> Successfully enrolled.  **Proposed experience:** Open a course -> Enroll -> Select a batch -> Sign in/up -> Successfully enrolled.&#x20;

**Acceptance Criteria**

GIVEN I am a teacher viewing the courses tab

WHEN I choose to enroll in course

THEN I am shown the list of ongoing batches.&#x20;

GIVEN I am viewing the batches

WHEN I choose to enroll in a batch

THEN I am taken to the sign in page.&#x20;

GIVEN I am on the sign in page

WHEN I successfully sign in/sign up

THEN

1. I am enrolled into the course and I'm shown a message confirming the same
2. I'm taken to the course TOC page from where I can start the course
3. I see that particular course in the "My Courses" section.&#x20;

**Other details**

* On the ongoing batches page, the enroll link should be converted to a button (using the design guidelines)
* If there are no active batches for a course, the user should be given the feedback even before they are asked to login. (Same message as of today)

***

\[\[category.storage-team]] \[\[category.confluence]]
