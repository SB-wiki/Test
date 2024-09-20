# Make-Content-Review-Checklist-configurable

**Background:** Make Content Review Checklist is not configurable in the portal.

**Problem Statement:**

Content Review Checklist is not configurable in the portal.

**Proposed Solution:**

It has to be made configurable.

Following are the different levels of configuration to be supported:

1. Instance level
2. Channel level

In case if there is a configuration at Channel level, it overrides Instance level configuration. Configuration is not mandatory.

Different configuration can be defined differently for the following content types:

1. Course
2. Textbook
3. Resource and Collection

so we will keep the checklist data in FORM-API for both channel and instance level.

Use the create/update form API with the following API request

**Sample API request for Request Changes with configuration:**

{

&#x20;"request": {

&#x20;  "type": "content",

&#x20;  "action": "requestforchanges",

&#x20;  "subType": "resource",

&#x20;  "data": {

&#x20;    "templateName": "defaultTemplate",

&#x20;    "action": "requestforchanges",

&#x20;    "fields": \[

&#x20;      {

&#x20;        "title": "Please tick the reasons for requesting changes and provide detailed comments:",

&#x20;        "otherReason": "Other Issue(s) (if there are any other issues, tick this and provide details in the comments box)",

&#x20;        "contents": \[

&#x20;          {

&#x20;            "name": "Appropriateness",

&#x20;            "checkList": \[

&#x20;              "Has Hate speech, Abuse, Violence, Profanity",

&#x20;              "Has Sexual content, Nudity or Vulgarity",

&#x20;              "Has Discriminatory or Defamatory content",

&#x20;              "Is not suitable for children"

&#x20;            ]

&#x20;          },

&#x20;          {

&#x20;            "name": "Content details",

&#x20;            "checkList": \[

&#x20;              "Inappropriate Title or Description",

&#x20;              "Incorrect Board, Grade, Subject or Medium",

&#x20;              "Inappropriate tags such as Resource Type or Concepts",

&#x20;              "Irrelevant Keywords"

&#x20;            ]

&#x20;          },

&#x20;          {

&#x20;            "name": "Usability",

&#x20;            "checkList": \[

&#x20;              "Content is NOT playing correctly",

&#x20;              "CANNOT see the content clearly on Desktop and App",

&#x20;              "Audio is NOT clear or NOT easy to understand",

&#x20;              "Spelling mistakes found in text used",

&#x20;              "Language is NOT simple to understand"

&#x20;            ]

&#x20;          }

&#x20;        ]

&#x20;      }

&#x20;    ]

&#x20;  }

&#x20;}

}

![](../../../../Design/FullExport/images/storage/request-changes-popup.png)

**Sample API request for Publish option with configuration:**

{

&#x20;"request": {

&#x20;  "type": "content",

&#x20;  "action": "publish",

&#x20;  "subType": "resource",

&#x20;  "data": {

&#x20;    "templateName": "defaultTemplate",

&#x20;    "action": "publish",

&#x20;    "fields": \[

&#x20;      {

&#x20;        "title": "Please confirm that ALL the following items are verified (by ticking the check-boxes) before you can publish:",

&#x20;        "contents": \[

&#x20;          {

&#x20;            "name": "Appropriateness",

&#x20;            "checkList": \[

&#x20;              "No Hate speech, Abuse, Violence, Profanity",

&#x20;              "No Sexual content, Nudity or Vulgarity",

&#x20;              "No Discrimination or Defamation",

&#x20;              "Is suitable for children"

&#x20;            ]

&#x20;          },

&#x20;          {

&#x20;            "name": "Content details",

&#x20;            "checkList": \[

&#x20;              "Appropriate Title, Description",

&#x20;              "Correct Board, Grade, Subject, Medium",

&#x20;              "Appropriate tags such as Resource Type, Concepts",

&#x20;              "Relevant Keywords"

&#x20;            ]

&#x20;          },

&#x20;          {

&#x20;            "name": "Usability",

&#x20;            "checkList": \[

&#x20;              "Content plays correctly",

&#x20;              "Can see the content clearly on Desktop and App",

&#x20;              "Audio (if any) is clear and easy to understand",

&#x20;              "No Spelling mistakes in the text",

&#x20;              "Language is simple to understand"

&#x20;            ]

&#x20;          }

&#x20;        ]

&#x20;      }

&#x20;    ]

&#x20;  }

&#x20;}

}

![](../../../../Design/FullExport/images/storage/publish-popup.png)

so in the above two request body we can configure the checklist on content

level by changing the subType. for ex: resource,textbook etc.

**for Request Changes following is the UI behaviour:**

Request Changes:

&#x20;     1.If checklist is not configured in form API, it will display 'Please detail the required changes in the comments' with a comment box below. On filling the comment box it will enable the request changes button.

&#x20;     2.If checklist is configured in form API, it will display the configured checklist with a comment box. Here you need to check at least 1 checkbox and write comments to enable the request changes button

&#x20;     3.If API throws an error, a default error message(Something went wrong, Please try again later.) from the portal will be displayed.

**for Publish Changes following is the UI behaviour:**

Publish:

1. If checklist is not configured in form API, it will only display 'Are you sure you want to publish?'. Here publish button should be enabled from default.
2. If checklist is configured in form API, it will display the configured checklist. Here you need to check all the check boxes to enable the publish button.
3. If API throws an error, a default error message(Something went wrong, Please try again later.) from the portal will be displayed.

**Limitation:**

if in FORM-API other Reason is not defined Other Issue(s) checklist will not show.

***

\[\[category.storage-team]] \[\[category.confluence]]
