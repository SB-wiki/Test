
1.  **Matrix** : A question set which is meant for multi-entity. 


    1. Entity can be school / child / teacher / principal (not predefined, not related to any user entity in system) OR user profile (switch user, etc)


    1. can have a limit to number of responses allowed or can have a minimum number of responses required


    1. On play, should show required number of entity responses (Child 1, Child 2, ..)


    1. On play, should show ‘Add Child’ to add more responses → Entity ID (Unique ID), Entity Name (Child 1), Entity type (Child)


    1. Show questions for each entity response → Name, Age, Gender, School, Fav subject, etc



    
    1. Does not cover multiplayer quiz like scenario - either on same device or on different devices. Since entity is not understood by system - not related to any object in the system. (Not covering TN Assessment use-case, switch profile in player etc)



    
1. Language translation for question, hints, tip at question level


    1. Translations - supported as part of the model. Creation & consumption is yet to be imagined.


    1. Hint - at question level only, always visible →  _make it part of body with specific styling_ 


    1. Tip - at question & options level, and on-demand only →  _store it as Hint in QuML. Enhancement: Hint is not just at interaction level but also at question level_ 



    
1. date, auto-capture date, 


    1. Text, validation as date (dd-MM-yyyy)


    1. auto-capture enabled


    1. player should insert the timestamp



    

    
1. slider type of questions.


    1. range / series with a step: 1 - 10, 


    1. lower end, upper end: 1, 10


    1. On play, show slider


    1. Response, single value from the range



    
1. text, number, select, multi-select type of questions.


    1. Add to interaction types


    1. Update spec



    
1. Pagination (= Question set)


    1. View mode of question set - normal, page


    1. Questions grouped by question sets to provide page or normal play



    
1. Section (= Question set within Page question set)


    1. Question Set Name: wherever it is set - show as section name



    
1. define parent-child questions, with the scenario of one child question being dependent on multiple parents and the condition can be any  **and,or,not**  or other expressions.


    1. Question set pre-condition at the beginning of the question set


    1. Branching at the end of question set


    1. Convert to question set object wherever these rules are applicable



    
1. emoji/image as a question option, along with the text description for it.


    1. Only sample



    
1. if remarks are allowed and can be added for questions.


    1. ‘Add Remark’ to add paragraph remark


    1. Optional - provide response on-demand


    1. Accept text, files, or both


    1.  _QuML spec update_ , question object update



    
1. capture question group(s) (entity types) for which the question is to be answered.


    1. Question is meant for : Schools, Students


    1. Is this correct?


    1. Questions meant for primary school. School is an entity, and Primary school is a meta of school entity. 



    
1. whether the question is to be auto rated or not ?


    1. Evaluation mode: 


    1. Correct?



    
1. File upload


    1. min , max no of files


    1. size limit


    1. mime types allowed


    1. Definition and  _Spec update_ 



    
1. regex validation for the response to the question.


    1. sample



    
1. Ability to define if the question can be allowed to be marked as “Not applicable”


    1. If MCQ, create an option called NA


    1. What does NA mean in scoring?



    

    
1. Ability to define if a user can upload audio recording as a response to the question


    1. File upload



    
1. Ability to define question Number - Custom numbers like 1.a or 1.1


    1. Question set behaviour - numbering scheme


    1. Use-case - is it a real need? Is it always “1.a”? Can this be standardised? What is the value?



    
1. Ability to define the entity meta key to prefil value of question from.


    1. Need clarity


    1. School - number of teachers - pre-filled, can be changed



    
1. Ability to define the question weightage to be used in scoring.


    1. Sample



    
1. Ability to define scores at option level for radio/multiselect questions


    1. Sample



    
1. Capability to define if the question is to be shown in preview


    1. Can it be random? What’s the real value?



    
1. Ability to define if there is a voice over enabled for question.


    1. Update definition and spec



    
1. Ability to uniquely identify a question in the solution


    1. Identifier is available



    



*****

[[category.storage-team]] 
[[category.confluence]] 
