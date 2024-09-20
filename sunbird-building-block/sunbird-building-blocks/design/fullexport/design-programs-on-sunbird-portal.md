# \[Design]-Programs-on-Sunbird-portal

\*\*Introduction: \*\* This document describes the design for Programs to integrate with Sunbird Portal and also discusses the ability of Programs to support and launch multiple programs for various adopters.

\*\*Overview: \*\* Currently, Programs are used by a single adopter to run a specific activity within a defined scope which uses minimum configuration. It is currently used to create a specific set of content types. (Example: QuestionSet creation). By and large it is used for creation purpose.&#x20;

\*\*Problem Definition: \*\* Program portal should be able to support to launch multiple programs configured for various adopters. A program can have more than one activity. Each activity can take its own configuration. An admin of the program adopter should be able to define the scope, actions, tools etc based on the activity/purpose. Programs on the portal should be able to handle multiple active programs at a time.&#x20;

**Key Area to be analysed:**

1. Ability to load components dynamically based on configuration&#x20;
2. Ability to load components dynamically on multiple levels based on configuration

\*\*Solution: \*\* \*\*Program configuration based on components and its action. \*\* Since each tool (comprises of multiple components and tools can share the same components between each other) is going to solve the purpose of each activity in a program, the program can have its configurations based on the input that each component in the tool is expecting.&#x20;

Say for example, if the purpose of the program is to just see the coverage of textbooks, then the tool that is used in the program would expect a scope to be defined i.e: Board, Class, Medium, Subject, Framework. This can be the program configuration and nothing else would be required by the admin to see the coverage.&#x20;

Let us take an example of a program whose purpose is to create content for different contentTypes such as PracticeSet, Explanation, Experiential, CuriositySet, etc for each chapter in a given textbook.&#x20;

The workflow of the above mentioned program can be split into two parts

1. Creation
2. Review and Publish

\*\*Creation: \*\*

In creation, a contributor with creator access visits the program and does the following actions

1. **Selects a textbook** of a particular class and subject
2. **Selects a contentType** of a particular chapter that is to be created
3. **Selects a questionCategory** if the contentType is either PracticeSets/CuriositySet
4. **Creates** a content or assessment based on the chosen content type&#x20;
5. **Previews** the created assessment or content and submits for preview

**Review**

1. **Selects a textbook** of a particular class and subject
2. **Selects a content** of a chapter that are up for review
3. Sees the preview of the content before doing **Accept/Reject** and **publishing**
4. If **rejecting** , leaves a the reason as a **comment** to reject.&#x20;

The above listed actions can more or less be broken down into the following highlevel components.&#x20;

1. Collection Component
2. ChapterList Component
3. ContentCreation Component
4. ContentUpload Component
5. Preview Component

Each component will take its own configuration and has a set of actions that the user can perform

For example:

1. The Collection component would expect CollectionType, Board, Class, Medium, Subject, Framework to list the textbook and it would have actions such as showFilters

![](<../../../../Design/FullExport/images/storage/CollectionComponent (2).png>)

Similarly, ChapterList component would expect CollectionId and List of content types as configuration and selectChapter, addResource, preview etc as actions.

![](<../../../../Design/FullExport/images/storage/chapterlist component (2).png>)

If we put together all the component and its required configurations, actions and possible enhancements into a module/highlevel component the following would be the overall component hierarchy and configuration.

![](<../../../../Design/FullExport/images/storage/Flowchart-programs (2) (1).jpg>)

With this basic set of configurations and actions a program can be created by an admin of a program.&#x20;

```
{
  "programId": "217bddc0-df59-11e9-8d82-2b7f2cdfa2fd",
  "description": "Test Prep program",
  "name": "Test Prep",
  "slug": "sunbird",
  "startDate": "2019-09-25T12:50:30.000Z",
  "endDate": null,
  "status": null,
  "type": "private",
  "roles": {
    "value": [
      "CONTRIBUTOR",
      "REVIEWER",
      "PUBLISHER"
    ]
  },
  "defaultRoles": [
    "CONTRIBUTOR"
  ],
  "onBoardingForm": {
    "templateName": "onBoardingForm",
    "action": "onboard",
    "fields": [
      {
        "code": "school",
        "dataType": "text",
        "name": "School",
        "label": "School",
        "description": "School",
        "inputType": "select",
        "required": false,
        "displayProperty": "Editable",
        "visible": true,
        "range": [
          {
            "identifier": "my_school",
            "code": "my_school",
            "name": "My School",
            "description": "My School",
            "index": 1,
            "category": "school",
            "status": "Live"
          }
        ],
        "index": 1
      }
    ]
  },
  "header": {
    "tabs": [
      {
        "index": 0,
        "label": "Contribute Questions",
        "onClick": {
          "component": "collectionComponent"
        },
        "actionRoleMap": {
          "show": {
            "roles": [
              "Contributor",
              "Reviewer"
            ]
          },
          "drag": {
            "roles": [
              "Contributor",
              "Reviewer"
            ]
          }
        }
      },
      {
        "index": 1,
        "label": "Issue Certificate",
        "onClick": {
          "component": "issueCertificateComponent"
        },
        "actionRoleMap": {
          "show": {
            "roles": [
              "Reviewer"
            ]
          }
        }
      },
      {
        "index": 2,
        "label": "Dashboard",
        "onClick": {
          "component": "dashboardComponent"
        },
        "actionRoleMap": {
          "show": {
            "roles": [
              "Admin"
            ]
          }
        }
      }
    ]
  },
  "actions": {
    "showFilters": {
      "roles": [
        "Contributor",
        "Reviewer",
        "Admin"
      ]
    },
    "addresource": {
      "roles": [
        "Contributor"
      ]
    },
    "preview": {
      "roles": [
        "Contributor",
        "Reviewer"
      ]
    },
    "move": {
      "roles": [
        "Contributor"
      ]
    },
    "delete": {
      "roles": [
        "Contributor"
      ]
    },
    "selectChapter": {
      "roles": [
        "Contributor",
        "Reviewer"
      ]
    },
    "showTotalContribution": {
      "lable": "Total Contributoion",
      "roles": [
        "Contributor",
        "Reviewer"
      ]
    },
    "showMyContribution": {
      "lable": "My Contribution",
      "roles": [
        "Contributor"
      ]
    },
    "showRejected": {
      "lable": "Rejected",
      "roles": [
        "Contributor"
      ]
    },
    "showUnderReview": {
      "lable": "Under Review",
      "roles": [
        "Contributor"
      ]
    },
    "showtotalUnderReview": {
      "lable": "Total under review",
      "roles": [
        "Reviewer"
      ]
    },
    "showAcceptedByMe": {
      "lable": "Rejected by me",
      "roles": [
        "Reviewer"
      ]
    },
    "showRejectedByMe": {
      "lable": "Accepted by me",
      "roles": [
        "Reviewer"
      ]
    },
    "savePracticeSet": {
      "roles": [
        "Contributor"
      ]
    },
    "previewPracticeSet": {
      "roles": [
        "Contributor",
        "Reviewer"
      ]
    },
    "submitPracticeSet": {
      "roles": [
        "Contributor"
      ]
    },
    "deletePracticeSet": {
      "roles": [
        "Contributor"
      ]
    },
    "acceptPracticeSet": {
      "roles": [
        "Reviewer"
      ]
    },
    "rejectPracticeSet": {
      "roles": [
        "Reviewer"
      ]
    },
    "addQuestionPracticeSet": {
      "roles": [
        "Contributor"
      ]
    },
    "addSolutionPracticeSet": {
      "roles": [
        "Contributor"
      ]
    },
    "changeUploadFile": {
      "roles": [
        "Contributor"
      ]
    },
    "submitUpload": {
      "roles": [
        "Contributor"
      ]
    },
    "acceptUpload": {
      "roles": [
        "Reviewer"
      ]
    },
    "rejectUpload": {
      "roles": [
        "Reviewer"
      ]
    },
    "showPreview": {
      "roles": [
        "Contributor",
        "Reviewer"
      ]
    },
    "showDashboard": {
      "roles": [
        "Admin"
      ]
    },
    "reportSelection": {
      "label": "Select Report"
    },
    "reportContentTypeSelection": {
      "label": "Select Content-Type"
    },
    "reportDownload": {
      "label": "Download"
    },
    "reportRefresh": {
      "label": "Refresh"
    }
  },
  "config": {
    "filters": {
      "implicit": [
        {
          "code": "framework",
          "defaultValue": "NCF",
          "label": "Framework",
          "visibility": false
        },
        {
          "code": "board",
          "defaultValue": "AP",
          "label": "Board",
          "visibility": false
        },
        {
          "code": "medium",
          "defaultValue": "English",
          "label": "Medium",
          "visibility": false
        }
      ],
      "explicit": [
        {
          "code": "class",
          "range": [
            "Class 6",
            "Class 7",
            "Class 8"
          ],
          "label": "Class",
          "multiselect": false,
          "defaultValue": [
            "Class 6"
          ],
          "visibility": true
        },
        {
          "code": "subject",
          "range": [
            "English",
            "Maths"
          ],
          "label": "Subject",
          "multiselect": false,
          "defaultValue": [
            "English"
          ],
          "visibility": true
        }
      ]
    },
    "groupBy": {
      "value": "Subject",
      "defaultValue": "Class"
    },
    "contentTypes": {
      "value": [
        {
          "name": "Explanation",
          "contentType": "ExplanationResource",
          "mimeType": [
            "application/pdf"
          ],
          "thumbnail": "",
          "description": "description",
          "marks": 5,
          "resourceType": "",
          "Audience": "",
          "formConfiguration": [
            {
              "code": "LearningOutcome",
              "range": [],
              "label": "Learning Outcome",
              "multiselect": true
            },
            {
              "code": "bloomslevel",
              "range": [],
              "label": "Learning Level",
              "multiselect": true
            }
          ],
          "filesConfig": {
            "accepted": "pdf",
            "size": "50"
          }
        },
        {
          "name": "Experimental",
          "contentType": "ExperientialResource",
          "mimeType": [
            "video/mp4",
            "video/webm",
            "video/x-youtube"
          ],
          "thumbnail": "",
          "description": "description",
          "marks": 5,
          "resourceType": "",
          "Audience": "",
          "formConfiguration": [
            {
              "code": "LearningOutcome",
              "range": [],
              "label": "Learning Outcome",
              "multiselect": true
            },
            {
              "code": "bloomslevel",
              "range": [],
              "label": "Learning Level",
              "multiselect": true
            }
          ],
          "filesConfig": {
            "accepted": "mp4, webm, youtube",
            "size": "50"
          }
        },
        {
          "name": "Practice Sets",
          "contentType": "PracticeQuestionSet",
          "mimeType": [
            "application/vnd.ekstep.ecml-archive"
          ],
          "questionCategories": [
            "vsa",
            "sa",
            "la",
            "mcq"
          ],
          "thumbnail": "",
          "description": "description",
          "marks": 5,
          "resourceType": "",
          "Audience": "",
          "formConfiguration": [
            {
              "code": "LearningOutcome",
              "range": [],
              "label": "Learning Outcome",
              "multiselect": true
            },
            {
              "code": "bloomslevel",
              "range": [],
              "label": "Learning Level",
              "multiselect": true
            }
          ]
        },
        {
          "name": "Curiosity",
          "contentType": "CuriosityQuestionSet",
          "mimeType": [
            "application/vnd.ekstep.ecml-archive"
          ],
          "questionCategories": [
            "curiosity"
          ],
          "thumbnail": "",
          "description": "description",
          "marks": 5,
          "resourceType": "",
          "Audience": "",
          "formConfiguration": [
            {
              "code": "LearningOutcome",
              "range": [],
              "label": "Learning Outcome",
              "multiselect": true
            },
            {
              "code": "bloomslevel",
              "range": [],
              "label": "Learning Level",
              "multiselect": true
            }
          ]
        }
      ],
      "defaultValue": [
        {
          "name": "Practice Sets",
          "contentType": "PracticeQuestionSet",
          "mimeType": [
            "application/vnd.ekstep.ecml-archive"
          ],
          "questionCategories": [
            "vsa",
            "sa",
            "la",
            "mcq"
          ],
          "thumbnail": "",
          "description": "description",
          "marks": 2,
          "resourceType": "",
          "Audience": "",
          "formConfiguration": [
            {
              "code": "LearningOutcome",
              "range": [],
              "label": "Learning Outcome",
              "multiselect": false
            },
            {
              "code": "bloomslevel",
              "range": [],
              "label": "Learning Level",
              "multiselect": true
            }
          ]
        }
      ]
    },
    "textbookList": [],
    "filesConfig": {
      "accepted": "pdf, mp4, webm, youtube",
      "size": "50"
    },
    "practiceSetConfig": {
      "No of options": 4,
      "solutionType": [
        "Video",
        "Text & image"
      ],
      "questionCategory": [
        "vsa",
        "sa",
        "ls",
        "mcq",
        "curiosity"
      ]
    },
    "formConfiguration": [
      {
        "code": "LearningOutcome",
        "range": [],
        "label": "Learning Outcome",
        "multiselect": false
      },
      {
        "code": "bloomslevel",
        "range": [],
        "label": "Learning Level",
        "multiselect": true
      }
    ]
  }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
