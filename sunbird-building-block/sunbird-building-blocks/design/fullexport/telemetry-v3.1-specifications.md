
## Change Log
The latest version of telemetry event contains device profile, user profile, content model and dialcode metadata added from pipeline jobs.


## Telemetry V3.1 Envelope

```
{
  // About the event
  "eid": , // Required.
  "ets": , // Required. Epoch timestamp of event (time in milli-seconds. For ex: 1442816723)
  "ver": , // Required. Version of the event data structure, currently "3.0"
  "mid": , // Required. Unique message ID. Used for deduplication, replay and update indexes

  // Who did the event
  "actor": { // Required. Actor of the event.
    "id": , // Required. Can be blank. Id of the actor. For ex: uid incase of an user
    "type":  // Required. Can be blank. User, System etc.
  },

  // Context of the event
  "context": { // Required. Context in which the event has occured.
    "channel": , // Required. Channel which has produced the event
    "pdata": { // Optional. Producer of the event
      "id": , // Required. unique id assigned to that component
      "pid": , // Optional. In case the component is distributed, then which instance of that component
      "ver":  // Optional. version number of the build
    },
    "env": , // Required. Unique environment where the event has occured.
    "sid": , // Optional. session id of the requestor stamped by portal
    "did": , // Optional. uuid of the device, created during app installation
    "cdata": [{ // Optional. correlation data
      "type":"", // Required. Used to indicate action that is being correlated
      "id": "" // Required. The correlation ID value
    }],
    "rollup": { // Optional. Context rollups
      "l1": "",
      "l2": "",
      "l3": "",
      "l4": ""
    }
  },

  // What is the target of the event
  "object": { // Optional. Object which is the subject of the event.
    "id": , // Required. Id of the object. For ex: content id incase of content
    "type": , // Required. Type of the object. For ex: "Content", "Community", "User" etc.
    "ver": , // Optional. version of the object
    "rollup": { // Optional. Rollups to be computed of the object. Only 4 levels are allowed.
      "l1": "",
      "l2": "",
      "l3": "",
      "l4": ""
    }
  },

  // What is the event data
  "edata": {}, // Required.

  // Tags
  "tags": [""], // Optional. Encrypted dimension tags passed by respective channels

  // Device metadata
  "devicedata": {
    "os": "", // OS name and version
    "cpu": "", // processor name
    "sims": , // number of sim cards, -1 if unknown
    "idisk": , // total internal disk in GB, -1 if unknown
    "mem": , // total mem in MB, -1 if unknown
    "scrn": , // screen size in inches, -1 if unknown
    "id": "", // physical device id if available from OS
    "camera": "", // primary and secondary camera specs
    "edisk": , // total external disk (card) in GB, -1 if unknown
    "make": "" // device make and model
    "country": "", // device country info
    "city": "", // device city info
    "countrycode": "", // device country ISO code
    "state": "", // device state info
    "statecode": "", // device state ISO code
    "iso3166statecode": "", // device state code in ISO-3166 format
    "firstaccess": , // first access time of the device
    "uaspec": {
      "agent": "", // user agent (mozilla, chrome, safari, ie)
      "raw": "", // Raw user agent of server
      "system": "", // System identification
      "platform": "" // client platform,
      "ver": "" // Agent version number
    }
  },

  // User metadata - not applicable for actor.type other than user
  "userdata": {
    "state": "", // user state info
    "district": "", // user district info
    "block": "", // user block info
    "school": "", // user school info
    "subject": [], // list of subjects taught 
    "grade": [], // list of grades taught 
    "usertype": "", // type of user
    "language": [] // list of languages known
  },

  // content metadata
  "contentdata": {
    "lastsubmittedon": "", // last submitted date of the content
    "pkgversion": , // version of the content
    "language": [], // list of languages in the content
    "medium": "", // language medium of the content
    "lastpublishedon": "", // last published date of the content
    "contenttype": "", // type of resource
    "lastupdatedon": "", // last updated date of the content
    "framework": "",
    "name": "", // name of the content
    "mimetype": "", // mime type of the resource in the content
    "objecttype": "", // type of content
    "mediatype": "", // media type of the resource
    "board": "", // board of affiliation
    "status": "" // status of the content
  },

  //dialcode metadata - applicable only for SEARCH event
  "dialcodedata": {
    "channel": "", // channel for which dialcode is generated
    "batchcode": "", // batch for which dialcode belongs to 
    "publisher": "", // publisher of the dialcode
    "generatedon": "", // dialcode generated on
    "publishedon": "", // dialcode published on
    "status": "" // status of the dialcode
  }
}

```




*****

[[category.storage-team]] 
[[category.confluence]] 
