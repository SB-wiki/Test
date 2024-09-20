# QuML-Question-Spec

This document contains the QuML question spec that needs to be implemented by player and editor. This document has two sections

1. Key Attributes of question and their behaviour
2. Question session workflow that needs to be implemented by the QuML question player

### Attributes

#### body

Body contains the text, graphics, media objects and interactions that describe the question’s content and information about how it is structured. Body can be either a String or a Map, based on whether the question is created for usage in one language or multiple languages.

```json
{
  "body": "question body as string when question can be used in only one language"
}
```

```json
{
  "body": { // question body as a map when question can be used in multiple languages
    "<language>": "question body in the specified language"
  }
}
```

Body can contain following types of HTML elements:

*   Structural HTML elements like

    , ,

    * and
    *
    * Media elements like , and&#x20;
    * Input elements like text input, text area, select, options, check box, radio buttons, file upload and canvas elements

    In addition to the standard HTML elements and attributes, **body** can also contain the following:

    * Usage of “data-\*” attributes to specify the interactions on HTML elements, bind response variables to the interactions, use media and template variables.
      * In addition to “data-\*” attributes, body will also have HTML comments as placeholders for the interactions
    * Usage of standard style classes defined by the specification. QuML players should provide implementation for the defined classes.

    **“data-\*“ attributes** and HTML comments - are used for the following purposes:InteractionsA question can contain zero or more interactions with the user. Most of these interactions are typical question types (for example, multiple choice, order elements, fill in the blanks). Interactions can also be used for activities like "upload document," "draw a picture," and "start a film". Interactions can be defined in the body using HTML data attributes like **“data-\<interaction\_name>-interaction”** . Following interactions should be supported in the current version:

    * **data-choice-interaction** : For multiple choice questions which can have more than one option as the correct answer
    * **data-text-interaction** : For fill in the blank questions where user has to input a text as the response
    * **data-select-interaction** : For questions where user has to select one or more options from a list
    * **data-match-interaction:** For match the following question types where user matches the options

    ```html
    <!-- Sample usage of simple choice interaction -->
    <div data-simple-choice-interaction data-response-variable='response1' value=0 class='mcq-option'>
      <p>option 1</p>
    </div>
    <div data-simple-choice-interaction data-response-variable='response1' value=1 class='mcq-option'>
      <p>option 2</p>
    </div>
    <div data-simple-choice-interaction data-response-variable='response1' value=2 class='mcq-option'>
      <p>option 3</p>
    </div>
    <div data-simple-choice-interaction data-response-variable='response1' value=3 class='mcq-option'>
      <p>option 4</p>
    </div>

    <!-- new format -->
    <div data-choice-interaction='response1' class='mcq-horizontal'>
    </div>

    <div data-match-interaction='response1' class='mtf-horizontal'>
    </div>

    ```

    ```html
    <!-- Sample usage of text interaction -->
    <input type="text" name="element" data-text-interaction data-response-variable="response_01" /> -- old format
    <input type="text" name="element" data-text-interaction="response_01" />

    <!-- Sample usage of select interaction -->
    <select name="element" multiple data-select-interaction="response_02" >
    </select>
    ```

    QuML player should provide the implementation for all the defined interaction types. QuML player should capture the response provided by the user for the interactions within the question and bind them with the specified response variables.

    Response VariablesResponse variables are used to capture the response of a user. Each response variable declared may be bound to one & only one interaction and defined using the html data attribute:  **“data-response-variable”** .

    ```html
    <input type="text" name="element" data-text-interaction="response_01">
    ```

    In the above sample, there is response variable named “response\_01” defined on the HTML input element. When user enters a value in this text box, QuML player should set the entered value as the value for the variable “response\_01”.

    ```
    <div data-choice-interaction='responseValue' class='mcq-horizontal'>
    </div>
    ```

    In the above sample, the response variable “responseValue“ should be set to “1” when user selects this option in a MCQ question. The expected value and the scoring logic for each response variable is declared in the “responseDeclaration” section of the question.

    Asset VariablesAsset variables are used to load assets during the rendering of a question. Values for asset variables refer to an asset in the QuML repository server. Asset variables can be used in a question using the html data attribute:  **“data-asset-variable”** . This data attribute should be set on HTML elements that are used for rendering assets (e.g. img, audio and video elements). And when the question is being rendered, the location of the asset object represented by the asset variable is set as the source of the HTML element on which the asset variable is declared.

    ```html
    <img src="/assets/public/content/do_21307454512712908814986/artifact/g3c1saq8.jpg" data-asset-variable="do_21307454512712908814986">
    ```

    All the assets used in a question are declared in “media“ section of the question. This declaration is needed to package and pre-download the question assets for offline usage.

    **Style classes -** QuML specification has defined set of standard classes for various sections, elements and interactions in a question

    ```html
    <!-- sample 2-col layout question body -->
    <div class="question-body question-2-col">
    <div class="question-col">
      question text & images come here
    </div>
    <div class="question-col">
      <div data-choice-interaction='response1' class='mcq-horizontal'>
      </div>
    </div>
    </div>

    <!-- sample 1-col layout question body -->
    <div class="question-body">
    <div>
      question text & images come here
    </div>
    <div data-choice-interaction='response1' class='mcq-horizontal'>
    </div>
    </div>

    ```

    * question body styles
      * question-body: for overall question body
      * 2-col-layout: for questions rendered in two columns. e.g: 2-col MCQ questions where question body is in one column and options are presented in the second column
      * question-column: for defining columns in questions with 2-col-layout
    * image styles
      * img-small: use 25% of the available width and scales the image accordingly. 50% or 100% width may also be used for these images when available width is below certain specified values.
      * img-medium: use 50% of the available width and scales the image accordingly. 100% width may also be used for these images when available width is below certain specified values.
      * img-large: always use 100% of the available width
      * img-align-left
      * img-align-right
    * MCQ options styles
      * mcq-options-vertical: always show options vertically
      * mcq-options-grid: show options in a grid. if available width is small, fall back to vertical layout.
      * mcq-options-horizontal: show options horizontally. if the available width is small, fall back to grid or vertical layout.
    * Input text styles: these classes should be used for text interaction elements.
      * text-small:
      * text-medium:
      * text-large:
    * Drop down styles: these classes should be used for single & multi select interaction elements.
      * drop-down:

    ```html
    <!-- Sample question body with multiple interactions and style classes -->
    <div class="question-body 1-col-layout">
    <p>Question text</p>
    <figure class="img-medium img-align-right"><img src="/assets/public/content/do_213033060302831616192/artifact/803020004_1590949744419.jpg" data-asset-variable="do_213033060302831616192"></figure>
    <p>Some more text</p>
    <div>
    An inline text interaction <input type="text" name="element" data-text-interaction="response_01" class="text-small"/>
    </div>
    <div data-simple-choice-interaction='responseValue' class="mcq-options-horizontal">
    </div>
    </div>
    ```

    #### solutions

    Providing exemplar answers for questions aid candidates in-depth learning and enhance user’s understanding of the concepts. Multiple solutions can be configured for a question.

    ```json
    {
      "solutions": [
        "solution in HTML format",
        "a question can have more than one solution. in such cases, another solution in HTML format"
      ]
    }
    ```

    Similar to body, solutions in multiple languages can be specified:

    ```json
    {
      "solutions": {
        "<language>": ["list of solutions in the specified language"]
      }
    }
    ```

    Solutions HTML must contain only structural and media HTML elements. There should be interactions in a solution and hence no input HTML elements. QuML players should allow the users to view the solutions if the context in which the question is being used allows the users to view the solution.

    #### instructions

    Instructions on how to understand, attempt or how the question will be evaluated.

    ```json
    {
      "instructions": {
        "instructions in HTML format"
      }
    }
    ```

    Similar to body, instructions in multiple languages can be specified:

    ```json
    {
      "instructions": {
        "<language>": "instructions in the specified language"
      }
    }
    ```

    Instructions HTML also must contain only structural and media HTML elements. There should be interactions in a solution and hence no input HTML elements.

    #### hints

    ```json
    {
      "hints": [
        "hints in HTML format",
        "a question can have more than one hint"
      ]
    }
    ```

    Similar to body, hints in multiple languages can be specified:

    ```json
    {
      "hints": {
        "<language>": ["hints in the specified language"],
        "<language>": ["hints in the specified language"]
      }
    }
    ```

    #### media

    **“media”**  attribute contains information about the assets used in the question. It should have declaration for every asset used in the question across body, feedback, instructions, hints and solutions.

    ```json
    {
      "media": [
        {
          "id": "unique id of the asset, e.g.: do_21307455384335974414989",
          "baseUrl": "base url of the asset repository, e.g: https://dev.sunbirded.org",
          "src": "relative path of the asset, e.g: /assets/public/content/do_21307455384335974414989/artifact/g3c2vt1q6_1.jpg",
          "type": "type of the asset - image, audio or video"
        }
      ]
    }
    ```

    QuML players should use absolute path (baaseUrl + src) of the asset during online usage of the question and in case of offline usage, the asset should be pre-downloaded to the device/system where the question is being used.

    #### interactionTypes

    List of interactions present in the question body. This list can be null if there are no interactions in the question.

    ```json
    {
      "interactionTypes": [“choice”, “text”, “select”, "date", "file-upload", "canvas"]
    }
    ```

    #### interactions

    ```
    {
      "interactions": {
        "<response_variable_01>": { // one declaration for each response variable
            "type": "data type of the response variable - one of choice, text, select"
            "options": [ // if type is "choice" or "select"
              {
                "label": "option 1 HTML body",
                "value": 0
              },
              {
                "label": "option 2 HTML body",
                "value": 1
              },
              ...
            ],
            “validations”: { // optional validations can be provided for the response variable
              "range": { // range will have min/max or an enum
                "max": "<allowed_max_value>", 
                "min": "<allowed_min_value>",
                "enum": ["array of values"]
              },
              "limits": {
                "maxlength": "<max_length_of_the_response>",
                "minlength": "<min_length_of_the_response>"
              },
              "pattern": "<regex_pattern_to_validate_the_format>"
            }
        }
      }
    }

    // interactions for MTF type will be like below

    {
      "Interactions": {
        "<response_variable_01>": {
          "type": "match",
          "optionsSet": {
            "left": [ // left side of the options to display and should be shiffled while rendering
              {
                "label": "The option HTML body", //can be "Apple"
                "value": "<value>" // Can be any type example: "apple"
              },
              {
                "label": "The option HTML body",
                "value": "<value>"
              }
            ],
            "right": [ // right side of the options to display
              {
                "label": "The option HTML body",
                "value": "<value>"
              },
              {
                "label": "Yellow",
                "value": "<value>"
              }
            ]
          }
        }
      }
    }

    ```

    #### responseDeclaration

    A  **“responseDeclaration”**  contains information about the response to a question: When is it correct, and (optionally) how is it scored?

    Response Declaration should have declaration for every response variable in the question body. Optionally, the declaration can have the following details:

    * _Correct Response:_  Correct (or optimal) values for the response variable
    * _Mapping to Score:_  Map different values to score so that a response can have more nuances than plain right or wrong, e.g.: a multiple choice question with more than one correct answer can support partial scoring
    * _Hints_ : hints to be shown for this response variable. Hints are shown only if they are allowed in the context where the question is being used.

    ```json
    {
      "responseDeclaration": {
        "<response_variable_01>": { // one declaration for each response variable
            "type": "data type of the response variable - one of string, integer, float, boolean"
            "cardinality": "single, multiple, or ordered", 
            "correctResponse": {
              "value": "<expected response value>",
              "caseSensitive": "true/false", // default is false
              "outcomes": {
                  "SCORE": "<score_value>" // set the SCORE to the specified value. default to maxScore/<number of response variables>
              }
            },
            "mapping": [ // configure SCORE for different responses
              {
                "response": "<expected response value>", // if user provides this response
                "outcomes": {
                  "SCORE": "<score_value>" // set the SCORE to the specified value
                }
                "caseSensitive": "true/false" // if response value check should be case sensitive or not
              }
            ] 
        }
      }
    }

    // MTF response declaration 

    {
      "responseDeclaration": {
        "<response_variable_01>": {
        "response_1": {
          "type": "data type of the response variable - one of string, integer, float, boolean",
          "cardinality": "multiple",
          "correctResponse": {
            "value": {
              "<left side option value>": "<matching right side option value>", //  Example: "apple": "red",
              "<left side option value>": "<matching right side option value>", //  This below outcome score is given if the values are matched otherwise check with mappings
            },
            "outcomes": {
              "SCORE": "<score_value>"
            }
          },
          "mapping": [
            {
              "response": {
                "value": {
                 "<left side option value>": "<matching right side option value>", //  Example: "apple": "red"
                }
              },
              "outcomes": {
                "SCORE": "1"
              }
            }
          ]
        }
      }
    }
    ```

    Examples:

    ```
    {
      "responseDeclaration1": { // question with two fill-in-the-blanks, each having different scores
        "maxScore": 1,
        "response1": {
          "type": "integer",
          "cardinality": "single",
          "correctResponse": {
            "value": 4,
            "outcomes": {"SCORE": 0.75} // score of 0.75 for correct response to the first blank
          }
        },
        "response2": {
          "type": "integer",
          "cardinality": "single",
          "correctResponse": {
            "value": 2,
            "outcomes": {"SCORE": 0.25} // score of 0.25 for correct response to the first blank
          }
        }
      },
      "responseDeclaration2": { // question with one fill-in-the-blank. 
        "maxScore": 1,
        "response1": {
          "type": "string",
          "cardinality": "single",
          "correctResponse": {
            "value": "New Delhi",
            "outcomes": { "SCORE": 1 } // score of 1 for correct response
          },
          "mapping": [
            {
              "response": "Delhi",
              "outcomes": { "SCORE": 0.5 } // partial score of 0.5 for a relevant response
            }
          ]
        }
      },
      "responseDeclaration3": { // question with a multi-select dropdown. 
        "maxScore": 1,
        "response1": {
          "type": "string",
          "cardinality": "multiple",
          "correctResponse": {
            "value": [ "New Delhi", "Chennai" ],
            "outcomes": { "SCORE": 1 } // score of 1 for correct response, i.e when both the correct answers are selected
          },
          "mapping": [
            {
              "response": ["New Delhi"],
              "outcomes": {"SCORE": 0.5} // partial score of 0.5 for selecting one correct option
            },
            {
              "response": ["Chennai"],
              "outcomes": {"SCORE": 0.5} // partial score of 0.5 for selecting other correct option
            }
          ]
        }
      },
      "responseDeclaration4": { // question with two fill-in-the-blanks, both having same scores
        "maxScore": 1,
        "response1": {
          "type": "integer",
          "cardinality": "single",
          "correctResponse": {
            "value": 4,
            "outcomes": {"SCORE": 0.5} // score of 0.5 for correct response to the first blank
          }
        },
        "response2": {
          "type": "integer",
          "cardinality": "single",
          "correctResponse": {
            "value": 2,
            "outcomes": {"SCORE": 0.5} // score of 0.5 for correct response to the second blank
          }
        }
      },
      "responseDeclaration5": { // question with a simple MCQ
        "maxScore": 1,
        "response1": {
          "type": "integer",
          "cardinality": "single",
          "correctResponse": {
            "value": 1,
            "outcomes": {"SCORE": 1} // score of 1 for correct option
          }
        }
      },
      "responseDeclaration6": { // question with a MMCQ
        "maxScore": 1,
        "response1": {
          "type": "integer",
          "cardinality": "multiple",
          "correctResponse": {
            "value": [2, 3],
            "outcomes": {"SCORE": 1} // score of 1 for selecting both the correct options
          },
          "mapping": [
            {
              "response": [2],
              "outcomes": {"SCORE": 0.5} // partial score of 0.5 for selecting option 2
            },
            {
              "response": [3],
              "outcomes": {"SCORE": 0.5} // partial score of 0.5 for selecting option 3
            },
            {
              "response": [3, 4],
              "outcomes": {"SCORE": 0.5} // partial score of 0.5 for selecting options 3 & 4
            }
          ]
        }
      }
      "responseDeclaration7": { // MTF
        "response_1": {
          "type": "integer",
          "cardinality": "multiple",
          "correctResponse": {
            "value": {
              "apple": "red",
              "1": "3"
            },
            "outcomes": {
              "SCORE": "<score_value>"
            }
          },
          "mapping": [
            {
              "response": {
                "value": {
                  "apple": "red",
                  "1": "3"
                }
              },
              "outcomes": {
                "SCORE": "1"
              }
            }
          ]
        }
      }
    }


    ```

    #### scoringMode

    Scoring mode of the question:

    * system: evaluated and score is generated by the platform (e.g. within the player using the response declaration info).
    * none: question has no evaluation and score is never generated for such questions.

    ```json
    {
      "scoringMode": "one of system, none"
    }
    ```

    #### maxScore

    Maximum score for the question. Default value will be 1. Creator can update to a higher value. Score for each response mapping should not be greater than this.

    ```
    {
      "maxScore": "integer value" 
    }
    ```

    #### timeLimit

    Hard time limit for the question - in seconds. User has to provide response within this time limit.

    ```
    {
      "timeLimit": "integer value" 
    }
    ```

    #### timer

    Show or hide timer when playing this question.

    ```
    {
      "showTimer": "true or false"
    }
    ```

    #### editorState

    Used by editors to store question data in a format compatible to the editor.

    ```json
    {
      "editorState": "<JSON_object>"
    }
    ```

    #### qumlVersion

    Version of the QuML used to create the question.

    ```json
    {
      "qumlVersion": "1.1"
    }
    ```

    #### showFeedback

    Display feedback if this flag is set to true

    ```json
    {
      "showFeedback": "true or false"
    }
    ```

    #### showSolutions

    Allow users to view solution if this flag is set to true

    ```json
    {
      "showSolutions": "true or false"
    }
    ```

    ### Question Session

    A QuML question comprises of multiple components with a well-defined structure. Each component of the question comes into play at different states of a question session. QuML implementations (players) should use these components and perform the required action in-between state transitions. Below are the different states in a question play session:

    * **start** - start of the question play
    * **interacting** - when user is interacting with the question and providing his/her responses. and optionally, may be viewing hints also.
    * **feedback** - feedback is rendered to the users based on their responses
    * **solution** - user is viewing the solutions for the question, if solutions are available for the question and the question playing context allows users to view the solution
    * **review** - user is reviewing the responses provided, if the question playing context allows users to review their responses
    * **finished** - response processing is complete and outcomes (SCORE, duration, FEEDBACK to be shown) are computed by the player

    #### State Transitions

    QuML players should do certain actions while transitioning from one state to another:

    **start → interacting:** QuML player should load assets, render instructions & body (in the user’s language if multiple languages are supported by the question) and apply the stylesheet.

    **interacting → interacting:** should capture user responses, set values for response variables and show hints (if applicable).

    **interacting → solution:** should render the solutions of the question. question will move into this state by explicit action from user to view the solution.

    **interacting → finished:** should process responses using responseDeclaration and set outcomes (like SCORE, FEEDBACK). And also generate the required telemetry events.

    **finished → feedback:** should render the feedback. question will move into this state automatically if “showFeedback” is set true.

    **finished → review:** should render the question body with user responses.

    #### Outcome Variables

    Every question session should compute and set values for certain outcome variables at the end of a question sessions. These outcome variables are used for multiple purposes:

    * display feedback
    * generate telemetry events
    * used by QuestionSet player to compute the overall question set score (or other outcome variables), if this question is being rendered as part of a question set.

    Following are the outcome variables that should be set by the QuML players:

    * **SCORE** : score attained by the user. It should be a **float** value.
    * **numAttempts** : an integer that records the number of attempts of each question the user has taken (if multiple attempts are allowed in the context where the question is being used). The value defaults to 0 initially and then increases by 1 at the start of each attempt.
    * **duration** : a float that records the accumulated time (in seconds) in an attempt. In other words, the time between the beginning and the end of the question session minus any time the session was in the suspended state ( _TBD: what should be set as duration in case of multiple attempts_ ).
    * **completionStatus** : completion status of the question. one of complete, incomplete, skipped or unknown.

    ***

    \[\[category.storage-team]] \[\[category.confluence]]
