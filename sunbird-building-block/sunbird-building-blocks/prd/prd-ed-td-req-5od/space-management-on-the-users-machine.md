# Space-management-on-the-user's-machine

IntroductionGiven schools have limited space on their devices, they need a mechanism to clear up any unwanted content that they have either downloaded or imported. It is ideal that they get to do this through the desktop app itself, instead of having to search through folders and delete content - that way they are conscious of the content they are deleting.&#x20;

JTBD

* \*\*Jobs To Be Done: \*\* As a desktop app user, I want to be able to delete content or stop downloads on the app, so that I can manage my space on the machine.&#x20;
* **User Personas:** Government school teacher, Cluster Rep
* **System or Environment:**  School with intermittent or no connectivity

Requirement Specifications

* Ability to delete textbooks and individual content
* Ability to pause and cancel downloads

\<Story: User deletes content from the desktop app> OverviewOnce a user has downloaded or imported content, they need an ability to delete the content as and when they are done with it - as they may be running out of space.&#x20;

Assumption: Textbook or course spines are usually in the size of KBs, and can be downloaded or cached every time a textbook is opened. The users don't need to be made aware that this is downloaded.&#x20;

| Srl. No. | User Action                                                                            | Expected Result                                                                                                                                                         |
| -------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | User opens a downloaded textbook or a downloaded individual content from their library | They are shown an option to delete the content (This option is not shown on textbooks where only the spine has been downloaded, or who have not downloaded the content) |
| 2        | The user opens their downloads tab where they view a textbook or an individual content | They are shown an option to delete the content (This option is also shown for textbooks where only the spine is downloaded)                                             |
| 3        | The user chooses to download the textbook or the individual content                    | They are shown a message asking them to confirm whether they'd like to delete the content?                                                                              |
| 4        | The user confirms that they would like to delete the content                           | They are shown a message that the content is deleted (and the delete happens in the background) and the user is taken to their library page                             |
| 5        | The user confirms that they don't want to delete the content                           | The content is not deleted, and they remain on the page they initiated the action from                                                                                  |

\<Alternate Scenario 1>

| Srl. No. | User Action                                                                     | Expected Result                                                                                                                        |
| -------- | ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user deletes a whole textbook                                                 | The whole textbook inclusive of the spine should get deleted                                                                           |
| 2        | A user deletes an individual content which is linked to more than one textbook  | The individual content will be deleted, and when the user visits that content piece they will see the content details page with either |

1. an empty player + content information and a message asking them to download the content if they are offline
2. the content playing on the content details page, with the option to download the content if they are online

\| | 3 | A user deletes a textbook which contains a content which is linked to another textbook | The individual content gets deleted from both textbooksThe user will have to re-download this content when they're viewing the new textbook |

WireframesNo wireframes to be added for now.

Please replace the download button on the TOC page and the individual content details page with a delete button (when the download is complete).&#x20;

Please use design guidelines to create this button, and to style the confirmation popup.&#x20;

JIRA Ticket ID[SB-15384 System JIRA](https://browse/SB-15384)

\<Story: User pauses/resumes/cancels a download or an import of content> OverviewIn a quest to download content to use offline in schools, teachers/cluster reps may try to download or import a piece of content that is

* much bigger size than they expected&#x20;
* not the content they intended to download
* not suited for download under their current bandwidth conditions&#x20;

In such cases, a user should have the ability to pause, cancel or resume the download.&#x20;

| Srl. No. | User Action                                                     | Expected Result                                                                                                                                                                                                  |
| -------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | A user initiates a download or an import of content             | They see the item come up in their content manager, with options to pause, cancel and resume the action                                                                                                          |
| 2        | They choose to pause the action                                 | The download or import halts mid way, and the user can choose to resume the action(All paused actions - irrespective of whether paused by the user or the app will autoresume the next time you launch the app)  |
| 3        | They choose to cancel the action                                | The action immediately aborts, and the content downloaded/imported so far gets deleted                                                                                                                           |
| 4        | A download or an import fails when the user attempts the action | The user sees that action has failed, and that they can retry                                                                                                                                                    |

| Srl. No. | User Action                                                                                                                 | Expected Result                                                                           |
| -------- | --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| 1        | A user tries to cancel the import before the content has been copied fully by the system                                    | The overall action is aborted                                                             |
| 2        | A user tries to cancel the import after the content has been copied, but before it is extracted                             | The copied content is deleted and the overall action is aborted                           |
| 3        | A user tries to pause the import before a content piece is copied, and they resume it afterwards                            | Only if the same pendrive is connected, the action can resume - else it will fail         |
| 4        | A user tries to pause the import after a content piece is copied, but before it is extracted, and they resume it afterwards | Irrespective of whether the same pendrive is plugged in or not, the action can be resumed |

Wireframes[https://projects.invisionapp.com/d/main#/console/18612105/389083501/preview](https://projects.invisionapp.com/d/main#/console/18612105/389083501/preview)

JIRA Ticket ID[SB-15386 System JIRA](https://browse/SB-15386)

Localization Requirements

| UI Element                        | Description                                                                                               | Language(s)/ Locales Required             |
| --------------------------------- | --------------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| Tab headers - Library & Downloads | Main navigation headers in the desktop app                                                                | All languages supported by the mobile app |
| CTAs                              | Action buttons that a user can interact with like pause, delete, resume, retry, cancel                    | All languages supported by the mobile app |
| Status messages                   | Statuses displayed to the user like 'waiting for download', 'waiting for upload', 'Download Failed' etc.  | All languages supported by the mobile app |

Telemetry Requirements

| Event Name       | Description                                                                                                                                                                                                          | Purpose                                                            |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Clicks on pause  | Interact event containing the action performed by the user (pause download, pause import) along with the context of the content the user (content ID) and the point of pause (x% or how many MB they paused at)      | To get a sense of realistic constraints the user is grappling with |
| Clicks on resume | Interact event containing the action performed by the user (resume download, resume import) along with the context of the content the user (content ID) and the point of resume (x% or how many MB they resumed at)  |                                                                    |
| Clicks on cancel | Interact event containing the action performed by the user (cancel download, cancel import) along with the context of the content the user (content ID) and the point of cancel (x% or how many MB they canceled at) |                                                                    |

Non-Functional Requirements

| Performance / Responsiveness Requirements      | Load/Volume Requirements                                                                                           | Security / Privacy Requirements |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------------------------------- |
| All actions should be performed in 4-5 seconds | User can only action one item at a time, and only after the action is complete - the user can action the next item |                                 |
|                                                |                                                                                                                    |                                 |

***

\[\[category.storage-team]] \[\[category.confluence]]
