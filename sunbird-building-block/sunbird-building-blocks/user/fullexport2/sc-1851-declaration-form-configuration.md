# SC-1851-Declaration-form-configuration

#### Requirement:

* User should be able to self declare information about a role (e.g. Teacher, Volunteer) he/she is playing for an organisation. the organisation must exist as an org entity within the platform.
* The list of fields that can be declared for a role should be driven via configuration.
* User should be able to declare multiple roles and for multiple orgs. One role is always associated with one org.
* Any user should be able self-declare information.
* Platform should also take care of backward compatibility for older version of mobile apps. It can be assumed all self declared information from older version are only for one role that is configured at platform level (e.g: Teacher).
* A future possibility is that users should be able to declare certain information which is not associated with any role also. The fields to be collected should be configurable by the org which is collecting the information. Please ensure that the design addresses this or can be easily extended to support this in future.

#### Proposed Solution 1:

Form APIs are used to store and retrieve UI forms currently. The same flow can be reused with some modifications.

Existing Table Structure:

```
CREATE TABLE qmzbm_form_service.form_data (
    root_org text,
    framework text,
    type text,
    subtype text,
    action text,
    component text,
    created_on timestamp,
    data text,
    last_modified_on timestamp,
    PRIMARY KEY ((root_org, framework, type, subtype, action, component))
);

```

Request to retrieve forms from form\_data table:

Url : [https://staging.ntp.net.in/api/data/v1/form/read](https://staging.ntp.net.in/api/data/v1/form/read)

Request Payload:

```
{
	"request": {
		"type": "user",
		"action": "update",
		"subType": "teacherDetails",
		"rootOrgId": "0126632859575746566",
		"component": "portal"
	}
}
```

Response:

Form API Read Response

```
{
	"id": "api.form.read",
	"params": {
		"resmsgid": "7e66f854-0712-4fce-accd-928b5c4f2b34",
		"msgid": "ea1631a6-eec9-4b03-a893-525be0dab43a",
		"status": "successful"
	},
	"responseCode": "OK",
	"result": {
		"form": {
			"type": "user",
			"subtype": "teacherdetails",
			"action": "update",
			"component": "portal",
			"framework": "*",
			"data": {
				"templateName": "defaultTemplate",
				"action": "update",
				"fields": [{
					"code": "state",
					"dataType": "text",
					"name": "state",
					"label": "State",
					"description": "Select state",
					"editable": true,
					"inputType": "select",
					"required": true,
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 1
				}, {
					"code": "district",
					"dataType": "text",
					"name": "district",
					"label": "District",
					"description": "Select district",
					"editable": true,
					"inputType": "select",
					"required": true,
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 2
				}, {
					"code": "phone",
					"dataType": "number",
					"name": "phone",
					"label": "Mobile Number",
					"description": "Enter mobile number",
					"editable": true,
					"inputType": "text",
					"required": true,
					"validation": [{
						"type": "required",
						"message": "Mobile number is required"
					}, {
						"type": "pattern",
						"value": "^[6-9]\\d{9}$",
						"message": "Entered mobile number is incorrect"
					}],
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 3
				}, {
					"code": "email",
					"dataType": "text",
					"name": "email",
					"label": "Email Address",
					"description": "Enter email address",
					"editable": true,
					"inputType": "email",
					"required": false,
					"validation": [{
						"type": "email",
						"message": "Entered email address is incorrect"
					}],
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 4
				}, {
					"code": "school",
					"dataType": "text",
					"name": "school",
					"label": "School/ Org name",
					"description": "Enter school name",
					"editable": true,
					"inputType": "input",
					"required": false,
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 5
				}, {
					"code": "udiseId",
					"dataType": "text",
					"name": "udiseId",
					"label": "School UDISE ID/ Org ID",
					"description": "Enter UDISE ID",
					"editable": true,
					"inputType": "input",
					"required": false,
					"validation": [{
						"type": "minlength",
						"value": "11",
						"message": "Minimum length should be 11 numbers"
					}, {
						"type": "maxlength",
						"value": "11",
						"message": "Maximum length should be 11 numbers"
					}, {
						"type": "pattern",
						"value": "^[0-9]*$",
						"message": "Only 11 digit number is allowed"
					}],
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 6
				}, {
					"code": "teacherId",
					"dataType": "text",
					"name": "teacherId",
					"label": "Enter ID as requested by your State/ Board/ Org",
					"description": "Enter ID",
					"editable": true,
					"inputType": "input",
					"required": true,
					"displayProperty": "Editable",
					"visible": true,
					"validation": [{
						"type": "pattern",
						"value": "^[A-Za-z0-9]*$",
						"message": "Special characters not supported"
					}],
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 7
				}]
			},
			"created_on": "2020-06-01T06:16:48.401Z",
			"last_modified_on": "2020-07-10T09:27:05.727Z",
			"rootOrgId": "*"
		}
	},
	"ts": "2020-07-23T13:41:48.417Z",
	"ver": "1.0"
}
```

#### Changes Required for Solution 1 to support role based configuration:

Existing flow can be reused, along with few changes:

1. Current flow supports form configuration in organisation level, need to change this to persona level.
2. subType column can be used to store the persona or new persona column can be added to the table, so that for each role we can configure the forms differently.
3. Validations are already included in the form definition currently.
4. Private fields array should be added to have the field names which require encryption.
5. This private fields array should be send during update to back end, so that back end can encrypt the data from these fields..
6. Create and update in Form APIs can be used to configure the forms for different persona from admin side.
7. Create and update API should also support the persona wise update of forms and should have the option to specify private fields array.
8. Default persona(‘default’) should be provided, which can be used to configure fields which do not specifically belong to one role.

Updated API response:

Response

```
{
	"id": "api.form.read",
	"params": {
		"resmsgid": "7e66f854-0712-4fce-accd-928b5c4f2b34",
		"msgid": "ea1631a6-eec9-4b03-a893-525be0dab43a",
		"status": "successful"
	},
	"responseCode": "OK",
	"result": {
		"form": {
			"type": "user",
			"subtype": "teacherdetails",
			"action": "update",
			"component": "portal",
			"framework": "*",
			"data": {
				"templateName": "defaultTemplate",
				"action": "update",
				"fields": [{
					"code": "state",
					"dataType": "text",
					"name": "state",
					"label": "State",
					"description": "Select state",
					"editable": true,
					"inputType": "select",
					"required": true,
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 1
				}, {
					"code": "district",
					"dataType": "text",
					"name": "district",
					"label": "District",
					"description": "Select district",
					"editable": true,
					"inputType": "select",
					"required": true,
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 2
				}, {
					"code": "phone",
					"dataType": "number",
					"name": "phone",
					"label": "Mobile Number",
					"description": "Enter mobile number",
					"editable": true,
					"inputType": "text",
					"required": true,
					"validation": [{
						"type": "required",
						"message": "Mobile number is required"
					}, {
						"type": "pattern",
						"value": "^[6-9]\\d{9}$",
						"message": "Entered mobile number is incorrect"
					}],
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 3
				}, {
					"code": "email",
					"dataType": "text",
					"name": "email",
					"label": "Email Address",
					"description": "Enter email address",
					"editable": true,
					"inputType": "email",
					"required": false,
					"validation": [{
						"type": "email",
						"message": "Entered email address is incorrect"
					}],
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 4
				}, {
					"code": "school",
					"dataType": "text",
					"name": "school",
					"label": "School/ Org name",
					"description": "Enter school name",
					"editable": true,
					"inputType": "input",
					"required": false,
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 5
				}, {
					"code": "udiseId",
					"dataType": "text",
					"name": "udiseId",
					"label": "School UDISE ID/ Org ID",
					"description": "Enter UDISE ID",
					"editable": true,
					"inputType": "input",
					"required": false,
					"validation": [{
						"type": "minlength",
						"value": "11",
						"message": "Minimum length should be 11 numbers"
					}, {
						"type": "maxlength",
						"value": "11",
						"message": "Maximum length should be 11 numbers"
					}, {
						"type": "pattern",
						"value": "^[0-9]*$",
						"message": "Only 11 digit number is allowed"
					}],
					"displayProperty": "Editable",
					"visible": true,
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 6
				}, {
					"code": "teacherId",
					"dataType": "text",
					"name": "teacherId",
					"label": "Enter ID as requested by your State/ Board/ Org",
					"description": "Enter ID",
					"editable": true,
					"inputType": "input",
					"required": true,
					"displayProperty": "Editable",
					"visible": true,
					"validation": [{
						"type": "pattern",
						"value": "^[A-Za-z0-9]*$",
						"message": "Special characters not supported"
					}],
					"renderingHints": {
						"fieldColumnWidth": "twelve"
					},
					"index": 7
				}],
				"privateFields":["phone","email"]
			},
			"created_on": "2020-06-01T06:16:48.401Z",
			"last_modified_on": "2020-07-10T09:27:05.727Z",
			"rootOrgId": "*"
		}
	},
	"ts": "2020-07-23T13:41:48.417Z",
	"ver": "1.0"
}
```

Assumptions:

* If adding new persona column, for existing data/forms in the table, it can be ‘default’.
* There is org and sub-org in the system. This design changes are on the assumption that external id details and configuration needs to be on org level.

Clarifications received:

* Do we need to add sub-org to the configurations?
  * Sub-org too will have an id, so it is up to portal like consumers to pick suborg form or rootorg form.
* How do a user register on multiple org?
  * User registration on multiple orgs is being discussed in SC-1837.
* How can a user switch between orgs or sub-orgs? After login or during login?
  * User switches roles, not orgs - refer to SC-1837. Org switch is taking it to next level and not sure if it is being considered.

#### Proposed Solution 2:

Tenant preference APIs in learners-service can be used for adding form config, based on roles. Read, add, and update tenant preferences API’s are existing.

* ‘role’ column can be renamed to ‘persona’
* There can be a ‘default’ persona for common config not specific to roles
* 'data' can store the fields details like, filed name , type, description, required or not and also the private flag which specifies encryption is needed or not

Existing table structure:

```
CREATE TABLE sunbird.tenant_preference (
    id text PRIMARY KEY,
    data text,
    key text,
    orgid text,
    role text,
    tenantname text
) 
CREATE INDEX inx_tp_key ON sunbird.tenant_preference (key);
CREATE INDEX inx_tp_userid ON sunbird.tenant_preference (orgid);

```

New Table Structure:

```
CREATE TABLE sunbird.tenant_preference (
    id text,
    data text,
    key text,
    orgid text,
    persona text,
    PRIMARY KEY (key, persona, orgid)
);
```

Existing Response Structure:{

&#x20;   "id": "api.org.preferences.read",

&#x20;   "ver": "v1",

&#x20;   "ts": "2020-07-27 13:28:47:737+0530",

&#x20;   "params": {

&#x20;       "resmsgid": null,

&#x20;       "msgid": "b530174a-5f9d-41c0-a304-acdabfbddf93",

&#x20;       "err": null,

&#x20;       "status": "success",

&#x20;       "errmsg": null

&#x20;   },

&#x20;   "responseCode": "OK",

&#x20;   "result": {

&#x20;       "tenantPreference": \[

&#x20;           {

&#x20;               "role": null,

&#x20;               "data": "",

&#x20;               "tenantname": null,

&#x20;               "id": "1",

&#x20;               "orgId": "\*",

&#x20;               "key": "content.textbook.save"

&#x20;           }

&#x20;       ]

&#x20;   }

}

Proposed Response Structure:{

&#x20;   "id": "api.org.preferences.read",

&#x20;   "ver": "v1",

&#x20;   "ts": "2020-07-27 13:28:47:737+0530",

&#x20;   "params": {

&#x20;       "resmsgid": null,

&#x20;       "msgid": "b530174a-5f9d-41c0-a304-acdabfbddf93",

&#x20;       "err": null,

&#x20;       "status": "success",

&#x20;       "errmsg": null

&#x20;   },

&#x20;   "responseCode": "OK",

&#x20;   "result": {

&#x20;       "tenantPreference": \[

&#x20;           {

&#x20;               "tenantname": null,

&#x20;               "id": "1",

&#x20;               "orgId": "\*",

&#x20;               "persona": “teacher”,

&#x20;               "key": "self-declaration",

&#x20;               "data": {

&#x20;                             "fields": \[{

&#x20;                                            "name": "state",

&#x20;                                            "dataType": "text",

&#x20;                                            "description": "Select state",

&#x20;                                            "required": true

&#x20;                             }, {

&#x20;                                            "name": "district",

&#x20;                                            "dataType": "text",

&#x20;                                            "description": "Select district",

&#x20;                                            "required": true

&#x20;                             }, {

&#x20;                                            "name": "phone",

&#x20;                                            "dataType": "number",

&#x20;                                            "description": "Enter mobile number",

&#x20;                                            "required": true,

&#x20;                                            "private": true

&#x20;                             }, {

&#x20;                                            "name": "email",

&#x20;                                            "dataType": "text",

&#x20;                                            "description": "Enter email address",

&#x20;                                            "required": false,

&#x20;                                            "private": true

&#x20;                             }, {

&#x20;                                            "name": "school",

&#x20;                                            "dataType": "text",

&#x20;                                            "description": "Enter school name",

&#x20;                                            "required": false

&#x20;                             }, {

&#x20;                                            "name": "udiseId",

&#x20;                                            "dataType": "text",

"                                             description": "Enter UDISE ID",,

&#x20;                                            "required": false

&#x20;                             }, {

&#x20;                                            "name": "teacherId",

&#x20;                                            "dataType": "text",

&#x20;                                            "description": "Enter ID",

&#x20;                                            "required": true

&#x20;                             }]

&#x20;                }

&#x20;           }

&#x20;       ]

&#x20;   }

}

***

\[\[category.storage-team]] \[\[category.confluence]]
