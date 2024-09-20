 **Background:** inQuiry need to enable multi-language support for Questions & QuestionSets where data like question content (body), hints, instructions can be stored in multiple language. So that user can select the language of their choice (user may select one or multiple language) during creation & consumption. 

 **Problem Statement:** 


* Currently Question & QuestionSet V1 api’s doesn’t support multilingual data for body, hints, instructions, feedback etc.


* As per QuML Spec below metadata should support multi-language:





|  **objectType**  |  **metadata**  |  **Current Data Type (v1 api)**  |  **Expected Data Type (v2 api)**  |  **Comment**  | 
|  --- |  --- |  --- |  --- |  --- | 
| QuestionSet | instructions | object | object |  | 
| QuestionSet | feedback | object | object |  | 
| Question | body | string | object |  | 
| Question | answer | string | object |  | 
| Question | instructions | object | object |  | 
| Question | hints | array of string | object |  | 
| Question | feedback | object | object |  | 
| Question | solutions | array of object | object |  | 
| Question | interactions | object | object |  | 



 **Solution:** 


* inQuiry will provide Question & QuestionSet V2 api’s which will provide CRUD operation for multilingual data.





|  **Publicly Exposed API**  |  **Service Level API’s**  |  **qumlVersion**  |  **compatibilityLevel**  | 
|  --- |  --- |  --- |  --- | 
| v1 api’s | v4 api’s | supports 1.0 but not stamped in data. | 5 | 
| v2 api’s | v5 api’s | supports 1.1 onwards.  | 6 | 


* inquiry v2 api’s will support multiple QuML version.


    * It support QuML version 1.1 onwards.


    * For each version of QuML, inquiry will maintain different schema folder.


    * User can send the  **qumlVersion**  metadata in create request payload. if it is valid, payload will be validated against respective schema.


    * If user doesn’t provide  **qumlVersion,** micro-service will use  **default**  **qumlVersion**  configured in micro-service through a service level configuration.


    * micro-service will also maintain a configuration for all supported QuML version. e.g: api_v5_supported_quml_version=\[1.1, 1.2, 1.3]


    * inquiry will stamp  **qumlVersion**  to all objects created through v2 api’s and same will be used during read and update api’s calls.


    * once question or questionset created against a specific QuML version, qumlVersion can’t be upgraded/downgraded through update api’s. It is restricted to avoid any data corruption.


    * addition of new quml version require few code changes like adding schema and application configurations, code changes to flink job.



    
* Current compatibilityLevel is set to  **5**  for the data created using v1 api’s. For v2 api’s, it will be set to  **6**  so that users should be able to discover and play only on latest app having latest player.


    * Going forward, adopters should use  **qumlVersion**  metadata to control discovery of question/questionset.


    * QuML player won't understand comaptibilityLevel, but will upgrade it to 6 for backward compatibility (existing apps).



    
*  **qumlVersion**  should be used by  **QuML player** .


    * QuML payer should use the metadata for checking player compatibility. This will remove dependency of metadata  **compatibilityLevel** at application layer.


    * based on qumlVersion, player should switch the logic to process data.



    
* data filter based on language capability will be enabled for question read and list api’s. query parameter lang=language_code will be used. e.g: ?lang=en


* As of now, inquiry v2 api’s will not follow spec for below properties 


    * properties: interactions & visibility


    * interactions: will be implemented, once format is generalised for all question types at spec level. 


    * visibility: inquiry will continue to use  **default** visibility which is used as public visibility across all components including other building blocks.



    
* async-questionset-publish flink job will handle different data validation based on  **qumlVersion** .


* v2 review & publish api won’t allow data having  **qumlVersion**  less than 1.1


    * existing data having qumlVersion 1.0 must be migrated before sending to review & publish v2 api’s.


    * inquiry will provide auto-migration to qumlVersion 1.1 using v2 update api.



    
* question & questionset v1 api’s will be enhanced to throw an error, when user try to read/update data created using v2 api’s. qumlVersion check will be enabled for v1 api’s as well to achieve the behaviour.


* For existing data created using v1 api’s, we have two approach as mentioned below:


    * No static Data Migration for existing objects and data transformation in question read & list api at run time to support v2 api spec.


    * One time static Data Migration



    

 **No Static Migration:** 

 **Pros:** 


1. Old version of questionset-editor & mobile app works fine with v1 api.


1. Once older questions edited using v2 editor and api's, it will be migrated to v2 data model. So end user (consumption) won’t be affected on immediate basis and at that point old mobile app will not be able to discover the question (comaptibilityLevel will be upgraded to maintain backward compatibility of Sunbird-Ed mobile app).



 **Cons:** 


1. Platform need to understand all multi-language data (including editorState) and transform it to v2 api format for every read & list api call.


1. API Performance will be affected (specially question list api). To improve performance, cache will be implemented for list api to hold data post data transformation (currently no cache implementation present for list api). 


1. Once the data is migrated to v2 data model, old player will not be able to discover the question (comaptibilityLevel will be upgraded).





 **Static Migration:** 

 **Pros:** 


1. Consumption api’s (question read & list api) doesn't need any run-time data transformation. So api performance won’t be affected.



 **Cons:** 


1. old mobile app won't be able to render existing questions for online consumption.


1. old editor also start breaking even for v1 api’s





 **API Specification:** 

 **Question Create API:** 

Sample Input  **for single language:** 
```json
{
  "name": "Name of the question",
  "code": "unique code of the question",
  "mimeType": "application/vnd.sunbird.question",
  "primaryCategory": "Multiple Choice Question",
  "interactionTypes": ["choice"],
  "qumlVersion": 1.1,
  "media": [
    {
      "id": "do_2137498365362995201237",
      "type": "image",
      "src": "/assets/public/content/assets/do_2137498365362995201237/tea.jpeg",
      "baseUrl": "https://dev.inquiry.sunbird.org"
    }
  ],
  "body": "<div class='question-body' tabindex='-1'><div class='mcq-title' tabindex='0'><p><span style=\"background-color:#ffffff;color:#202124;\">Which of the following crops is a commercial crop?</span></p></div><div data-choice-interaction='response1' class='mcq-vertical'></div></div>",
  "answer": "<p>Barley</p>",
  "instructions": {
    "language_code": "<div>...</div>"
  },
  "hints": {
    "hint_1": "<div>...</div>",
    "hint_2": "<div>...</div>"
  },
  "feedback": {
    "feedback_1": "<div>...</div>",
    "feedback_2": "<div>...</div>"
  },
  "solutions": {
    "solution_1": "solution 1 html string",
    "solution_2": "solution 2 html string"
  },
  "interactions": {
    "response1": {
      "type": "choice",
      "options": [
        {
          "label": "<p>Wheat</p>",
          "value": "w"
        },
        {
          "label": "<p>Barley</p>",
          "value": "b"
        },
        {
          "label": "<p>Maize</p>",
          "value": "m"
        },
        {
          "label": "<p>Tea</p>",
          "value": "t"
        }
      ],
      "validation": {
        "required": "Yes"
      }
    }
  },
  "responseDeclaration": {
    "response1": {
      "cardinality": "single",
      "type": "integer",
      "correctResponse": {
        "value": 3
      },
      "mapping": [
        {
          "value": 2,
          "score": 0.5
        },
        {
          "value": 1,
          "score": 0.25
        }
      ]
    }
  },
  "outcomeDeclaration": {
    "maxScore": {
      "cardinality": "single",
      "type": "integer",
      "defaultValue": 3
    }
  },
  // any additional properties goes here. e.g: framework, createdBy, etc..
}
```

* In the above request spec, a  **default language code**  (configured in the system at object level schema) will be injected and data will be transformed (as mentioned in multi language format ) to v2 format and then saved to database.


* The data  transformation will be done to support both formats mentioned in quml specification.



 **Sample**  **Input for multi-language (default input)** :


```json
{
  "name": "Name of the question",
  "code": "unique code of the question",
  "mimeType": "application/vnd.sunbird.question",
  "primaryCategory": "Multiple Choice Question",
  "interactionTypes": ["choice"],
  "qumlVersion": 1.1,
  "media": [
    {
      "id": "do_2137498365362995201237",
      "type": "image",
      "src": "/assets/public/content/assets/do_2137498365362995201237/tea.jpeg",
      "baseUrl": "https://dev.inquiry.sunbird.org"
    }
  ],
  "body": {
    "language_code": "<div class='question-body' tabindex='-1'><div class='mcq-title' tabindex='0'><p><span style=\"background-color:#ffffff;color:#202124;\">Which of the following crops is a commercial crop?</span></p></div><div data-choice-interaction='response1' class='mcq-vertical'></div></div>"
  },
  "answer": {
    "language_code": "<p>Barley</p>"
  },
  "instructions": {
    "language_code": "<div>...</div>"
  },
  "hints": {
    "hint_1": {
      "language_code": "<div>...</div>"
    },
    "hint_2": {
      "language_code": "<div>...</div>"
    }
  },
  "feedback": {
    "feedback_1": {
      "language_code": "<div>...</div>"
    },
    "feedback_2": {
      "language_code": "<div>...</div>"
    }
  },
  "solutions": {
    "solution_1": {
      "language_code": "<div>...</div>"
    },
    "solution_2": {
      "language_code": "<div>...</div>"
    }
  },
  "interactions": {
    "response1": {
      "type": "choice",
      "options": [
        {
          "label": {
            "language_code": "<p>Wheat</p>"
          },
          "value": 1
        },
        {
          "label": {
            "language_code": "<p>Barley</p>"
          },
          "value": 2
        },
        {
          "label": {
            "language_code": "<p>Maize</p>"
          },
          "value": 3
        },
        {
          "label": {
            "language_code": "<p>Tea</p>"
          },
          "value": 4
        }
      ],
      "validation": {
        "required": "Yes"
      }
    }
  },
  "responseDeclaration": {
    "response1": {
      "cardinality": "single",
      "type": "integer",
      "correctResponse": {
        "value": 3
      },
      "mapping": [
        {
          "value": 2,
          "score": 0.5
        },
        {
          "value": 1,
          "score": 0.25
        }
      ]
    }
  },
  "outcomeDeclaration": {
    "maxScore": {
      "cardinality": "single",
      "type": "integer",
      "defaultValue": 3
    }
  },
  // any additional properties goes here. e.g: framework, createdBy, etc..
}
```
 **Success Response (200):** 


```json
{
    "id": "api.question.create",
    "ver": "5.0",
    "ts": "2023-01-30T19:43:43ZZ",
    "params": {
        "resmsgid": "ca1ed6b6-994d-487c-8ecd-0ca164a84c94",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_2137224832856555521270",
        "versionKey": "1675107822985"
    }
}
```


 **Question Read API:** 

 **Request:** 


```
curl --location --request GET 'https://dev.inquiry.sunbird.org/api/question/v2/read/do_213688205764337664161?mode=edit&fields=answer,instructions' \
--header 'Authorization: {{api_key_new}}'
```
 **Response:** 


* question read api will always return will data in below format:




```json
{
  "id": "api.question.read",
  "ver": "5.0",
  "ts": "2023-01-30T03:28:23ZZ",
  "params": {
    "resmsgid": "db23eb9e-207c-488c-a45a-7da36a2084ee",
    "msgid": null,
    "err": null,
    "status": "successful",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "question": {
      "identifier": "do_213688205764337664161",
      "qumlVersion": 1.1,
      "media": [
        {
          "id": "do_2137498365362995201237",
          "type": "image",
          "src": "/assets/public/content/assets/do_2137498365362995201237/tea.jpeg",
          "baseUrl": "https://dev.inquiry.sunbird.org"
        }
      ],
      "body": {
        "language_code": "<div class='question-body' tabindex='-1'><div class='mcq-title' tabindex='0'><p><span style=\"background-color:#ffffff;color:#202124;\">Which of the following crops is a commercial crop?</span></p></div><div data-choice-interaction='response1' class='mcq-vertical'></div></div>"
      },
      "answer": {
        "language_code": "<p>Barley</p>"
      },
      "instructions": {
        "language_code": "<div>...</div>"
      },
      "hints": {
        "hint_1": {
          "language_code": "<div>...</div>"
        },
        "hint_2": {
          "language_code": "<div>...</div>"
        }
      },
      "feedback": {
        "feedback_1": {
          "language_code": "<div>...</div>"
        },
        "feedback_2": {
          "language_code": "<div>...</div>"
        }
      },
      "solutions": {
        "solution_1": {
          "language_code": "<div>...</div>"
        },
        "solution_2": {
          "language_code": "<div>...</div>"
        }
      },
      "interactions": {
        "response1": {
          "type": "choice",
          "options": [
            {
              "label": {
                "language_code": "<p>Wheat</p>"
              },
              "value": 1
            },
            {
              "label": {
                "language_code": "<p>Barley</p>"
              },
              "value": 2
            },
            {
              "label": {
                "language_code": "<p>Maize</p>"
              },
              "value": 3
            },
            {
              "label": {
                "language_code": "<p>Tea</p>"
              },
              "value": 4
            }
          ],
          "validation": {
            "required": "Yes"
          }
        }
      },
      "responseDeclaration": {
        "response1": {
          "cardinality": "single",
          "type": "integer",
          "correctResponse": {
            "value": 3
          },
          "mapping": [
            {
              "value": 2,
              "score": 0.5
            },
            {
              "value": 1,
              "score": 0.25
            }
          ]
        }
      },
      "outcomeDeclaration": {
        "maxScore": {
          "cardinality": "single",
          "type": "integer",
          "defaultValue": 3
        }
      }
    }
  }
}
```

* the read api transforms data created using v1 api’s. It injects default language code configured in the system at object level schema and return the response to user.


* same transformation will be applicable in  **Question List API** 


* if specific language data is demanded using query param  **lange=language_code**  then only that language data will be returned.


    * if the requested language data is not available, api will return system default language data.


    * what should be behaviour????



    



 **Question Update API:** 


* Question Update API also support both spec as mentioned in create api.


* For older data (created with v1 api’s), on v2 api update call, data will be migrated to v2 api format as well as qumlVersion will be set to 1.1.



 **Sample Input for Update API (single language):** 


```json
{
  "name": "Name of the question",
  "versionKey": "123456"
  "media": [
    {
      "id": "do_2137498365362995201237",
      "type": "image",
      "src": "/assets/public/content/assets/do_2137498365362995201237/tea.jpeg",
      "baseUrl": "https://dev.inquiry.sunbird.org"
    }
  ],
  "body": "<div class='question-body' tabindex='-1'><div class='mcq-title' tabindex='0'><p><span style=\"background-color:#ffffff;color:#202124;\">Which of the following crops is a commercial crop?</span></p></div><div data-choice-interaction='response1' class='mcq-vertical'></div></div>",
  "answer": "<p>Barley</p>",
  "instructions": {
    "language_code": "<div>...</div>"
  },
  "hints": {
    "hint_1": "<div>...</div>",
    "hint_2": "<div>...</div>"
  },
  "feedback": {
    "feedback_1": "<div>...</div>",
    "feedback_2": "<div>...</div>"
  },
  "solutions": {
    "solution_1": "solution 1 html string",
    "solution_2": "solution 2 html string"
  },
  "interactions": {
    "response1": {
      "type": "choice",
      "options": [
        {
          "label": "<p>Wheat</p>",
          "value": "w"
        },
        {
          "label": "<p>Barley</p>",
          "value": "b"
        },
        {
          "label": "<p>Maize</p>",
          "value": "m"
        },
        {
          "label": "<p>Tea</p>",
          "value": "t"
        }
      ],
      "validation": {
        "required": "Yes"
      }
    }
  },
  "responseDeclaration": {
    "response1": {
      "cardinality": "single",
      "type": "integer",
      "correctResponse": {
        "value": 3
      },
      "mapping": [
        {
          "value": 2,
          "score": 0.5
        },
        {
          "value": 1,
          "score": 0.25
        }
      ]
    }
  },
  "outcomeDeclaration": {
    "maxScore": {
      "cardinality": "single",
      "type": "integer",
      "defaultValue": 3
    }
  }
}
```
 **Sample Input for Update API (default input format):** 


```json
{
  "versionKey": "12345"
  "name": "Name of the question",
  "media": [
    {
      "id": "do_2137498365362995201237",
      "type": "image",
      "src": "/assets/public/content/assets/do_2137498365362995201237/tea.jpeg",
      "baseUrl": "https://dev.inquiry.sunbird.org"
    }
  ],
  "body": {
    "language_code": "<div class='question-body' tabindex='-1'><div class='mcq-title' tabindex='0'><p><span style=\"background-color:#ffffff;color:#202124;\">Which of the following crops is a commercial crop?</span></p></div><div data-choice-interaction='response1' class='mcq-vertical'></div></div>"
  },
  "answer": {
    "language_code": "<p>Barley</p>"
  },
  "instructions": {
    "language_code": "<div>...</div>"
  },
  "hints": {
    "hint_1": {
      "language_code": "<div>...</div>"
    },
    "hint_2": {
      "language_code": "<div>...</div>"
    }
  },
  "feedback": {
    "feedback_1": {
      "language_code": "<div>...</div>"
    },
    "feedback_2": {
      "language_code": "<div>...</div>"
    }
  },
  "solutions": {
    "solution_1": {
      "language_code": "<div>...</div>"
    },
    "solution_2": {
      "language_code": "<div>...</div>"
    }
  },
  "interactions": {
    "response1": {
      "type": "choice",
      "options": [
        {
          "label": {
            "language_code": "<p>Wheat</p>"
          },
          "value": 1
        },
        {
          "label": {
            "language_code": "<p>Barley</p>"
          },
          "value": 2
        },
        {
          "label": {
            "language_code": "<p>Maize</p>"
          },
          "value": 3
        },
        {
          "label": {
            "language_code": "<p>Tea</p>"
          },
          "value": 4
        }
      ],
      "validation": {
        "required": "Yes"
      }
    }
  },
  "responseDeclaration": {
    "response1": {
      "cardinality": "single",
      "type": "integer",
      "correctResponse": {
        "value": 3
      },
      "mapping": [
        {
          "value": 2,
          "score": 0.5
        },
        {
          "value": 1,
          "score": 0.25
        }
      ]
    }
  },
  "outcomeDeclaration": {
    "maxScore": {
      "cardinality": "single",
      "type": "integer",
      "defaultValue": 3
    }
  }
}
```
 **Response:** 


```json
{
    "id": "api.question.update",
    "ver": "5.0",
    "ts": "2023-01-30T19:43:43ZZ",
    "params": {
        "resmsgid": "ca1ed6b6-994d-487c-8ecd-0ca164a84c94",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_2137224832856555521270",
        "versionKey": "1675107822985"
    }
}
```


 **Question Review API :** 


* there is no change in spec from v1 to v2 api. 


* For older data, the api will throw client error if the qumlVersion is 1.0.



 **Question Publish API:** 


* there is no change in spec from v1 to v2 api. 


* For older data, the api will throw client error if the qumlVersion is 1.0.



 **Question Retire API:** 


* there is no change in spec from v1 to v2 api. 


* there is no change for logical behaviour of the api



 **Question Copy API:** 


* there is no change in spec from v1 to v2 api. 


* the api will support copy operation only if object qumlVersion match with default qumlVersion supported by the micro-service.


* For older data, the api will throw client error if the qumlVersion is 1.0. First the data should be migrated.





 **QuestionSet API’s:** 

 **QuestionSet Create API:** 


* there is no change in spec from v1 to v2 api.


* for instructions metadata, editor need to send specific language code in the data.


    * if language code is not supplied, default language code will be injected at platform level.



    

 **QuestionSet Read API & Hierarchy Read API:** 


* For older data, language code will be stamped and data transformation will be done before returning the response for below fields:


    * instructions, hints & feedback


    * data sample: 


    * 
```
"instructions": {
    "language_code": "<div>...</div>"
  },
  "hints": {
    "hint_1": {
      "language_code": "<div>...</div>"
    },
    "hint_2": {
      "language_code": "<div>...</div>"
    }
  },
  "feedback": {
    "feedback_1": {
      "language_code": "<div>...</div>"
    },
    "feedback_2": {
      "language_code": "<div>...</div>"
    }
  }
```


    



 **QuestionSet Update Hierarchy API:**  **Sample Input Request with single language attributes:** 


```json
{
  "request": {
    "data": {
      "nodesModified": {
        "q1": {
          "metadata": {
            "name": "Name of the question",
            "code": "q1",
            "mimeType": "application/vnd.sunbird.question",
            "primaryCategory": "Multiple Choice Question",
            "interactionTypes": [
              "choice"
            ],
            "qumlVersion": 1.1,
            "media": [
              {
                "id": "do_2137498365362995201237",
                "type": "image",
                "src": "/assets/public/content/assets/do_2137498365362995201237/tea.jpeg",
                "baseUrl": "https://dev.inquiry.sunbird.org"
              }
            ],
            "body": "<div class='question-body' tabindex='-1'><div class='mcq-title' tabindex='0'><p><span style=\"background-color:#ffffff;color:#202124;\">Which of the following crops is a commercial crop?</span></p></div><div data-choice-interaction='response1' class='mcq-vertical'></div></div>",
            "answer": "<p>Barley</p>",
            "instructions": {
              "language_code": "<div>...</div>"
            },
            "hints": {
              "hint_1": "<div>...</div>",
              "hint_2": "<div>...</div>"
            },
            "feedback": {
              "feedback_1": "<div>...</div>",
              "feedback_2": "<div>...</div>"
            },
            "solutions": {
              "solution_1": "solution 1 html string",
              "solution_2": "solution 2 html string"
            },
            "interactions": {
              "response1": {
                "type": "choice",
                "options": [
                  {
                    "label": "<p>Wheat</p>",
                    "value": "w"
                  },
                  {
                    "label": "<p>Barley</p>",
                    "value": "b"
                  },
                  {
                    "label": "<p>Maize</p>",
                    "value": "m"
                  },
                  {
                    "label": "<p>Tea</p>",
                    "value": "t"
                  }
                ],
                "validation": {
                  "required": "Yes"
                }
              }
            },
            "responseDeclaration": {
              "response1": {
                "cardinality": "single",
                "type": "integer",
                "correctResponse": {
                  "value": 3
                },
                "mapping": [
                  {
                    "value": 2,
                    "score": 0.5
                  },
                  {
                    "value": 1,
                    "score": 0.25
                  }
                ]
              }
            },
            "outcomeDeclaration": {
              "maxScore": {
                "cardinality": "single",
                "type": "integer",
                "defaultValue": 3
              }
            }
          },
          "objectType": "Question",
          "root": false,
          "isNew": true
        }
      },
      "hierarchy": {
        "questionset_identifier": {
          "children": [
            "q1"
          ],
          "root": true
        }
      }
    }
  }
}

```
 **Sample Input Request with multi-language attributes (default format):** 


```json
{
  "request": {
    "data": {
      "nodesModified": {
        "q1": {
          "metadata": {
            "name": "Name of the question",
            "code": "q1",
            "mimeType": "application/vnd.sunbird.question",
            "primaryCategory": "Multiple Choice Question",
            "interactionTypes": [
              "choice"
            ],
            "qumlVersion": 1.1,
            "media": [
              {
                "id": "do_2137498365362995201237",
                "type": "image",
                "src": "/assets/public/content/assets/do_2137498365362995201237/tea.jpeg",
                "baseUrl": "https://dev.inquiry.sunbird.org"
              }
            ],
            "body": {
              "language_code": "<div class='question-body' tabindex='-1'><div class='mcq-title' tabindex='0'><p><span style=\"background-color:#ffffff;color:#202124;\">Which of the following crops is a commercial crop?</span></p></div><div data-choice-interaction='response1' class='mcq-vertical'></div></div>"
            },
            "answer": {
              "language_code": "<p>Barley</p>"
            },
            "instructions": {
              "language_code": "<div>...</div>"
            },
            "hints": {
              "hint_1": {
                "language_code": "<div>...</div>"
              },
              "hint_2": {
                "language_code": "<div>...</div>"
              }
            },
            "feedback": {
              "feedback_1": {
                "language_code": "<div>...</div>"
              },
              "feedback_2": {
                "language_code": "<div>...</div>"
              }
            },
            "solutions": {
              "solution_1": {
                "language_code": "<div>...</div>"
              },
              "solution_2": {
                "language_code": "<div>...</div>"
              }
            },
            "interactions": {
              "response1": {
                "type": "choice",
                "options": [
                  {
                    "label": {
                      "language_code": "<p>Wheat</p>"
                    },
                    "value": 1
                  },
                  {
                    "label": {
                      "language_code": "<p>Barley</p>"
                    },
                    "value": 2
                  },
                  {
                    "label": {
                      "language_code": "<p>Maize</p>"
                    },
                    "value": 3
                  },
                  {
                    "label": {
                      "language_code": "<p>Tea</p>"
                    },
                    "value": 4
                  }
                ],
                "validation": {
                  "required": "Yes"
                }
              }
            },
            "responseDeclaration": {
              "response1": {
                "cardinality": "single",
                "type": "integer",
                "correctResponse": {
                  "value": 3
                },
                "mapping": [
                  {
                    "value": 2,
                    "score": 0.5
                  },
                  {
                    "value": 1,
                    "score": 0.25
                  }
                ]
              }
            },
            "outcomeDeclaration": {
              "maxScore": {
                "cardinality": "single",
                "type": "integer",
                "defaultValue": 3
              }
            }
          },
          "objectType": "Question",
          "root": false,
          "isNew": true
        }
      },
      "hierarchy": {
        "questionset_identifier": {
          "children": [
            "q1"
          ],
          "root": true
        }
      }
    }
  }
}
```
 **Sample Success Response:** 


```json
{
    "id": "api.questionset.hierarchy.update",
    "ver": "5.0",
    "ts": "2023-05-08T07:03:25ZZ",
    "params": {
        "resmsgid": "deb89409-5775-4970-921d-1298f99dafa7",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_21379147288621056013168",
        "identifiers": {
            "q1": "do_21379147288888115213169"
        }
    }
}
```

* data transformation will be done for questions data supplied in single language under request.


    * if question data is provided without language information, default language will be stamped.



    

 **QuestionSet Update API:** 


* there is no change in spec from v1 to v2 api.


* For older questionset having qumlVersion 1.0, v2 api will auto migrate to quml spec 1.1.



 **QuestionSet Review API:** 


* there is no change in spec from v1 to v2 api. 


* For older data, the api will throw client error if the object qumlVersion is 1.0.


* All children should belong to same qumlVersion as per Questionset. ????



 **QuestionSet Publish API:** 


* there is no change in spec from v1 to v2 api. 


* For older data, the api will throw client error if the object qumlVersion is 1.0.



 **QuestionSet Retire API:** 


* there is no change in spec from v1 to v2 api. 


* there is no change for logical behaviour of the api



 **QuestionSet Copy API:** 


* there is no change in spec from v1 to v2 api. 


* the api will support copy operation only if object qumlVersion match with default qumlVersion supported by the micro-service.


* For older data, the api will throw client error if the qumlVersion is 1.0. First the data should be migrated.





*****

[[category.storage-team]] 
[[category.confluence]] 
