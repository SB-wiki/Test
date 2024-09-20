# V1-Templates-in-Ekstep

This document contains details about the older v1 templates available in ekstep. It provides information about how to

* Create and upload templates.
* Create questions(MCQ, FTB and MTF) in ekstep portal.
* How to debug template issues.

**Types of templates**

1. MCQ
2. FTB
3. MTF

**How to create questions using templates**

1. Login to dev.ekstep.in or qa.ekstep.in
2. Click on Resources → Question Bank'
3. It will show you the list of available templates and the preview
4. To create a new question, Click on Add Question
5. And select a template and click start creating
   1. For FTB,
   2. Enter the question text, the question text may be the title for the question or may be the question itself.
   3. Enter the answer text, the answer text can be single or multiple
   4. It may have the additional Model field to be filled for some templates.
   5. For some templates, the questions and answers can be generated randomly.
   6. For MCQ,
   7. Enter the question text, the question text may be the title for the question or may be the question itself.
   8. Enter the answer text, the answer text can be single or multiple
   9. It may have the additional Model field to be filled for some templates.
   10. For some templates, the questions and answers can be generated randomly.&#x20;
   11. For MTF,
   12. Enter the question text, the question text may be the title for the question or may be the question itself.
   13. Enter the answer text, the answer text can be single or multiple
   14. It may have the additional Model field to be filled for some templates.
   15. For some templates, the questions and answers can be generated randomly.&#x20;
6. Click on "save" and "save & create another"
7. The created question will be available in the question bank.

**List of available v1 templates in QA and Production**

1. Measuring Angles
2. Number Chart
3. Place Value In Numbers
4. MCQ - General
5. Comparing Angles
6. Horizontal Operations with Place Value Models
7. Vertical Operations with Place Value Models
8. Comparing Numbers
9. Place Value Bundles
10. Comparing Size
11. Counting Objects
12. Comparing Quantities
13. Place Value Models - Learn
14. Text Question, Text Options (Vertical)
15. Text + Image Question, Text or Image Options
16. Counting with Place Value Models - 1
17. Counting with Place Value Models - 2
18. Image Question, Image or Audio Option
19. Mcq long text
20. Sequencing
21. TEXT AND IMAGE MATCHING (HORIZONTAL)
22. Text and Image Matching (Vertical)
23. Reordering Letters & Numbers
24. Sorting Template
25. Reordering Words
26. Operations with images
27. Fill in the Blanks (with Image) - Word Answers
28. Vertical Operations
29. Division
30. Addition/Subtraction (with place value markers)
31. Addition/Subtraction
32. Multiplication (with parametrization)
33. Fill in the Blank - Number Answers
34. Multiplication
35. Sudoku
36. Multiple Blanks
37. Division
38. Vertical Operations
39. Fill in the Blank (sentence) - Number Answers
40. Custom Keyboard

**How to debug templates in browser**

* Clone the content-player([https://github.com/project-sunbird/sunbird-content-player](https://github.com/project-sunbird/sunbird-content-player)) repo of sunbird.
* Inside content-player → player → public → fixture-stories, Add your template folder containing (index.ecml, assets etc)
* Inside content-player → player → app-data → fixture-content-list.json, Add the below object structure to the json object result → contnet

&#x20;                   {

&#x20;                        "identifier": "template-name",

&#x20;                        "mimeType": "application/vnd.ekstep.ecml-archive",

&#x20;                        "localData": {

&#x20;                                   "questionnaire": null,

&#x20;                                    "appIcon": "fixture-stories/template\_folder\_name/logo.png",

&#x20;                                    "subject": "literacy\_v2",

&#x20;                                    "description": "epub - Beyond Good and Evil",

&#x20;                                    "name": "Custom Eval",

&#x20;                                    "downloadUrl": "",

&#x20;                                    "checksum": null,

&#x20;                                    "loadingMessage": "Without requirements or design, programming is the art of adding bugs to an empty text file. ...",

&#x20;                                    "concepts": \[{

&#x20;                                                    "identifier": "LO1",

&#x20;                                                    "name": "Receptive Vocabulary",

&#x20;                                                    "objectType": "Concept"

&#x20;                                       }],

&#x20;                                    "identifier": "org.ekstep.customeval",

&#x20;                                    "grayScaleAppIcon": null,

&#x20;                                    "pkgVersion": 1

&#x20;                         },

&#x20;                        "isAvailable": true,

&#x20;                        "path": "fixture-stories/custom\_eval"

&#x20;             },

* In the browser, click on the template logo you added for the template, the player will show the template, If the ECML is valid.
* Inside content-player → player, Open command prompt and type "node app.js" and press enter.
* In the browser type "localhost:3000".

**How to create templates**

* Create a folder with the template name. The template folder structure should contain
  * assets
  * images.png
  * widgets
  * css
  * index.css
  * js
  * index.js
  * items
  * assessment.json
  * index.ecml
* **Assets** folder contains images required for the template
* **Widgets** folder contains additional js and css required for the template
* **Items** folder contains assessment.json file which is used by the template
*   **index.ecml** contains the ECML for the template. The basic structure of the template is&#x20;

    *

    &#x20;         &#x20;

```
       <param name="next" value="stage1"/>
```

&#x20;     &#x20;

```
            <embed template="item" var-item="item"/>

       </g>

</stage>

<stage h="100" id="stage1" w="100" x="0" y="0" preload="true">

       <param name="next" value="stage2"/>

       <param name="previous" value="splash"/>

       <image assest="image">

</stage>

<stage h="100" id="stage2" w="100" x="0" y="0" preload="true">

<param name="previous" value="stage1"/>

       <image assest="image">

</stage>
```

* **Tags used in ECML**
  * theme -  Which is the entry point of the ecml. It should specify the id as theme and the stage which is to be rendered first.
  * manifest - it contains the media tags of medias(images, audio), js and css files used inside the template
  * media - it is used to include the medias(images, audio), js and css files used inside the template
  * stage - this tag specifies each screen inside the renderer. One can add multiple stages. The start stage should be "splash" and should be included in the theme tag. If you want to include the json add attribute iterate and var = item
  * embed - Embed tag is used to embed the template inside the stage
  * param - name attribute of param can be next, previous to specify the navigation to the next and previous stages.
  * controller - this tag is used to include the json file inside the items folder. specify the json file name as id and name attribute.
  * template - contains unique id for the template and the tag contains various tags which specify the UI for the template.
*   **assessment.json**

    * For **MCQ**
    * {

    "identifier": "template\_name",

    "title": "template\_name",

    "total\_items": 1,

    "shuffle": false,

    "max\_score": 1,

    "subject": "LIT",

    "item\_sets": \[{

    &#x20;        "id": "set\_1",

    &#x20;        "count": 1

    }],

    "items": {

    &#x20;        "set\_1": \[{

    &#x20;        "identifier": "protractor.que1",

    &#x20;        "qid": "protractor.que1",

    &#x20;        "type": "MCQ",

    &#x20;         "template\_id": "template\_name",

    &#x20;         "template": "template\_name",

    &#x20;         "title": "Question text here",

    &#x20;         "question\_audio": "",

    &#x20;         "question": "Question\_title",

    &#x20;         "model" : {

    &#x20;                   "angleRange":"0-180" // for example, and it can be anything depands on the model

    &#x20;         },

    &#x20;        "question\_image": "angle\_img",

    &#x20;        "options": \[{

    &#x20;               "value": {

    &#x20;                     "type": "mixed",

    &#x20;                     "text": "120",

    &#x20;                     "audio": "",

    &#x20;                     "image": "",

    &#x20;                     "asset": ""

    &#x20;               }

    &#x20;        }, {

    &#x20;        "value": {

    &#x20;                    "type": "mixed",

    &#x20;                    "text": "180",

    &#x20;                     "audio": "",

    &#x20;                     "image": "",

    &#x20;                     "asset": ""

    &#x20;                    }

    &#x20;        },{

    &#x20;       "value": {

    &#x20;                     "type": "mixed",

    &#x20;                     "text": "75",

    &#x20;                    "audio": "",

    &#x20;                    "image": "",

    &#x20;                    "asset": ""

    &#x20;                },

    &#x20;                "answer": true

    &#x20;         }]

    &#x20;     }

    }

    * For **FTB**
    * {

    "identifier": "template\_name",

    "title": "template\_name",

    "total\_items": 1,

    "shuffle": false,

    "max\_score": 1,

    "subject": "LIT",

    "item\_sets": \[{

    &#x20;        "id": "set\_1",

    &#x20;        "count": 1

    }],

    "items": {

    &#x20;        "set\_1": \[{

    &#x20;        "identifier": "protractor.que1",

    &#x20;        "qid": "protractor.que1",

    &#x20;        "type": "MCQ",

    &#x20;         "template\_id": "template\_name",

    &#x20;         "template": "template\_name",

    &#x20;         "title": "Question text here",

    &#x20;         "question\_audio": "",

    &#x20;         "question": "Question\_title",

    &#x20;         "model: {

    &#x20;               "keys": "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"

    &#x20;         },

    &#x20;        "answer":  {

    &#x20;               "ans1": {

    &#x20;                        "value": "जजज",

    &#x20;                        "score": 1

    &#x20;                }

    &#x20;           }

    &#x20;     }

    }

    * For **MTF**
    * {

    "identifier": "template\_name",

    "title": "template\_name",

    "total\_items": 1,

    "shuffle": false,

    "max\_score": 1,

    "subject": "LIT",

    "item\_sets": \[{

    &#x20;        "id": "set\_1",

    &#x20;        "count": 1

    }],

    "items": {

    &#x20;        "set\_1": \[{

    &#x20;        "identifier": "protractor.que1",

    &#x20;        "qid": "protractor.que1",

    &#x20;        "type": "MCQ",

    &#x20;         "template\_id": "template\_name",

    &#x20;         "template": "template\_name",

    &#x20;         "title": "Question text here",

    &#x20;         "question\_audio": "",

    &#x20;         "question": "Question\_title",

    &#x20;         "model" : {

    &#x20;                   "angleRange":"0-180" // for example, and it can be anything depands on the model

    &#x20;         },

    &#x20;        "question\_image": "angle\_img",

    &#x20;       "lhs\_options": \[{

    &#x20;            "value": { "type": "mixed", "audio": "", "image": "home", "text": "" },

    &#x20;            "index": 0

    &#x20;          }, {

    &#x20;             "value": { "type": "mixed", "audio": "", "image": "home", "text": "" },

    &#x20;             "index": 1

    &#x20;         }, {

    &#x20;              "value": { "type": "mixed", "audio": "", "image": "", "text": "3" },

    &#x20;              "index": 2

    &#x20;         }, {

    &#x20;            "value": { "type": "mixed", "audio": "", "image": "", "text": "4" },

    &#x20;            "index": 3

    &#x20;        }, {

    &#x20;           "value": { "type": "mixed", "audio": "", "image": "", "text": "5" },

    &#x20;            "index": 4

    &#x20;        }, {

    &#x20;           "value": { "type": "mixed", "audio": "", "image": "", "text": "6" },

    &#x20;           "index": 5

    &#x20; }],

    "rhs\_options": \[{

    &#x20;         "value": { "type": "mixed", "audio": "", "image": "home", "text": "" },

    &#x20;          "answer": 0

    &#x20;     }, {

    &#x20;          "value": { "type": "mixed", "audio": "", "image": "", "text": "the" },

    &#x20;          "answer": 1

    &#x20;    }, {

    &#x20;         "value": { "type": "mixed", "audio": "", "image": "home", "text": "" },

    &#x20;         "answer": 2

    &#x20;   } ,{

    &#x20;         "value": { "type": "mixed", "audio": "", "image": "", "text": "the" },

    &#x20;         "answer": 3

    &#x20;   }, {

    &#x20;         "value": { "type": "mixed", "audio": "", "image": "", "text": "school" },

    &#x20;         "answer": 4

    &#x20;   }, {

    &#x20;        "value": { "type": "mixed", "audio": "", "image": "", "text": "team." },

    &#x20;       "answer": 5

    &#x20;   }],

    &#x20;  }

    }

**Steps to upload templates in Ekstep portal**

1. Go inside the template folder and create a zip of the template folder.
2. Login to [dev.ekstep.in](http://dev.ekstep.in) or [qa.ekstep.in](http://qa.ekstep.in)
3. Click on "Create new lesson" button
4. Select "Upload a file".
5. Fill all the required fields
6. Select the \*\*Content Type \*\* as "template"
7. Select the Template Type as "MCQ" or "FTB" or "MTF"
8. Enter the template name as same as template id in the ECML.
9. Upload the .zip file of the template.
10. Then save the template and send for review.
11. Once it is reviewed and published by other user your template will appear in the question bank.

**Steps to create the lesson by adding the questions**

1. Login to [dev.ekstep.in](http://dev.ekstep.in) or [qa.ekstep.in](http://qa.ekstep.in)
2. Click on "Create new lesson" button
3. Select "Create new lesson".
4. Fill all the required fields
5. Click on launch editor
6. Click on "Add question set" plugin from the core plugins bar
7. Select any questions from the list or apply filter (or) search to select the required question
8. Provide question title, Total marks and how many number of questions to be displayed, and the toggle button to show immediate feedback and the shuffle questions
9. Then click on "add Question set" will add the question set to the stage.
10. Then click on "preview to start the assessment.
11. Click on dowload icon to download it to the mobile and an email will be send to the email id.
12. Click on the button to play the lesson inside your Genie app

**Other details about templates**

[https://docs.google.com/spreadsheets/d/1fQ8ekSVjHG-QHTCffMa7K56WWIAXyGKnAWRSX7VgpdQ/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1fQ8ekSVjHG-QHTCffMa7K56WWIAXyGKnAWRSX7VgpdQ/edit?usp=sharing)

[https://docs.google.com/spreadsheets/d/1LvqQzHfhi4eNDl4LtBUJCqCfYBF71NwHYHO2Ko1B45k/edit#gid=1994775373](https://docs.google.com/spreadsheets/d/1LvqQzHfhi4eNDl4LtBUJCqCfYBF71NwHYHO2Ko1B45k/edit#gid=1994775373)

**ECML Reference**

[https://github.com/ekstep/Common-Design/wiki/ECML-Home](https://github.com/ekstep/Common-Design/wiki/ECML-Home)

[https://github.com/ekstep/Common-Design/wiki/Item-Templates-V1](https://github.com/ekstep/Common-Design/wiki/Item-Templates-V1).

### Related articles

Related articles appear here based on the labels you select. Click to edit the macro and add or change labels.

false5com.atlassian.confluence.content.render.xhtml.model.resource.identifiers.SpaceResourceIdentifier@4b0a743falsemodifiedtruepagelabel = "kb-how-to-article" and type = "page" and space = "SBDES"kb-how-to-article

true

|   |
| - |
|   |

***

\[\[category.storage-team]] \[\[category.confluence]]
