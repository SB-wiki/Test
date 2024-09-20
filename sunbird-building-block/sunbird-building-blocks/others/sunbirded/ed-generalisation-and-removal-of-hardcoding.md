
## Value Statement
Adopters from any domain will be able to install the sunbird Ed software, update the required form configuration, portal & mobile configurations and launch the app, and allow the end-to-end creation and consumption of course (+ certificate issuance), textbook and reports.


## Proposed System

* Flexible User Onboarding


    * Select User Role - Give the flexibility for sunbirdEd users to onboard into the app/portal without having to select a user role and any adopter should have the capability to easily enable and disable this behaviour based on their requirement.


    * Select BMGS/ Equivalent framework - Give the flexibility for sunbirdEd users to onboard into the app/portal without having to select a framework category and any adopter should have the capability to easily enable and disable this behaviour based on their requirement.



    
* Framework category (?) - The sunbird Ed platform should work with any framework used by the by adopter with flexibility on the number of levels of the framework categories (backend and the editors)


    * For eg, the system should dynamically allow entries to the DB based on the levels in the targeted framework category. Right now the system only support 4 levels in the framework category.



    
* Search 


    * The search API  parameters / facets have to be config driven based on the framework category used. Any hardcoding done w.r.t this has to be removed.



    
* Flexibility on Primary Category - Adopters can use the existing default primary category, or extend them to suit their needs.




### Any adopter should be able to perform the following:

* Create a new framework for any domain without any BMGS reference.


* Create new primary categories(Training Material).


* Create a new audience type.


* Configure the home page. (For example, Diksha has 4 to 5 sections which is completely based on search API. Each section contains a different search query based upon the requirement.). So on the home page, these sections should be configured.


* Skip user selection & framework selection given we have a default value, and also skip selection of location. 


* Add or remove categories in the framework selection page, ie. the user can configure the number of categories to be displayed in the framework selection page in app/portal.


* Create contents(Collection, Course, QuestionSet, Resource) in respective editors and tag it to the newly developed framework, and attach a certificate for trackable content.


* See / discover all the contents tagged to the selected framework on the home page.


* Configure filters depending on the requirement (post content discovery).


* Consume all trackable and non-trackable contents.


* Check the progress and get a certificate after consuming trackable content.


* View the reports after the consumption of trackable content - Hawkeye report should be configurable




## Removal of Hardcoding 

* Hardcoding of the term DIKSHA, and anything specific to adopters (OGHR, NCERT, Vidhyadaan)


    * DIKSHA in the OTP sms template (Lern)


    * urls, component names class names



    
* Hardcoding of B/M/G/S


    * [https://project-sunbird.atlassian.net/l/cp/tba7quS9](https://project-sunbird.atlassian.net/l/cp/tba7quS9)



    
* Hardcoding of functionalities to a certain primary category or content type. 


    * For eg., any functionality hard coded to ‘courses’ and not to ‘trackable collections’ need to be removed. (Lesson plan, Text book, e-textbooks ?)


    * List of primary categories : [https://project-sunbird.atlassian.net/l/cp/K1PkAG01](https://project-sunbird.atlassian.net/l/cp/K1PkAG01)



    
* Hardcoding of org id, target framework id mapping.


* Dependency on target framework & target framework related properties


* Hardcoding of framework names/id (eg: any hardcoding in editors to point to ‘K-12’ framework as the target framework.)


* Hardcoding of labels specific to the education domain and logic/functionality specific to the users


    * For eg. Student, Teacher, Admin, Parent etc & Perform certain actions if the user is Admin/Parent


    * Any hardcoding related to particular state, districts, block, cluster, schools / location.



    
* Hardcoding of channel name/id, organisation name/id, tenant name/id



We are assuming there will be only a single framework used across tenants. Yet to handle multiple frameworks in the same portal



*****

[[category.storage-team]] 
[[category.confluence]] 
