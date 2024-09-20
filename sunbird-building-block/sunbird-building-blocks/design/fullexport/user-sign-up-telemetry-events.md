# User-sign-up-Telemetry-events

**Overview** As part of the user self-sign up - we are verifying the users validity through OTP. As  a result - 2 end-points will be introduced, i.e. Generate OTP and Verify OTP.

We need to capture this events as part of the telemetry.

Here are the various events that will be generated as part of the telemetry logs

**API Access telemetry** **v1/otp/generate**

```
{
  "eid": "LOG",
  "ets": 1544592273785,
  "ver": "3.0",
  "mid": "1544592273785.a49bb73d-0369-4720-9cca-0614c2ccc490",
  "actor": {
    "id": "X-Consumer-ID",
    "type": "consumer"
  },
  "context": {
    "channel": "CUSTODIAN_ORG_ID",
    "pdata": {
      "id": "local.sunbird.learning.service",
      "pid": "learning-service",
      "ver": "1.13.0"
    },
    "env": "otp",
    "cdata": \[
      {
        "id": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf",
        "type": "request"
      }
    ],
    "rollup": {
      
    }
  },
  "edata": {
    "level": "info",
    "type": "api_access",
    "message": "",
    "params": \[
      {
        "duration": 85
      },
      {
        "method": "POST"
      },
      {
        "url": "v1/otp/generate"
      },
      {
        "status": "200"
      }
    ]
  }

```

**v1/otp/verify**

```
{
  "eid": "LOG",
  "ets": 1544592273785,
  "ver": "3.0",
  "mid": "1544592273785.a49bb73d-0369-4720-9cca-0614c2ccc490",
  "actor": {
    "id": "X-Consumer-ID",
    "type": "consumer"
  }, "context": { "channel": "CUSTODIAN_ORG_ID", "pdata": { "id": "local.sunbird.learning.service", "pid": "learning-service", "ver": "1.13.0" }, "env": "otp", "cdata": \[ { "id": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf", "type": "request" } ], "rollup": { } }, "edata": { "level": "info", "type": "api_access", "message": "", "params": \[ { "duration": 85 }, { "method": "POST" }, { "url": "v1/otp/verify" }, { "status": "200" } ] }


```

**/user/v1/tnc/accept**

```
{
  "eid": "LOG",
  "ets": 1544592273785,
  "ver": "3.0",
  "mid": "1544592273785.a49bb73d-0369-4720-9cca-0614c2ccc490",
  "actor": {
    "id": "55dd1f83-b48c-4eab-973e-428f199230fa",
    "type": "User" }, "context": { "channel": "CUSTODIAN_ORG_ID", "pdata": { "id": "local.sunbird.learning.service", "pid": "learning-service", "ver": "1.13.0" }, "env": "user", "cdata": \[ { "id": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf", "type": "request" } ], "rollup": { } }, "edata": { "level": "info", "type": "api_access", "message": "", "params": \[ { "duration": 85 }, { "method": "POST" }, { "url": "/user/v1/tnc/accept" }, { "status": "200" } ] }
```

**Telemetry Audit events** **/user/v1/tnc/accept**

```
{
  "eid": "AUDIT",
  "ets": 1544592512883,
  "ver": "3.0",
  "mid": "1544592512883.5041d899-5b0d-423f-8de4-cb34a3ec95bb",
  "actor": {
    "id": "55dd1f83-b48c-4eab-973e-428f199230fa",
    "type": "User" },  "context": { "channel": "CUSTODIAN_ORG_ID", "pdata": { "id": "local.sunbird.learning.service", "pid": "learning-service", "ver": "1.13.0" }, "env": "user", "cdata": \[ { "id": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf", "type": "request" } ], "rollup": { } }, "object": { "id": "55dd1f83-b48c-4eab-973e-428f199230fa", "type": "user" }, "edata": { "prevState": "v1", "state": "v2", "props": \[ "tncAcceptedVersion" ] } }
```

***

\[\[category.storage-team]] \[\[category.confluence]]
