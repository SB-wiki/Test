# Licensing-and-Attribution-on-DIKSHA

IntroductionThis story defines the appropriate licensing and attribution details to be provided at the time of content creation and to be displayed at the time of content consumption on DIksha.

JTBDUse this section  to elaborate on:

* \*\*Jobs To Be Done: \*\* 1. As a content creator i should be able to view licensing provision of the content at the same time i should be able to provide author and attribution details for the content.      2. As a content consumer i should be able to view the licensing provision and author & attribution details of a content.
* **User Personas:** This story is relevant for the users creating or consuming content on Diksha.&#x20;

Requirement SpecificationsUse Case: Defining appropriate licensing, attribution, creation and ownership fields for a contentThe objective of this story is to define various fields (related to licensing, attribution, creation etc) which are to be captured at the time of content creation and to display to user at the time of content consumption.

NA

Use Case: Defining appropriate licensing, attribution, creation and ownership fields for a content User Story 1: For Content Creation - OverviewThis user story defines the fields (related to licensing, attribution, creation etc) to be captured at the time of content creation. Story is further segregated into three scenarios.

\*\* \*\* A new resource (teaching, learning, practice or test content) or Textbook is created on DIKSHA either through uploading a file or using content editor.

* Replace the following existing fields:
  * Creators
  * Contributors
  * Credit To
  * Owner

Add following fields and their value to be provided by the creator during creation time.

1. **Author:**  (of the resource) - The person or organization who has authored the content. If the author herself is creating the content on DIKSHA, she can give her name. But if a different person has authored the content and do not have access to DIKSHA, the person creating the content on DIKSHA should provide the original author’s name. This is a free flowing text and is mandatory.
2. **License** : There are two types of licenses supported on DIKSHA. They are CC-BY and Youtube. All content created on DIKSHA will by default have CC-BY 4.0 license. For any youtube content, the license will be automatically fetched from youtube and get updated. A message with License details is displayed on editor while creating content (like, the content is licensed as CC-BY 4.0, except for Youtube. Youtube is licensed under Youtube license).&#x20;
3. **Copyright** :  Person or Organization who owns the copyright. Is a free flowing  text. Default should be the name of DIKSHA tenant. This field is mandatory. This will have person/org name appended with year of creation value seperated by comma.
4. **Year of creation** - This field will contain the year when the content was created and this value required to be appended with copyright field's value on consumption page. This is a mandatory field. No default value. It is a text filed. It should validate that entered text is a four digit number - minimum value 1900 and max value 2500.
5. **Attributions** : List of persons or organizations who have contributed to this content. A free flowing text

\<Alternate Scenario 1>A resource (teaching, learning, practice or test content) or Textbook is created on DIKSHA by copying an existing content.

In this scenario, the same fields has to be provided by the creator as in main scenario.

\<Alternate Scenario 2>In this scenario same fields have to be displayed as in main scenario when user edit the existing content details on Diksha.&#x20;

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

User Story 2: For Content Consumption - OverviewThis user story defines the fields (related to licensing, attribution, creation etc) to be displayed at the time of content consumption. Story is further segregated into three scenarios.

Following needs to be displayed on content details page (both on portal and app) when a content is consumed:

1. **Created on DIKSHA by** - This is the user name of the user who created the content on DIKSHA
2. **Author** - As provided by creator during creation of the content
3.  **License Terms** - Display following values by default for content other than you tube:

    License Terms: CC-BY 4.0 For details: [https://creativecommons.org/licenses/by/4.0/legalcode](https://creativecommons.org/licenses/by/4.0/legalcode)
4. **Published on DIKSHA by** - This is the tenant name in which the content is created and published
5. **Copyright** : This field should display the copyright value provided at the time of creation along with appended field value of "Year of creation". For example if copyright value provided was "Uttar Pradesh" and year of creation is "2019" than copyright field will display following value - "Uttar Pradesh, 2019"
6. **Credits** - Clicking on this, a popup with following details will be shown:

\<Alternate Scenario 1>In this scenario, user is consuming the content which has been created by copying the existing content. At the time of consumption: On content details page all the details of the content as in main scenario have to be displayed. In addition, it should show the following details from the source content -&#x20;

" **This content is derived from:**

**Content** :

**Author of Source Content** :

**License Terms** :

**Published on DIKSHA by** : \<Published on DIKSHA by (value of the source content)>"

\<Alternate Scenario 2>In this scenario, user is consuming the existing content whose details have been edited. Following fields shall be displayed to consumer:

1. **Created on DIKSHA by** - This is the user name of the user who created the content on DIKSHA
2. **Author** - As provided by creator during editing of the content
3.  **License Terms** - Display following values by default for content other than you tube:

    License Terms: CC-BY 4.0 For details: [https://creativecommons.org/licenses/by/4.0/legalcode](https://creativecommons.org/licenses/by/4.0/legalcode)
4. **Published on DIKSHA by** - This is the tenant name in which the content is created and published
5. **Copyright** : This field should display the copyright value provided at the time of creation along with appended field value of "Year of creation". For example if copyright value provided was "Uttar Pradesh" and year of creation is "2019" than copyright field will display following value - "Uttar Pradesh, 2019"
6. **Credits** - Clicking on this, a popup with following details will be shown:

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

User story 3 - Statement to be displayed across all the pages under footer section on Diksha.Following line to be displayed along with the CC-BY logo -

"All content here is licensed under a Creative Commons license (CC-BY 4.0), unless otherwise noted."

Wireframes[https://docs.google.com/presentation/d/1WgA7kcYL46gTGhUNf3sAT141o6ZQTi6uROrZdzgOmXc/edit?usp=sharing](https://docs.google.com/presentation/d/1WgA7kcYL46gTGhUNf3sAT141o6ZQTi6uROrZdzgOmXc/edit?usp=sharing)

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket ID[SB-13042 System JIRA](https://browse/SB-13042) Jira ticket this story.

Localization RequirementsNA

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                                     | Description                                                       | Purpose                                                      |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------------ |
| Mention the event that will generate telemetry and which needs to be captured. | Provide event details. e.g. clicking upload for textbook taxonomy | Provide a reason why the event telemetry should be captured. |

Non-Functional RequirementsUse this section to capture non-functional requirements in the following table. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Performance / Responsiveness Requirements                                                                      | Load/Volume Requirements                                                                      | Security / Privacy Requirements                                     |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Provide the perfomance or the responsivenes required from the system to ensure that the Use Case is effective. | Provide the load or volume required from the system to ensure that the Use Case is effective. | Provide security and privacy requirements for an effective Use Case |
|                                                                                                                |                                                                                               |                                                                     |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted                                                     | Impact Description                                 |
| ----------------------------------------------------------------------------- | -------------------------------------------------- |
| Specify the name of the product/solution on which this use case has an impact | Explain how the product/solution will be impacted. |
|                                                                               |                                                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted                               | Impact Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Content Creator                                  | Content creator will not see some of the existing fields which are being replaced with new fields for content licensing, authoring and attributions.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Content Consumer                                 | Content consumer will see new fields and values for content licensing, authoring and attributions.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Old App versions                                 | Old App versions should not break and should continue to show old labels and fields for existing and new data.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Existing Data                                    | New App versions will show new set of labels and fields for existing data.For "Author" field that is new, its default value should be updated with tenant/state name and corresponding values to be rendered at consumption page.For "Copyright" field, value should be mapped from the existing field name "Ownership". In case "Copyright" field is blank for any of the content, value should be updated with "tenant/state" name and corresponding values to be rendered at consumption page. Also for all the existing content, copyright field value should be appended by static text - "2019". For example if copyright value provided was "Uttar Pradesh" and than copyright field will display following value - "Uttar Pradesh, 2019" For "Attributions" field, it appends all the values from following as comma separated string:Creators, Contributors, Attributions under Credits |
| Existing Data that was a copy of another content | Existing copied content cannot show the information of the source content as it is not available as part of its metadata. This will require a data migration to capture it. It will be raised as a separate ticket in future if required.So, existing copied content will show "Not available" under " **This content is derived from"**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
