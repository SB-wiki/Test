
## Functional use case

### Overview
The SCERT wants to create a repository of reviewed questions in a question bank. (State is about to digitize 8000+ questions). These questions will be added with public visibility. This bank will keep on increasing with multiple State resource groups will be tasked every few months to add to the bank for future usage.

Going forward, when the state wants to create a practice question set/Exam question set → They want to use the functionality to search and filter from the question bank/library and directly add. 

This feature will be present in addition to the Create new feature.


### Functional use case flows:
Addition of questions in the question bank/library:


1. Question contributors will contribute questions for different grades and subjects and tag Topics and LO


1. SCERT will review the questions that are being contributed - \[Only single-level review]



Usage of question added in bank/library:


1. For creating public - practice question set, practice quiz or Private - exam paper, weekly/monthly quiz, SAT papers. 

    The creator can choose to Add from the library → Apply filters of BMG + Subject + Topic + LO and select one or more questions and add to the question set.


1. The questions will go to the sourcing reviewer for Acceptance or rejection in the final question set






## Product flow

### Creation of Library:

1. A new question set is created by the name of  _“Question library”_ 


    1. Visibility of this is set as public.


    1. Single level review is enabled


    1. Nominations are turned off


    1. All interactive questions are added



    
1. All the contributors and reviewers are added to the question paper


    1. Any new contributor, either SCERT or a Vendor is added to the question library project


    1. SCERT adds the reviewers (Either Subject matter experts) or others to review the question



    


### Contributions and Review

1. Contributors add the question in the library project and add relevant tags for BMG+Subject+Topic+LOs


1. The reviewers review the questions and request for change if required


1. Once approved, the questions start showing up in the Add from Library Feature.




### Add From Library

1. (New) Add from Library supports Questions as content type. 


1. (New) If the content is being added for the Question set → Only Questions contents are shown (of the type selected while question set definition)


1. (New) Private questions are not shown as part of the search result in the library


1. Filters to be supported


    1. Existing


    1. Content types


    1. Class(s)


    1. Subject(s)


    1. Chapter(s)



    
    1. (New) To be added:


    1. Board 


    1. Medium


    1. Learning Outcomes

    (Board and medium is required to set the context for Topics and LOs)



    

    

To be confirmed:


1. Visibility of questions in the library across organizations or only within the organization only



Open question:


1. If a question is added from the library, and the reviewer requests for change what will be the flow? 


    1. Will it go to the original author (doesn’t make sense)


    1. Make a copy of the question and ask the person who has added it to edit


    1. Disable the provision to request for change for a question added from library



    



Designs

|  |  **Index**  | 
|  --- |  --- | 
| [Mockups](https://docs.google.com/presentation/d/12JW58Iokn-3IdwifUeWab8F8vPC8HFHqZjkbERtwsLc/edit?usp=sharing) | Slide 56 - 64 - Searching and adding a quesiton | 
| Slide 65 - 69 - Contribution reviewer flow | 
| Slide 70 - 74 - Souricing reviewer flow | 


## User Stories


|  **Actor**  |  **Use case enabled**  |  **Workflow steps**  |  **Status**  | 
|  --- |  --- |  --- |  --- | 
| Contributor | Adding a question from LibraryPre-requisite:
1. The user should be added to a Question paper project as a contributor



 | 
1. On login on contribution portal, user sees the lists of projects they are part of


1. On opening of a project user sees the list of question papers that are part of the project


1. On opening a question paper, user sees the list of sections within the question paper with option to 'Upload content'


1. On the section header, the user will see two options


    1. Create new


    1. Add from Library



    
1. On click on Add from library user is taken to a new page - where user can search a question and add the question



 |  | 
| Contributor | User can select filters on the add from library page | 
1. User can apply these filters for the content:


    1. Content Types \[ _editable_ ]


    1. Dorpdown values - Question types (from the project context)


    1. User can remove few question types from the selection for filtering 



    
    1. Class \[ _Non editable_ ]


    1. Subject \[ _Non-editable_ ]


    1. Chapters \[ _editable_ ]


    1. Nested values based on Subject selection


    1. searchable dropdown


    1. Single select



    
    1. Learning Outcomes \[ _editable_ ]


    1. Nested values based on chapter selection


    1. searchable dropdown


    1. Single select



    

    
1. User can reset the filter selections


    1. Content Types - is reset to list from the project context


    1. Class - No change 


    1. Subject - No change


    1. Chapter - Selection is removed


    1. Learning o


    1. On reset Chapter and Learning outcome selections are reset



    

 |  | 
| Contributor | User clicks on reset button after selecting fitlers | 
1. Changes in the filter selection


    1. Content Types \[ _editable_ ]


    1. Selection value is reset to the list of question types from the project context



    
    1. Class \[ _Non editable_ ] 


    1. No change



    
    1. Subject \[ _Non-editable_ ]


    1. No change



    
    1. Chapters \[ _editable_ ]


    1. Selected items are removed



    
    1. Learning Outcomes \[ _editable_ ]


    1. Selected items are removed



    

    

 |  | 
| Contributor | User selects the filter values are clicks on apply (No search result is found) | 
1. The filter selection panel is minimized and collapses to the top as a bar


1. The user is shown the no results default page



 |  | 
| Contributor | User selects the filter values are clicks on apply (search result is found) | 
1. The filter selection panel is minimized and collapses to the top as a bar


1. All the questions from the search result are shown on the left column


    1. Question title


    1. Question details is shown as the title


    1. If the length is long towards the end '…' is added


    1. On mouse hover - show the complete question text



    
    1. Author


    1. Show the (original) creator details of the question



    

    
1. Right side - Preview section


    1. By default, the first search result is selected and its preview is generated


    1. Preview of question - component is used to display the question


    1. Below the preview- metadata of the question is shown:


    1. Class


    1. Subject


    1. Content type


    1. Topic


    1. Learning outcome


    1. Skills tested


    1. Author


    1. Created on


    1. Also, avaliable in - Places where it is reused


    1. Attributions


    1. Copyright


    1. Licence



    

    

 |  | 
| Contributor | User clicks on “Select content” to add the question to the question paper | 
1. A pop-up opens with the list of all the sections in the question paper


1. Default selection is the section on which the user had clicked Add from Library


1. User can click on Add - The question is immediatly added to the section in question paper


1. User can also select a different section from the list (single select) On add, the question will be added to the currently selected section in the quesiton paper



 |  | 
| Contributor | User can modify the search filters and add more questions | 
1. On click of the collabsed bar “Filter - What kind of content you are looking for”


    1. The filter bar expands


    1. User sees all the Filter options as above


    1. Previous filter selctions are shown



    
1. User can change the filter and search again


1. From the new search result, user can add the question to any of the sections in the question paper


1. On select content → The content is directly added to the selected section.



 |  | 
| Contributor | User can go back to question paper | 
1. On click of back button


    1. user is taken back to the list of contents view of the question paper 


    1. All the questions added from library are shown in the respective sections


    1. The status of the questions added from library is set as “Added from Library” , this status is green coloured



    
1. User can click on Create new / Add from library on any of the sections and go into that flow



 |  | 
| Contributor | User opens the question added from library | 
1. User can:


    1. view the question details


    1. Click on edit details - to view the metadata of the question


    1. Click on preview to preview the question in a player



    
1. User cannot


    1. Edit the question 


    1. Edit question metadata



    

 |  | 
| Contribution reviewer | View the questions contributed | 
1. On login on contribution portal, user sees the lists of projects they are part of


1. On opening of a project user sees the list of question papers that are part of the project with option to “review content”


1. On opening a question paper user sees all the 


    1. Sections in the question paper


    1. Questions contributed within the question paper


    1. Count of questions contributed in each of the sections is shown


    1. Questions created and added  - 


    1. User gets the option to - Request for change, Approve



    
    1. Questions added from Library - User does not have any action - user can only 


    1. View the question details


    1. Click on edit details - to view the metadata of the question


    1. Click on preview to preview the question in a player



    
    1. There is no option for the user to request for change for a question that is added from library



    

 |  | 
| Sourcing reviewer | User can accept or Reject the question in the question paper | 
1. On login on sourcing portal, user sees the lists of projects they are part of


1. On opening of a project user sees the list of question papers that are part of the project


1. On opening a question paper, user sees 


    1. Sections in the question paper


    1. Questions contributed within the question paper


    1. Count of questions contributed in each of the sections is shown



    
1. Questions created and added


    1. User gets the option to - Request for change, Approve, Reject



    
1. Questions added from library


    1. User gets the option to - Approve, Reject


    1. User does not get the option to request for change



    

 |  | 



 **Implementation Approach** 
1.  **Enabling questions approved by contribution reviewer** 

    Add Approved in status filter array while searching (composite/v3/search)

    


1.  **Skill tested, Question type and Status (default)** 

    Add above fields in category definition search config

    


```json
{
  "objectCategoryDefinition": {
    "forms": {
      "searchConfig": {
        "properties": [
          {
            "new config"
          }
        ]
      }
    }
  }
}

```



1.  **Chips/Tags in question list view** 

    We'll use the same configuration ([Question list](https://project-sunbird.atlassian.net/wiki/pages/resumedraft.action?draftId=2956165131)) to show tags 





For review 





*****

[[category.storage-team]] 
[[category.confluence]] 
