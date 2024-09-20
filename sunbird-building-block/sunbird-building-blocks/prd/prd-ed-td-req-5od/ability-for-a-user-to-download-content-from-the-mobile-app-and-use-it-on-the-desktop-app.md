# Ability-for-a-user-to-download-content-from-the-mobile-app-and-use-it-on-the-desktop-app

**JTBD** As a teacher,

I want to be able to import SunbirdEd content that I have downloaded from the mobile app, or that someone has shared with me onto the desktop app

So that I can use it in class to teach.&#x20;

**Context** Many of the teachers in Government schools do not have access to computers at home. In order to use the content in the offline computers available in classes, they need to be bring it to the school on an external device like a pendrive. In order to support this, they should be able to download content from the mobile app, export it to a pendrive and then import it using the desktop app. This is the mechanism used by many teachers on the field in order to move videos (non-SunbirdEd videos) to a desktop.&#x20;

The current exported .ecar file formats are incompatible between the mobile app and the desktop app.

This epic covers two primary capabilities:

* Compatibility of the .ecar file formats between mobile app and desktop app when exported
* A mechanism for a user to share the content from the mobile app to the desktop

**User story: Compatibility of .ecar files between mobile app and desktop app** Main Scenario

| Srl. No. | User Action                                                                                                                                                                                                                            | Expected Result                                                                                                     |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| 1        | User exports an individual content file from the mobile app and shares it using whatsapp, shareit, bluetooth or any other mechanisms and somehow gets it on a pendrive/SD card/CDShe then uses the desktop app and uploads the content | She should be able to upload it to the desktop app successfully and play the content in class                       |
| 2        | She downloads a textbook from the mobile app and tries uploading it to the desktop app                                                                                                                                                 | She should be able to upload it to the desktop app successfully, surf through the TOC and play the content in class |
| 3        | She downloads content on the desktop app, exports it to a pendriveShe then imports it to the mobile app                                                                                                                                | She should be able to import it into the mobile app and play the content                                            |
| 4        | She downloads a recent version of the content using the mobile appShe imports it to the desktop app, when an older version of the content was already present                                                                          | The content gets updated on the desktop app                                                                         |

Alternate Scenarios

| Srl. No. | User Action                                                                                                                                                                                                  | Expected Result                                                                                                           |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| 1        | She downloads partial content (spine ecar, incomplete text book) from the mobile app and tries uploading it to the desktop app                                                                               | She should be able to upload it to the desktop app, and open it up                                                        |
| 2        | She downloads a more recent version of the content on the offline desktop appShe then tries to import it to the mobile app when she already has an older version of the content downloaded on the mobile app | She doesn't have to redownload the entire content (as she is only shown info about updates on specific pieces of content) |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

***

\[\[category.storage-team]] \[\[category.confluence]]
