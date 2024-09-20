 **Proposed Solution for offline desktop telemetry events**  **Use cases for plugin installation flow :** 
```js
{
  "eid": "START",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
    "type": "plugin",
    "uaspec": {
      "agent": "Chromium",
      "platform": "WebKit",
      "raw": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) snap Chromium/73.0.3683.103 Chrome/73.0.3683.103 Safari/537.36",
      "system": "Linux",
      "ver": "73.0.3683.103"
    }
    "mode": "installation"
  }
}
```



```js
{
  "eid": "END",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
    "type": "plugin",
    "mode": "installation",
    "duration": "317 sec",
    "summary": [
      {
        "installation_status": "success",
		"errors": 0
      }
    ]
  }
}
```


 **Use cases for Network Connection flow :** 


```js
{
  "eid": "AUDIT",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
    "props": [
      "Network"
    ],
    "state": "Connected",
    "prevstate": "Disconnected",
    "duration": "10 sec"
  }
}
```



```js
{
  "eid": "AUDIT",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
    "props": [
      "Network"
    ],
    "state": "Disconnected",
    "prevstate": "Connected",
    "duration": "5 sec"
  }
}
```


 **Use cases for changing settings flow :** 


```js
{
  "eid": "AUDIT",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
    "props": [
      "Setting"
    ],
    "state": <Current_Setting_State>,
    "prevstate": <Previous_Setting_State>,
    "duration": "3 sec"
  }
}
```
 **Use cases for searching flow :** 


```js
{
  "eid": "SEARCH",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
    "type": "Search",
    "query": "Java",
    "filters": {
		"category": "technology"
	},
    "sort": {},
    "size": 20,
    "topn": [
      {}
    ]
  }
}
```


 **Use cases for each and every API call flow :** 


```js
{
  "eid": "LOG",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "type": "api_access",
      "level": "INFO",
      "message": "/api/search?text=java",
      "params": [
         {
            "category": "technology"
         }
      ]
   }
}
```



```js
{
  "eid": "LOG",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "type": "api_access",
      "level": "ERROR",
      "message": "searched content not found on server"
  }
}
```
 **Use cases for Downloading content flow :** 


```js
{
  "eid": "AUDIT",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "props": [
         "Download"
      ],
      "state": "Started",
      "prevstate": "Stopped"
   }
}
```



```js
{
  "eid": "AUDIT",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "props": [
         "Download"
      ],
      "state": "Finished",
      "prevstate": "Running",
      "duration": "240 sec"
   }
}
```



```js
{
  "eid": "LOG",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "type": "content_download_paused",
      "level": "INFO",
      "message": "Download Paused",
      "params": [
         {
            "content_id": "0777946b-adb1-4624-863c-f909a784b3e9"
         }
      ]
   }
}
```



```js
{
  "eid": "LOG",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "type": "content_download_resumed",
      "level": "ERROR",
      "message": <error_stack>,
      "params": [
         {
            "content_id": "0777946b-adb1-4624-863c-f909a784b3e9"
         }
      ]
   }
}
```



```js
{
  "eid": "LOG",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "type": "content_download_failed",
      "level": "ERROR",
      "message": <error_stack>,
      "params": [
         {
            "content_id": "0777946b-adb1-4624-863c-f909a784b3e9"
         }
      ]
   }
}
```



```js
{
  "eid": "LOG",
  "context": {
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "pdata": {
      "id": "dev.sunbird.offline",
      "ver": "2.0.0",
      "pid": "sunbird-offline"
    },
    "env": "offline"
  },
  "edata": {
      "type": "content_download_duplicate",
      "level": "ERROR",
      "message": <error_stack>,
      "params": [
         {
            "content_id": "0777946b-adb1-4624-863c-f909a784b3e9"
         }
      ]
   }
}
```




*****

[[category.storage-team]] 
[[category.confluence]] 
