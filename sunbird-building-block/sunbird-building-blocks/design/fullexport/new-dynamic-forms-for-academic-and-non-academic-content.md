

 **Background:** Design link:- [https://whimsical.com/Swkqpz6rnePYg9nPEFjv64](https://whimsical.com/Swkqpz6rnePYg9nPEFjv64)

Jira link:- [https://project-sunbird.atlassian.net/browse/SH-364](https://project-sunbird.atlassian.net/browse/SH-364)

 **Problem Statement:** 
* Show Different sections as per the config to show the dynamic form


* Show checkbox in dynamic form and enable/disable the save/submit button



 **Key Design Problems:** Currently, the dynamic form does not have the following functionality


* Sections in dynamic forms


* Checkbox dataType


* Enable and disable the Save button as per condition 




## Solution 1:
Define HTML template in a form configuration itself


```
{
  "request": {
    "type": "---",
    "subType": "---",
    "action": "save/review",
    "data": {
      "template": "<div class="col-12">
				<div class="col-3" id="{code-icon}">
						
				</div>
				<div class="col-9">
					<div class="col-6" id="{code-title}">
						
					</div>
					<div class="col-6" id="{code-description}">
						
					</div>
					<div class="col-6" id="{code-board}">
						
					</div>
					<div class="col-6" id="{code-medium}">
						
					</div>
					<div class="col-6" id="{code-licenseterms}">
						
					</div>
				</div>
      </div>",
      "action": "save/review",
      "fields": [
        {
          "code": "icon",
          ---
          ---
          ---
          ---
        },
        {
          "code": "title",
          ---
          ---
          ---
          ---
        },
        {
          "code": "description",
          ---
          ---
          ---
          ---
        },
        {
          "code": "board",
          ---
          ---
          ---
          ---
        }        
      ]
    }
  }
}
```

## Solution 2:

* Use system settings API to define all the templates and use the template name in the form configuration


* While rendering the form call system settings API with template name to get HTML layout of the form




```
{
  "request": {
    "type": "---",
    "subType": "---",
    "action": "save/review",
    "data": {
      "templateName": "reviewFormTemplate",
      "action": "save/review",
      "fields": [
        {
          "code": "icon",
          ---
          ---
          ---
          ---
        },
        {
          "code": "title",
          ---
          ---
          ---
          ---
        },
        {
          "code": "description",
          ---
          ---
          ---
          ---
        },
        {
          "code": "board",
          ---
          ---
          ---
          ---
        }        
      ]
    }
  }
}
```
System settings get API to get HTML layout by template name

API: [{{host}}/learner/data/v1/system/settings/get/](https://dev.sunbirded.org/learner/data/v1/system/settings/get/save_review)reviewFormTemplate


```
{
  field: "reviewFormTemplate"
  id: "reviewFormTemplate"
  value: "<div class="col-12">
				<div class="col-3" id="{code-icon}">
						
				</div>
				<div class="col-9">
					<div class="col-6" id="{code-title}">
						
					</div>
					<div class="col-6" id="{code-description}">
						
					</div>
					<div class="col-6" id="{code-board}">
						
					</div>
					<div class="col-6" id="{code-medium}">
						
					</div>
					<div class="col-6" id="{code-licenseterms}">
						
					</div>
				</div>
      </div>"
}
```
Solution 3: **_Predefine forms in the editor_** 

Config changes for sections:- 
* Introduced a new template as a “sectionalFormTemplate“ in metadata plugin


* Will add one more section as “Sections“ in a data 


* In this sections array, we will define the section name can other data


* The fields are associate with this section




```
{
  "request": {
    "type": "---",
    "subType": "---",
    "action": "save/review",
    "data": {
      "templateName": "reviewForm",
      "action": "save/review",
      "sections": [
        {
          "code": "section-1",
          "lable": "Lable for the section",
          "tooltip": "Tooltip for the section-1"
        },
        {
          "code": "section-2",
          "lable": "Lable for the section",
          "tooltip": "Tooltip for the section-1"
        }
      ],
      "fields": [
        {
          "code": "---",
          ---
          ---
          "section": "section-1",
          ---
          ---
        },
        {
          "code": "---",
          ---
          ---
          "section": "section-1",
          ---
          ---
        },
        {
          "code": "---",
          ---
          ---
          "section": "section-2",
          ---
          ---
        },
        {
          "code": "---",
          ---
          ---
          "section": "section-2",
          ---
          ---
        }        
      ]
    }
  }
}
```
 **Config changes for the checkbox:-** 
* Introduced a new input type as a checkbox in a form config fields




```
{
    "code": "licenseterms",
    "dataType": "text",
    "description": "licenseterms",
    "editable": true,
    "index": 17,
    "inputType": "checkbox",
    "label": "License Terms",
    "name": "licenseterms",
    "placeholder": "licenseterms",
    "defaultValue": "By creating and uploading content on DIKSHA, you consent to publishing this content under the Creative Commons Framework, specifically under the CC-BY-SA 4.0 license.",
    "renderingHints": {
        "value": {
            "video/x-youtube": "By linking or uploading YouTube videos on DIKSHA, you consent to publishing it as per the terms of the YouTube video license. DIKSHA accepts only videos with YouTube Standard License or Creative Commons License."
        },
        "class": "twelve wide field"
    },
    "required": false,
    "visible": true
} 
```
 **Note:-** We are considering only one checkbox will be showing as a part of the metadata form. 

 **Save/Submit button functionality:-** 
* If the form field having the  _checkbox_  input type property and  _required_  property is  **true** , We will check for the rules and enable/disabled the save/submit button


* Rules as follows:





|  **InputType**  |  **Required**  |  **Metadata['code']**  |  **Save/Submit**  | 
|  --- |  --- |  --- |  --- | 
| checkbox | true | “false“ | Disabled | 
| checkbox | true | “true“ | Enabled | 
| checkbox | false | “false“ | Enabled | 
| checkbox | false | “true“ | Enabled | 


1. For the new empty form, if "inputType": "checkbox" && "required": true && metadata\['code'] === ”false” the save button will be disabled


1. For the new empty form, if "inputType": "checkbox" && "required": true && metadata\['code'] === ”true” the save button will be enabled


1. For the new empty form, if "inputType": "checkbox" && "required": false && metadata\['code'] === ”false” the save button will be enabled


1. For the new empty form, if "inputType": "checkbox" && "required": false && metadata\['code'] === ”true” the save button will be enabled






## Solution 4:
Define a template layout structure to show the fields on the form


```
{
  "request": {
    "type": "---",
    "subType": "---",
    "action": "save/review",
    "data": {
      "templateName": "reviewFormTemplate",
      "action": "save/review",
      "templateLayout": [
      {"row": [
        {
          column: [
            {"code" : "appIcon"}
          ]
        },
        {
          column: [
            {"row" : [ {"code" : "appIcon"} ]},
            {"row" : [ {"code" : "description"} ]},
            {"row" : [ 
                {
                  column: [
                    {"code" : "subject"}
                  ]
                },
                {
                  column: [
                    {"code" : "topic"}
                  ]
                }
            ]},
            {"row" : [ 
                {
                  column: [
                    {"code" : "board"}
                  ]
                },
                {
                  column: [
                    {"code" : "medium"}
                  ]
                },
                {
                  column: [
                    {"code" : "grade"}
                  ]
                }
            ]},
            {"row" : [ 
                {
                  column: [
                    {"code" : "subject"}
                  ]
                },
                {
                  column: [
                    {"code" : "audience"}
                  ]
                }
            ]}
          ]
        }
        ]
      }]
      "fields": [
        {
          "code": "icon",
          ---
          ---
          ---
          ---
        },
        {
          "code": "title",
          ---
          ---
          ---
          ---
        },
        {
          "code": "description",
          ---
          ---
          ---
          ---
        },
        {
          "code": "board",
          ---
          ---
          ---
          ---
        }        
      ]
    }
  }
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 
