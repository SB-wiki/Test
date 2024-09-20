# Upload-of-participants-to-invite-only-batch

IntroductionStates want to control who can enroll into a batch. This cannot be done in an open batch and hence can be done via an invite-only batch. Invite-only batches are not designed to support more than 50 enrollments. However, states' training batches are upwards of 5k. Hence the need to bulk upload participants from the backend.

User Story 1 As a state admin, I should be able to upload batch participants in an invite only batch from the back end using an API.

Pre-requisites:a) All state teachers are onboarded

Workflow Steps: **Adding users to invite-only batch**

a) Invite-only batch is created by the course mentor.&#x20;

b) Batch ID is shared with the DIKSHA implementation team.

c) State also shares the list of participants with a unique identifier - could be the state ID or DIKSHA user ID

c) Implementation team runs the API to upload the participants in the desired batch

**Removing users from invite-only batch:**

a) Invite-only batch is created by the course mentor.&#x20;

b) Batch ID is shared with the DIKSHA implementation team.

c) State also shares the list of participants with a unique identifier - could be the state ID or DIKSHA user ID - who need to be removed from the batch

c) Implementation team runs the API to remove the participants in the desired batch

WireframesN/A

ExceptionsIf the user is already present in the batch then skip the record.

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID [SB-13085 System JIRA](https://browse/SB-13085)Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

User Story 2Invite only batches are designed to support 100 users. If the count of participants exceeds 100 members in the batch then when the mentor clicks on 'Edit Batch' the usability of the entire window is poor. The scope of this story is:

1. No changes to adding participants functionality in Create Batch workflow.
2. Scope of the changes are only for Edit Batch workflow.

a) if the participant list exceeds 100 members, then grey out the participants drop down button in the Edit batch window so that the mentor cannot add any further participants from the front end.

b) If the participants are added from backend, then there is no limit to the number of users who can be added to the batch. If more than 100 members are in the batch then grey out the participants drop down as mentioned in point a)

b) Show a message on the batch window, that 'Please contact your state admin to add or remove participants from this batch'.&#x20;

3. This Edit batch window can be navigated either by clicking on the course card or from the workspace tab. The experience outlined in point a) should be replicated irrespective of how the mentor lands up in 'Edit Batch' window
4. Course dashboard and download csv should capture all the list of participants with their course progress&#x20;

Wireframes

N/A

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-13087 System JIRA](https://browse/SB-13087)

Insert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name | Description | Purpose |
| ---------- | ----------- | ------- |
|            |             |         |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                | Expected maximum participants in invite-only batches is 10k                                   |                                                                     |

Impact on other Products/Solutions

Impact on Existing Users/Data N/A

Key MetricsN/A

***

\[\[category.storage-team]] \[\[category.confluence]]
