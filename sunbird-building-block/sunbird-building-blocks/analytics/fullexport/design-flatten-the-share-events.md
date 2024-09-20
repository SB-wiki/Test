# \[Design]-Flatten-the-share-events

IntroductionThis story is to flatten the share event into multiple share events, so that slice and dice on various dimensions for the metric **totalDownloads** can be performed.

Problem statementThe SHARE event captures all the contents downloaded on to a device. However, for a textbook download, the items object within the event captures all the resources downloaded. Since this is an array field, it is not denormalized and indexed into druid. Therefore we are not able to compute the total download metrics.

### Solution -1: Events Flatten Samza job

![](<../../../../Analytics/Fullexport/images/storage/Screenshot 2019-12-26 at 12.33.28 PM.png>)

Events Flatten job is responsible for flattening the share events into multiple share events so that  **totalDownloads** metrics can be computed.

**Job Responsibilities:**

&#x20;1\. Flatten the share events to multiple share events.

&#x20;2\. Generate always unique  **mid** for newly generated flatten events.

**Disadvantages:**

1. The load will increase to Events Validator - We are flattening the single "SHARE" events into multiple "SHARE" Events, The Events Validator job should validate all newly generated share events.
2. Need to allocate Extra resources for the Events flatten jobs.

**Advantages:**

&#x20;1 \*\*. \*\* During share events flattening process if any invalid events or duplicated events are generated then those events can be easily omitted from the Events validator and Events De-Dup samza job.

&#x20;2\. The throughput of the remaining jobs will the same.

**SHARE Event Structure**

```js
{
  "ver": "3.0",
  "eid": "SHARE",
  "ets": 1577278681178,
  "actor": {
    "type": "User",
    "id": "7c3ea1bb-4da1-48d0-9cc0-c4f150554149"
  },
  "context": {
    "cdata": [
      {
        "id": "1bfd99b0-2716-11ea-b7cc-13dec7acd2be",
        "type": "API"
      },
      {
        "id": "SearchResult",
        "type": "Section"
      }
    ],
    "channel": "505c7c48ac6dc1edc9b08f21db5a571d",
    "pdata": {
      "id": "prod.diksha.app",
      "pid": "sunbird.app",
      "ver": "2.3.162"
    },
    "env": "app",
    "sid": "82e41d87-e33f-4269-aeae-d56394985599",
    "did": "1b17c32bad61eb9e33df281eecc727590d739b2b"
  },
  "edata": {
    "dir": "In",
    "type": "File",
    "items": [
      {
        "origin": {
          "id": "1b17c32bad61eb9e33df281eecc727590d739b2b",
          "type": "Device"
        },
        "id": "do_312785709424099328114191",
        "type": "CONTENT",
        "ver": "1",
        "params": [
          {
            "transfers": 0,
            "size": 21084308
          }
        ]
      },
      {
        "origin": {
          "id": "1b17c32bad61eb9e33df281eecc727590d739b2b",
          "type": "Device"
        },
        "id": "do_31277435209002188818711",
        "type": "CONTENT",
        "ver": "18",
        "params": [
          {
            "transfers": 12,
            "size": "123"
          }
        ]
      },
      {
        "origin": {
          "id": "1b17c32bad61eb9e33df281eecc727590d739b2b",
          "type": "Device"
        },
        "id": "do_31278794857559654411554",
        "type": "TextBook",
        "ver": "1"
      }
    ]
  },
  "object": {
    "id": "do_312528116260749312248818",
    "type": "TextBook",
    "version": "10",
    "rollup": {}
  },
  "mid": "02ba33e5-15fe-4ec5-b360-3d03429fae84",
  "syncts": 1577278682630,
  "@timestamp": "2019-12-25T12:58:02.630Z",
  "flags": {
    "tv_processed": true,
    "dd_processed": true
  },
  "type": "events"
}
```

Flattening the above share events to 3 **SHARE\_ITEM** Events.

1. If the Item list object has params.transfers = 0 then edata .type should be "download"
2. If the Item list object has params.transfers = > 0 then edata .type should be "Import"
3. If the share event has object then move the object data to rollup l1

```js
{
  "ver": "3.0",
  "eid": "SHARE_ITEM",
  "ets": 1577278681178,
  "actor": {
    "type": "User",
    "id": "7c3ea1bb-4da1-48d0-9cc0-c4f150554149"
  },
  "context": {
    "cdata": [
      {
        "id": "1bfd99b0-2716-11ea-b7cc-13dec7acd2be",
        "type": "API"
      },
      {
        "id": "SearchResult",
        "type": "Section"
      }
    ],
    "channel": "505c7c48ac6dc1edc9b08f21db5a571d",
    "pdata": {
      "id": "prod.diksha.app",
      "pid": "sunbird.app",
      "ver": "2.3.162"
    },
    "env": "app",
    "sid": "82e41d87-e33f-4269-aeae-d56394985599",
    "did": "1b17c32bad61eb9e33df281eecc727590d739b2b"
  },
  "edata": {
    "dir": "In",
    "type": "download",
    "size": 21084308
    "items": []
  },
  "object": {
    "id": "do_312785709424099328114191",
    "type": "CONTENT",
    "version": "1",
    "rollup": {
      "l1": "do_312528116260749312248818",
       
    }
  },
  "mid": "02ba33e5-15fe-4ec5-b360-3d03429fae84",
  "syncts": 1577278682630,
  "@timestamp": "2019-12-25T12:58:02.630Z",
  "flags": {
    "tv_processed": true,
    "dd_processed": true
  },
  "type": "events"
}
```

```js
{
  "ver": "3.0",
  "eid": "SHARE_ITEM",
  "ets": 1577278681178,
  "actor": {
    "type": "User",
    "id": "7c3ea1bb-4da1-48d0-9cc0-c4f150554149"
  },
  "context": {
    "cdata": [
      {
        "id": "1bfd99b0-2716-11ea-b7cc-13dec7acd2be",
        "type": "API"
      },
      {
        "id": "SearchResult",
        "type": "Section"
      }
    ],
    "channel": "505c7c48ac6dc1edc9b08f21db5a571d",
    "pdata": {
      "id": "prod.diksha.app",
      "pid": "sunbird.app",
      "ver": "2.3.162"
    },
    "env": "app",
    "sid": "82e41d87-e33f-4269-aeae-d56394985599",
    "did": "1b17c32bad61eb9e33df281eecc727590d739b2b"
  },
  "edata": {
    "dir": "In",
    "type": "imported",
    "size": 1523
    "items": []
  },
  "object": {
    "id": "do_31277435209002188818711",
    "type": "CONTENT",
    "version": "18",
    "rollup": {
      "l1": "do_312528116260749312248818",
    }
  },
  "mid": "02ba33e5-15fe-4ec5-b360-3d03429fae84",
  "syncts": 1577278682630,
  "@timestamp": "2019-12-25T12:58:02.630Z",
  "flags": {
    "tv_processed": true,
    "dd_processed": true
  },
  "type": "events"
}
```

```js
{
  "ver": "3.0",
  "eid": "SHARE_ITEM",
  "ets": 1577278681178,
  "actor": {
    "type": "User",
    "id": "7c3ea1bb-4da1-48d0-9cc0-c4f150554149"
  },
  "context": {
    "cdata": [
      {
        "id": "1bfd99b0-2716-11ea-b7cc-13dec7acd2be",
        "type": "API"
      },
      {
        "id": "SearchResult",
        "type": "Section"
      }
    ],
    "channel": "505c7c48ac6dc1edc9b08f21db5a571d",
    "pdata": {
      "id": "prod.diksha.app",
      "pid": "sunbird.app",
      "ver": "2.3.162"
    },
    "env": "app",
    "sid": "82e41d87-e33f-4269-aeae-d56394985599",
    "did": "1b17c32bad61eb9e33df281eecc727590d739b2b"
  },
  "edata": {
    "dir": "In",
    "type": "File",
    "items": [  ]
   
  },
  "object": {
    "id": "do_31278794857559654411554",
    "type": "TextBook",
    "version": "1",
    "rollup": {
      "l1":"do_312528116260749312248818",
     }
  },
  "mid": "02ba33e5-15fe-4ec5-b360-3d03429fae84",
  "syncts": 1577278682630,
  "@timestamp": "2019-12-25T12:58:02.630Z",
  "flags": {
    "tv_processed": true,
    "dd_processed": true
  },
  "type": "events"
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
