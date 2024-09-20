# Configuring-Sunbird-Email-Notification-in-Content-service

## Background:

Currently, Sunbird email service is used to send the notification to the user on different actions in review workflow. Sunbird uses same default email templates for all workflow actions such as publish, request changes.

## Problem statement:

Email template configuration at action/channel level for review workflow in content service should be provided

## Proposed Solution:

### Default Templates

Sunbird comes with default templates for actions in content review workflow. Below are the default templates present in Sunbird.

1. Send for review
2. Request for changes
3. Publish

Default templates will be stored in sunbird middleware(learner service) and configuration for the template will be stored as form config. Default template can also be configured at the installation time using Form API's.

Below is the sample template configuration for different content review workflows stored in form service.

Publish{

"request": {

"type": "notification",

"action": "publish",

"subType": "email",

"data": {

"templateName": "publishedTemplate",

"action": "publish",

"fields": \[{

"body": "Congratulations! The content that you had submitted has been accepted for publication. It will be available for usage shortly.\
\
Content Type: \{{Content type\}}\
Title: \{{Content title\}}\
Link: \{{Content link\}}\
",

"subject": "Congratulations, your content is live! Content Type: \{{Content type\}}, Title: \{{Content title\}}",

"logo": "[https://dev.open-sunbird.org/assets/images/sunbird\_logo.png](https://dev.open-sunbird.org/assets/images/sunbird\_logo.png)"

}]

}

}

}

Request Changes{

"request": {

"type": "notification",

"action": "requestForChanges",

"subType": "email",

"data": {

"templateName": "requestForChangesTemplate",

"action": "requestForChanges",

"fields": \[{

"body": "We acknowledge your contribution and effort in creating content for us. However, we are unable to accept the content that you submitted.\
We look forward to a more meaningful relationship with you, the next time around.\
\
Content Type: \{{Content type\}}\
Title: \{{Content title\}}\
Link: \{{Content link\}}\
Reviewer name: \{{Reviewer name\}}\
",

"subject": "Our sincere apologies! Content Type: \{{Content type\}}, Title: \{{Content title\}}",

"logo": "[https://dev.open-sunbird.org/assets/images/sunbird\_logo.png](https://dev.open-sunbird.org/assets/images/sunbird\_logo.png)"

}]

}

}

}

Send for Review{

"request": {

"type": "notification",

"action": "sendForReview",

"subType": "email",

"data": {

"templateName": "sendForReviewTemplate",

"action": "sendForReview",

"fields": \[{

"body": "A content has been submitted for review.\
\
Content Type: \{{Content type\}}\
Title: \{{Content title\}}\
Creator: \{{Creator name\}}\
Link: \{{Content link\}}\
",

"subject": "Content has been submitted for review! Content Type: \{{Content type\}}, Title: \{{Content title\}}",

"logo": "[https://dev.open-sunbird.org/assets/images/sunbird\_logo.png](https://dev.open-sunbird.org/assets/images/sunbird\_logo.png)"

}]

}

}

}

In the above request,&#x20;

1. type:  is the type of form.
2. action: workFlow action.
3. subType: type of notification.
4. templateName: name used to store in Cassandra DB.
5. body: Body of the Email.
6. subject: subject of Email.
7. logo: log used in Email. If not sent default will be used.

Below placeholders are used to dynamically change the content information. So, it is recommended to keep this respective fields:

* \{{Content type\}}
* \{{Content title\}}
* \{{Content link\}}
* \{{Creator name\}}
* \{{Reviewer name\}}

### Custom templates:

We can also create custom email template channel/tenant specific. If customized templates are not present, the default template will be used to send email for different actions in review workflows.

If any tenants want to configure their own email template, they can do so by adding new email template configurations in Form API and manually inserting the new template in Casandra DB of Sunbird middleware service.

#### Instruction to create custom templates

* Templates name configured in Form API should be in "slug\_workflowAction" format.
* Templates name used to store in Cassandra DB should be same as configured in Form API
* &#x20;rootOrgId should be added in form API request along with other fields.
* &#x20;Placeholders should be there in their respective fields.
* &#x20;If the custom template is configured in form service, then custom template with the same name should also be added in Learner service(sunbird middleware). If not added Learner service will throw an error.

For example, If slug is "sunbird" and action is send for review, template name should be "sunbird\_sendforReviewTemplate". Sample custom template configuration.

{

"request": {

"type": "notification",

"action": "sendForReview",

"subType": "email",

"rootOrgId": "0123166367624478721",

"data": {

"templateName": "sendForReviewTemplate",

"action": "sendForReview",

"fields": \[{

"body": "A content has been submitted for review.\
\
Content Type: \{{Content type\}}\
Title: \{{Content title\}}\
Creator: \{{Creator name\}}\
Link: \{{Content link\}}\
",

"subject": "Content has been submitted for review! Content Type: \{{Content type\}}, Title: \{{Content title\}}",

"logo": "[https://dev.open-sunbird.org/assets/images/sunbird\_logo.png](https://dev.open-sunbird.org/assets/images/sunbird\_logo.png)"

}]

}

}

}

### Limitation:

* Only predefined placeHolder can be dynamically replaced with content data while sending mail

***

\[\[category.storage-team]] \[\[category.confluence]]
