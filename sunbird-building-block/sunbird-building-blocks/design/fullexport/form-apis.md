
# Update on Form Service

### Schema


| Current Column | Proposed Columns | 
|  --- |  --- | 
| type (varchar) | type (varchar) | 
| subtype (varchar) | subtype (varchar) | 
| action (varchar) | action (varchar) | 
| component (varchar) | component (varchar) | 
| root_org (varchar) | root_org (varchar) | 
| framework (varchar) | framework (varchar) | 
| data (varchar) | data (varchar) | 
| created_on (timestamp) | created_on (timestamp) | 
| last_modified_on (timestamp) | last_modified_on (timestamp) | 
|  | isretired (varchar) NEW | 
|  | version (varchar) NEW | 
|  | versionhistory (varchar) NEW | 



Existing Key in the tableroot_org, framework, type, subtype, action, component

New Key for the tableroot_org, framework, type, subtype, action, component, isretired, version


### API's
/read

will only read a form if the form is not retired

`v1/form/read

`

request object


```
{
	"request": {
		"type": "contentcategory",
		"subType": "global",
		"action": "menubar",
		"framework": "*",
		"rootOrgId": "*",
        	"component": "portal"
    }        
}

```
/create

creates a form if the same form is not available in the DB

v1/form/create

request Object


```

{
	"request": {
		"type": "contentcategory",
		"subType": "global",
		"action": "menubar",
		"framework": "*",
		"rootOrgId": "*",
        "component": "portal",
         "data": {
                "templateName": "activities",
                "action": "list",
                "fields": [
                    {
                        "index": 1,
                        "title": "ActivityCourses",
                        "desc": "ActivityCourses",
                        "activityType": "Content",
                        "isEnabled": true,
                        "filters": {
                            "contentType": [
                                "Course"
                            ]
                        }
                    },
                    {
                        "index": 0,
                        "title": "ActivityTextbooks",
                        "desc": "ActivityTextbooks",
                        "activityType": "Content",
                        "isEnabled": true,
                        "filters": {
                            "contentType": [
                                "TextBook"
                            ]
                        }
                    }
                ]
            },
            "created_on": "2020-06-25T10:59:57.258Z",
            "last_modified_on": "2020-07-09T05:46:59.095Z"
    }        
}

```


/update

update will retire the existing form and creates a new form entry in the DB

v1/form/update

request Object


```
{
	"request": {
		"type": "contentcategoryA",
		"subType": "globalA",
		"action": "menubarA",
		"framework": "*",
		"rootOrgId": "*",
        "component": "portal",
         "data": {
                "templateName": "activities",
                "action": "list",
                "fields": [
                    {
                        "index": 1,
                        "title": "ActivityCourses",
                        "desc": "ActivityCourses",
                        "activityType": "Content",
                        "isEnabled": true,
                        "filters": {
                        "contentType": [
                                "Course"
                            ]
                        }
                    },
                    {
                        "index": 0,
                        "title": "ActivityTextbooks",
                        "desc": "ActivityTextbooks",
                        "activityType": "Content",
                        "isEnabled": true,
                        "filters": {
                        "contentType": [
                                "TextBook"
                            ]
                        }
                    }
                ]
            },
            "created_on": "2020-06-25T10:59:57.258Z",
            "last_modified_on": "2020-07-09T05:46:59.095Z"
    }        
}

```



### New API's
/list

will list all the forms in the DB

v1/form/list

request Object


```
{
	"request": {
		"type": "contentcategory",
		"subType": "global",
		"action": "menubar",
		"framework": "*",
		"rootOrgId": "*",
        "component": "portal"
    }        
}
```
/retire

will retire a form from the DB

`v1/form/retire'

request Object


```
{
	"request": {
		"type": "contentcategory",
		"subType": "global",
		"action": "menuba",
		"framework": "*",
		"rootOrgId": "*",
        "component": "portal",
        "version":"v1"
    }        
}
```
/restore

will restore a specific version of form and will make a new copy of the form with new version number

v1/form/restore

request object


```
{
	"request": {
		"type": "contentcategoryaaaa",
		"subType": "globalaaaaa",
		"action": "menubaraaaa",
		"framework": "*",
		"rootOrgId": "*",
        "component": "portal",
		"version":"v3"
    }        
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 
