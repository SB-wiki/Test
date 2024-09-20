# Capturing-usage-of-features-for-analysis

**Introduction** In this wiki, we will discuss an approach to compute usage of various features across different components. The usage of features can be captured using telemetry events and then subsequently used for analysis of different feature usage. We will discuss the following computations as part of this wiki

* Approach for computation of feature for existing features.
* Approach for capturing required details for feature usage computation for new features.

**Solution:** \*\*Description: \*\* The usage of various features can be directly derived from telemetry events after defining a structure for instrumenting the usage of features. A data product summariser will operate on the telemetry events to compute the feature usage data. The usage data can then be indexed into Druid for further visualisation or analysis.

&#x20;   \*\*   Event Flow:     \*\*

![](<../../../../Design/FullExport/images/storage/Screenshot 2019-04-01 at 3.41.11 PM.png>)

\*\*      Event Name:   FEATURE\*\*

&#x20;&#x20;

\*\*      Event Data Structure:\*\*

```js
{
	id:"Feature Identifier", //required
	name:"Editor Undo Redo", // Optional
	description:"", // Optional
    version:"1.0", // Version of the feature
	releasedversion:"15.0", // Required, In which version of product having this featureId
	category:"SunbirdEd" //  Optional, Defined this feature is related to SunbirdEd or SunbirdCore (Ex: SunbirdEd or SunbirdCore)
	duration:"42343", //Optional, Time spent in second 
	
}
```

**Existing features usage computation:** \*\* \*\*

|   | Feature                                 | Event Name | Properties                                                                                                                                                                                                                             |
| - | --------------------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1 | Youtube video in the ECML Content       | INTERACT   | actor.type='User'context.env='contenteditor'object.type='content'edata.type='select'edata.plugin.id='org.ekstep.video'                                                                                                                 |
| 2 | Question Plugin                         | INTERACT   | actor.type='User'context.env='contenteditor'object.type='content'edata.type='click'[edata.id](http://edata.id)='button'edata.subtype='select'[edata.plugin.id](http://edata.plugin.id)='org.ekstep.questionbank'                       |
| 3 | Content suggestion in textbook          | INTERACT   | actor.type='User'context.env='contenteditor'object.type='content'edata.type='click'[edata.id](http://edata.id)='button'edata.subtype='select'edata.plugin.id='org.ekstep.suggestioncontent'                                            |
| 4 | Math symbol and formula                 | INTERACT   | actor.type='User'context.env='contenteditor'object.type='content'edata.type='TOUCH'[edata.id](http://edata.id)='input'edata.pageid='question-creation-mcq-form'[edata.plugin.id](http://edata.plugin.id)='org.ekstep.questionunit.mcq' |
| 5 | Assessment summariser in the mobile app | IMPRESSION | actor.type='User'context.env='reports-users-group'edata.pageid='user'edata.uri='user'edata.type='view'                                                                                                                                 |
| 6 | User Groups in mobile app               | IMPRESSION | actor.type='User'context.env='user'edata.pageid='users-groups'edata.uri='users-groups'edata.type='view'                                                                                                                                |

### Conclusion:

\* Instead of generating new FEATURE event object from the upstream component, generate a INREACT Event with cdata object having featureId with this we can compute the feature usage.

\* For the existing features, Implement data product to compute the feature usage only if the computation is not possible from the druid.

\*\* \*\*

***

\[\[category.storage-team]] \[\[category.confluence]]
