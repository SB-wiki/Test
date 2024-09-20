# DIKSHA-License-Support

IntroductionCurrently DIKSHA supports only one license when a content is created or uploaded onto DIKSHA. However, NCERT and content providers like Khan Academy have different license types (such as CC-BY-SA, CC-BY-SA-NC etc.). Hence it is required that DIKSHA support multiple types of licenses for content. However all the licenses should comply to CC framework.

JTBD

* \*\*Jobs To Be Done: \*\* All tenants on DIKSHA know about the supported licenses and ensure content created or uploaded by them have proper license on it. Consumers of content also get to know the correct license information of the content they consume
* **User Personas:** State Admin, Content Providers, Content Creators, Content Consumers

Requirement Specifications

### 1. Configuration

* A set of licenses supported across DIKSHA should be configured - henceforth referred to as DLL (DIKSHA License List).
* The configuration will have a name and description text of the license. Examples:
  * CC BY-NC-SA 4.0: This license is Creative Commons Attribution-NonCommercial-ShareAlike - [https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode)
  * CC BY-NC 4.0 : This license is Creative Common Attribution- Non Commercial -  [https://creativecommons.org/licenses/by-nc/4.0/legalcode](https://creativecommons.org/licenses/by-nc/4.0/legalcode)
  * CC BY-SA 4.0: This license is Creative Commons Attribution-ShareAlike - [https://creativecommons.org/licenses/by-sa/4.0/legalcode](https://creativecommons.org/licenses/by-sa/4.0/legalcode)
  * CC BY4.0:  This license is Creative Commons Attribution - [https://creativecommons.org/licenses/by/4.0/legalcode](https://creativecommons.org/licenses/by/4.0/legalcode)
  * Standard Youtube License: This is the standard license of any Youtube content
* Each tenant can configure a default license from the DLL. Example for some of the tenant as follows:

All the configuration happens through back end script (no front-end for self-service), as part of tenant creation process. For all existing tenants, it will happen as a one time update.

JIRA Ticket ID[SB-15413 System JIRA](https://browse/SB-15413)

### 2. Creation

#### New Content

* During the creation of any content (resource, textbook, course, collection), by default any content created in that tenant will have license as defined by the tenant.
* However content creator has an option to select any license from DLL. Edit Details page of Content Editor has a "License" field that displays a drop-down list of licenses (license name) from DLL.
* Default license configured for that tenant will be selected by default.
* Edit Details page of Content Editor will have a static text at the bottom, different for content (resource), textbook, lesson plan and course. Sample static text:

“ _By creating any type of content (resources, books, courses etc.) on DIKSHA, you consent to publish it under the Creative Commons License Framework. Please choose the applicable creative commons license you wish to apply to your content._ ”

#### Upload Content

“Upload File” page will also have static text at the bottom. Sample static text:

UPLOADING / LINKING CONTENT: “ _By uploading content on DIKSHA, you confirm that you are publishing it under a Creative Commons license that is compatible with the copyright license of the original work and are giving appropriate credit to the original author of the content._ ”

Uploading Youtube videoA Youtube video has one of the two license types:

1. Standard Youtube License
2. Creative Commons License

Both these licenses are part of the DLL list. When a Youtube video is uploaded, system extracts the license information from Youtube and map it to one of the licenses in DLL and automatically updates the license value accordingly. When user opens Edit Details page of the uploaded Youtube video, the extracted license is displayed and is non-editable.

Copied Content

* When a content is copied, the license will be retained as it is. It cannot be modified.
* "License" field of Edit Content Details page for any copied content will display the license name of the original content and remains non-editable.
* Even if the original content is modified, the license of the copied content retains the license that is present at the time of copying the content.

#### Upload Asset (video, audio, image)

All Assets except Youtube videoAssets will have the default license configured for the tenant. User cannot change the license. A static text is shown in the asset upload page. Sample text:

&#x20;“ _**I understand and confirm that all resources and assets created through the content editor or uploaded on the platform shall be available for free and public use without limitations on the platform (web portal, applications and any other end user interface that the platform would enable) and will be licensed under terms & conditions and policy guidelines of the platform.**_ _**In doing so, the copyright and license of the original author is not infringed.**_ ”

In case Asset is a Youtube videoIf the asset is a Youtube video, the current validation exists as it is ([SB-7328 System JIRA](https://browse/SB-7328)), i.e., the video should have a "Creative Commons Attribution" license.

However, the license value is mapped to CC-BY 4.0 of DLL and the asset license value is updated to CC-BY 4.0 as given in the DLL.

Search AssetsThere is no additional filter for license value required in the search.

#### Review

When reviewer opens content to review, in the content details below the content, License information of the content is displayed.

JIRA Ticket ID[SB-15413 System JIRA](https://browse/SB-15413)

### 3. Consumption

* The name and description text of the license selected during the creation of content is shown on content details page against License Terms attribute (both in portal and mobile): "<>: <>". There is no change in the UI design/layout as of now. The text will be wrap if it exceeds that current width of the field.
* Following license values to be displayed at detail page on consumption side:
*

\| License Name | Description | URL | Final Text to be displayed on consumption page | | CC BY-NC-SA 4.0 | For details see below: | [https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode) | CC BY-NC-SA 4.0 For details see below: [https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode) | | CC BY-NC 4.0  | For details see below: | [https://creativecommons.org/licenses/by-nc/4.0/legalcode](https://creativecommons.org/licenses/by-nc/4.0/legalcode) | CC BY-NC 4.0 For details see below:[https://creativecommons.org/licenses/by-nc/4.0/legalcode](https://creativecommons.org/licenses/by-nc/4.0/legalcode) | | CC BY-SA 4.0 | For details see below:  | [https://creativecommons.org/licenses/by-sa/4.0/legalcode](https://creativecommons.org/licenses/by-sa/4.0/legalcode) | CC BY-SA 4.0 For details see below:[https://creativecommons.org/licenses/by-sa/4.0/legalcode](https://creativecommons.org/licenses/by-sa/4.0/legalcode) | | CC BY4.0: | For details see below: | [https://creativecommons.org/licenses/by/4.0/legalcode](https://creativecommons.org/licenses/by/4.0/legalcode) | CC BY4.0 For details see below:[https://creativecommons.org/licenses/by/4.0/legalcode](https://creativecommons.org/licenses/by/4.0/legalcode) | | Standard YouTube License | | | Standard YouTube License |

* License of a content is not shown at any other place except content detail page (need to be removed from the end page of the content player)

JIRA Ticket ID[SB-15414 System JIRA](https://browse/SB-15414)

### 4. Existing Content and Assets

* Get the default license value for each content provider.
* Non-copied and non-youtube content: Existing content license value should be updated as per default license for its tenant (except for copied content and Youtube content). This is applicable both for contents which already has any existing license value as well as contents for which license field is blank.
* Copied Content: Update the same license value as that of the source content from which it is copied
* Youtube Content: Update the license value of all Youtube content to the value of Youtube license name as defined in DLL
* Update the values for all existing content as well as assets based on above logic.

JIRA Ticket ID[SB-15415 System JIRA](https://browse/SB-15415)

\| | |

WireframesUI design PPT - Refer  slide 5 - [https://docs.google.com/presentation/d/1WgA7kcYL46gTGhUNf3sAT141o6ZQTi6uROrZdzgOmXc/edit#slide=id.g5cc8799187\_0\_45](https://docs.google.com/presentation/d/1WgA7kcYL46gTGhUNf3sAT141o6ZQTi6uROrZdzgOmXc/edit#slide=id.g5cc8799187\_0\_45) &#x20;

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

Localization RequirementsN/A

Telemetry RequirementsN/A

Non-Functional RequirementsN/A

Impact on other Products/Solutions

| Product/Solution Impacted   | Impact Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Content Bulk Upload Format  | <p>Since we are providing an option to choose license to content creator from portal, it is important that we take care of this for bulk upload process as well. We need to add one additional column in bulk upload sheet to capture license value for each content piece being uploaded. Following to consider:</p><ul><li>If license cell is blank means no value provided for any content, consider default tenant license for that content.</li><li>In case any particular value is provided, consider that as license value for that content.</li><li>Value provided in license cell must belong to DLL (Diksha License List) </li></ul> |
|                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted                                                  | Impact Description                           |
| ------------------------------------------------------------------- | -------------------------------------------- |
| Specify whether existing users or data is impacted by this use case | Explain how the users/data will be impacted. |
|                                                                     |                                              |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
