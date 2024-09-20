# \[Design-Brainstorm]Provide-a-telemetry-event-when-slide-has-completed-loading

Introduction:This wiki page explains the design and implementation of how to log telemetry event to track the stage load time.

Background: Currently, we are logging the Interact and Impression event before stage load but - we are not logging the telemetry event after the stage is successfully loaded.

* INTERACT event before the stage is loaded

{"eid":"INTERACT","ets":1549431812446,"ver":"3.0","mid":"INTERACT:92198c65a9c0b189d25263364939384b","actor":{"id":"9942b170-1fd4-4161-964c-3d70b699f1e9","type":"User"},"context":{"channel":"505c7c48ac6dc1edc9b08f21db5a571d","pdata":{"id":"staging.diksha.app","ver":"2.0.localstaging-debug","pid":"sunbird.app.contentplayer"},"env":"contentplayer","sid":"c89f3277-b20f-410c-8bb6-6b050458a1f0","did":"ceeae2aa2bec16943fe4229564ed1caedf2880f9","cdata":\[{"id":"offline","type":"PlayerLaunch"},{"id":"2541eef75f1ad15f1a9d0e6f0edea666","type":"ContentSession"}],"rollup":{"l1":"do\_2126647710500290561553"\}},"object":{"id":"do\_2126647710500290561553","type":"Content","ver":"1.0"},"tags":\[],"edata":{"type":"TOUCH","subtype":"","id":"next","pageid":"8c49e497-98e5-439b-bd07-6e44a7d68d5c","extra":{"stageProgress":{"id":"8c8d4b50-1c59-4355-8042-ae2a84769ab3","progress":"100%"\}}\}}

* IMPRESSION event before the stage is loaded

{"eid":"IMPRESSION","ets":1549431460158,"ver":"3.0","mid":"IMPRESSION:0f1f82aefd1d1e0fd6c4c0a7ce0efe58","actor":{"id":"9942b170-1fd4-4161-964c-3d70b699f1e9","type":"User"},"context":{"channel":"505c7c48ac6dc1edc9b08f21db5a571d","pdata":{"id":"staging.diksha.app","ver":"2.0.localstaging-debug","pid":"sunbird.app.contentplayer"},"env":"contentplayer","sid":"c89f3277-b20f-410c-8bb6-6b050458a1f0","did":"ceeae2aa2bec16943fe4229564ed1caedf2880f9","cdata":\[{"id":"offline","type":"PlayerLaunch"},{"id":"2541eef75f1ad15f1a9d0e6f0edea666","type":"ContentSession"}],"rollup":{"l1":"do\_2126647710500290561553"\}},"object":{"id":"do\_2126647710500290561553","type":"Content","ver":"1.0"},"tags":\[],"edata":{"type":"workflow","pageid":"d373ccbc-955d-4b46-bda1-5ad52d54ca3e","uri":""\}}

**Problem Statement:** Currently, we are not logging the telemetry event after the stage load. Because of this, we are not able to track the stage load time. [SB-10185 System JIRA](https://browse/SB-10185)

Solution: We need to log the telemetry event before and after the stage load so that we can get the time between before and after stage load time.&#x20;

* **Before:** We are already logging the INTERACT event before the stage is loaded, we can log telemetry event along with this event.
* **After:** In PreloadJS we have "complete" event  - this event will fire when a queue completes loading all files

queue.on("complete", function() {

&#x20;       // Log following telemetry event

}, null, !0),

Event Data for before and after stage load{ "edata": {          "type": "system/app",           "level": "INFO",          "message": "Stage load completed",           "pageid": "stage\_id",           "params": \[                        {                             "startProgress": "60%", // Preload of stage completed by 60% before clicking on next.                              "endProgress": "100%" // Stage 100% loaded after clicking on next.                       }, { "key", "value"}               // All the plugins or assets lodaded from 60% to 100%.           ] \}}

Conclusion:&#x20;

* Log IMPRESSION event on completion of stage load
* Add one more property in IMPRESSION event as a duration.

***

\[\[category.storage-team]] \[\[category.confluence]]
