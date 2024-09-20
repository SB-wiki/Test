# Sunbird-Portal----Implementation-of-Angular-Stepper-for-onboarding-flows

### Introduction:

* [Introduction:](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#introduction:)
* [Existing workflow:](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#existing-workflow:)
* [Problem Statement:](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#problem-statement:)
* [Phase 1: Key design problems:](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#phase-1:-key-design-problems:)
* [Phase 2 : Key design problems:](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#phase-2-:-key-design-problems:)
* [Design](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#design)
* [Solution 1 :](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#solution-1-:)
* [Solution 2 :](sunbird-portal-implementation-of-angular-stepper-for-onboarding-flows.md#solution-2-:) This document describes the design approach of angular stepper for on-boarding flows.

Background: **Jira Ticket Ref :-** [ https://project-sunbird.atlassian.net/browse/ED-1057](https://project-sunbird.atlassian.net/browse/ED-1058)

**DiscussionThread Ref :-** [https://github.com/orgs/Sunbird-Ed/discussions/335](https://github.com/orgs/Sunbird-Ed/discussions/335)

**Wireframes:-** [https://www.figma.com/file/QlF2TDkmkpiIwBQcHS49nZ/Diksha-Steppers-Design?node-id=0%3A1\&t=GGbZygR6BGK1uF3u-0](https://www.figma.com/file/QlF2TDkmkpiIwBQcHS49nZ/Diksha-Steppers-Design?node-id=0%3A1\&t=GGbZygR6BGK1uF3u-0)

Currently, on the portal there are 3 on-boarding steps. Every adopter inherits this on-boarding workflow by default.

### Existing workflow:

**Here are some screenshots of the existing onboarding process:-**

* Screenshot 1: UserType

![](../../../../Others/SunbirdED/images/storage/gbxCAtsQE5Nm8C96i\_ySMXluo-eHgKPAc-56E93gfnx4xO0Lc9QnIxjkZ3F-VGF4KJO\_HjhE6vYF9TPHQGbMS32hEL\_iMOY7QVjVrbibZ8U2Tu\_wAGZ1g7zjQuU0Svigk1KaFdoFcnq7hyPDASCrLudkkWHACqUWuLAL662ZBsuJPLc-H0KkH7ead9NT9w)

* Screenshot 2: framework categories selection

![](../../../../Others/SunbirdED/images/storage/FQ1BEB2OpMH56oPeXvAsCha\_vuty45k9XXVOM0EtxCrTLNi-3T9utr4QOzc26qLJp0rC\_FfkKudg7ooKAu5S24ZzHzKZ\_PpnIsKl5MVsBiKg82IlswOWk4WzkdjXMUmGli7GI81H3pAab7uRq1ANhGHEsbhT54aoEnRSjWqVIngP1seqAOxxKLVM4UqNAw)

* Screenshot 3: Location

![](../../../../Others/SunbirdED/images/storage/nfXYiZp0VGjsBGAMWS5ENC9eRyQMVqrH5nntLbs6372QZmBo4F1Ke8ktrCGD\_0wGyAP-dilIjl4qh-xVEEirOz3Br1YqnUHMNGKCV8OHh8Ru9SEKpiSE2vvOKFa4NzjOClr1JnDtE5YXCv8X8l3WSxTY3VA-65ijp945wJ8JNLvvYn7vqI-1gjVvw7AypA) **Change request:** As part of [ED-1058 System JIRA](https://browse/ED-1058) onboarding flow should be configurable.

### Problem Statement:

In accordance with the existing design. code changes are needed for adding a new step or removing one of these on-boarding steps.

1. How adopter can change the stage position.
2. How adopter can remove/hide the stage.
3. How adopter can add/show the stage.
4. The number of steps needed to proceed is not obvious to users.
5. Steps cannot be skipped by users.

### Phase 1: Key design problems:

* How to hide/show the on-boarding workflow based on configuration.
* How to change the sequence of on-boarding workflow based on configuration.

### Phase 2 : Key design problems:

* How to add new on-boarding-workflow using SB-Forms.
* How to add new on-boarding workflow(pdf,video player) using form config.

### **Design** :

### Solution 1 :

* **All these on-boarding popup can be removed using a form config flag.**
  * The form config flag can be used to remove the popup from appearing when the user visits the page. This can be done by setting the flag to false.

**Pros:**

* Adopter can hide/show all these on-boarding steps using form config with minimal effort.
* No code level changes required.

**Cons:**

* If we removed all these on-baording steps. existing workflow may break (framework categories selection, Location, UserType data may not come).
* Unable to set the framework categories selection, Location, UserType data to localstorage to load portal data.

### Solution 2 :

**In accordance with the problem statement, we decided to use Configurable Angular steppers.**

* The Configurable Angular stepper is a component that allows users to navigate through a series of steps. It is a good way to guide users through a process, The stepper can be configured to display different types of stage.
* Stepper is based on form Config.

**Created form config for on-boarding stepper:-**

* Sample Curl to create stepper form config.

```json
curl --location --request POST '{<please specify your host name>}/api/data/v1/form/create' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: <please use your Bearer Token to create this form>' \
--data-raw '{
    "request": {
        "type": "useronboardingsteps",
        "action": "onboarding",
        "subType": "global",
        "rootOrgId": <please specify your root org id>,
        "component": "portal",
        "data":{
        
        "fields": 
        [
  {
    "stepLabel": "BMGS",
    "description": "Form step to accept BMGS from User",
    "isVisable": true,
    "sequence": 1,
    "isMandatory": true,
    "renderOptions": {
      "type": "component",
      "name": "BMGS"
    },
  },
  {
    "stepLabel": "UserType",
    "description": "Form step to accept userType from User",
    "isVisable": true,
    "sequence": 2,
    "isMandatory": true,
    "renderOptions": {
      "type": "component",
      "name": "userType"
    },
  },
  {
    "stepLabel": "Location",
    "description": "Form step to accept Location from User",
    "isVisable": true,
    "sequence": 3,
    "isMandatory": true,
    "renderOptions": {
      "type": "component",
      "name": "Location"
    },
  },
  {
    "stepLabel": "Simple HTML Page",
    "description": "Form step to accept HTML Page",
    "isVisble": false,
    "sequence": 4,
    "isMandatory": false,
    "renderOptions": {
      "type": "html",
      "content": "<div><h2> resources for an interesting learning experic</h2></div>"
    }
  }
]
      }
    }
}'
```

**Here are some Screenshot for Stepper on-boarding process :-**

* Stepper Screenshot 1: UserType&#x20;

![](../../../../Others/SunbirdED/images/storage/7\_qezbeJg5NDOlb71lCMTHmNJd8NDE94eqiThUewOsKxtP51bVa-5DCVY5W0Iqr-NxbrEJ\_3lgBmjpHLYGiuW90yKn1LffGNM\_QQz4lq-nJsl6HYsCbE7dh-k7LqgFs71MwCDRqz0lmG\_iKBP6GB-cJe1b5a3boRTVQxTi3j6UxMokbHYakAu8hAQHVt-Q)

* Stepper Screenshot 2 :- Location&#x20;

![](../../../../Others/SunbirdED/images/storage/yBkOgNI160A1EvfsYaKUtHtuqRB80CXX1kttxUqIzDTXrcS0AI0sRfEpZgfFxX29zFaKQ9mvVBnYs3rHPKVvptNXRxIQaFpJoOTQi-Y0yMVzQ5mBJK1qZWpzjKnAcdSv-8KfepaxiXEww9MqEwlbzcXxBCKhCHDU1VrTlTaxlEi69Q9cAl3ZMBNkPXRvxA)

* Stepper Screenshot 3:- framework categories selection

![](../../../../Others/SunbirdED/images/storage/Tts5mt3ZmkAu7MZdl5Wcgc7cOYEVINkeQGeBkTs-t4au6hAOnwpm81s4UxBIdkUMq8eyeIkJSROQPAD6pr5kpaYxBW-prZf469g5V1t4zTmskXHHIehReJG65ThnY8iKPec6gxiSLG4vXR0nPgv9VzSvP4r9XPquCQxpRY6ZAhMXFUx-YyEOHwjP67tG1A)

* Stepper Screenshot 4:- Preview

![](../../../../Others/SunbirdED/images/storage/zXcncilqoukNji8QALRCQhESOlAG2Z7qXgXtfeuUAEd3cATM3jrOqIkgxqNqoGUfRZZqqi4cla3VAc2Ty3ExUF2YiDw1nB4DWyLRN7cMup5qoT11hbuCpDuJNuMN1WPk4o5\_rTeTfrgm9w4nowG-TYiPXqBKTAlj-mSsj-FRAqIFPzKyy43cLAEAEJQGqA) **Pros:**

* An adopter can see what steps need to be taken.
* Adopter can change the on-boarding steps sequence based on form config.
* Adopter can hide/show the on-boarding steps based on form config.

**Cons:**

* Any new on-boarding steps has to be added code has to be written.
* Any on-boarding steps has to be altered code has to added.
* Design cannot add/altered the on-boarding steps using config.

**Reference links**

* **Angular stepper ref** : [https://material.angular.io/components/stepper/overview](https://material.angular.io/components/stepper/overview)
* **Jira Ticket Ref :-** [ https://project-sunbird.atlassian.net/browse/ED-1057](https://project-sunbird.atlassian.net/browse/ED-1058)
* **DiscussionThread Ref :-** [https://github.com/orgs/Sunbird-Ed/discussions/335](https://github.com/orgs/Sunbird-Ed/discussions/335)
* **Wireframes:-** [https://www.figma.com/file/QlF2TDkmkpiIwBQcHS49nZ/Diksha-Steppers-Design?node-id=0%3A1\&t=GGbZygR6BGK1uF3u-0](https://www.figma.com/file/QlF2TDkmkpiIwBQcHS49nZ/Diksha-Steppers-Design?node-id=0%3A1\&t=GGbZygR6BGK1uF3u-0)

***

\[\[category.storage-team]] \[\[category.confluence]]
