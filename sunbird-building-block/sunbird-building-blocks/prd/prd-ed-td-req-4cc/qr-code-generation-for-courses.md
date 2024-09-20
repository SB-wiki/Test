# QR-code-generation-for-Courses

IntroductionIn order to help the teachers who struggle to search and discover the specific course which they need to enroll, we provided a facility for teachers to scan a QR code and enroll/consume course as part of R 2.1.0. However, The QR code generation is currently being done as a back end activity by the Implementation team. Going forward, we want the State to be able to generate, download and print the QR codes on their own, without manual intervention from Implementation or any other team.

&#x20;JTBD

| **Who is the user and what is the user trying to do which is currently a struggle**                                                          | **What is the context**        | **Functional Goal**                                                        |
| -------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ | -------------------------------------------------------------------------- |
| Teachers, when enrolling and accessing online course content, struggle to search and discover the specific course which they need to enroll. | Course discovery & consumption | _Ability for teachers to scan a QR code and enroll/consume course content_ |

**User Personas:**

Teachers -  Users who login (State SSO/State on-boarded/Self signed up) to access the platform and consume the course content

State admin - Users who are responsible for the successful launch of the course(s) which includes publishing of courses and running outreach programs/campaigns to drive the course enrollment & completion metrics.&#x20;

Use Case - OverviewEnable State to enroll and consume course by scanning the appropriate course QR code. This can be accomplished by&#x20;

1. Automatically generating QR code for every Course&#x20;
2. Allow State to download and print QR codes for the intended Course/s&#x20;

**Epic JIRA Ticket ID:**

[SB-13466 System JIRA](https://browse/SB-13466)

User Story 1 - Generate QR code for every published course As a State admin, I would want to have a QR code generated for every published course, So that the course consumption becomes easy for my teachers in the state

\*\*Pre-conditions: \*\*

1. Content reviewer has clicked "Publish"

**Acceptance criteria:**

Verify that:

**Main work flow**

1. QR code gets generated.
2. There is only one QR code associated with a Course, irrespective of the number of times it is updated/published
3. The QR code is not visible to any user on the UI

**Alternate work flow**

None

**Exceptional Workflow**

None

**JIRA Ticket ID**

[SB-13471 System JIRA](https://browse/SB-13471)

User Story 2 - Download QR Code for a CourseAs a State Admin, I would want to be able to download QR codes for the intended courses, So that I can download/print the QR codes in a course catalog and distribute it to all the teachers in the state.

**Pre-conditions:**

1. A course is published
2. The logged in user has access to "Published" menu in Workspace
3. Logged in user has clicked "Published" from Workspace

**Acceptance criteria:**

Verify that:

**Main work flow**

1. There is a facility to download QR codes of all courses (created by the logged in user) that has QR code linked . This facility should be available only when there is at least one published course that has a QR code linked. Else, this facility should not be available. The name of the button/link should be "Download Course QR Code". Also, a tool tip should be displayed on mouse over - "Click this button to download QR codes that are linked to Courses"
2. The below details are available in the CSV file on download &#x20;
   1. Course Title - Title of the Course
   2. QR Code - 6 digit Dial code
   3. QR Code image - This will show the URL , click of which, a pop up with the QR code image would open (Example: [https://ntpproductionall.blob.core.windows.net/dial/0123221758376673287017/5\_A4D2H4.png](https://ntpproductionall.blob.core.windows.net/dial/0123221758376673287017/5\_A4D2H4.png))
3. The courses with no QR code are not available in the CSV file when downloaded&#x20;

**Alternate Workflow**

None

**Exceptional Workflow**

None

**UI design**

![](<../../../../PRD/prd-ed-td-req-4cc/images/storage/Download course QR code.png>)

Button active state  \*\*#07BC81 \*\* use this color code

Button on hover  \*\*#008840 \*\* use this color code

&#x20;        &#x20;

Button style -&#x20;

height: 32px;width: 199px;border-radius: 3px;           **JIRA Ticket ID**

[SB-13474 System JIRA](https://browse/SB-13474)

Localization Requirements

| UI Element | Description | Language(s)/ Locales Required |
| ---------- | ----------- | ----------------------------- |
| None       |             |                               |
|            |             |                               |

Telemetry Requirements

| Event Name                                                                     | Description                                                                                                                                                                | Purpose                                         |
| ------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| Download QR code for a course                                                  | Allows state admin to download the QR code (Image and code) as an image                                                                                                    | To track the usage of download QR code feature. |
| Scan QR code - Differentiate the scan between Course, Textbook or any resource | Telemetry should be captured when a QR code for a course is scanned. Scan of QR code associated with a Course should be differentiated from textbook or any other resource | To track the total QR code scan for courses     |
|                                                                                |                                                                                                                                                                            |                                                 |
|                                                                                |                                                                                                                                                                            |                                                 |

Non-Functional Requirements

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                |                                                                                               |                                                                     |
|                                                                                                                |                                                                                               |                                                                     |

Impact on other Products/Solutions

| Product/Solution Impacted                                                     | Impact Description                                                                                                                                                                                                                                                                      |
| ----------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Specify the name of the product/solution on which this use case has an impact | Explain how the product/solution will be impacted.                                                                                                                                                                                                                                      |
| ETB reports                                                                   | The QR scan count of courses might get included in the ETB scan report/s. It has to be ensured that the scan count resulting from Course QR code, does not get included in the ETB reports. The QR code scan count of textbooks/resources should be differentiated from that of courses |

Impact on Existing Users/Data&#x20;

| User/Data Impacted | Impact Description |
| ------------------ | ------------------ |
| NA                 |                    |
|                    |                    |

Key Metrics

| Srl. No. | Metric           | Purpose of Metric                                                                                                                     |
| -------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | Download QR code | This metric will provide insights on whether state admins are downloading the QR codes to drive the Course enrollment and consumption |
|          |                  |                                                                                                                                       |
|          |                  |                                                                                                                                       |

***

\[\[category.storage-team]] \[\[category.confluence]]
