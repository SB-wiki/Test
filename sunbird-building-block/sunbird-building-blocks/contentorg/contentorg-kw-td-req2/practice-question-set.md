


* Is Primary Category? Yes


* displayLabel: Practice Question Set


* objectType: QuestionSet


* trackable: false


* mimeType: \[QuML, ECML]


* Attributes that can be defined by user when creating the object:


    * K-12 Framework: Board, Medium, Grade, Subject, Topics, Learning Outcomes - No default, Not Mandatory


    * Name: No default, Mandatory


    * Description: No default, Not Mandatory 


    * Author: Defaulted to creator name (user can change), Mandatory


    * Copyright: Defaulted to Tenant Name (user can change), Mandatory


    * Attributions: No default, , Not Mandatory


    * Licence: Defaulted to default license of the tenant (user can change), Mandatory


    * Keywords: No default, Not Mandatory---


    * Audience Type: Defaulted to Student, Teacher (user can change), Mandatory 


    * Additional Categories: No default, Not Mandatory


    * ShowFeedback: Defaulted to true (editable), Mandatory


    * ShowSolutions: Defaulted to true (editable), Mandatory


    * allowRetry: Defaulted to true (editable), Mandatory


    * shuffle: Defaulted to false (editable), Mandatory


    * MaxScore: Defaulted to sum of marks of associated questions (editable), Mandatory


    * MaxQuestions: Defaulted to total number of questions in the question set (editable), Mandatory


    * instructions:  No default, Not Mandatory 


    * visibility:  No default, Not Mandatory 


    * scoringMode: \[system, offline, external, none] Default: system (editable)


    * releaseCriteria: \[none, date, content played] Default: none (editable)


    * maxTime: Time limit to play the question set


    * maxAttempts: Maximum number of attempts allowed


    * RequiresSubmit: Default: false (editable)


    * ContainsUserData: false for Practice Question Set, hidden, non-editable


    * 



    

Mapping of current Content Type: PracticeQuestionSet, PracticeResource, CuriosityQuestionSet - These can go into Additional Categories


# Practice Question Set \[Question Set object, QuML spec]

## Practice Question Set (3.9)

```
{
  "objectMetadata": {
    "config": {
      "sourcingSettings": {
        "collection": {
          "objectType": "QuestionSet",
          "primaryCategory": "Practice Question Set",
          "maxDepth": 0,
          "isRoot": true,
          "iconClass": "",
          "children": {
            "Question": []
          },
          "hierarchy": {}
        }
      }
    },
    "schema": {
      "properties": {
        "mimeType": {
          "type": "string",
          "enum": [
            "application/vnd.sunbird.questionset"
          ]
        }
      }
    }
  },
  "languageCode": [],
  "forms": {
    "create": {
      "templateName": "",
      "required": [],
      "properties": [
        {
          "name": "Basic details",
          "fields": [
            {
              "code": "instructions",
              "dataType": "text",
              "description": "Instructions for the question set",
              "editable": true,
              "inputType": "richtext",
              "label": "Instructions",
              "name": "Instruction",
              "placeholder": "Enter Instructions",
              "renderingHints": {
                "class": "sb-g-col-lg-2 required"
              },
              "validations": [
                {
                  "type": "maxLength",
                  "value": "500",
                  "message": "Input is Exceeded"
                },
                {
                  "type": "required",
                  "message": "Instruction is required"
                }
              ],
              "required": true,
              "visible": true
            },
            {
              "code": "appIcon",
              "name": "Icon",
              "label": "Icon",
              "placeholder": "Icon",
              "description": "Icon for the question set",
              "dataType": "text",
              "inputType": "appIcon",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              }
            },
            {
              "code": "name",
              "name": "Name",
              "label": "Name",
              "placeholder": "Enter Name",
              "description": "Name of the Question Set",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "maxLength",
                  "value": "120",
                  "message": "Entered name is too long"
                },
                {
                  "type": "required",
                  "message": "Name is required"
                }
              ]
            },
            {
              "code": "description",
              "name": "Description",
              "label": "Description",
              "placeholder": "Enter Description",
              "description": "Description of the Question Set",
              "dataType": "text",
              "inputType": "textarea",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Description is required"
                }
              ]
            },
            {
              "code": "keywords",
              "name": "Keywords",
              "label": "Keywords",
              "placeholder": "Enter Keywords",
              "description": "Keywords help search easily",
              "dataType": "list",
              "inputType": "keywords",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              },
              "validations": []
            },
            {
              "code": "instruction",
              "name": "Instruction",
              "label": "Instruction",
              "placeholder": "Enter Instructions",
              "description": "Instructions for the question set",
              "dataType": "",
              "inputType": "",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-2"
              },
              "validations": []
            },
            {
              "code": "primaryCategory",
              "name": "Type",
              "label": "Type",
              "placeholder": "",
              "description": "Type or Category of the Question Set",
              "dataType": "text",
              "inputType": "text",
              "editable": false,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              }
            },
            {
              "code": "additionalCategories",
              "name": "Additional Category",
              "label": "Additional Category",
              "placeholder": "Select Additional Category",
              "description": "Additonal Category of the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "nestedselect",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            }
          ]
        },
        {
          "name": "",
          "fields": [
            {
              "code": "board",
              "name": "Board/Syllabus",
              "label": "Board/Syllabus",
              "placeholder": "Select Board/Syllabus",
              "description": "Board or Syallbus of the Question Set",
              "default": "",
              "dataType": "text",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Board is required"
                }
              ]
            },
            {
              "code": "medium",
              "name": "Medium",
              "label": "Medium",
              "placeholder": "Select Medium",
              "description": "Medium of Instruction for the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [
                "board"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Medium is required"
                }
              ]
            },
            {
              "code": "gradeLevel",
              "name": "Class",
              "label": "Class",
              "placeholder": "Select Class",
              "description": "Class of the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [
                "board",
                "medium"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Class is required"
                }
              ]
            },
            {
              "code": "subject",
              "name": "Subject",
              "label": "Subject",
              "placeholder": "Select Subject",
              "description": "Subject of the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [
                "board",
                "medium",
                "gradeLevel"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Subject is required"
                }
              ]
            },
            {
              "code": "topic",
              "name": "Topics",
              "label": "Topics",
              "placeholder": "Choose Topics",
              "description": "Choose Topics covered in the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "topicselector",
              "editable": true,
              "required": false,
              "visible": true,
              "depends": [
                "board",
                "medium",
                "gradeLevel",
                "subject"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "audience",
              "name": "Audience",
              "label": "Audience",
              "placeholder": "Select Audience",
              "description": "Audience of the Question Set",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "range": [
                "Student",
                "Teacher",
                "Administrator"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Audience is required"
                }
              ]
            }
          ]
        },
        {
          "name": "Question set behaviour",
          "fields": [
            {
              "code": "shuffle",
              "name": "Shuffle Questions",
              "label": "Shuffle Questions",
              "placeholder": "Shuffle Questions",
              "description": "Questions will be Shuffled while playing",
              "default": "false",
              "dataType": "boolean",
              "inputType": "checkbox",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "maxQuestions",
              "name": "Show Questions",
              "label": "Show Questions",
              "placeholder": "Number of questions to be shown",
              "description": "Number of questions to be shown",
              "default": "",
              "dataType": "number",
              "inputType": "select",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "showFeedback",
              "name": "Show Feedback",
              "label": "Show Feedback",
              "placeholder": "Show Correct/Incorrect Feedback",
              "description": "Show Correct/Incorrect Feedback",
              "default": "Yes",
              "dataType": "text",
              "inputType": "checkbox",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "showSolutions",
              "name": "Show Solution",
              "label": "Show Solution",
              "placeholder": "Show Solution",
              "description": "Show Solution",
              "default": "Yes",
              "dataType": "text",
              "inputType": "checkbox",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "maxTime",
              "name": "Maximum Time",
              "label": "Maximum time",
              "placeholder": "hh:mm:ss",
              "description": "Maximum Time for the question set",
              "default": "300",
              "dataType": "text",
              "inputType": "timer",
              "editable": true,
              "visible": true,
              "required": false,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              },
              "validations": [
                {
                  "type": "time",
                  "message": "Please enter in hh:mm:ss",
                  "value": "HH:mm:ss"
                },
                {
                  "type": "maxLength",
                  "value": "05:59:59",
                  "message": "Maximum time should be less than 05:59:59"
                }
              ]
            },
            {
              "code": "warningTime",
              "name": "Warning Time",
              "label": "Warning Time",
              "placeholder": "hh:mm:ss",
              "description": "Warning time for the question set",
              "dataType": "list",
              "inputType": "timer",
              "editable": true,
              "required": false,
              "visible": true,
              "depends": [
                "maxTime"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              },
              "validations": [
                {
                  "type": "time",
                  "message": "Please enter hh:mm:ss",
                  "value": "HH:mm:ss"
                },
                {
                  "type": "compare",
                  "criteria": {
                    "<=": [
                      "maxTime"
                    ]
                  },
                  "message": "Warning time should be less than Max time"
                }
              ]
            }
          ]
        },
        {
          "name": "Ownership & Legal",
          "fields": [
            {
              "code": "author",
              "name": "Author",
              "label": "Author",
              "placeholder": "Enter Author",
              "description": "Author of the question set",
              "default": "",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Author is required"
                }
              ]
            },
            {
              "code": "attributions",
              "name": "Attributions",
              "label": "Attributions",
              "placeholder": "Enter Attributions",
              "description": "Attributions of the question set",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "copyright",
              "name": "Copyright",
              "label": "Copyright",
              "placeholder": "Copyright",
              "description": "Copyright",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Copyright is required"
                }
              ]
            },
            {
              "code": "copyrightYear",
              "name": "Copyright Year",
              "label": "Copyright Year",
              "placeholder": "Copyright Year",
              "description": "Year of the Copyright",
              "dataType": "number",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Copyright Year is required"
                }
              ]
            },
            {
              "code": "license",
              "name": "License",
              "label": "License",
              "placeholder": "Select license",
              "description": "License",
              "defaultValue": "CC BY 4.0",
              "dataType": "text",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "range": "",
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              }
            }
          ]
        }
      ]
    },
    "childMetadata": {
      "templateName": "",
      "required": [],
      "properties": [
        {
          "code": "name",
          "name": "Name",
          "label": "Name",
          "placeholder": "Name of the Question. E.g. Practice MCQ",
          "description": "Name helps you find it easily",
          "default": "",
          "dataType": "text",
          "inputType": "text",
          "editable": true,
          "required": true,
          "visible": true,
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "maxLength",
              "value": "100",
              "message": "Entered Name is too long"
            },
            {
              "type": "required",
              "message": "Name is required"
            }
          ]
        },
        {
          "code": "bloomsLevel",
          "name": "Learning level",
          "label": "Learning level",
          "placeholder": "Select Learning level",
          "description": "Learning level of the question",
          "dataType": "text",
          "inputType": "select",
          "editable": true,
          "required": false,
          "visible": true,
          "range": [
            "remember",
            "understand",
            "apply",
            "analyse",
            "evaluate",
            "create"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1"
          },
          "validations": []
        },
        {
          "code": "board",
          "name": "Board/Syllabus",
          "label": "Board/Syllabus",
          "placeholder": "Select Board/Syllabus",
          "description": "Board or Syallbus of the Question Set",
          "default": "",
          "dataType": "text",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Board is required"
            }
          ]
        },
        {
          "code": "medium",
          "name": "Medium",
          "label": "Medium",
          "placeholder": "Select Medium",
          "description": "Medium of Instruction for the Question Set",
          "default": "",
          "dataType": "list",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [
            "board"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Medium is required"
            }
          ]
        },
        {
          "code": "gradeLevel",
          "name": "Class",
          "label": "Class",
          "placeholder": "Select Class",
          "description": "Class of the Question Set",
          "default": "",
          "dataType": "list",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [
            "board",
            "medium"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Class is required"
            }
          ]
        },
        {
          "code": "subject",
          "name": "Subject",
          "label": "Subject",
          "placeholder": "Select Subject",
          "description": "Subject of the Question Set",
          "default": "",
          "dataType": "list",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [
            "board",
            "medium",
            "gradeLevel"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Subject is required"
            }
          ]
        }
      ]
    }
  }
}
```



## All supported configurations after 3.9 (for reference)
Question Set with Unit
```
{
  "objectMetadata": {
    "config": {
      "sourcingSettings": {
        "collection": {
          "objectType": "QuestionSet",
          "primaryCategory": "Practice Question Set",
          "maxDepth": 0,
          "isRoot": true,
          "iconClass": "",
          "children": {
            "Question": []
          },
          "hierarchy": {}
        }
      }
    },
    "schema": {
      "properties": {
        "mimeType": {
          "type": "string",
          "enum": [
            "application/vnd.sunbird.questionset"
          ]
        }
      }
    }
  },
  "languageCode": [],
  "forms": {
    "create": {
      "templateName": "",
      "required": [],
      "properties": [
        {
          "name": "Basic details",
          "fields": [
            {
              "code": "appIcon",
              "name": "Icon",
              "label": "Icon",
              "placeholder": "Icon",
              "description": "Icon for the question set",
              "dataType": "text",
              "inputType": "appIcon",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              }
            },        
            {
              "code": "name",
              "name": "Name",
              "label": "Name",
              "placeholder": "Enter Name",
              "description": "Name of the Question Set",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "max",
                  "value": "120",
                  "message": "Entered name is too long"
                },
                {
                  "type": "required",
                  "message": "Name is required"
                }
              ]
            },
            {
              "code": "description",
              "name": "Description",
              "label": "Description",
              "placeholder": "Enter Description",
              "description": "Description of the Question Set",
              "dataType": "text",
              "inputType": "textarea",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Description is required"
                }
              ]
            },
            {
              "code": "keywords",
              "name": "Keywords",
              "label": "Keywords",
              "placeholder": "Enter Keywords",
              "description": "Keywords help search easily",
              "dataType": "list",
              "inputType": "keywords",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              },
              "validations": []
            },
            {
              "code": "instruction",
              "name": "Instruction",
              "label": "Instruction",
              "placeholder": "Enter Instructions",
              "description": "Instructions for the question set",
              "dataType": "",
              "inputType": "",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-2"
              },
              "validations": []
            },
            {
              "code": "primaryCategory",
              "name": "Type",
              "label": "Type",
              "placeholder": "",
              "description": "Type or Category of the Question Set",
              "dataType": "text",
              "inputType": "text",
              "editable": false,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              }
            },
            {
              "code": "additionalCategories",
              "name": "Additional Category",
              "label": "Additional Category",
              "placeholder": "Select Additional Category",
              "description": "Additonal Category of the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "nestedselect",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            }
          ]
        },
        {
          "name": "",
          "fields": [
            {
              "code": "board",
              "name": "Board/Syllabus",
              "label": "Board/Syllabus",
              "placeholder": "Select Board/Syllabus",
              "description": "Board or Syallbus of the Question Set",
              "default": "",
              "dataType": "text",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Board is required"
                }
              ]
            },
            {
              "code": "medium",
              "name": "Medium",
              "label": "Medium",
              "placeholder": "Select Medium",
              "description": "Medium of Instruction for the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [
                "board"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Medium is required"
                }
              ]
            },
            {
              "code": "gradeLevel",
              "name": "Class",
              "label": "Class",
              "placeholder": "Select Class",
              "description": "Class of the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [
                "board",
                "medium"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Class is required"
                }
              ]
            },
            {
              "code": "subject",
              "name": "Subject",
              "label": "Subject",
              "placeholder": "Select Subject",
              "description": "Subject of the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "depends": [
                "board",
                "medium",
                "gradeLevel"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Subject is required"
                }
              ]
            },
            {
              "code": "topic",
              "name": "Topics",
              "label": "Topics",
              "placeholder": "Choose Topics",
              "description": "Choose Topics covered in the Question Set",
              "default": "",
              "dataType": "list",
              "inputType": "topicselector",
              "editable": true,
              "required": false,
              "visible": true,
              "depends": [
                "board",
                "medium",
                "gradeLevel",
                "subject"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "audience",
              "name": "Audience",
              "label": "Audience",
              "placeholder": "Select Audience",
              "description": "Audience of the Question Set",
              "dataType": "list",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "range": [
                "Student",
                "Teacher",
                "Administrator"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Audience is required"
                }
              ]
            }
          ]
        },
        {
          "name": "Question set behaviour",
          "fields": [
            {
              "code": "shuffle",
              "name": "Shuffle Questions",
              "label": "Shuffle Questions",
              "placeholder": "Shuffle Questions",
              "description": "Questions will be Shuffled while playing",
              "default": "false",
              "dataType": "boolean",
              "inputType": "checkbox",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "maxQuestions",
              "name": "Show Questions",
              "label": "Show Questions",
              "placeholder": "Number of questions to be shown",
              "description": "Number of questions to be shown",
              "default":"",
              "dataType": "number",
              "inputType": "select",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "showFeedback",
              "name": "Show Feedback",
              "label": "Show Feedback",
              "placeholder": "Show Correct/Incorrect Feedback",
              "description": "Show Correct/Incorrect Feedback",
              "default": "true",
              "dataType": "text",
              "inputType": "checkbox",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "showSolutions",
              "name": "Show Solution",
              "label": "Show Solution",
              "placeholder": "Show Solution",
              "description": "Show Solution",
              "default":"true",
              "dataType": "text",
              "inputType": "checkbox",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "requiresSubmit",
              "name": "Submit Confirmation",
              "label": "Submit Confirmation",
              "placeholder": "Submit Confirmation required",
              "description": "Submit Confirmation required to complete the question set",
              "default":"No",
              "dataType": "text",
              "inputType": "checkbox",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "maxTime",
              "name": "Maximum Time",
              "label": "Maximum time",
              "placeholder": "hh:mm:ss",
              "description": "Maximum Time for the question set",
              "default": "300",
              "dataType": "text",
              "inputType": "timer",
              "editable": true,
              "visible": true,
              "required": false,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              },
              "validations": [
                {
                  "type": "time",
                  "message": "Please enter in hh:mm:ss",
                  "value": "HH:mm:ss"
                },
                {
                  "type": "max",
                  "value": "05:59:59",
                  "message": "Maximum time should be less than 05:59:59"
                }
              ]
            },
            {
              "code": "warningTime",
              "name": "Warning Time",
              "label": "Warning Time",
              "placeholder": "hh:mm:ss",
              "description": "Warning time for the question set",
              "dataType": "list",
              "inputType": "timer",
              "editable": true,
              "required": false,
              "visible": true,
              "depends": [
                "maxTime"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              },
              "validations": [
                {
                  "type": "time",
                  "message": "Please enter hh:mm:ss",
                  "value": "HH:mm:ss"
                },
                {
                  "type": "compare",
                  "criteria": {
                    "<=": [
                      "maxTime"
                    ]
                  },
                  "message": "Warning time should be less than Max time"
                }
              ]
            },
            {
              "code": "maxAttempts",
              "name": "Maximum Attempts",
              "label": "Maximum Attempts",
              "placeholder": "Maximum number of attempts",
              "description": "Maximum number of attempts",
              "dataType": "number",
              "inputType": "select",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              },
              "range": [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25
              ]
            },
            {
              "code": "showTimer",
              "name": "Show Timer",
              "label": "Show Timer",
              "placeholder": "Show Timer",
              "description": "Show Timer",
              "default": "No",
              "dataType": "text",
              "inputType": "checkbox",
              "editable": false,
              "required": false,
              "visible": false,
              "depends": [
                "maxTime"
              ],
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            }
          ]
        },
        {
          "name":"Ownership & Legal",
          "fields":[
            {
              "code": "author",
              "name": "Author",
              "label": "Author",
              "placeholder": "Enter Author",
              "description": "Author of the question set",
              "default":"",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Author is required"
                }
              ]
            },
            {
              "code": "attributions",
              "name": "Attributions",
              "label": "Attributions",
              "placeholder": "Enter Attributions",
              "description": "Attributions of the question set",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": false,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1"
              }
            },
            {
              "code": "copyright",
              "name": "Copyright",
              "label": "Copyright",
              "placeholder": "Copyright",
              "description": "Copyright",
              "dataType": "text",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Copyright is required"
                }
              ]
            },
            {
              "code": "copyrightYear",
              "name": "Copyright Year",
              "label": "Copyright Year",
              "placeholder": "Copyright Year",
              "description": "Year of the Copyright",
              "dataType": "number",
              "inputType": "text",
              "editable": true,
              "required": true,
              "visible": true,
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              },
              "validations": [
                {
                  "type": "required",
                  "message": "Copyright Year is required"
                }
              ]
            },
            {
              "code": "license",
              "name": "License",
              "label": "License",
              "placeholder": "Select license",
              "description": "License",
              "defaultValue": "CC BY 4.0",
              "dataType": "text",
              "inputType": "select",
              "editable": true,
              "required": true,
              "visible": true,
              "range": "",
              "renderingHints": {
                "class": "sb-g-col-lg-1 required"
              }
            }
          ]
        }
      ]
    },
    "unitMetadata": {
      "templateName": "",
      "required": [],
      "properties": [
        {
          "code": "name",
          "dataType": "text",
          "description": "Name of the content",
          "editable": true,
          "inputType": "text",
          "label": "Title",
          "name": "Title",
          "placeholder": "Title",
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "required": true,
          "visible": true,
          "validations": [
            {
              "type": "max",
              "value": "120",
              "message": "Input is Exceeded"
            },
            {
              "type": "required",
              "message": "Title is required"
            }
          ]
        },
        {
          "code": "description",
          "dataType": "text",
          "description": "Description of the content",
          "editable": true,
          "inputType": "textarea",
          "label": "Description",
          "name": "Description",
          "placeholder": "Description",
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "required": true,
          "visible": true,
          "validations": [
            {
              "type": "max",
              "value": "500",
              "message": "Input is Exceeded"
            }
          ]
        },
        {
          "code": "keywords",
          "visible": true,
          "editable": true,
          "dataType": "list",
          "name": "Keywords",
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "description": "Keywords for the content",
          "inputType": "keywords",
          "label": "keywords",
          "placeholder": "Enter Keywords",
          "required": false,
          "validations": [
            {
              "type": "required",
              "message": "Keyword is required"
            }
          ]
        },
        {
          "code": "topic",
          "visible": true,
          "depends": [],
          "editable": true,
          "dataType": "list",
          "renderingHints": {},
          "name": "Topic",
          "description": "Choose a Topics",
          "inputType": "topicselector",
          "label": "Topics",
          "placeholder": "Choose Topics",
          "required": false
        }
      ]
    },
    "childMetadata": {
      "templateName": "",
      "required": [],
      "properties": [
        {
          "code": "name",
          "name": "Name",
          "label": "Name",
          "placeholder": "Name of the Question. E.g. Practice MCQ",
          "description": "Name helps you find it easily",
          "default":"", 
          "dataType": "text",
          "inputType": "text",
          "editable": true,
          "required": true,
          "visible": true,
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "max",
              "value": "100",
              "message": "Entered Name is too long"
            },
            {
              "type": "required",
              "message": "Name is required"
            }
          ]
        },
        {
          "code": "bloomsLevel",
          "name": "Learning level",
          "label": "Learning level",
          "placeholder": "Select Learning level",
          "description": "Learning level of the question",
          "dataType": "text",
          "inputType": "select",
          "editable": true,
          "required": false,
          "visible": true,
          "range": [
            "remember",
            "understand",
            "apply",
            "analyse",
            "evaluate",
            "create"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1"
          },
          "validations": []
        },
        {
          "code": "board",
          "name": "Board/Syllabus",
          "label": "Board/Syllabus",
          "placeholder": "Select Board/Syllabus",
          "description": "Board or Syallbus of the Question Set",
          "default": "",
          "dataType": "text",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Board is required"
            }
          ]
        },
        {
          "code": "medium",
          "name": "Medium",
          "label": "Medium",
          "placeholder": "Select Medium",
          "description": "Medium of Instruction for the Question Set",
          "default": "",
          "dataType": "list",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [
            "board"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Medium is required"
            }
          ]
        },
        {
          "code": "gradeLevel",
          "name": "Class",
          "label": "Class",
          "placeholder": "Select Class",
          "description": "Class of the Question Set",
          "default": "",
          "dataType": "list",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [
            "board",
            "medium"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Class is required"
            }
          ]
        },
        {
          "code": "subject",
          "name": "Subject",
          "label": "Subject",
          "placeholder": "Select Subject",
          "description": "Subject of the Question Set",
          "default": "",
          "dataType": "list",
          "inputType": "select",
          "editable": true,
          "required": true,
          "visible": true,
          "depends": [
            "board",
            "medium",
            "gradeLevel"
          ],
          "renderingHints": {
            "class": "sb-g-col-lg-1 required"
          },
          "validations": [
            {
              "type": "required",
              "message": "Subject is required"
            }
          ]
        }
        
      ]
    }
  }
}
```




Aim: resolve the confusion about Question set root level, section level, and question level metadata. 

Refer to

[https://project-sunbird.atlassian.net/browse/SB-23725](https://project-sunbird.atlassian.net/browse/SB-23725)



Confirm copy of context when creating question. Refer to [https://project-sunbird.atlassian.net/browse/SB-23723](https://project-sunbird.atlassian.net/browse/SB-23723)



*****

[[category.storage-team]] 
[[category.confluence]] 
