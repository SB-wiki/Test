This page contains details for the following EPICs

[https://project-sunbird.atlassian.net/browse/SB-22719](https://project-sunbird.atlassian.net/browse/SB-22719)  This contains Key Question Set Creation Capabilities

[https://project-sunbird.atlassian.net/browse/SB-22804](https://project-sunbird.atlassian.net/browse/SB-22804) Enable Course Assessment: Key Question Set Creation Capabilities (SB-22719) + Add Instruction

[https://project-sunbird.atlassian.net/browse/SB-22717](https://project-sunbird.atlassian.net/browse/SB-22717)

[https://project-sunbird.atlassian.net/browse/SB-22953](https://project-sunbird.atlassian.net/browse/SB-22953)  Key Question categories: MCQ, MSQ, FTB



* [Key Question Set Creation Capabilities](#key-question-set-creation-capabilities)
  * [Question details form driven by primary category configuration](#question-details-form-driven-by-primary-category-configuration)
  * [Question Preview](#question-preview)
  * [Preview Question Set](#preview-question-set)
* [Question set capabilities to enable Course Assessment](#question-set-capabilities-to-enable-course-assessment)
  * [Question Set configuration to enable Course Assessment](#question-set-configuration-to-enable-course-assessment)
    * [Submit required](#submit-required)
    * [Max attempts](#max-attempts)
  * [Create hierarchy (Creating Sections)](#create-hierarchy-(creating-sections))
* [Question reuse](#question-reuse)
* [Question categories](#question-categories)
  * [Fill In The Blanks](#fill-in-the-blanks)
* [Reference](#reference)

# Key Question Set Creation Capabilities
Details of [https://project-sunbird.atlassian.net/browse/SB-22719](https://project-sunbird.atlassian.net/browse/SB-22719)


## Question details form driven by primary category configuration
A tenant on Sunbird can define what details would they like to capture for each question in a question set. For instance, certain organisation might want creators to provide learning outcome & learning level for each question.

One more example, Survey allows questions to be marked as mandatory or optional. So when creating Survey, creator would get an option to mark individual question as mandatory in the Survey question set.

Each question in a question set should have a configurable details form that is driven by primary category configuration.



Metadata: To be provided by creator. Can’t be modified by person reusing it. Defined in object category definition. Overridden by question set form definition.

If an org wants LO for all questions, it should configure a question category with LO

Relational: In relation to the question set - can be set for new created or added from library. Defined in question set category definition.



→ Example of metadata configuration through question set category form definition 

Show / Hide / Mandatory Solution (and Hints - in future) as per category definition

Certain categories would want to configure default as Show Solution = false, hidden in the form configuration. Question creation page should hide the Solution block accordingly. Whereas certain categories might want to make Solution mandatory.



 **Conclusion** :  _Question set category will have form for Questions as well (optionally). It will override default Question category form._ 


## Question Preview
By default show preview in 16:9 aspect ratio with landscape orientation.

Allow user to switch to portrait orientation. Details in [https://project-sunbird.atlassian.net/browse/SB-23245](https://project-sunbird.atlassian.net/browse/SB-23245)


## Preview Question Set
CONSUMPTION PLAYER REQUIRED

Preview button will open Question set player. Player will support Question Set preview. 

Preview button is configurable - since collections might not need it.

On clicking submit, user should be able to preview the whole question set and check T&C on the confirmation page before finally submitting.

This preview will behave as if it would for a player after question set is published.


# Question set capabilities to enable Course Assessment
Details for [https://project-sunbird.atlassian.net/browse/SB-22804](https://project-sunbird.atlassian.net/browse/SB-22804)

Add Instruction for a question setCONSUMPTION PLAYER REQUIRED

Creator should be able to add rich text (or markdown) instructions for question set (on the details page). Instructions should allow 

→ basic formatting such as bold, italics, underline

→ Heading 1,2,3 styles OR Font size selection

→ Bulleted or Numbered list

→ Inserting Table 

→ Adding Images

→ Adding Audio 

OR 

→ Video as instruction (similar to Solution)

 **Conclusion** : 


1. Add this to SBForm or build independently


1. If independent, it will be at the bottom of the Question set details page. 




## Question Set configuration to enable Course Assessment
consumption player required

TimerUser flow: User selects Show Timer → Enter Max time (optional / mandatory as configured) and Warning time (optional)

→ Creator can enter  **maximum time**  in  _hours : minutes : seconds_ 

On completion of maximum time, player submits the question set response and redirects user to end summary page.

→ Timer should support  **warning time**  in  _hours : minutes : seconds_ . Warning time is always less than maximum time.

→ Warning time can only be defined after maximum time is defined. 

At warning time, timer text turns red and starts blinking. Timer flashes in red.

→ Show Timer is enabled automatically when user defines maximum time and cleared automatically if user removes maximum time (or makes it 00:00:00)

→ Validation: User cannot enter more than 60 seconds, 60 minutes, and 5 hours (this validation should be configurable). 

→ (Optionally) If user enter 90 minutes, system could automatically convert it to 1 hour 30 minutes. Similarly if user enters 90 seconds, system could convert it to 1 minute 30 seconds, and so on.



User cannot change font, colour of timer.



|  **Show Timer**  |  **Maximum Time**  |  **Warning Time**  |  **Player**  |  **Supported?**  | 
|  --- |  --- |  --- |  --- |  --- | 
| Yes | No | No | Count up from 00:00 |  | 
| Yes | Yes | No | Count down from max time (hh:mm:ss or mm:ss or ss) as per the limit defined and When 00:00 submit & go to end page |  | 
| Yes | Yes | Yes | Count down from max time (hh:mm:ss or mm:ss or ss) as per the limit defined and When warning time, flash timer in red from warning time till it reaches 00:00When 00:00 submit & go to end page |  | 
| No | Yes | No | Show time on the Instruction page. No count up / down  | Not supported | 
| No | No | No | Chill! |  | 

 **Notes** :


1. Use ShowTimer and TimeLimits in the Question Set object Definition


1. How does player behave if showTimer is false and timeLimit is defined by user?




### Submit required
→ Creator can select Yes / No. Default value is loaded as per form configuration in category definition.

This will show a submit confirmation page in question set player. This page will also have a details of the current attempt - Questions attempted, skipped.


### Max attempts
→ Creator can define max attempts for a question set. Min 1, Max 25. Default none.

Only for Question Set categories which are meant for Trackable Collections. If they are consumed independently there is no limit on attempts - default consumption behaviour.


## Create hierarchy (Creating Sections)
CONSUMPTION PLAYER REQUIRED

Question set should allow creating hierarchy / folders (child question sets) in it.

When a folder (child question set) is created, it has its own details form as configured in the primary question set category. Creator can modify settings as per the primary category form definition.

A child question set can contain questions or question set as per the hierarchy structure definition. For now we will assume only one level of folders (question sets). So a primary question set may contain question and/or folders (question sets) at level 1, and questions at level 2 (inside child question set)

Creator can drag-and-arrange questions across sections (child question sets)

It would also be possible to restrict users from creating questions directly under primary question set. Which will ensure that all questions are under at least one child question set (section). So a structure such as the one below can be achieved.. DONEGreen


```
Question Set 1                    //primary question set
  Question Set 1.1                // child question set
    Question
  Question Set 2.1
    Question
```


Supported: Adding Question Set to a Question Set (reuse). Adding collection to a collection.

Not supported / required: Creating Question Set within a Question Set (create). Similar to creating collection within a collection.


# Question reuse
Details for  [https://project-sunbird.atlassian.net/browse/SB-22717](https://project-sunbird.atlassian.net/browse/SB-22717)

→ Allow users to filter and search relevant questions in context to the question set they are creating. 

→ When user tries to ‘Add from Library’ launch the question browser with relevant context (framework categories, allowed question categories).

→ Contributor can filter using: Question categories, Medium, Class, Subject, Topic(s), My / All Questions, 



In future Question reuse should also


1. Support QuML v0.5 questions as well


1. Support ECML (v2) questions as well


1. Filter out ECML (v1) questions




# Question categories
Details for [https://project-sunbird.atlassian.net/browse/SB-22953](https://project-sunbird.atlassian.net/browse/SB-22953)


## Fill In The Blanks
CONSUMPTION PLAYER REQUIRED


* Creator types a few words.. a sentence maybe. Selects a word. Insert blank.


    * A blank is inserted in place of the selected word. 


    * As shown in designs, creator can now specify correct responses for the inserted blank



    
* Creator types a few words.. typing cursor is blinking. Insert blank.


    * A blank is inserted at the cursor position.


    * Creator can specify correct responses for the inserted blank.



    

→ Creator can create multiple blanks in a question

→ All standard rich text editing features are available to format the text of the question

→ Correct responses for a blank 

allows all characters,

any language,

does not allow LaTeX,

..

→ Blank validation is 

case insensitive,

ignores more than one space,

allows all characters,

..

Completed in 3.6, 3.7Question set details form driven by category configurationDONEGreen

Question Set details should be configurable such that it allows for flexibility yet does not burden the creator with plethora of details to be filled. 

Each primary category form would define which of the behaviour configuration settings it wants to expose to the creators. For example, Practice would allow creators to modify only Shuffle, Show/hide Feedback, and Show x/y questions.

A primary category form would also define default values for the configuration settings. For example, Submit required = true for Assessment.

A primary category form would also dictate whether certain attribute is editable or viewable or hidden. For example, 


* Shuffle (default false, editable) for Practice, 


* Submit required (default true, viewable) for Assessment,


* Scoring mode (default = no scoring, hidden) for Survey



So, a sample primary category form would be as follows:


```
Practice
  Shuffle: default false, editable
  Submit required: hidden, no default (not applicable)
  Show feedback: default true, viewable
  Show solution: default true, hidden
  ...
```
Add / Create New QuestionDoneGreen

Adding or Creating New question should allow creating question categories as specified in the category definition. For example, Assessment will not require Subjective Reference Questions

 **Conclusion**  _: Editor allows configuring a list of allowed object types & primary categories for a collection / question set category._ 




# Reference
Consumption stories [https://project-sunbird.atlassian.net/browse/SB-22827](https://project-sunbird.atlassian.net/browse/SB-22827)



*****

[[category.storage-team]] 
[[category.confluence]] 
