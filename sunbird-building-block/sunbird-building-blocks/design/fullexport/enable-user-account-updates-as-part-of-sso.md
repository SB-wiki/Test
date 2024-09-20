# Enable-user-account-updates-as-part-of-SSO

Problem Statement

#### Related Jira Task - [SB-11433 System JIRA](https://browse/SB-11433)

```js
{
    "jti": "<random_string>",
    "iss": "<issuer_id>",
    "sub": "<user_external_id>",
    "aud": "<base_url>",
    "iat": 1498556656,
    "exp": 1498560256,
    "name": "<name_of_the_user>",
    "state_id": "<channel_name_of_the_tenant>",
    "school_id": "<pre_created_school_external_id>",
    "roles": ["<role1>", "<role2>"],
    "redirect_uri": "<base_url>/resources"
}
```

The v2 Single Sign On(SSO) API allows user to login to DIKSHA if a user account is already present and creates an account for the user, if it is not present.

As of now, **name, school\_id, roles** fields are only used in creation flow and they are being ignored in subsequent SSO logins of the users.

The requirement is, if any of the fields( **name, school\_id, roles**\* ) change at the state database, it should reflect in DIKSHA as well during subsequent logins of the existing SSO users.

| Change in field                 | Required Action                                                                                                            |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| name (firstName)                | Update the first name of the user  (User Update API)                                                                       |
| school\_id (orgExternalId **)** | Add the user to the new school and remove from existing school, if any (Add Member to Org and Remove Member from Org APIs) |
| roles\*                         | Assign the new roles to the user replacing the existing ones(Assign role API)                                              |

Content service has the SSO API and the other consumed APIs are at learner service.

1. Content service has access to the latest data( **name, orgExternalId, roles** ) from SSO Payload
2. Content service has access to following data from DIKSHA - **firstName, organisationId, roles**

While name can be compared against firstName, for org and roles comparison, equivalent organisationId of the orgExternalId should be available.

\***Role update was reverted due to this change request**

Approach 1Use Organisation Search API - Content service can query learner service for org details using orgExternalId

| Pros                                                                                                                                                                                     | Cons                                                                                                                            |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Simplest and inline with current approach.  At present, there's a user read call to fetch the user details. This call would be a similar one to fetch the linked organisations' details. | For each SSO login, one extra API call (Org Search API) overhead will be added even if there's no change in the data in payload |

Approach 2At present, only linked organisationId is available at user details in elastic search at learner service. The corresponding orgExternalId field can also be added to user details, so that all requisite details( **name, orgExternalId, roles** ) to compare the data against payload would be available in the response of user read call itself.

| Pros                          | Cons                                                                                                                                                                         |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| No extra API calls are needed | When external id of an organisation is updated, user sync of all the linked users has to be done to make sure orgExternalId is latest in elastic search for each linked user |

Approach 3On successful SSO login, content service can push the payload into a kafka topic, from which an LMS samza job can read the data and do the needful(Approach 1).

| Pros                                                                                          | Cons                                                                                                                                                                                     |
| --------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| No overhead to SSO API. Comparison of fields and updation, if needed, happens asynchronously. | It's very rare for the payload data of a particular user to change. Though the execution is asynchronous, still there's an overhead to the system to perform this check for each request |

```js
{
  // about the event
  "identifier": "00001",                                  // unique event id
  "ets": 1556018741532,                                   // epoch timestamp of event (time in milli-seconds)
  "operationType": "UPDATE",                              // operation to be done
  "eventType": "transactional",                           // type of event
  "objectType": "user",                                   // affected entity

  // event data
  "event": {
    "userExternalId": "598345234",                        // externalId of the user
    "nameFromPayload": "John Doe",                        // name of the user from payload
    "channel": "demochannel",                             // channel of the tenant
    "orgExternalId": "52452345",                          // orgExternalId of the linked org
    "roles": [                                            // roles of the user
      "CONTENT_CREATOR",
      "CONTENT_REVIEWER"
    ],
    "userId": "aa28fa93-bcb6-449f-8312-fd842f6e971d",     // sunbird internal id of the user
    "organisations": [                                    // linked organisations' data
      {
        "organisationId": "0127474328062853120",
        "userId": "aa28fa93-bcb6-449f-8312-fd842f6e971d",
        "roles": [
          "CONTENT_CREATOR",
          "PUBLIC"
        ]
      }
    ],
    "firstName": "John Doe"                               // firstName of the user in the system
  }
}             
```

APIs to be consumed:

| API Name                | API Endpoint                      | Usage                                                                                 |
| ----------------------- | --------------------------------- | ------------------------------------------------------------------------------------- |
| Organisation Search API | /api/org/v1/search                | To find the organisationId of the linked organisation using orgExternalId and channel |
| Private User Update API | \{{host\}}/private/user/v1/update | To update name, organisation associations and roles of the user                       |

Change RequestCR - [https://project-sunbird.atlassian.net/browse/SB-11433?focusedCommentId=41101\&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-41101](https://project-sunbird.atlassian.net/browse/SB-11433?focusedCommentId=41101\&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-41101)

As per this change request, in SSO updates, roles will be ignored.

When school id is changed, user will be associated to the new school with existing roles for the user in the system.

***

\[\[category.storage-team]] \[\[category.confluence]]
