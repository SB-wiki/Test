# Collaboration-for-content-creation

**Overview:** Adding collaborators to the content in sunbird. when added as a collaborator to the content the collaborator will have rights to edit the content. And at a single instance only one person should be able to edit the content. collaborators support will be provided to all types of content.&#x20;

**Problem Statement:** Users should be able to see a new section called "Collaborating on" in workspace and should be able to see the list of contents where the loggedin user is collaborator

#### Proposed Solution:

Create a new component for Collaborating on section and add a new entry in workspace side bar for showing Collaborating on section.

#### Implementation:

\*\*Module : \*\*

we will add this component in workspace module.

**Component:**

collaborating-on (new)

**Validation:** &#x20;

This section will be shown for the users having role of \["CONTENT\_CREATOR","CONTENT\_CREATION","CONTENT\_REVIEWER","CONTENT\_REVIEW","BOOK\_CREATOR"]

\*\*Functionalities in collaborating component : \*\*

* **Fetching list of content :**
  * composite search api will be used to fetch the content where logged in user is collaborating the contents

&#x20;                 &#x20;

* \*\*Filters : \*\*
  * filters will be similar to draft section

**Problem Statement:** Content should be edited by only one person at single instance and any other users who has access to edit lands to the editor need to restrict him and show the error popup

#### Proposed Solution:

#### Implementation:

\*\*Module : \*\*

workspace

**Components-affected :**

* collection-editor
* content-editor
* generic-editor

**Functionality :**

* on land of editor components on ngOninit api will be called to content service to check the content lock status,
* if content status is locked then a popup will be launched to show the content status locked info
* on click of close icon or done button will be redirected to workspace
* api url :  /v1/content/checklockstatus
* api type : POST
*   api payload :&#x20;

    {

    &#x20;     contentId:"",

    &#x20;     type: "content",

    &#x20; }
*   return value :&#x20;

    &#x20;  use case 1

    &#x20;  {

    &#x20;      locked: true,

    &#x20;      user : "4564-4-6456456"

    &#x20;  }

    &#x20; use case 2&#x20;

    &#x20;  {

    &#x20;      locked: false

    &#x20;  }
* if api return values is {locked:false} then editor will be loaded
* if  api return values is {locked:true} user details will be fetched and error popup will be shown with user name in the popup as shown below.![](<../../../../Design/FullExport/images/storage/Screen Shot 2018-09-21 at 6.48.52 PM.png>)

**Problem Statement :**

* on adding collaborator to the content an email should be triggered to the added collaborator&#x20;
* on removing collaborator to the content an email should be triggered to the removed collaborator

#### Proposed Solution:

#### Implementation :&#x20;

* In contentService update api proxy functions get the content details before updating&#x20;
* update the content using update api (existing function)
* once content update is done compare the collobarators array of previous data with the latest updated data and get&#x20;
  * added collabarators
  * removed collabarators
*   send mails to added and removed collabarators&#x20;

    * get template config using form api &#x20;
    * payload {type': 'notification',

    'action': 'collaboration\_add' /  'collaboration\_remove' ,

    'subType': 'email',

    'rootOrgId': req.get('x-channel-id')}

    * url : /api/data/v1/form/read
    * replace variables in template with dynamic values and trigger mail&#x20;
    * payload :var request = {

    name: '',

    subject: '',

    body: '',

    actionUrl: '',

    actionName:'',

    recipientEmails: '',

    recipientUserIds: ,

    emailTemplateType:,

    orgImageUrl:,

    orgName:'',

    fromEmail:''

    }

    * url : /v1/notification/email

\*\*Problem Statement : \*\* storing of locked content data and achieving locking and unlocking the content when needed

* **storage** : cassandra database will be used to store the data of the locked content
* locking and unlocking apis will be made in content service
*   model name :  "document\_lock"

    fields: {

    &#x20;    resourceId: text,

    &#x20;    resourceType: 'text',

    &#x20;    userId: 'text',

    &#x20;    createdOn: {

    &#x20;        type: 'timestamp',

    &#x20;        default: {'$db\_function': 'toTimestamp(now())'}

    &#x20;    }

    }
* while inserting into the model ttl time also will be set.
* Extensibility server side plugin will be implemented.
*   **Locking :**

    * &#x20;  New record will be inserted in cassandra table "document\_lock" when content needs to be locked.&#x20;
    * &#x20;  all the contents that are inserted in the db will have field called TTL and some default X amount of time need to set so that record in the db will automtically deleted
    * Use cases of Content Getting Locked :
    * when user lands to the editor page and content is in unlocked state
    * Implementation of locking content&#x20;
    * after editor fetchs the content when edit mode api will be triggered from the editor to content service by passing content id and type of content to it
    * API :
    * url : /content/v3/managelock
    * payload : POST request

    {

    &#x20;  contentType:"",

    &#x20;  documentId:"",

    &#x20;  action:"lock" or "unlock" or "update"

    }

    * return value : 200 status of success and error status on error
    * once editor is loaded , editor has to send heartbeats to update the ttl time of the record inserted in cassandra so that user can continue to edit the content.
*   **UnLocking** &#x20;

    * Once content is locked by inserting in the db it can be unlocked again by system or by calling api to unlock manually.
    * Use cases of Content Getting UnLocked :
    * editor window becomes inactive
    * logout from other tab
    * user went offline due to connection issue
    * idle for specific time
    * user clicked on close button in editor
    * window close
    * clicked on browser back button
    * Implementation of Unlocking content&#x20;
    * on close of the content from editor api will be triggered to unlock the content&#x20;
    * url : /content/v3/managelock
    * payload : POST request

    {

    &#x20;  contentType:"",

    &#x20;  documentId:"",

    &#x20;  action:"unlock"&#x20;

    }

    * system unlock happens on the following cases :
    * if heart beat stops from frontend and ttl time exceeded&#x20;

&#x20;                                                                                  &#x20;

![](<../../../../Design/FullExport/images/storage/locking\_journey (2).png>)

![](<../../../../Design/FullExport/images/storage/heartbeat (3).png>)

&#x20;                                                                                            &#x20;

![](<../../../../Design/FullExport/images/storage/offline\_handling (1).png>)

* Existing api changes in content service :
  * /v1/content/update/:contentId api in content service need to be modified middleware checks to allow collaborators to edit.
* Assumptions :
  * lock service will be imported as npm module in content service&#x20;
  * Editor has to call heartbeat calls to content service for every x minutes
  * Editor has to handle the idle time in editor page and autosave and trigger unlock api&#x20;
  * Editor has to call trigger unlock api on close of the editor
  * Editor has to call  /v1/content/checklockstatus api when editor comes offline to online to check the locked status of the content
  * Editor has to implement adding / removing collaborators

***

\[\[category.storage-team]] \[\[category.confluence]]
