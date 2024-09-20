# DataScience-AMJ--Road-Map

**1. Use Case: Profanity Filter**

**Problem** : Detect profanity words and flag such Content.

RoadMap:

1. Feasibility Track (effort: one week)
   1. [review](https://github.com/vzhou842/profanity-check) existing methods: look-up based and model-based
   2. create positive and negative test data
   3. seed test data from public data sets: [cmu](https://www.cs.cmu.edu/\~biglou/resources/), [kaggle](https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge/data) and other sources, [word list](https://github.com/snguyenthanh/better\_profanity/blob/master/better\_profanity/profanity\_wordlist.txt), [word list](https://github.com/ben174/profanity/blob/master/profanity/data/wordlist.txt):&#x20;
   4. create own test data
   5. run [profanity](https://github.com/ben174/profanity), and [better\_profanity](https://github.com/snguyenthanh/better\_profanity/blob/master/better\_profanity/profanity\_wordlist.txt), [profanity\_check](https://github.com/vzhou842/profanity-check)
   6. ensemble them
   7. evaluate the performance on individual and ensemble approaches on test data
   8. design document
2. Production Track (effort: one week)
   1. Design Review and Documentation (telemetry, and data models for capturing feedback)
   2. Write test cases for positive and negative examples&#x20;
   3. Add profanity flagging tag to existing Auto Tagging Module
   4. And possibly write an "alert event" if a profanity tag turn positive

Rest of the flow is same as Productionizing Auto Tagging

Task Dependency Graph

1 → 2

(1a | 1b) → 1c → 1d → 1d → 1e → 1f&#x20;

2a → 2b → 2c → 2d

External Dependencies

1. DS VM&#x20;

DS Resources:

1. Tech Manager&#x20;
2. One DS developer  (can be split between two)
3. Solution Manager: Mohit

**TBD** : Align it with AMJ Sprint Cycles

**2. Use Case: Content Reuse**

**Problem** : [Story](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/overview)

RoadMap:

**Experiment Track**

1. Data Sourcing (effort: one week)
   1. Pick Maths, NCERT Grade 10 Textbook (which is the basis for NCF or NCERT framework in the platform), convert it to JSON data using
   2. Google ocr-uri
   3. pypdf2
   4. Filter and prepare MVC test data
2. Taxonomy Enrichment (effort: one week)
   1. Extract reference Taxonomy
   2. Take the reference framework and map the taxonomy pointers to the corresponding section in the digital twin of the textbook
3. Index this data in ES (effort: one week)
   1. Index enriched taxonomy
   2. Get the pointer text object, given taxonomy pointer,&#x20;
   3. Write ES Query&#x20;
4. Test and Iterate (two weeks)
   1. retrieval performance, and benchmark against baseline (existing) and iterate
5. If performance is acceptable
   1. Design Review
   2. Prod Roadmapping

Task Dependency Graph

(1a | 1b) → 2 → 3 → 4 → 5&#x20;

External Dependencies

1. DS VM

DS Resources:

1. Tech Manager
2. Two DS developers
3. Solution Manager: Mohit

**TBD** : Align it with AMJ Sprint Cycles

**3. (Potential) Use Case: EQB Curation Smart Tagging**

**Context** : [Context and Architecture](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1017053393/EQB+Architecture)

Problem: Figure out a way to assert quality of the question bank, and use those Quality tags to rank the questions

\*\*Experiment Track: \*\*

1. Manual Rules
   1. Check if Marking Schema (meant for a teacher) can be graduated to an Answer (that can be shown to a student)
2. Learn Model based Rules (variable depending on scope)
   1. NLP + Image Processing to detect if a question/answer has special symbols like
   2. polynomial
   3. matrix
   4. shapes ...
3. Load Rules (effort: 2 days)
   1. Code/Load the rules/models
4. Apply the Rubrics and Summarize the results (effort: 2 days)
5. Populate this data back to Google Sheets (as a means of sharing data with EQB team)
6. Evaluate
   1. Pick a sample and see if rules are holding well against the data
   2. Validate the generated tag by EQB team.&#x20;
   3. Summarize the results
7. If results are acceptable,&#x20;
   1. Design Review for Prod

DS Resources:

1. Tech Manager&#x20;
2. One/Two DS developers depending on availability and urgency
3. Solution Manager: Suren

Task Dependency Graph

(1 | 2) → 3 → 4 → 5 → 6 → 7

External Dependencies

1. Rubric from EQB team
2. Bandwidth from EQB team for providing validation inputs
3. Making the Question and Marking Scheme available for easy view by Validation team
4. DS VM

**TBD** : Align it with AMJ Sprint Cycles

**4. Use Case: Taxonomy Alignment**

**Context** : [Context and Architecture](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1017053393/EQB+Architecture)

Problem: A Textbook will be created that uses a Framework (Taxonomy) available in the platform. And against the chapter, topic of that Textbook, question-answer packets have to be created. However, the Taxonomy terms available on the Question Bank may not necessarily align completely with the Taxonomy on the platform. How do we align them?

\*\*Experiment Track: \*\*

1. Manual Mapping
   1. Extract Taxonomy Terms from Question Bank
   2. Done using scripts.&#x20;
   3. Select a corresponding Framework, for a given, board, subject, grade, medium,
   4. All existing Frameworks were extracted and kept in an Spreadsheet
   5. Manually align the terms
   6. Once the terms are mapped, every Question can be tagged to Framework on the platform
2. Mapping via Search
   1. Take data at the end of previous step as ground truth
   2. Use Enriched Taxonomy from Content Reuse Use Case (see above)
   3. Enrich Question Data (extract Text data from the Questions, do Smart Tagging)
   4. Treat Mapping as a Search Problem: Given a Question, which Taxonomy Term it should be mapped to
   5. Validate based on ground truth above

\*\*Production Track: \*\*

1. Proposal and Review
2. Define the data models
3. Ingest the Platform taxonomy terms or have look up (from at step 3 above)

DS Resources:

1. Tech Manager&#x20;
2. One/Two DS developers depending on availability and urgency
3. Solution Manager: Suren

Task Dependency Graph

(1 | 2) → 3 → 4 → 5 → 6 → 7

External Dependencies

1. Rubric from EQB team
2. Bandwidth from EQB team for providing validation inputs
3. Making the Question and Marking Scheme available for easy view by Validation team
4. DS VM

**TBD** : Align it with AMJ Sprint Cycles

**5. (Explore) Use Cases: Content Reuse and EQB Search**

**Problem** : [Content Reuse](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/overview) and [EQB](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1017053393/EQB+Architecture) are two sides of the same coin. They both are search problems at their core. We did a quick and dirty POC [here](https://project-sunbird.atlassian.net/browse/SC-874)  to try Deep Learning models. The results were very encouraging but we have to cautious as the model is probably overfit. We have not done thorough evaluation.

**Experiment Track A**

1. Validate the results from previous spike, and see if they are generalizing well.

**Experiment Track B**

1. Data Sourcing (effort: one week)
   1. prepare query, document data pairs (done)
   2. prepare query, document data pairs based on Taxonomy Enrichment words, and Enriched Content Model data (use normalized words only withtout lemming and stemming)
2. Model Sourcing (effort: 3 days)
   1. Download ELMO, Universal Sentence Encoders (from tensorhub), and work with them
3. Update the architecture (2 days)
   1. Instead of using bilstm, use ConvNets as query documents are bag of words and not really sentences
   2. Use Google UST as phrase, sentences representations, and learn a simple classifier (replace bi-lstms with a ffn)
4. Model Search (two weeks)
   1. use DNN with single dense layer as baseline&#x20;
   2. Use AutoML or NAS or Ray for automatic architecture search
5. Test and Iterate (two weeks)
   1. retrieval performance, and benchmark against baseline (existing) and iterate
6. If performance is acceptable
   1. Design Review
   2. Prod Roadmapping

Task Dependency Graph

A → B

(B1a | B1b) →  B2 → (B3a | B3b ) → (B4a | B4b) → B5 → B6&#x20;

External Dependencies

1. DS VM

DS Resources:

1. Tech Manager
2. Two DS developers
3. Solution Manager: Mohit

**TBD** : Align it with AMJ Sprint Cycles

***

\[\[category.storage-team]] \[\[category.confluence]]
