noteTeam missionGeneralise and externalise content organisation, creation & consumption in Sunbird platform.

Team missionGeneralise and externalise content organisation, creation & consumption in Sunbird platform.


##  Project information
List of high level items… Initial draft version, need to be cleaned up


* Separate Content, Collection and Asset object types - in platform, creation and consumption


* Make all collections trackable - in platform, creation and consumption


* Clean up and update definitions for all object types


* Enable categories for all object types


* Make Category definitions configurable - support for various types of configurations


* Unified creation experience for each object type - Asset, Question, Question Set, Content, Collection


* Unified consumption experience for each object type - Asset, Question, Question Set, Content, Collection


* Assessments


    * Enable question sets to contain assets


    * Embedding questions and question sets in content and collections


    * Play questions and question sets independently without embedding them in content or collections



    

 **Sequencing of Tasks** :


1. Changes to core Content Model and Creation API - needs to support backward compatibility with Content Type until everything moves and it is deprecated (no UI change)


1. Update the existing contents with new values (no UI change)


1. Changes to Consumption API (search and content get API) to support new values + Consumption front-end logic using modified API (may have UI change)


1. Creation front-end + bulk upload scripts calling modified API with right values (no UI change)


1. Change in Analytics (druid indexing, reports wherever required)


1. Creation front-end using new content model to load the editors dynamically - through configuration - instead of hard coding (no UI change)


1. Change in Creation UI to support new categories (UI change)



Some of them may happen in parallel based on effort and resource availability, but we cannot skip one and go to another


##  Detailed Release roadmap
The sequence in which the features you are executed. 


### R3.2.0


|  **Feature**  |  **Circle (KP, Consumption, VDN, etc)**  |  **Sprint**  |  **Priority**  |  **Effort**  |  **Status**  |  **Notes**  | 
|  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
| List feature | List initiative that feature belongs to | Type /date to add a date range | HighRed /MediumBlue /LowYellow | HighRed /MediumBlue /LowYellow | In progressYellow /not started /ShippedGreen | Link to project pages and epics | 
| Enhance Content model to support “category”. Categories can be defined using API with minimal configuration. | KP | 3.2.0 Sprint 1 | HIGH |  | IN PROGRESS |  | 
| Update the existing contents with new values | KP | 3.2.0 Sprint 2 | HIGH |  | NOT STARTED |  | 
| Changes to Consumption API (search and content get API) to support new values + Consumption front-end logic using modified API  - v1 | Consumption |  |  |  |  |  | 
| Editors for content creation call modified API with right values | VDN | Sprint 14 (3.2.0 Sprint 2) | HIGH |  | NOT STARTED |  | 
| Editors for content creation call modified API with right values | DIKSHA Portal | 3.2.0 Sprint 2? |  |  | NOT STARTED |  | 
| Enhance APIs tracking of collections which are marked as “trackable” - configured at system as part of category definition. | KP | 3.2.0 Sprint 2 |  |  | NOT STARTED |  | 
| Enhance APIs and triggers to issue credentials for any collection | KP | 3.2.0 Sprint 2 |  |  | NOT STARTED |  | 
| Disable creation of multiple parallel batches for a course (UI) | Circle 1 | 3.2.0 Sprint 2 |  |  |  |  | 
| Auto creation of a batch for all trackable collections (Backend) | KP | 3.2.0 Sprint 2 |  |  |  |  | 
| Edits to batch for all trackable collection categories (UI) | ? | 3.2.0 Sprint 2 |  |  |  |  | 
| Enable logged in users to Join and consume trackable collections (already enabled for collection = course) (UI) | ? | 3.2.0  |  |  |  |  | 
| Enable collection category creators to view aggregate usage summary metrics of their trackable collection categories (Backend - on demand report) | KP | 3.2.0 Sprint 2 |  |  |  |  | 
| Enable group admin to assign any trackable collection category to a group | Circle 1 | 3.2.0 Sprint 1 |  |  | IN-PROGRESS |  | 
| Enable group admin to view member progress of trackable collection activity  | KP | 3.2.0 Sprint 2 |  |  |  |  | 
| Enable configuring a certificate template to ‘collection’ category (backend) ( enabled for collection = course) | KP | 3.2.0 Sprint 2 |  |  |  |  | 
| Changes to cert services to issue certificates using svg format (Backend) | Platform User (PU) & KP | 3.2.0 Sprint 1 |  |  |  |  | 
| Enable attaching a certificate to course and define issue rules as a self service (UI) | Circle 1 | 3.2.0 Sprint 1 + 2 |  |  | IN PROGRESS |  | 
| Issue of certificates to ‘collection’ category (backend) | KP | 3.2.0 Sprint 2 |  |  |  |  | 
| Changes on the client side to render certificates from svg template (UI) | Circle 3 | 3.2.0 Sprint 2 |  |  |  |  | 
| Enable tagging of student, teacher and administrator to every content and collection category | Implementation Team | 3.2.0 |  |  |  |  | 
| Migration of existing content not tagged to  audience | KP | 3.2.0 Sprint 2 |  |  |  |  | 
|  **Content Player V2 framework**  | Content Framework + Common Consumption | 3.2.0 Sprint 1 & 2 |  |  | INITIATED | Faster, Light weight, Thin. Pure JS & HTML first. Natively embeddable Generalised players for each object type that can support different behaviour as per attributes | 
|  **Content Player V2 - PDF (Beta)**  | Content Framework + Common Consumption |  |  |  |  | Faster (zero) load time. Supports portrait orientation. Responsive to any screen size.Zoom in & out. Jump pages. Summary: Time spent, pages read. Can play individual content | 
|  **Content Player V2 - Video (Alpha POC)**  | Content Framework + Common Consumption |  |  |  |  |  | 
|  **Question Set Player (Beta)**  | Content Framework + Common Consumption |  |  |  |  | Play Question Set that contain Questions, Information, and other Question Sets. Question sets containing Video - in future.Play question sets independently without requiring content wrapper. Faster load time. Better performance. Responsive layout that adjusts to screen size automatically. | 
|  **Question Set Creation (Beta)** <ul><li>Migration of ECML  _Not suggested_ 

</li><li>Creation of Question Set (QuML)

</li></ul> | Content Framework + Common Consumption |  |  |  |  | Create question sets containing questions, instructions (info), and other question sets. Question sets containing Video - in future.Ease of creating MCQ by using smart layout engine. Bulk creation of MCQ (QuML) | 


### R3.3.0


|  **Feature**  |  **Circle**  |  **Sprint**  |  **Priority**  |  **Effort**  |  **Status**  |  **Notes**  | 
|  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
| Separate content and collection as different object types | KP |  |  |  |  |  | 
| Change in Analytics (druid indexing, reports wherever required) | HawkEye | 3.3.0 Sprint 1? | HIGH |  |  |  | 
| Creation front-end using new content model to load the editors dynamically | VDN | Sprint 15, 16 |  |  |  |  | 
| New definitions for all object types | KP |  |  |  |  |  | 
| Defining categories with behaviour | KP |  |  |  |  |  | 
| Content frameworks - Enable support of multiple frameworks - (content organizing + target) | KP | 3.3.0 Sprint 1 | HIGH |  |  |  | 
| Content frameworks - Enable creator to tag each content or collection category to multiple frameworks (organizing + target) | Circle 1 | 3.3.0 Sprint 2 | HIGH |  |  |  | 
| Enable attaching a certificate to any collection and define issue rules as a self service (UI) | Circle 1 | 3.3.0 |  |  |  |  | 
|  **Question Set Player (Beta)**  |  |  |  |  |  | Question Set configurations: Timer, Shuffle, Display Count, Score Display, Summary | 



|  **Feature**  |  **Circle**  |  **Sprint**  |  **Priority**  |  **Effort**  |  **Status**  |  **Notes**  | 
|  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
| Change in Creation UI to support new categories | VDN |  |  |  |  |  | 
| Creation front-end using new content model to load the editors dynamically | DIKSHA Portal |  |  |  |  |  | 





*****

[[category.storage-team]] 
[[category.confluence]] 
