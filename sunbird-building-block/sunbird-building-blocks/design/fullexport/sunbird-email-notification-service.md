# Sunbird-Email-Notification-Service

**Overview:**    Sunbird email notification service is built to send an email. Any other service can call this service to notify the user.AS of now email service is configured by installation,

but now we need to channel based email configuration.

**Problem Statement:**    How to do the email configuration per tenant(channel) for different types of email (content review,publish )etc.

**Proposed Solution:**      As per the existing api specification:  We will used data base to store the email template file. File will be store per tenant for different kind of email. System will always have one default email template for

each email type, in case some of the tenant haven't set the template , he will get email with predefined template.

**Table structure :**

**Name of table** : email\_template

| attribute     | description                                  |
| ------------- | -------------------------------------------- |
| name          | name of the template and must be unique.(PK) |
| template      | complete email body                          |
| createdOn     | when it's created                            |
| lastUpdatedOn |                                              |
| createdBy     | userId of template creator                   |
| lastUpdatedBy |                                              |
|               |                                              |
|               |                                              |

Current Notification Service API:

```
    URI : "/v1/notification/email"

          Request : 

                   {

                     "params": { },

                     "request":{

                             "name": "Amit",

                             "subject": "NOTIFICATION MAIL SEND TESTING 001",

                             "body": "This the testing Notification mail body",

                             "actionUrl": "[https://lh3.googleusercontent.com/Yh6ZlCb8dQIDIwAWbwd2jboFCyTqq8wc2xbLMs9ykYemOX3vjOTtT6Npfbk-jFkCciwY=w300](https://lh3.googleusercontent.com/Yh6ZlCb8dQIDIwAWbwd2jboFCyTqq8wc2xbLMs9ykYemOX3vjOTtT6Npfbk-jFkCciwY=w300)",

                             "actionName": "Download Image",

                             "recipientEmails": \[],

                             "recipientUserIds": \["e4d4f77c-7d5f-4436-a01e-1fe129af875a"],

                             "emailTemplateType":"rejectContent",

                             "tempPassword":"gvvucd637",

                             "userName":"Alpha"

                             "recipientSearchQuery":{

                              "filters":{

                                "rootOrgId":"",

                                 "organisations.role":\[]

                               }

                             }

                              }

                        }



  existing templates:



       1. contentFlaggedMailTemplate

       2. acceptFlagMailTemplate

       3. rejectFlagMailTemplate

       4. publishContentMailTemplate

       5. rejectContentMailTemplate

       6. welcomeMailTemplate

       7. unlistedPublishContentMailTemplate

       8. emailtemplate(default)




```

***

\[\[category.storage-team]] \[\[category.confluence]]
