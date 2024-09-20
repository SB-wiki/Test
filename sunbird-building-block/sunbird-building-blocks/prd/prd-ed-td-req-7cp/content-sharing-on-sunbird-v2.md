# Content-sharing-on-Sunbird-v2

IntroductionSharing of content has followed the basic rules from EkStep Genie, and haven't been updated with time. The goal of this feature will be to update Sharing to make it more powerful, and more likely to share with other users or bring in new users.&#x20;

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* As a teacher/parent, I would like to share what I am using on Sunbird with another teacher/parent. It could just be a link to the content, or the content itself.
* **User Personas:**  [Teacher](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Teacher), [Student](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Student), [Ram](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Ram), [Shyam](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1030127844/User+Personas+India+public+school+education#UserPersonas\(Indiapublicschooleducation\)-Shyam)&#x20;
* **System or Environment:**  Most likely to be used in school (if sharing files). If sending links, can be anywhere.

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

OverviewAs a teacher/parent, I would like to share content with people around me - to direct their attention to a particular piece of content, or to share the content I have already downloaded.

Overall Process Workflow **Flow 1**

1. User A finds a piece of content interesting, and wants to share with User B.
2. User A opens the book/content details page (not downloaded), and taps on the share icon.
3. User sends link to content via WhatsApp to User B.
4. User B sees that the message contains the link to content and information on how to download the Sunbird app.
5. User B taps on the content link and is taken to the content on the web.
6. User might choose to install the app to consume the content from.

\*\*Flow 2 \*\*

1. User A finds a piece of content interesting, and wants to share with User B.
2. User A opens the book/content details page (already downloaded), and taps on the share icon.
3. User A might choose to send the link (Flow 1 applies), or send the downloaded content via WhatsApp/ShareIt, or download the content as an archive to local storage.
   1. Downloaded content sent via some app:
   2. User B receives the content file, along with some instructions on how to load the content via the Sunbird app (link provided).
   3. User B installs the Sunbird app via the link provided, and then attempts to open the content file.
   4. User B imports the content and everyone lives happily forever after.
   5. File stored on local storage.
   6. User A copies the file from the Downloads folder on the local storage, and transfers onto a USB drive.
   7. User B receives the USB drive and taps on the content (because they already have the Sunbird app).
   8. User B imports the content and everyone lives happily forever after.
   9. (User might also use the same content on the offline desktop app)

**Flow 3**

1. User A thinks the Sunbird app is amazing, and wants to share with User B.
2. User A opens the burger menu and selects Settings.
3. User A taps 'Share the Sunbird app'.
   1. User A decides to send link:
   2. User B receives the app link, and opens it.
   3. User B is amazed at the super-amazing functionality that the Sunbird app provides! (So many colors!)
   4. User B installs the app and opens it and finds the amazing world of Sunbird.
   5. User A decides to send the file (apk):
   6. User B receives the app file (apk) via WhatsApp/ShareIt, along with some instructions on how to install it.
   7. User B opens the app, and installs it, and finds the amazing world of Sunbird.
   8. User A decides to save the apk file in their Downloads folder, because they have some important reason:
   9. User A then decides the time is right to send the apk to User B.
   10. User B receives the apk, and fully trusting user A, installs it.
   11. User B finds the amazing world of Sunbird.

OverviewAs a user, I should be able to share content from one device to another, either as a content link or as downloaded pieces of content that can be imported.

Main Scenario - Sending content/collection links from one device to another

| Srl. No. | User Action                                                                                                 | Expected Result                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| -------- | ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | A user clicks on a content card.                                                                            | User sees content details page.                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | User clicks Share on content                                                                                | User sees the share popup, and default selected option is 'Share link'.                                                                                                                                                                                                                                                                                                                                                                                                |
|          | User clicks on 'Share' for the link.                                                                        | User sees the Android dialog for app to share with.                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | User selects an app (e.g. WhatsApp)                                                                         | User sees the WhatsApp app open, and the text displays the following (example):" See 'Content name' on : < http link of content with utm for sharing >Try this content on the mobile app: \<http link of the Sunbird app on Play Store with utm for **sharing content link** and this content id>"The thumbnail of the content should be auto-displayed, and the name of the content with the class (similar to when a user shares a YouTube video with other people). |
|          | Receiving user clicks on:(a) the content link received from WhatsApp(b) the app link received from WhatsApp | (a) User is taken to content on Sunbird website, and if they tap on install link - it uses a utm of 'share' and the content id.(b) User is taken to the play store with the utm of 'share' and the content id.                                                                                                                                                                                                                                                         |
|          | User installs and launches the app                                                                          | Telemetry event is fired with relevant utm params.                                                                                                                                                                                                                                                                                                                                                                                                                     |

Alternate Scenario 1 - User sends downloaded content via filesharing app (ShareIt/WhatsApp etc.)

| Srl. No. | User Action                                                | Expected Result                                                                                                                                                                                                                                                                                                                                                                                                              |
| -------- | ---------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | A user clicks on a content card which has been downloaded. | User sees content details page.                                                                                                                                                                                                                                                                                                                                                                                              |
|          | User clicks Share on content                               | User sees Share popup                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | User clicks on 'Send' within the popup.                    | User sees a % archiving popup with an option to cancel (E.g. 'Packing x/y')User is shown a bunch of apps to send ecar via.                                                                                                                                                                                                                                                                                                   |
|          | User sends content via one of the sharing apps             | (a) Content name is of the format "\_".(b) Metadata in the file contains the list of content included within this archive, in the following format: Collection name                                                                                                                                                                                                                                                          |
|          | Receiving user clicks on the archive file                  | User is taken to the Sunbird app, and sees the splash screen with a confirmation popup to import content. User is not taken away from splash screen until import is complete / cancelled.                                                                                                                                                                                                                                    |
|          | User confirms to import content                            | User sees a progress count of the import status e.g. (Importing 14/50), and an option to cancel. If the import completes, the user is taken to the root content imported. If multiple distinct content/collections were imported, user is taken to the downloads tab.If all content was successfully imported/merged, and if the user had checked the box asking to delete ecar after import, then the archive gets deleted. |
|          | (Optional) User opts to cancel.                            | Content is partially imported, and the user is taken to the root content imported. If multiple distinct content/collections were imported, user is taken to the downloads tab.The ecar should NOT be deleted after partial/unsuccessful import.                                                                                                                                                                              |

Alternate Scenario 2 - User downloads content to device as a ecar

| Srl. No. | User Action                                                              | Expected Result                                                                                                                                                                                                                                                |
| -------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User clicks on 'Save' within the sharing popup for a downloaded content. | User sees a % archiving popup with an option to cancel (E.g. 'Packing x/y')Content is stored in the default Downloads folder directly on the root of the current storage drive (e.g. Internal Storage or SD card).Confirmation toast message is shown to user. |

Alternate Scenario 3 - User shares multiple content from Downloads tab ( Separate story to be taken in a later release - [SB-16680 System JIRA](https://browse/SB-16680) )

| Srl. No. | User Action                      | Expected Result                                                       |
| -------- | -------------------------------- | --------------------------------------------------------------------- |
|          | User goes to 'Downloads' tab     | User sees all content that has been downloaded (including spines).    |
|          | User multi-selects a few content | User sees a contextual popup with Share and Delete                    |
|          | User taps on Share               | User sees share popup where they can select from (Share, Send, Save): |

1. Share: Share text is sent in the following format:
   1. " See the following content on : 'Content name 1': < http link of content with utm for sharing > 'Content name 2': < http link of content with utm for sharing >  'Content name 3': < http link of content with utm for sharing >&#x20;

_(etc.)_

Try this content on the mobile app: \<http link of the Sunbird app on Play Store with utm for **sharing (multiple) content link** and first content id>

"

The thumbnail of the first content should be auto-displayed, and the name of the content with the class (similar to when a user shares a YouTube video with other people).

1. Send: as per (Alternate Scenario 1)
2. Save: as per (Alternate Scenario 2)

When app regains context/completes action, the selected content get unselected. | | | User presses back button (on device) or the cancel button on the contextual (share+delete) popup | All selected content gets unselected. |

Alternate Scenario 4 - User sends Sunbird app to other device as link

| Srl. No. | User Action                                                                                   | Expected Result                                                                                                                                                                             |
| -------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User goes to Settings and clicks share on the Sunbird app, and then selects to share as link. | User sees the WhatsApp app open, and the text displays the following (example):" Get from the Play Store: \<http link of the Sunbird app on Play Store with utm for **sharing app link** >" |

Alternate Scenario 5 - User sends Sunbird app to other device as apk

| Srl. No. | User Action                                                                          | Expected Result                                                                                                                                |
| -------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User goes to Settings and clicks share on the Sunbird app, and then selects to send. | User launches the sharing apps dialog, and sends the apk of the Sunbird app, in the following name format:\_.apk (e.g. DIKSHA\_2\_2\_232.apk). |

Alternate Scenario 6 - User downloads Sunbird app to local device as apk

| Srl. No. | User Action                                                                          | Expected Result                                                                                                                         |
| -------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
|          | User goes to Settings and clicks share on the Sunbird app, and then selects to save. | User saves the apk of the Sunbird app to the default local storage drive in the 'Downloads' folder:\_.apk (e.g. DIKSHA\_2\_2\_232.apk). |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception                                                                                          | Expected Handling                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| -------- | ---------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | User attempts to share the link to a leaf-node content from inside a textbook/collection                   | The share link format should have the root textbook/collection identifier as part of it, so that the user opens the content from within the context of THAT book/collection.Standard behaviour of how the spine loads for the textbook/collection applies (just that it's in the background, so the user doesn't necessarily notice it).If the user presses BACK from this details page, it should take the user to the textbook/collection which this content is a part of. Pressing BACK again will take the user to the library page. |
|          | There isn't enough space on device while trying to export content                                          | User should see the 'Insufficient space on disk' message, with a message to 'Clear some space and try again'.                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | There isn't enough space on device while importing content                                                 | If the user confirms to import content on the splash screen, then the user should see the 'insufficient space on disk' message. (The reason for this is that the user can atleast see the size of the content attempted for import).                                                                                                                                                                                                                                                                                                     |
|          | There isn't enough memory for importing/exporting large content (e.g. archive being unzipped into RAM)     | (a) Import - Extract content onto disk if there is space, else show the insufficient space message. Then import content by content, after which clear the temp storage space.(b) Export - If insufficient RAM available to create an exportable file, show 'Insufficient phone memory' message, with the body saying 'The content is too big to package'.                                                                                                                                                                                |
|          | Content being imported is not of compatible type                                                           | Before showing the import content popup, the user should see the 'This content format (versionNum) is incompatible with the current version of (compatible versionNum)'.                                                                                                                                                                                                                                                                                                                                                                 |
|          | Content transfer abruptly breaks in between (e.g. user exits the app while attempting to export or import) | If there was a break during:a. Export - When app relaunches, the temp files created for export should be deleted.b. Import - When app relaunches, whatever is imported should have remained imported. Whatever wasn't, isn't. If the user attempts to import same content again, anyway a merge action will take place.IN ALL CASES, BEAR IN MIND THAT **SPINES ARE IMPORTED BEFORE LEAF CONTENT** so as not to impact visibility of whatever content got imported.                                                                      |

Wireframes[https://invis.io/2FT7UM1NZ83](https://invis.io/2FT7UM1NZ83)

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-6138 System JIRA](https://browse/SB-6138)

Localization Requirements

| UI Element    | Description                                                                                    | Language(s)/ Locales Required |
| ------------- | ---------------------------------------------------------------------------------------------- | ----------------------------- |
| Popup content | All generic popup text that is NOT content specific (e.g. body of popups, NOT name of content) | All supported languages       |
|               |                                                                                                |                               |

Telemetry Requirements

| Event Name                                                                       | Description                                       | Purpose                                                                                                                             |
| -------------------------------------------------------------------------------- | ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Tap on share (addn attribs: root-content / root-collection / leaf-content / app) | When user taps on the share icon                  | To know how many users attempt to share, and what they're trying to share                                                           |
| Tap on confirm (addn attribs: share/send/save)                                   | When user selects a mode of sharing and confirms  | To know the dominant mode in which users share.                                                                                     |
| Saw import popup (addn attribs: size of import, count of content)                | When user sees the import popup on splash screen  | To know how many users attempt to import content.                                                                                   |
| Initiated import of content (addn attribs: delete after import = true/false?)    | When user initiates the import                    | To know how many users go ahead with importing content, and how many of those choose to delete the archive after successful import. |
| Import successful (addn attribs: count of content)                               | When user successfully completes import           | To know how many users successfully import all content.                                                                             |
| Import failed (addn attribs: import success count, import fail count)            | When user is unsuccessful in completion of import | To know how many users fail to import all content.                                                                                  |
| App install utm                                                                  | To know source of install (if coming from share)  | To know how many users install the app because of a content share event.                                                            |
| Launch of app (addn attrib: deeplink)                                            | To know if launch was caused due to deeplink      | To know how many users launch the app via a deeplink, vs. their intrinsic motivation.                                               |
|                                                                                  |                                                   |                                                                                                                                     |

Non-Functional Requirements

| Performance / Responsiveness Requirements                                                                                           | Load/Volume Requirements                                                                                                | Security / Privacy Requirements |
| ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| Import of single content should not take more than 5 seconds.                                                                       | On average, 1 full textbook at a time.On close to max load, assume 50 textbooks in one package (device memory willing). |                                 |
| Import of multiple content should not take more than 0.5 second per content. (Imagine 5 books being imported with 250 content each) |                                                                                                                         |                                 |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted | Impact Description                                                                      |
| ------------------------- | --------------------------------------------------------------------------------------- |
| TPD                       | Examprep                                                                                |
| Sunbird Portal            | Portal needs to include parsing the app install with UTM params based on the share link |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted | Impact Description |
| ------------------ | ------------------ |
| Existing users     |                    |

1. Will see a more full-fledged method to share content/app
2. Older apps will need to be able to support parameterized URLS (for e.g., addition of utm param to the content deeplink). If this is not possible, then parameterization of content deeplinks might need to be reconsidered.

\| | | |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                            | Purpose of Metric                                                                                       |
| -------- | --------------------------------- | ------------------------------------------------------------------------------------------------------- |
|          | Content sharing funnel (outgoing) | Helps us understand how many people attempt to share content:Unique devices that ( launched app         |
|          | Content sharing funnel (incoming) | Helps us understand how many people attempt to access shared content:Unique devices that ( launched app |

***

\[\[category.storage-team]] \[\[category.confluence]]
