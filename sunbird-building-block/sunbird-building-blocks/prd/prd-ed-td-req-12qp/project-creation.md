This page details the definitions and items relevant to the project creation.

The proposed interaction flow for the Project creation is mentioned below:



| Sl | User story | Present user interaction | Proposed user interaction | Open Items/ Decisions | 
| 1 |  Admin can create a Project for sourcing question papers. | 
1. Go to Diskha Portal, to create a new Question paper collection


1. Define metadata for the question paper


1. Define sections of the question paper


1. Define instructions for the question paper



 | Admin will go to sorucing (vdn sourcing) and create project along with the question set defining the scope.
1. Go to souricng portal, Create new project


1. Name the project, allow or not allow nominations


1. Define relevant dates


1. Select target object (of the type Collection or question paper set)


1. Selects the target assets (filtered list based on selected target object)


1. Create or select target Object(s)


    1. Creation flow


    1. Define metadata for question set \[Grade, Subject, medium, etc]


    1. Define sections for the question set


    1. Define Instructions for the question set



    
    1. Select from existing flow


    1. Admin can also search for past question sets, using filters for grade, subject, medium.


    1. Admin can select one or more existing question sets



    

    
1. Define blueprint for each of the question set(s)


1. Pubish project



 | Closed:
1. Question set on the dev portal now, does not allow to add sections. Is that a limitation?  Creation of sections can be managed through configuration, we need to specify/limit levels at which sections can be created.


1. Question sets, can only be created/selected through this flow. There is no separate screen/ touchpoint where user can view/create question sets.


1. Blueprint definition will happen as per the current flow.


1. For point number 6 in the proposed flow:


    1. Object level value will be stored for


    1. Allow creation of new target → This will show the button of create new


    1. Allow selection from existing target → This will show the button of select from existing which will open a pop-up to create/select from the exisiting



    

    
1. Since we are already defining the question set definition what is the use of collection creator role? This has been removed from the design



Open Tasks:
1. Review by design team on the UI Mockup


1. Use case grooming session with Kartheek


1. Enginnering implementation design to be shared by Bharat



 | 
| 2 | Admin can assign users as Souricng reviewers (Question paper creator) | 
1. Go to Souricng portal


1. Select a published project


1. Go to assign users tab (in project details page)


1. Search for user and assign them the role of reviewer



 | No interaction ChangeNo UI Change | Closed:
1. There will not be any change in this flow due to the change in project creation flow.



 | 
| 3 | Admin can assign users as Question contributors and Question reviwers | 
1. Go to Contribution portal


1. Select a published project


1. Go to assign users tab (in project details page)


1. Search for user and assign them the role of reviewer



 | No interaction ChangeNo UI Change | Closed:
1. There will not be any change in this flow due to the change in project creation flow.


1. It is not possible to allow for contribution roles from the sourcing portal.



Open:
1. Design flow for taking user to the contribution role assignment page from souricng project.



 | 


## Details

1.  **Flow for creating a new question set** 


    1. User clicks on create new question set


    1. User provides the Metadata, sections, and Instructions for the question set


    1. User saves the question set by clicking the save button


    1. On save the question set is saved


    1. On save - The user redirected to the previous screen of selecting/creating a new question set



    
    1. To create a another question set


    1. User again clicks on the create new question set button


    1. Follow the flow explained above



    

    
1.  **Metadata**  - These define the details and the scope of the question set


    1. Name - Default value?


    1. Description


    1. Instruction 


    1. Keywords


    1. Board \*


    1. Medium \*


    1. Class \*


    1. Subject \*


    1. Topics - NA


    1. Audience \* - Default - Student


    1. Max Attempts - NA


    1. Shuffle questions - Default not selected


    1. Max attempts - NA


    1. Max time - NA


    1. Waiting time - NA



    
1.  **Sections**  - These define the sections under which questions are added.


    1. No section can be added


    1. In this case, all the questions are sequentially added one after the another



    
    1. If the sections are added


    1. There would be only one level of sections


    1. A question can belong inside a particular section


    1. Or some question can be added directly to the question set after or before the section



    
    1. The sequence of questions in the question paper is fixed as per the sequence the questions are added.



    
1.  **Instructions**  - These are typically text which is shared at the start of the question paper, this is unique for each question paper/set.


    1. Requires support for numbering - Mandatory


    1. Requires support for Rich text editing - Good to have


    1. Image support - As per the current requirement/ understanding, this is not required.



    



No change in the current flow of Assigning roles on Sourcing or Contribution.





*****

[[category.storage-team]] 
[[category.confluence]] 
