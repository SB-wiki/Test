
## Overview
[https://project-sunbird.atlassian.net/browse/SB-26139](https://project-sunbird.atlassian.net/browse/SB-26139)

To implement RBAC , sunbird-apimanager-util need an API to fetch user roles to append in auth token. And we also have one requirement where Portal need only user roles data along with some other org details like orgName to display on assign role page.


## API Details:
URI : {{host}}[/private/user/v1/role/read/](http://localhost:9000/v1/user/role/read/0e70f455-8a9d-495e-a03b-6398c6ccfedc){{userId}}?fields=orgName


### Request:
CURL : 


```
curl --location --request GET '{{host}}/private/user/v1/role/read/{{userId}}?fields=orgName' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer {{kong_api_key}}' \
--header 'x-authenticated-user-token: {{keycloak_access_token}}'
```

### Response:

```
{
    "id": "api.user.role.read.0e70f455-8a9d-495e-a03b-6398c6ccfedc",
    "ver": "v1",
    "ts": "2021-08-18 14:10:08:364+0530",
    "params": {
        "resmsgid": null,
        "msgid": "043f60b5-57b6-4f30-9cd6-7699830ebfa9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "roles": [
            {
                "role": "ORG_ADMIN",
                "createdDate": "2021-08-18 14:06:28:373+0530",
                "updatedBy": null,
                "createdBy": "85745d2b-3f83-4565-99a5-aeae93db2b2d",
                "scope": [
                    {
                        "organisationId": "0127738024883077121",
                        "orgName": "Org Name"
                    }
                ],
                "updatedDate": null
            },
            {
                "role": "BOOK_CREATOR",
                "createdDate": "2021-08-18 14:06:28:372+0530",
                "updatedBy": null,
                "createdBy": "85745d2b-3f83-4565-99a5-aeae93db2b2d",
                "scope": [
                    {
                        "organisationId": "0127738024883077121",
                        "orgName": "Org Name"
                    }
                ],
                "updatedDate": null
            }
        ]
    }
}
```

### Note:   For Any client (Portal) which need org details along with user roles , they can pass fields as query param to fetch extra details like orgName






*****

[[category.storage-team]] 
[[category.confluence]] 
