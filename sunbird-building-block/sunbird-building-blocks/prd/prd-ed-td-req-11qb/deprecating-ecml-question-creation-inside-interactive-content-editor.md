In order to deprecate ECML Question creation inside Interactive Content Editor, we would need to have a suitable substitute for all its ‘used’ capabilities in the (new) Question set editor. Here’s a list of features currently supported (and used) in Interactive Content Editor.

We also need to evaluate if we need the ability to create questions inside interactive content editor for real. It would need to be enabled by using QuML questions then.


## Feature parity overview


|  |  **Capability**  |  **Priority**  |  **Creation Status**  |  **Consumption Status**  | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | Add multiple question sets in a question set (Sections) | P2 for Assessment, Practice, | Completed in 4.3 | Completed in 4.3 | 
| 2 | Sections should support rich text instructions | P1 for Quiz, P2 for Assessment, Practice | To be done in 4.4 | To be done in 4.4 | 
| 3 | Sections should support configurable behaviour such as Shuffle, Show x/total, Show/Hide Feedback | P1 for Quiz, Practice, Assessment if Sections are enabled | Completed in 4.3 | Completed in 4.3 | 
| 4 | Reuse questions from question bank | P1  | Not planned yet. Samagra plans to do this in OND | NA | 
| 5 | Copy Question (during Reuse or Creation) | P2 |  | NA | 
| 6 | Question Type - FTB | P1 | Not planned yet. ShikshaLokam plans to do this in OND | Not planned yet. ShikshaLokam plans to do this in OND | 
| 7 | Question Type - MTF | P1 | Not planned yet.  | Not planned yet. | 
| 8 | Reordering Words | P3 | Not planned yet.  | Not planned yet.  | 
| 9 | Sequencing Parts of Sentence | P3 | Not planned yet.  | Not planned yet.  | 
| 10 | Attach Audio | P1 for Quiz, P2 for Practice, Assessment | Not planned yet.  | Not planned yet.  | 
| 11 | Provide multiple information between question sets (slides) | P1 for Comprehension (CCT) type quizzes | Not planned yet.  | Not planned yet.  | 


## Question Set Creation
List of features & capabilities currently available for Questions in interactive content editor



|  |  **ECML Question Set Creation**  |  |  **Priority**  |  **Plan**  | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | Add multiple question sets within the question set |  | P2 | < 4.0 | 
| 2 | Search and select questions from the question bank |  | P2 | < 4.0 | 
| 3 |  | Search using string queryFilter questions using:
1. Type of question


1. Difficulty level


1. Board, Medium, Class, Subject, Topics 


1. All or only My Questions



 |  |  | 
| 4 |  | Show My questions or All questions |  |  | 
| 5 |  | Preview question |  |  | 
| 6 |  | Select multiple questions to add to the question set |  |  | 
| 7 | Configure question set behaviour |  |  |  | 
| 8 |  | Give name to the question set |  |  | 
| 9 |  | Configure 
1. Shuffle, 


1. Show x/y, (Display)


1. Show/hide feedback


1. Max score (automatically computed from question max score)



 | P1 | 3.8 | 
| 10 |  | Give weightage (marks) to each question. Weighted score is reset to 1 when Shuffle is turned ON. | P2 | < 4.1 | 
| 11 | Create questions of various types: MCQ, FTB, MTF, Sequencing, Reordering |  |  |  | 
| 12 |  | Create  **Multiple Choice Question**  with 
1. 7 layouts


1. Min 2 and max 8 options


1. Shuffle options


1. Mark any one option as correct answer (mandatory, multiple correct not supported)


1. Options cannot be empty


1. Add Image and Audio to Question or Option


1. Add Math & Scientific Text (Formulae & Equation) to Question or Option



 |  |  | 
| 13 |  | Create  **Fill In The Blank** 
1. There should be at least on blank


1. Blanks can be created by using square brackets \[\[ ]]  to indicate words to be made blank in a sentence

<ul><li>Use square brackets \[\[ ]]  to indicate blanks in the sentence. The words between \[\[ ]]  will appear as blanks to student.

</li><li>Example: 'The tree is \[\[tall]]  and \[\[strong]] .' The question will be created as: 'The tree is _______ and _______.' The correct answers will be 'tall' and 'strong'.

</li></ul>
1. Multiple blanks are supported


1. Keyboard type:


    1. System (Android / OS)


    1. English (A-Z, not QWERTY)


    1. Numbers only


    1. 26 keys configurable



    
1. Partial scoring


1. Unordered evaluation


1. Add Image and Audio to Question or Option


1. Add Math & Scientific Text (Formulae & Equation) to Question or Option



 |  |  | 
| 14 |  | Create  **Match The Following** 
1. Add pairs (min 3, max 5)


1. Partial scoring


1. Add Image and Audio to Question or Option


1. Add Math & Scientific Text (Formulae & Equation) to Question or Option



 |  |  | 
| 15 |  | Create  **Reordering Words** 
1. Prefilled prompt “Arrange the given words in proper order to form a sentence.”


1. Type a sentence with maximum 120 characters


1. Arrange the given words in proper order to form a sentence.


1. Add Image and Audio to Question or Option


1. Add Math & Scientific Text (Formulae & Equation) to Question or Option



 |  |  | 
| 16 |  | Create  **Sequencing** 
1. Partial scoring


1. Max upto 4 options, Min 2 options


1. Each sequence option can have max 120 characters


1. Two layouts - horizontal and vertical


1. Add Image and Audio to Question or Option


1. Add Math & Scientific Text (Formulae & Equation) to Question or Option



 |  |  | 
| 17 |  **Text editing** Across all questions (during question creation) | Available formatting
1. Bold, Italics, Underline


1. Font size


1. Text colour, Background (highlight) colour


1. Add Formula (Math & Scientific text)


1. Remove or clear formatting


1. Character limit


    1. Question can be max 1000 characters


    1. MCQ Options are max 1000 characters


    1. MTF Options are max 25 characters


    1. Sequencing and Reordering supports max 120 characters



    

 |  |  | 
| 18 |  **Attach images and audio** Across all questions (during question creation) | Attach / add media to any question, option
1. Images 


1. Audio



 |  |  | 
| 19 |  **Math & Scientific text** Across all questions (during question creation) | Add Math & Scientific Text (Formulae & Equation) to Question or Option |  |  | 
| 20 | Preview (during question creation) | 
1. Preview refreshes manually when user clicks on ‘Preview’


1. Preview will show unsaved latest changes 



 |  |  | 
| 21 | Navigating back-and-forth from Question creation | 
1. No warning provided when there are unsaved changes


1. When user goes back from Question creation page, with unsaved changes, to Question category select page → No warning given, but if user selects the same category as it was being created earlier, the unsaved question data is still present / retained and use can continue creation



 |  |  | 
| 22 | Provide details for question | 
1. Title\*


1. Description


1. Board\*, Medium\*, Class\*, Subject\*


1. Topic


1. Level\* (Difficulty level)


1. Max Score\* (default = 1, editable)



 |  |  | 
| 23 | Create one more (copy / clone) question | Save and Create Another / Similar Question |  |  | 
| 24 | In the content, it is possible to copy, paste, reorder, delete question sets |  |  |  | 
| 25 | Plugins such as Timer, Summary, Report card, Progress bar |  |  |  | 
| 26 | Add slides before and after question set slide |  |  |  | 


## Question Set Consumption


|  |  **ECML Player: Question Set - Consumption**  |  |  |  **Release**  | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | Question types and templates
1. MCQ (with 7 layouts)


1. FTB


1. MTF


1. Sequencing


1. Reordering



 |  |  |  | 
| 2 |  | Multiple Choice Question | 
1. 7 layouts


1. Max score (default = 1)


1. Shuffle options



 | 3.9 | 
| 3 |  | Match The Following | 
1. Partial scoring


1. Max 5 pairs



 | 4.0 | 
| 4 |  | Fill In The Blank | 
1. Types of keyboard: Device / System, Custom (English, etc)


1. Partial scoring


1. Unordered evaluation



 | 4.1 | 
| 5 |  | Sequencing | 
1. Partial scoring


1. 4 options to be arranged in sequence



 | 3.9 | 
| 6 |  | Reordering |  | 3.9 | 
| 7 | Common question consumption UX | 
1. Zoom-in and zoom-out images


1. If Question text is long, show a few sentences, give option to expand / show complete question. User can collapse to see less.



 |  |  | 
| 8 | Scoring / Evaluation logic | 
1. Default Max mark = 1 (if marks not available in metadata)


1. Compute total score (denominator) based on ASSESS events generated. Every user will get marks out of number of questions attempted. This needs to be verified.


1. Partial scoring


    1. ON - ANY of the correct answers to get partial score


    1. OFF - ALL of the correct answer to be selected to get full score



    

 |  |  | 
| 9 | Telemetry | 
1. RESPONSE for every option selected (in MCQ, MTF, Sequencing, Reordering) - Not in FTB. To be verifiedRed


1. ASSESS - on navigating next, system evaluates and generates ASSESS


1. INTERACT


1. IMPRESSION - View question, View slide


1. START - Only for the whole content, not for question set


1. END - Only for the whole content, not for question set


1. ERROR - Slide render, Plugin error



 |  | 3.9 | 
| 10 | Navigation | 
1. PREV SLIDE - 


1. NEXT SLIDE - Check answer, Show feedback if required, or go to next question


1. RELOAD - Reset any selected / entered answer and replay audio if there is any 


1. REPLAY - Replay from starting the whole content



 |  | 3.9 | 
| 11 | Feedback popup | 
1. NEXT QUESTION - Will go to next question. No evaluation (Skip).


1. TRY AGAIN - Same question displayed with previous answer selected / retained.



 |  | 3.9 | 
| 12 | Question set Behaviour: 
1. Shuffle, 


1. Feedback, 


1. Show x/y, 


1. Weighted scoring



 |  |  | 3.9 | 
| 13 |  | SHUFFLE |  | 3.9 | 
| 14 |  | SHOW / HIDE FEEDBACK |  | 3.9 | 
| 15 |  | SHOW x OUT OF y |  | 3.9 | 
| 16 |  | WEIGHTED SCORINGEvery question has different max marks within a question set |  | 3.9 | 
| 17 | Timer | User can add timer to a question set with warning timeUser can copy across different slides - which used to act as single timer for the content |  | 3.9 | 
| 18 | Sections  | User can add more than one question set in a content and configure behaviour for each one |  | 4.0 | 
| 19 | Progress bar |  |  | 3.9 | 
| 20 | Summariser / Submit confirmation | It is submit confirmation only in Self Assess content type. It sends summary event to Assessment aggregator API |  | 3.9 | 
| 21 | Slides to provide more context about the question set | Creator can create slides at any point in the content. _Creator can add Instructions to question set (in NEW Question set)_  |  | 3.9 | 
| 22 | End screen | Score configuration: Show score, Show only score obtained, Show complete scoreTotal score _Denominator (Total score) -_  _Eg. Show 20 out of 100 and player has played only 10 (timer ended). Total score should be 20 (sum of individual question max score) - not 100, not 10._  |  | 4.0 | 

















|  **QuML player - Consumption**  |  |  | 
|  --- |  --- |  --- | 
| Instruction | 
1. Instruction as 

<ul><li>Plain text

</li><li>Rich text with 


    1. Bold, Italics, Underline


    1. Bulleted and Numbered list


    1. Heading 1, 2, 3.. or Font size


    1. Font colour (optional)


    1. Table (optional)


    1. Math-Sci text (optional / not required)



    </li><li>Rich text with images and audio (auto play)

</li></ul>

 |  | 
| MCQ | 
1. 4 layouts as supported in creation


1. Zoom in & out of images


1. Listen to audio attached to the question (currently not supported in creation)


1. View feedback on submitting (navigating next)


1. View solution (if available)


1. View hints (if available)


1. Support shuffled order of questions


1. Support picking x out y questions while displaying to the user (shortlist from question bank)


1. Show/hide feedback


1. Show timer (if available)


1. Support explicit submit - and the ability to go back and change older answers/skipped answers



 |  | 
| Subjective questions | Rick text with/without image |  | 
| Lazy loading | 
1. Allow the basic structure to load first followed by content followed by controls


1. Buffering will be for next 2 page and  1 previous page


1. Buffering to work along with shuffle, x out of y configured by creator



 |  | 
| Timer  | 
1. Show timer to user 


1. Show warning time if configured



 |  | 





*****

[[category.storage-team]] 
[[category.confluence]] 
