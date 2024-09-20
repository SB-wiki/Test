# Licensing-and-Attribution-on-DIKSHA-for-Resources-and-Textbooks

## Problem Definition:

This story defines the appropriate licensing and attribution details to be provided at the time of content creation and to be displayed at the time of content consumption on DIksha.

Current structure of metadata:As per current structure, there are various content metadata which persists data for various fields. Below are the details of content metadata which are passed in request while creating or updation of the content.

* \*\*createdBy: \*\* User Id of the Content Creator in Diksha
* **creator:** User Name of the Content Creator in Diksha
* \*\*createdFor: \*\* Organisation Id of the channel where the content is created
* **organisation:** Organisation Name of the channel where the content is created
* **creators:** List of primary contributors  **(** Free Text). Provided by Content Creator
* \*\*contributors: \*\* List of secondary contributors (Free Text) . Provided by Content Creator
* \*\*attributions: \*\* List of attributions (free Text). Provided by Content Creator
* \*\*license: \*\* License of the content
* \*\*ownershipType: \*\* Ownership Type of the Content ( **createdBy/createdFor** )

There are few fields where the value depends upon  \*\*ownershipType \*\* field.

* \*\*ownedBy: \*\*
  * Organisation Id of the channel where the content is created (when **ownershipType : createdFor** )
  * User Id of the Content Creator in Diksha (when **ownershipType : createdBy** )
* \*\*owner: \*\*
  * Organisation Name of the channel where the content is created (when **ownershipType : createdFor** )
  * User Name of the Content Creator in Diksha (when **ownershipType : createdBy** )

## Expected metadata:

As per the PRD and requirement discussion, below are the list of expected fields and proposed metadata:

\| **Fields** | **Metadata** | **Description for Design Discussion** | **Post Discussion final Field name** | | **Created on DIKSHA by** | creator (existing) (Text) | As mentioned above  \*\*creator \*\* contains name of the logged in user. This field can be utilised for mentioned purpose. | \*\*creator: \*\* It is an **existing** text field. Editor has to pass name of the creator. | | **Original Author** | author (Text) | Currently, there is a field  \*\*creators \*\* which is a text field and from UI, creators of the content is passed. We can utilise the same property.If we want relevant name for the field, we can have a new property named  **author.** | \*\*author: \*\* It is an **existing** text field. Editor has to pass name of the author. | | **License Terms** | license (existing) (Text) | There is an existing property named \*\*license, \*\* we can utilise the same field. Currently, the system is updating license only for youtube contents. For other content, there is no default value. | \*\*license: \*\* It is an  **existing** text field. Except youtube content, KP does not provide any default value for contents. Editor has to pass value for license. | | **Published on DIKSHA by** | organisation (existing) (List)  channel (existing) (Text)  publishedBy (new) (Text) | Content metadata property  \*\*organisation \*\* is list of partner organisation name, so publisher organisation will not be identified.  **channel** contains id of the organisation, so we can not use this field also. We can introduce new property  \*\*publishedOn \*\* which will be text property and contains Organisation name. Default value will be null. Editor has to pass organisation name. | \*\*organisation: \*\* It is an **existing** list field. Editor has to pass Name of the organisation in list format. | | **Credits** → **Copyright** | copyright (existing) (Text) | \*\*copyright \*\* is an existing text field. We will be expecting value from the editor. By default value will be null. | \*\*copyright: \*\* It is a **existing**  text field. Editor has to pass value for the field. | | **Credits** → **Attributions** | attributions (existing) (List) | It is existing metadata (list) property. As per discussion for existing content this field will be populated with existing  **collaborators, attributions and creators.**  For new contents only  **attributions** field will be populated with comma separated attribution list. | \*\*attributions: \*\* It is an **existing** List field. For new content List of the value has to be passed. For old contents set of  **collaborators, attributions and creators** can be utilised for populating the data. |

As part of  \*\*Copy Content API, \*\* there will be additional metadata for the copied content  **originData** which will contain **name** , **author** , **license** , and  **organisation** details of Origin content.

***

\[\[category.storage-team]] \[\[category.confluence]]
