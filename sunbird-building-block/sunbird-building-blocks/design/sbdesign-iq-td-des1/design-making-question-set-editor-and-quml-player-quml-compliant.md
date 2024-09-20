# \[Design]---Making-Question-Set-Editor-and-QuML-Player-QuML-Compliant

BackgroundWhile comparing the existing inQuiry question and question set metadata with QuML specs we found a few gaps. Below are the properties having some differences from the QuML specs:

**Question metadata which has some differences from the QuML specs are:-**

* responseDeclaration
* media

**responseDeclaration** Currently, the responseDeclaration is stored in the below format but maxScore is not allowed in it and   outcomes property is not allowed inside correctResponse

```
"responseDeclaration": {
       "response1": {
           "maxScore": 1, // maxScore is not allowed here
           "cardinality": "single",
           "type": "integer",
           "correctResponse": {
               "value": "0",
               "outcomes": {
                   "SCORE": 1
               } // outcome is not allowed here, only property ‘value’ is allowed
           },
           "mapping": []
       }
   }
```

**Proposed Solution for responseDeclaration** **Editor Changes:** Instead of keeping maxScore and outcomes in responseDeclaration we can store maxScore in outcomeDeclaration as below:

```
"outcomeDeclaration": {
    "maxScore": {
      "cardinality": "single",
      "type": "integer",
      "defaultValue": 3
    }
  },
```

We will not store outcomes.score inside correctResponse because maxScore and outcomes.score holds the same value.

For newly created single select MCQ question responseDecleration and outcomeDeclaration will be stored in the below format:

```
"responseDeclaration": {
    "response1": {
      "cardinality": "single",
      "type": "integer",
      "correctResponse": {
        "value": 2
      },
      "mapping": [
        {
          "value": 2,
          "score": 3
        }
      ]
    }
  },
  "outcomeDeclaration": {
    "maxScore": {
      "cardinality": "single",
      "type": "integer",
      "defaultValue": 3
    }
}
```

For multi-select MCQ, responseDecleration and outcomeDeclaration will be in the below format:

```
"responseDeclaration": {
    "response1": {
      "cardinality": "single",
      "type": "integer",
      "correctResponse": {
        "value": [2,1]
      },
      "mapping": [
        {
          "value": 2,
          "score": 0.5
        },
        {
          "value": 1,
          "score": 0.5
        }
      ]
    }
  },
  "outcomeDeclaration": {
    "maxScore": {
      "cardinality": "single",
      "type": "integer",
      "defaultValue": 1
    }
  },
```

We will store the maxScore inside the outcomeDeclaration property for new question creation using v2 API.

* **No Data Migration (Recommended)**
  * We will do these changes as part of the v2 API and will give the data in the above format.
  * If a user edits the old question using v2 API, We will store maxScore inside the outcomeDeclaration and remove the maxScore from the responseDeclaration.
* **Data Migration (Not Recommended)**
  * We can do the data migration for the old questions and update the question metadata with the format mentioned above.
  * This solution is not recommended because, with the migration of old questions, the old mobile app will break.

**Player Changes:**

* The player will check if the question is having the outcomeDeclaration in the metadata of the question and what’s the maxScore value present in it.
* If the outcomeDeclaration property is found then the player will use it as is it.
* If the question does not have the outcomeDeclaration property in the metadata then the player will look for the maxScore property in the responseDeclartion.

**media** Currently, Question metadata contains media in the below format:

```
"media": [{
   "id": "do_2136952965043896321346",
   "type": "image", //instead of ‘type’ it should be ‘mediaType’
   "src": "/assets/public/content/assets/do_2136952965043896321346/mountain.jpeg",
   "baseUrl": "https://dev.inquiry.sunbird.org"
}]] ]></ac:plain-text-body></ac:structured-macro><p>As per QuML specs, it should be stored in the below format:</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="9870593f-0022-4550-8443-fd0bf6cb9164"><ac:plain-text-body><![CDATA["media": [{
   "id": "do_2136952965043896321346",
   "mediaType": "image",
   "src": "/assets/public/content/assets/do_2136952965043896321346/mountain.jpeg",
   "baseUrl": "https://dev.inquiry.sunbird.org"
}]] ]></ac:plain-text-body></ac:structured-macro><h4><strong><u>Proposed Solution for media</u></strong></h4><h5><strong><u>Editor Changes:</u></strong></h5><ul><li><p><strong><ac:inline-comment-marker ac:ref="32c15f6a-992e-4e2e-a0e5-26be9e88ef88">Update QuML specs </ac:inline-comment-marker><span style="color: rgb(151,160,175);"><ac:inline-comment-marker ac:ref="32c15f6a-992e-4e2e-a0e5-26be9e88ef88">(Recommended)</ac:inline-comment-marker></span></strong></p><ul><li><p><ac:inline-comment-marker ac:ref="32c15f6a-992e-4e2e-a0e5-26be9e88ef88">If we can update the QuML spec then change will not be required in the editor and player.</ac:inline-comment-marker></p></li></ul></li><li><p><strong>No Data Migration <span style="color: rgb(151,160,175);">(Recommended)</span></strong></p><ul><li><p>If we are not updating the QuML specs then we have to do the following changes:</p><ul><li><p>For the new question creation, we will store the media in a new format using v2 API.</p></li><li><p>If the user edits the old question using v2 API, we will check if the <code>type</code> is present in the media object, and convert it to <code>mediaType</code> while editing the question.</p></li></ul></li></ul></li></ul><ul><li><p><strong>No migration <span style="color: rgb(151,160,175);">(Not Recommended)</span></strong></p><ul><li><p>We can do the data migration for the old questions and update the question with the above-mentioned format. </p></li><li><p>This solution is not recommended because, with the migration of old questions, the old mobile app will break.</p></li></ul></li></ul><h5><strong><u>Player Changes:</u></strong></h5><p>(Note: Following changes will not be required if we are updating the QuML specs as mentioned above).</p><ul><li><p>The player will first check if the question media have <code>mediaType</code> property if not it will check in <code>type</code> property.</p></li></ul><hr /><h2><strong>QuestionSet metadata which has some differences from the QuML specs is:-</strong></h2><ul><li><p>timeLimits</p></li></ul><h3><strong><span style="color: rgb(7,71,166);">timeLimits</span></strong></h3><p>Time limits are currently being stored in the question set metadata as below:</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="8aa1bccd-9daa-47e1-9de0-cca1ebef9567"><ac:parameter ac:name="language">json</ac:parameter><ac:plain-text-body><![CDATA[timeLimits: {
   "maxTime": "240",
   "warningTime": "60"
}
```

The use of maxTime is to show the timer on the QuML player and the use of warningTime is to indicate the time remaining to complete the question set.

![](../../../../Design/sbdesign-iq-td-des1/images/storage/maxTime.png)![](../../../../Design/sbdesign-iq-td-des1/images/storage/warningTime.png)But as per the QuML schema, timeLimits\` should be stored in the below format:

```json
timeLimits:
{
  "description": "Time limits for the complete set and/or for each question in the question set.",
   questionset: {
           min: number,
           max: number
   },
   question: {
           min: number,
           max: number
   }
}
```

**Proposed Solution for timeLimits** We can set the timeLimits for the question set as:

```json
timeLimits:
{
   questionset: {
           min: number,
           max: number,
           warn: number // update the QuML specs
           
   }
}
```

If we have a time limit for each of the questions we will store the timeLimits to the question set metadata as:

```json
timeLimits:
{
   question: {
           min: number,
           max: number,
           warn: number // update the QuML specs
   }
}
```

If we want to store max and warn value but don't want to store min value we can store the data in the below format:

```json
timeLimits:
{
   questionset: {
           min: null,
           max: 240,
           warn: 60
           
   }
}
```

We will have to update the QuML spec so the warn time should be stored inside timeLimits

**Editor Changes:**

* **No Data Migration (Recommended)**
  * For the new question creation, we will store the timeLimits in a new format using v2 API.
  * If the user edits the old question using V2 API, we will check for the timeLimits if it's present in the old format we will convert it to the new format on save.
* **Data Migration (Not Recommended)**
  * we can do the data migration for the old questions and update the question with the above-mentioned format.

**Player Changes:** The player will first check if the question has timeLimits.questionset it will take the min and warn value from there, if timeLimits.questionset is undefined and timeLimits directly contains maxTime and warningTime it will take the value from there.

***

\[\[category.storage-team]] \[\[category.confluence]]
