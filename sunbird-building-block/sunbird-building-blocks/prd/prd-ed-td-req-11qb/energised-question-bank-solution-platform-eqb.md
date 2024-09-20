# (Energised)-Question-Bank-Solution-(Platform)-\[EQB]

(Energised) Question Bank primarily deals with Question and Question Set objects to enable a variety of use-cases centred around different types of questions & question sets. Know more about Question & Question set here: \[\[Question Definition|Question-Definition]] and \[\[Question Set Definition|Question-Set-Definition]]

This would cater to a variety of use-cases, such as

\| **Quick summary of the Use Case** | | Learn | Learner, Instructor, Administrator | ETB, Independent | **Practicing and learning for myself (ETB Practice)** As a student, I want to practice and learn by practicing for the chapters in my textbook | Practice worksheets linked to curriculum ETBs for students and teachers | | Instructor | Independent, ETB (Offline) | **Conducting practice offline (Teaching material)** As a teacher, I want to provide practice to students for a chapters in the textbook | | | Learner, Instructor, Administrator | | **Practice for an examination-style test (Mock Test)** As a student, I want to practice for an examination (Chapter by chapter & Mock test for a subject) | | | | | **Administering test offline** As a teacher, I want to conduct practice for an examination with my students | | | | | **Fun quiz anytime anywhere anyone** As a learner, I want to play a fun quiz on my favourite topic or on a topic I am very curious about | | | | | **Survey** Survey before & after a course training. Share your information, or information about something or your experience, feedback. Transactional data capture. Registration form. | | | --- | --- | --- | --- | --- |

| ---                                |
| ---------------------------------- |
| ---                                |
| ---                                |
| ---                                |
| ---                                |
| **Quick summary of the Use Case**  |
| Learn                              |
| Instructor                         |
| Instructor                         |
| Learner, Instructor, Administrator |
| Learner, Instructor, Administrator |
|                                    |
|                                    |
|                                    |
|                                    |
|                                    |
|                                    |

## MVP of EQB Platform & Solution

MVP would focus on enabling Survey, Test, Assessment, Quiz, and Practice capabilities for conducting Pre & Post Training Survey, Pre-Test for a Training, Baseline and End-line Survey & Assessment for Training, Self-Reflection Survey, and more..

[https://project-sunbird.atlassian.net/browse/SB-20202](https://project-sunbird.atlassian.net/browse/SB-20202)

### Platform MVP

Categories for Questions & Question Sets

Question Object Type:

* Attributes: Evaluation Mode, Contains PII (i.e. skip indexing user responses in druid), visibility
* Interaction types: Single select, Multi select, Short answer, Long answer, & Non-interactive Reference
* QuML mimetype&#x20;

Question Set Object Type:

* Attributes: Trackable, Date based release criteria, Instructions, Summary type, Contains PII, Visibility, Shuffle, Show feedback, Timer, Number of attempts, Navigation mode, Completion criteria, Requires submit,&#x20;
* Nested Question Sets, Publish workflow
* Linking Credentials (based on completion & score)
* Add question sets to Collection with release criteria (start & end dates) for Question sets within the collection
* Support for QuML questions only

Credentials:

* Issue credentials
* Depositing the credential in cert-registry & user-registry\*\*
* Fetch credentials

Data migration of existing QuML Questions & Question sets

### Consumption MVP

* Ability to discover various categories of Question sets on all consumption channels
* Ability to play questions and question sets
* Support configurations in the question set, such as trackable, start & end date, requires submit, summary display, capture PII
* Enable playing of question sets as part of collection
* Allow access to assessment as per dates configured
* Ability to view credential received for a question set
* Daily metric dashboard for admins
* Completion report download for admins (on-demand)

### Creation MVP

* Ability to create Survey, Test, and Assessment on DIKSHA
* Ability to create question set containing questions of various type, such as MCQ, MMCQ / MSQ, FTB, and Long FTB
* Ability to search and reuse questions
* Ability to add instructions and information to question set
* Ability to configure question sets before publishing
* Ability to link credentials to question set - independently and in context to a collection
* Ability to review question sets on DIKSHA
* Add question sets to collection
* Specify start & end date for assessments within a collection

Note:

* Interactive ECML content containing questions will continue to play as-is
* Questions created in interactive ECML editor cannot be reused for Survey, Test, and Assessment

### Data reports MVP

**Daily usage** metrics for all question sets: Plays, Completions, Location based aggregates,&#x20;

**Completion report** (only for trackable question sets). Dimensions: location, collection id and within a time range.

**User report** : For a question set, question level score for each user.&#x20;

**Question report** : To understand performance of all participants for a question. For a question set, compute&#x20;

_Total & Avg Time Spent_ , _Total Attempts_ , _Total Correct / Incorrect / Skipped Attempts_ for each question.

**Data exhaust** for questions without evaluation & questions containing PII

Enable admin to **view and download** report on DIKSHA

We currently have..

* Collection (Course) score report: Collection containing content of type (CourseAssess) - based on a flag - it generates report
  * Each user in a batch, for a content → score (best of attempts, explicit submit)
* Quiz daily metrics
  * Total sessions, devices, time spent
  * Participant info, at least a question answered
* Quiz Winner reports
  * [https://docs.google.com/document/d/1NAT7ReireW6BWWW252MDulqAfHhswuKkLn5sZpPt-Ww/edit](https://docs.google.com/document/d/1NAT7ReireW6BWWW252MDulqAfHhswuKkLn5sZpPt-Ww/edit)
  * All quiz (object\_id) events - viewed on mobile / portal, play, edit
  * Played
  * Participant info
  * Questions
  * Valid attempts - no of q / time
  * Dedup for did, take last / first attempt
* Summary exhaust
* Data dump exhaust (telemetry exhaust)
  * PII data sharing →
  * Rest of the data exhaust →
* ETB
  * LO reports
  * IRT
  * Learner proficiency (session or device)
* Survey (Manage)
  * Criteria based report
  * Session based report

### Question and Question Set capabilities mapped to different use-cases

\| **Capability** | **Survey** | **Test** | **Assessment** | | **Question types** | MCQ, MSQ, FTB (S/L), DD | MCQ, MSQ, FTB (S/L) | MCQ, MSQ, FTB (S/L) | | **Shuffle** | No | Yes/No | No | | **Feedback** | No | Yes | No | | **Evaluation & Scoring** | No | Yes | Yes | | **Start & End date** | No | No | Yes | | **Attempts** | Unlimited | Unlimited | Controlled | | **Contain PII** | Yes, likely to | No | No | | **Explicit Submit** | No | No | Yes | | **Summary** | Duration & No of Qs | Detailed | Score & Duration | | **Trackable** | Yes/No | Yes/No | Yes | | **Credentials** | No | Yes/No | Yes | | **Completion criteria** | Optional | Optional | Mandatory | | **Reports** | Participant’s responses | Question level report | Question & User level report | | **Visibility** |   |   |   |

## Practice Resource Creation, Consumption, Data, and Manage Workflows

#### As a user, I should be able to play Survey, Practice Test / Test, Assessment / Exam, Practice Resource, Quiz and other Question Set categories on all consumption channels (app & portal)

[https://project-sunbird.atlassian.net/browse/SB-20204](https://project-sunbird.atlassian.net/browse/SB-20204)

As a user, I should be able to play Survey, Practice Test / Test, Assessment / Exam, Practice Resource, Quiz and other Question Set categories on all consumption channels (app & portal)

As a user, given I have found any of the question set content, when I open / play the content, then I should be able to play it with the relevant consumption behaviour appropriate for that content. For example, when I play a quiz, then the quiz plays with a timer (if provided by creator).

Question set player should be able to play question set

* smooth and fast
* containing terms & condition, questions and information
* configured to show feedback, shuffle questions, and show x/y questions
* that capture user info (PII)
* with mandatory and optional questions
* that require explicit submit
* that display different types of summary as configured by creator
* that support different evaluation modes (system, none)
* generate relevant telemetry
* and allow playing the next / previous content in the collection from the end page

#### As a creator, I want to create Survey, Test, Assessment, Quiz, and Practice resource

[https://project-sunbird.atlassian.net/browse/SB-20209](https://project-sunbird.atlassian.net/browse/SB-20209)

As a creator,

→ I want to create a question set to provide practice content for the chapter or topic

→ When I open a textbook in a sourcing project, I should be able to contribute Practice Resource

→ When I am creating a Practice Resource, I should be able to:

* Create multiple choice questions
* Create fill in the blank questions
* Create reference questions (VSA, SA, LA or 2 mark, 4 mark, etc)
* Copy (duplicate) a question with all its attributes
* Provide details for the question such as: Learning Outcome, Learning Level,

→ When I am creating a question set, I should be able to

* Save Question Set
* Submit Question Set
* Preview Question Set (from beginning)
* Add Instruction or Information about the Practice Resource
* View review comments (for the question set and for any of the questions)

→ When creating any question, I should be able to

* Select question type / template
* Preview question
* Save question (same as Save Question Set)
* View review comment

→ When creating MCQ, I should be able to

* Select layout of MCQ (out of 4 available layouts)
* Change layout anytime

→ When I am done creating questions, I should be able to configure following for the question set

* Shuffle On / Off (default Off)
* Show how many questions out of total questions created (default - show all)
* Show / Hide Feedback (default Show)
* Weightage for each question in the question set (default equal weightage of 1 mark each)
  * Should we disable shuffle when weightage is provided?
* Provide details for the Question Set such as:
  * Name
  * Author
  * Attributions
* Question set would inherit / derive these values from the textbook:
  * Board, Medium, Class, Subject,
  * Topic (optional)
  * License
* Question set would inherit / derive these values from the category configuration:
  * Category (Practice Resource)
  * Audience (“Student”, editable)
  * Icon

→ When I am configuring Question Set, I should be able to preview it with configured behaviour

#### Support configurations in the question set such as

[https://project-sunbird.atlassian.net/browse/SB-20205](https://project-sunbird.atlassian.net/browse/SB-20205)

* Trackable: requires login for the question set when played individually
* Credentials: issue certificate as configured in the question set (individually or as part of a collection)
* Start & end date: for the question set as configured by creator either individually or as part of a collection

As part of a collection, it inherits these attributes from collection

#### As a creator, I want to create Multiple Choice Questions (MCQ & MSQ) for a Question Set

[https://project-sunbird.atlassian.net/browse/SB-20210](https://project-sunbird.atlassian.net/browse/SB-20210)

As a creator, I want to create Multiple Choice Questions for a Question Set

MCQ with single or multiple correct answers (partial scoring)

Supported configurations (for the question)

As a teacher, I want to create Multiple Choice Questions with one or more correct answers to provide practice questions aligned with textbook chapters to students.

As a creator,

→ When I am creating a (Practice) Question Set

* I select what to add to the question set - Instructions, MCQ, FTB, Reference questions
  * If there are more than one template / layout options, they are all shown upfront grouped by type of block (question type)
  * User can change the layout within a question type at any time (e.g. changing from MCQ to FTB should be restricted)
* I can navigate to any block in the question set using the table of content (on left)
  * I can re-arrange blocks in the ToC
  * New blocks such as 'Section' can be possible in future. Each Section would have Instruction and Settings.
* I can copy-paste from other sources such as MS Word, PowerPoint, Internet, Google Docs, etc
  * Any supported characters or piece of pasted information should be pasted as image if possible or else stripped off so that question does not contain any invalid data
  * A relevant toast message should be shown to the creator to check preview before saving
* I can change layout for MCQs or other question types at any time
* I can preview in portrait and landscape orientation (or in other words computer and phone mode)
* I can mark one or many options correct
  * When I have marked more than one option correct, the scoring mode is set to ‘Partial’ scoring. So I will get marks for any of the correct options I select
  * I can select to award marks only when ALL correct options are selected. Partial scoring mode is disabled.
* I can add Solution for each question
  * Solution can be a video or a note / paragraph (text with images)
* I can add Hint(s) for each question
  * Hints can be configured to be available upfront or after first.. nth attempt

I see various layout templates to choose from. We decided to keep only two layouts - MCQ, Multimedia MCQ,

Layout templates:

1. With question and options in vertical scroll single-column layout.
   1. Question text can be of any length (say, max 1000)
   2. Limit text font size from 14 to 48
   3. Text can be styled as Bold, Italics, Superscript, Subscript
   4. Text can be aligned left, centre, right or justified
   5. Language of the text can be selected from supported Indian languages
   6. Text can contain bulleted or numbered list with only first level of indent (not multi-level)
   7. Question text (body) can contain a table
   8. with upto 10 x 10 cells
   9. Header column and row
   10. and more features as supported by the editor library being used
   11. Question text (body) can contain formulae, equations, and expression (Math & Scientific text)
   12. Support most frequently used equations
   13. Support special characters & symbols
   14. Support Equations formats
   15. Support advanced equation or expression
   16. Question image can be small (25%) / medium (50%) / large (100%). Image can be added anywhere in the question body
   17. Options can be
   18. Large (100%): list (vertically stacked),
   19. Small (25%): horizontal (cards), \[ _Should the user choose number of columns or is it always 4?_ ]
   20. Medium (50%): grid layout \[ _This would divide the option area into two columns_ ]
   21. Options may contain images
   22. Option images can be small / medium / large if using Large options (list vertically stacked)
   23. Option images are small in case of Small options (horizontal small size).
   24. Option images can be small / medium in case of Medium options (grid layout)

Notes:

* We will not provide more than 2 MCQ layout options
* We are not providing two column (side-by-side) question layout as that would involve multiple scroll interactions on the screen which could confuse the user.

#### As a creator, I want to create Fill in The Blank (short & long) for a Question Set

[https://project-sunbird.atlassian.net/browse/SB-20211](https://project-sunbird.atlassian.net/browse/SB-20211)

Short & Long FTB

With or Without Word / Character Limit

With input validation

#### As a creator, I want to create Single or Multi-select dropdown questions

[https://project-sunbird.atlassian.net/browse/SB-20212](https://project-sunbird.atlassian.net/browse/SB-20212)

Max limit of options

"Other" option

#### As a creator, I want to add information or instructions to a question set

[https://project-sunbird.atlassian.net/browse/SB-20214](https://project-sunbird.atlassian.net/browse/SB-20214)

Instruction title

Instruction (rich text with images)

1. Creator selects ‘Create New’
2. Creator select appropriate category from ‘Create New’ list of categories
3. On selecting ‘Practice Resource’, default configuration for Practice Resource category will be applied to ease creation process
   1. Shuffle: Off, editable
   2. Number of questions to show: All, editable
   3. Weightage: Equal (1 Mark), editable. _If weightage is applied, Number of questions should be ‘All’_ . Should we display marks to players in case of weighted question sets?
   4. Max marks: Total marks, view-only
4. Other configurations supported for the question set
   1. Scoring mode
   2. Timer
   3. Start and End date
   4. Certificate
   5. Certificate criteria
   6. Requires login + measure progress & performance
   7. Requires explicit submit + measure performance
   8. Completion criteria
   9. Question numbering - Q1, Q1.1, Q1.1.1 OR Q1, Q1.a, Q1.a.i,
5. Name of the question set is required, will be blank by default. User can enter any alpha-numeric character in all supported languages. Special characters are not allowed except for “?”, “-”, …
6. Creator can add
   1. Instruction / Introduction / Information
   2. Multiple Choice Question
   3. Fill In the Blank
   4. Reference Question
   5. Dropdown Questions (Single or Multi-select)
   6. File upload Questions
7. Questions or Information block are created as draft.
   1. Visibility for Questions (of any type) is set as public
   2. Information / Instruction / Introduction / Section block is set to ‘parent’ visibility
8. All changes are auto-saved. User can Undo / Redo changes (upto 10?)
9. Live or quick preview available for each question to verify the look & feel of the question
10. Creator can
    1. Reorder questions or blocks within a question set
    2. Copy or duplicate a question or information block
    3. Delete questions from a question set. (In future, when we enable question reuse, user can remove question added from library)
    4. Preview question
    5. Change layout for MCQ options during preview
    6. Change image size for Question or (all) Options during preview
    7. Navigate questions (by scrolling or by selecting from question list on the left pane)
    8. Preview Question set
    9. Configure question set behaviour
    10. Submit Question Set
    11. View Review comments at Question or Question Set level
11. Pagination
    1. Creator can group questions to be shown on a particular page. A page scrolls vertically. Page looks best in portrait mode. Should we have default orientation of question set?
    2. Can be used to show more than one question on a page. Default - one question at a time.
    3. Questions having multi-part might prefer to show on one page or multiple pages
12. Section
    1. This works more as a header to demarcate parts in a question set - similar to Information block with only Title?
    2. This works best in portrait mode, vertical scrolling mode
    3. Does section work similar to a nested question set?
    4. Nested question sets have their own configuration - they inherit parent attributes as much as possible
13. Question set layout and navigation
    1. All question on a page - Portrait mode, Vertical scroll. Can be in landscape mode as well.
    2. One question at a time - Previous / Next buttons to navigate (or Question map / Progress bar). Can be in portrait or landscape mode.
14. **Information** block can
    1. be called as ‘Introduction’ or ‘Instruction’ or ‘Section’ or anything else creator wishes to name it as. _Default name will be “Introduction”_ .
    2. This is not to be confused with ‘Description’. _We are not using Description_ .
    3. have audio attached with it
15. Any block - Information or Question can have audio attached to it
16. Any question can have
    1. Audio for the question. Audio can be set to autoplay.
    2. Marks. Default: 1. Creator can provide different marks to indicate weightage of the questions
    3. Solution
    4. Solution can be rich text (with images) or audio. _In future, Videos could be added to Rich text_ .
    5. Solution is always available after attempting a scored question or on-demand in case of non-scored questions
    6. Hints
    7. Hints at question level after an incorrect attempt or on-demand
    8. Multiple hints with configurable access (always available on-demand, or on Nth incorrect attempt)
    9. Hints can be plain text upto 160 characters
    10. Tips
    11. Tips help a user in understanding question or option further. Specially in responding to a survey
    12. These appear inline - not on-demand
    13. Can we merge tips and hints? Have a custom experience depending on the category of use-case?
17. Question Set information. Each question set could be tagged with
    1. Name
    2. Board, Medium, Class, Subject (derived from collection / context if possible)
    3. Topic(s)
    4. Author
    5. Credits / Attributions
    6. License
    7. Description? Thumbnail Icon?
    8. Max Time / Time Limit
    9. Total Questions
    10. Total Marks
18. Certificate
    1. Certificate based criteria such as completion or questions attempted or score obtained.
    2. Registration upfront might not be required. It could be ‘Login to unlock your certificate’ as a post-facto prompt
19. Question information. Each question should / could be tagged with
    1. Board, Medium, Class, Subject (derived from question set / context if possible)
    2. Learning Outcome
20. **Multiple Choice Question**

    \[ _Provide the minimal simple MCQ creation experience. Make it easy to create visually appealing questions._ ]

    What if we keep MCQ creation UX as-is and only change the QuML + Question Set API integration?

    1. Question is a rich-text block which supports images, equations & formulae, formatting, styling,
    2. Font style: Bold, Italics, Superscript, Subscript
    3. Font size: 12 to 48 (configurable range)
    4. Font family: List of language specific fonts for supported Indian languages
    5. Math & Scientific text: as-is
    6. Add Image: Upload, Search All Images, My Images
    7. Bulleted & Numbered list
    8. Font & Font Background Colour
    9. Text Alignment (Left, Centre, Right, Justify)
    10. Insert Table
    11. Special Character
    12. Undo, Redo
    13. Disable these: To-do list, Indent +/-, Block quote, Add Video, Format as Heading, Link, Page Break
    14. Math and Scientific text
    15. Gets inserted wherever user’s cursor is
    16. Should be able to continue typing text before or after the inserted LaTeX / KaTeX block
    17. Line height will need to managed when this block is inserted
    18. User can delete this using backspace or delete button
    19. Selecting the block and pressing enter will place the cursor after the block. Pressing enter again will create new line
    20. Images
    21. Images can be aligned Left, Centre, Right
    22. Image size can be Small, Medium, Large
    23. Options can
    24. Layout as horizontal ↔ (┉ ), vertical ↕ (↕) , and grid (⠛). Change layout during preview.
    25. Image size (applicable to all options)
    26. be minimum 2 and maximum 8 or 10
    27. have same capabilities as question body
    28. Options can change creation layout based on option layout selected (visual arrangement similar to player view)
    29. Options need to be marked as correct. At least one. How would the player know that multiple correct options are possible? Should we show check-boxes in player?
    30. Evaluation logic
    31. ANY of the correct answer (Partial scoring)
    32. ALL of the correct answer (Non-partial scoring)
    33. Preset layouts
    34. Simple MCQ (Text, Vertical options), Multimedia MCQ (Grid options, With images)
    35. Placeholder image put inside options to guide creator. On clicking placeholder image, Add Image from Library opens up.
    36. Change preset anytime during creation or during preview
21. **Fill In the Blanks**
    1. Type a sentence, select a word or phrase, and make it a blank
    2. Can have multiple blanks
    3. Each blank can have more than one correct response. \_\_\_ is the Silicon Valley of India\_ . (Bengaluru, Bangalore)
    4. Multiple blanks can be (read more \[\[Fill in The Blank - Multiples and Variations - Nov, 2018|Fill-in-The-Blank---Multiples-and-Variations---Nov,-2018]] )
    5. Sequential. Independent. \_Complete the prime number sequence 3, 5, \_, 11, _, 17_
    6. Unordered list of answers, unique
    7. One group, variations, unique
    8. Multiple groups, variations, unique
    9. Linked responses with 2 or more blanks
    10. Evaluation logic
    11. Ignore blanks
    12. Case insensitive
    13. Ignore special characters?
    14. Printable by downloading as PDF
    15. FTB are printed with empty blanks - numbered to map to answers
    16. Answers are printed with sequence numbers
22. Copy-pasting from MS Word, Excel, PowerPoint or anywhere on internet
    1. Allow text with styling format
    2. Paste equations as (embedded) images
    3. Paste image as embedded. Do not use local file storage path for image
    4. Paste table as HTML
    5. …

### Minimal scope

To be updated in [https://project-sunbird.atlassian.net/browse/DP-1044](https://project-sunbird.atlassian.net/browse/DP-1044)

1. Question Set -
   1. ECML → QuML
   2. Content generalisation: Object type, Category,
   3. Feature parity Configurations: Shuffle, Show Feedback, Weightage, MaxQuestions
   4. New Configurations: Timer (Quiz), Summary (Course Assessment),
   5. New attributes: Visibility, .. (can be derived from category, or from Form API / editor config)
   6. Integration of Question set player (QuML) for preview - player mode
2. Question -
   1. MCQ -
   2. MCQ creation as-is (no change)
   3. MCQ Creation minimal changes
   4. Introduce new layouts: Options - V, H, G | Select option layout: V, H, G
   5. Question body contains image: S (default), M, L. Align left (default), centre, right.
   6. Image should not pixelate. Large should not extend the image - it should show original image size.
   7. Option contains image: Preset image size & alignment
   8. V - Small, left
   9. H - Large, centre
   10. G - Medium, left
   11. Change layout during editing and preview
   12. Zooming of images - on player
3. Creation UX - Switch between edit and preview - more intuitive
4. Separation of Question level metadata & Question Set level metadata
   1. Q level - LO, Marks (Weightage)
5. Lifecycle -
6. Visibility - derive from parent
7. Scroll up on any question to navigate to next question (refer to GSlides)

## Survey

\[\[Survey|Survey]]

## Scenarios

### Question categories mapped to a Question Set

Practice Question Set (Subjective) should have only VSA, SA, LA Question categories

Practice Question Set (Objective) should contain MCQ, FTB, MTF categories

Survey should contain MCQ, FTB, File Upload, and Slider categories

### Question Set structure

Practice Question set would contain only Questions

Survey would contain Sections (Question Set Unit) and Questions will only be present in Sections (not in root Question Set)

In a Survey, I want to add Section. To the sections, I want to add Questions of type MCQ, FTB, MTF, File Upload, Slider, etc. I also want to add a specific category of Question set a Section level.

### Multiple Choice Question - single & multi choice

Scoring & Correct options: There could be score for each option or even no score for any of the options. So there could be no correct answers. Marking an answer correct is essentially same as setting 1 mark for that option.

Partial scoring: There could be one or more correct options - let the user select one or more correction options. If there are more than one correct options - system would allow partial marking - which would essentially mark each option as 1/(number of options correct)

Single or Multi-Choice: When there are no correct options (all options having 0 marks) - user should select interaction type as single/multi. If marks are mentioned for one or more options - make it automatically as single/multi-choice.

When question has no correct answer but it still has specific interactions.type. For example, select one or more of your favourite ice-cream? Vanilla, Chocolate, Strawberry, Blackcurrant.

### Fill in The Blank

For each blank there can be one or more possible correct responses. User will be awarded marks when they enter any of the possible acceptable responses.

For more than one blanks, refer to this document for scenarios \[\[Fill in The Blank - Multiples and Variations - Nov, 2018|Fill-in-The-Blank---Multiples-and-Variations---Nov,-2018]]

There is an additional scenarios where different responses to a blank can be graded differently. For example, \_\_\_\_ is capital of India. If New Delhi, give full marks. If Delhi, give half mark.

Imagine a question which has dropdown, text input, and number input. Number input should validate user’s input & open number-entry-keyboard by default.

When question does not have any correct response but it still has interactions.type. For example, what’s your age? (should be number, no specific correct answer)

### Scoring logic

Basic: Marks per response. For example - Different marks for each option in MCQ, Different marks for each blank.

Simple logic:

→ Option 1 =1/3 OR option 2 = 1/3 OR option 3 = 1/3. If any two or more, SUM of marks. (ANY Correct Answer i.e. Partial scoring)

→ If Option 1 AND Option 2 AND Option 3 = 1, Else 0 (ALL Correct Answer i.e. No Partial Scoring)

Advanced logic:

→ Use AND, OR, NOT, etc operators along with Responses to create custom logic. Similar to Advanced Formula Editor using LaTeX / KaTeX

### View & Navigation for player for Sections

Show questions from a section on the same page. Progress and Status indicator behave accordingly for Question Sets containing Sections.

## January 2021 - Question Set and Question Roadmap

draftYellow

[https://project-sunbird.atlassian.net/browse/SB-22719](https://project-sunbird.atlassian.net/browse/SB-22719)

Creation workflow should support:

1. Viewing all my questions, question sets
2. Creation workflow for Question sets and Questions (independently)

Key Creation capabilities:

1. Configure question set settings required for a specific Question Set category. This includes list of behavioural settings, their default values and if they are mandatory.
2. Support Question Set configurations such as Shuffle, Show x/y, Show/Hide feedback,
3. Support MCQ (single select) and Reference (non-interactive, Subjective) questions
4. Support Question Set configurations such as Timer with Warning time, Show/Hide Submit confirmation, Max attempts
5. Support creation of various question categories such as MCQ (with multiple correct), FTB, MTF, Subjective questions, Sequencing, Ordering,
6. Quick preview of each question with ability to view in mobile as well as desktop mode
7. Entering details (metadata) and configuring behaviour of each individual question
8. Ability to create a (child) question set within a question set, and configure behaviour such as Shuffle, Show x/y, etc for each child question set
9. Add questions from library
10. For questions added from library, allow editing question behaviour after adding to the question set
11. Preview of the whole question set before submitting for review

[https://project-sunbird.atlassian.net/browse/SB-20202](https://project-sunbird.atlassian.net/browse/SB-20202)

Based on the vision [_Project inQuiry_ ](https://github.com/sunbird-specs/inQuiry)(QuML specification), we will develop a minimum viable product for _Question bank Digital Infrastructure_ which enables a variety of use-cases such as practice, quiz, survey, practice test, assessment, and more. These will enable **Learn** , **Help Learn** , and **Manage Learn** interactions.

Question Set Creation should support existing use-cases (listed below) enhancing the **Ease of creation** , **Ability to extend & configure** , and **Self-serviceability** .

1. **Practice** in context to ‘ **Learn** ’,
2. **Quiz** in context to ‘ **Learn** ’,
3. Course **Assessment** in content to ‘ **Help Learn** ’, and

Ability to enable use-cases such as **Survey** , **Observation** , **Institutional Assessment** (rubric-driven) and **Exam Papers** through ecosystem engagement.

At a high-level the plan is to enable,

→ **Practice** in 3.7Yellow,

→ Course **Assessment** in 3.8Blue,

→ **Quiz** in 3.9 (future)Purple

This section lists out key functional capabilities for various use-cases enabling us to roll-out first version at scale using the generalized capabilities of _Question Bank Digital Infrastructure_ .

Key creation capabilities for **Practice** \[ **Learn** ] (V1):

1. Question categories such as MCQ (with multiple correct), FTB, MTF, Sequencing, Ordering, and Subjective questions
2. Configuration such as Shuffle, Show x out of y, Show/Hide feedback

Key capabilities for Course **Assessment** \[ **Help Learn** ] (V1):

1. Question categories such as MCQ (with multiple correct), FTB, ..
2. Configuration such as Shuffle, Show x out of y, Hide feedback
3. Additional configuration such as Timer, Submit confirmation, Max attempts
4. Ability to add Sections and configure behaviour such as Shuffle, Show x/y, etc for each section

Key capabilities for **Quiz** \[ **Learn** ] (V1):

1. Question categories such as MCQ (with multiple correct), FTB, MTF
2. Configuration such as Shuffle, Show x out of y, Hide feedback
3. Additional configuration such as Timer, Submit confirmation, Max attempts
4. Ability to add Sections and configure behaviour such as Shuffle, Show x/y, etc for each section

Key capabilities for **Quiz** \[ **Learn** ] (V2):

1. Ability to attach a certificate to the Question Set and configure certification criteria
2. Ability to set Start and End Date for a question set
3. Ability to turn on/off if login is required ( _Trackable_ Enable/Disable)

### Player supported configurations

1. showTimer, timeLimit 2. Total number of questions / Max Questions 3. NavigationMode - Linear/ non-linear 4. allowSkip - true/false 5. setType - \[“materialised”, “dynamic”] 6. showHints - 7. SummaryType - 8. showFeedback - 9. requiresSubmit - 10. shuffle - 11. showSolutions -

***

\[\[category.storage-team]] \[\[category.confluence]]
