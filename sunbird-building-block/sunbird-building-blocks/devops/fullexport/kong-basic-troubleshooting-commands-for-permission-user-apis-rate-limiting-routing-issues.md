Kong is a pretty powerful tool and is also known as an nginx on steroids, let us go through the basic troubleshooting  commands in kong.


## Check if the kong service is working and is able to connect to the DB.
Login to the kong container and run the below command


```
sh-4.2# curl  -s localhost:8001/status | python -m json.tool
# Output:
{
    "database": {
        "reachable": true
    },
    "server": {
        "connections_accepted": 83517,
        "connections_active": 6,
        "connections_handled": 83517,
        "connections_reading": 0,
        "connections_waiting": 5,
        "connections_writing": 1,
        "total_requests": 201893
    }
}

```

## Check the available consumers in the system
Login to the container and run the below command


```
sh-4.2# curl  -s localhost:8001/consumers?size=8192 | python -m json.tool
# Output:
{
    "data": [
        {
            "created_at": 1560317507000,
            "id": "11111-11111-11111-1111-111",
            "username": "kong-smy"
        }
    ],
    "total": 1
}
```

## Check the available APIs in the system
Login to the container and run the below command


```
sh-4.2# curl  -s localhost:8001/apis?size=8192 | python -m json.tool
# Output:
{
    "data": [
        {
            "created_at": 1575010817000,
            "id": "e6520bde-f988-4ed5-b818-035b4e7720cf",
            "name": "updateOrgType",
            "preserve_host": false,
            "retries": 5,
            "strip_uri": true,
            "upstream_connect_timeout": 60000,
            "upstream_read_timeout": 60000,
            "upstream_send_timeout": 60000,
            "upstream_url": "http://learner-service:9000/v1/org/type/update",
            "uris": [
                "/org/v1/type/update"
            ]
        }
    ],
    "total": 1
}
```

## Check the available Plugins in the system
Login to the container and run the below command


```
curl  -s localhost:8001/plugins?size=8192 | python -m json.tool 
# Output:
{
    "data": [
                {
            "api_id": "e6520bde-f988-4ed5-b818-035b4e7720cf",
            "config": {
                "fault_tolerant": true,
                "hour": 30000,
                "limit_by": "credential",
                "policy": "local",
                "redis_port": 6379,
                "redis_timeout": 2000
            },
            "created_at": 1575010994000,
            "enabled": true,
            "id": "1e6f47bc-6f33-43b1-a81e-aaea889ca0b7",
            "name": "rate-limiting"
        }
     ],
    "total": 1
}
```
To Debug what plugins are applied to API, just take the API ID from the available APIs in the system curl command and search for the ID in the plugins you can find the rate limits applied, size payload limit applied, whitelist applied to the API.


##  Check the available Permissions to the users in the system
Login to the kong container and run the below command


```
sh-4.2# curl -s localhost:8001/consumers/mobile_admin/acls | python -m json.tool
# Output:
{
    "data": [
        {
            "consumer_id": "1111-1111-1111",
            "created_at": 1585491452000,
            "group": "mobileSuperAdmin",
            "id": "1111-1111-1111-1111"
        }
    ],
    "total": 1
}
```
Here mobile_admin is the name of the consumer, you need to replace the consumer name which you got from consumers list.



*****

[[category.storage-team]] 
[[category.confluence]] 
