# Telemetry-Changes-of-2.6.0

### District Mapping (SC-1373)

Jira ID - [SC-1373 System JIRA](https://browse/SC-1373)

\*\*User location-DeviceLocation Telemetry - \*\* Will be triggered when the user clicks submits his location.

{

```
"edata": {

"type": "location-changed/location-unchanged","subtype": "state_dist_changed/state_changed/dist_changed", "id": "submit-clicked", "pageid": "location-popup",

  }

}
```

Possible values of fields -

1.type

*

```
"location-changed" - if location is changed.
```

*

```
"location-unchanged" ** - ** if location is un changed.
```

### **Impression Event** -

Will be trigged when location popup is flashing up on the screen.

```
{

context: {

env: 'user-location',

cdata: \[{id: 'user:state:districtConfimation', type: 'Feature'},

      {id: 'SC-1373', type: 'Task'}

    ]

  },

edata: {

type: 'view',

pageid: "location-popup",

uri: "/profile", // route from which popup is visible to user.

}

};
```

\*\*Telemetry log event - \*\* Will be triggered for API calls to update device or user location. For error and success, both cases these telemetries should be generated.&#x20;

```
{

"edata": {

"type": "update-location", // Required. Type of log (system, process, api_access, api_call, j

"level": "ERROR", // Required. Level of the log. TRACE, DEBUG, INFO, WARN, ERROR, FA

"message": "Updation of device profile failed", // Required. Log message

"pageid": "location-popup", // Optional. Page where the log event has happened

}

}
```

Possible values of fields -

1.level

*

```
"ERROR" :   When api fails.
```

*

```
"SUCCESS" : When API is success.
```

### Teacher-ID Verification (SC-1349)

Impression Event when the popup is visible

```js
{
      "eid": "IMPRESSION",
      "ets": 1575542490098,
      "ver": "3.0",
      "mid": "IMPRESSION:04a571d699d378b3db912ad9ab026820",
      "actor": {
        "id": "30ac4ca6-20b4-4e09-82cc-06758b6e624c",
        "type": "User"
      },
      "context": {
        "channel": "01285019302823526477",
        "pdata": {
          "id": "dev.sunbird.portal",
          "ver": "2.6.0",
          "pid": "sunbird-portal"
        },
        "env": "user-verification",
        "sid": "YieKCuJsgkgt0_hyc5i_GzGKeGlMeKrR",
        "did": "bfb7c01a5fd1fca853a6d22e64e38db3",
        "cdata": [
          {
            "id": "user:state:teacherId",
            "type": "Feature"
          },
          {
            "id": "SC-1349",
            "type": "Task"
          }
        ],
        "rollup": {
          "l1": "01285019302823526477"
        },
        "uid": "30ac4ca6-20b4-4e09-82cc-06758b6e624c"
      },
      "object": {
        
      },
      "tags": [
        "01285019302823526477"
      ],
      "edata": {
        "type": "view",
        "pageid": "user-verification-popup",
        "uri": "/learn"
      }
  }
```

Following Intrect Events for each button click

1.When User clicks on the NO button

```js
{ 
         "eid":"INTERACT",
         "ets":1575536161454,
         "ver":"3.0",
         "mid":"INTERACT:dbabb17de9891a20d9a70820fc7eaa10",
         "actor":{ 
            "id":"30ac4ca6-20b4-4e09-82cc-06758b6e624c",
            "type":"User"
         },
         "context":{ 
            "channel":"01285019302823526477",
            "pdata":{ 
               "id":"dev.sunbird.portal",
               "ver":"2.6.0",
               "pid":"sunbird-portal"
            },
            "env":"user-verification",
            "sid":"uWvg13UT2jPih2SIU4IVs4VOOF9F62x2",
            "did":"1df8f400acfbd15c2e8baedb0b5e9928",
            "cdata": [
      			{
        			id: 'user:state:teacherId',
        			type: 'Feature'
      			},
      			{
        			id: 'SC-1349',
        			type: 'Task'
      			}
    		],
            "rollup":{ 
               "l1":"01285019302823526477"
            },
            "uid":"30ac4ca6-20b4-4e09-82cc-06758b6e624c"
         },
         "object":{ 
         },
         "tags":[ 
            "01285019302823526477"
         ],
         "edata":{ 
            "id":"ext-user-verify-reject",
            "type":"click",
            "pageid":"user-verification-popup"
         }
  }
```

2. When User clicks on the YES button

```js
{ 
         "eid":"INTERACT",
         "ets":1575536161454,
         "ver":"3.0",
         "mid":"INTERACT:dbabb17de9891a20d9a70820fc7eaa10",
         "actor":{ 
            "id":"30ac4ca6-20b4-4e09-82cc-06758b6e624c",
            "type":"User"
         },
         "context":{ 
            "channel":"01285019302823526477",
            "pdata":{ 
               "id":"dev.sunbird.portal",
               "ver":"2.6.0",
               "pid":"sunbird-portal"
            },
            "env":"user-verification",
            "sid":"uWvg13UT2jPih2SIU4IVs4VOOF9F62x2",
            "did":"1df8f400acfbd15c2e8baedb0b5e9928",
            "cdata": [
      			{
        			id: 'user:state:teacherId',
        			type: 'Feature'
      			},
      			{
        			id: 'SC-1349',
        			type: 'Task'
      			}
    		],
            "rollup":{ 
               "l1":"01285019302823526477"
            },
            "uid":"30ac4ca6-20b4-4e09-82cc-06758b6e624c"
         },
         "object":{ 
         },
         "tags":[ 
            "01285019302823526477"
         ],
         "edata":{ 
            "id":"ext-user-verify-confirm",
            "type":"click",
            "pageid":"user-verification-popup"
         }
  }
```

3. When User clicks on Submit Button after entring the teacher ID

```js
{ 
         "eid":"INTERACT",
         "ets":1575536161454,
         "ver":"3.0",
         "mid":"INTERACT:dbabb17de9891a20d9a70820fc7eaa10",
         "actor":{ 
            "id":"30ac4ca6-20b4-4e09-82cc-06758b6e624c",
            "type":"User"
         },
         "context":{ 
            "channel":"01285019302823526477",
            "pdata":{ 
               "id":"dev.sunbird.portal",
               "ver":"2.6.0",
               "pid":"sunbird-portal"
            },
            "env":"user-verification",
            "sid":"uWvg13UT2jPih2SIU4IVs4VOOF9F62x2",
            "did":"1df8f400acfbd15c2e8baedb0b5e9928",
            "cdata": [
      			{
        			id: 'user:state:teacherId',
        			type: 'Feature'
      			},
      			{
        			id: 'SC-1349',
        			type: 'Task'
      			}
    		],
            "rollup":{ 
               "l1":"01285019302823526477"
            },
            "uid":"30ac4ca6-20b4-4e09-82cc-06758b6e624c"
         },
         "object":{ 
         },
         "tags":[ 
            "01285019302823526477"
         ],
         "edata":{ 
            "id":"ext-user-verify-submit",
            "type":"click",
            "pageid":"user-verification-popup"
         }
  }


```

4. When the teacher ID is wrong and a error Modal appears and user clicks on the OK button

```js
{
  "eid": "INTERACT",
  "ets": 1575536161454,
  "ver": "3.0",
  "mid": "INTERACT:dbabb17de9891a20d9a70820fc7eaa10",
  "actor": {
    "id": "30ac4ca6-20b4-4e09-82cc-06758b6e624c",
    "type": "User"
  },
  "context": {
    "channel": "01285019302823526477",
    "pdata": {
      "id": "dev.sunbird.portal",
      "ver": "2.6.0",
      "pid": "sunbird-portal"
    },
    "env": "user-verification",
    "sid": "uWvg13UT2jPih2SIU4IVs4VOOF9F62x2",
    "did": "1df8f400acfbd15c2e8baedb0b5e9928",
    "cdata": [
      		{
        		id: 'user:state:teacherId',
        		type: 'Feature'
      		},
      		{
        		id: 'SC-1349',
        		type: 'Task'
      		}
    ],
    "rollup": {
      "l1": "01285019302823526477"
    },
    "uid": "30ac4ca6-20b4-4e09-82cc-06758b6e624c"
  },
  "object": {
    
  },
  "tags": [
    "01285019302823526477"
  ],
  "edata": {
    "id": "ext-user-verify-fail",
    "type": "click",
    "pageid": "user-verification-popup"
  }
}
```

5. On success of the teacher verification the success pop-up is shown and when user clicks on the ok button of this popup

```js
{
  "eid": "INTERACT",
  "ets": 1575536161454,
  "ver": "3.0",
  "mid": "INTERACT:dbabb17de9891a20d9a70820fc7eaa10",
  "actor": {
    "id": "30ac4ca6-20b4-4e09-82cc-06758b6e624c",
    "type": "User"
  },
  "context": {
    "channel": "01285019302823526477",
    "pdata": {
      "id": "dev.sunbird.portal",
      "ver": "2.6.0",
      "pid": "sunbird-portal"
    },
    "env": "user-verification",
    "sid": "uWvg13UT2jPih2SIU4IVs4VOOF9F62x2",
    "did": "1df8f400acfbd15c2e8baedb0b5e9928",
    "cdata": [
      	{
        	id: 'user:state:teacherId',
        	type: 'Feature'
      	},
      	{
        	id: 'SC-1349',
        	type: 'Task'
      	}
    ],
    "rollup": {
      "l1": "01285019302823526477"
    },
    "uid": "30ac4ca6-20b4-4e09-82cc-06758b6e624c"
  },
  "object": {
    
  },
  "tags": [
    "01285019302823526477"
  ],
  "edata": {
    "id": "ext-user-verify-success",
    "type": "click",
    "pageid": "user-verification-popup"
  }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
