# RBAC-on-Sunbird

For the slide deck on RBAC and implementation design, please check out - [https://docs.google.com/presentation/d/1wNp1re47Isc\_BX\_wZWPjmJkOgnSqrlfhiNKRqJrirFE/edit?usp=sharing](https://docs.google.com/presentation/d/1wNp1re47Isc\_BX\_wZWPjmJkOgnSqrlfhiNKRqJrirFE/edit?usp=sharing)

#### Design:

* Use OPA and Envoy as sidecars in backend microservices for authorization
* A program which can convert the json schema definitions to OPA rego code
* Token structure

```json
{
  "aud": "https://sunbirded.org/auth/realms/sunbird",
  "sub": "f:229738b7-253c-4adf-9673-a857ppb86999:gca2925f-1qqq-4654-9177-fece3fd6afc9",
  "roles": [
    {
      "role": "BOOK_CREATOR",
      "scope": [
        {
          "organisationId": "0127134797703392110"
        }
      ]
    },
    {
      "role": "CONTENT_CREATOR",
      "scope": [
        {
          "organisationId": "0127134797703392110"
        }
      ]
    },
    {
      "role": "CONTENT_REVIEWER",
      "scope": [
        {
          "organisationId": "0127134797703392110"
        }
      ]
    },
    {
      "role": "COURSE_MENTOR",
      "scope": [
        {
          "organisationId": "0127134797703392110"
        }
      ]
    },
    {
      "role": "ORG_MODERATOR",
      "scope": [
        {
          "organisationId": "0127134797703392110"
        }
      ]
    },
    {
      "role": "PROGRAM_DESIGNER",
      "scope": [
        {
          "organisationId": "0127134797703392110"
        },
        {
          "organisationId": "0127134797703392110"
        }
      ]
    },
    {
      "role": "REPORT_ADMIN",
      "scope": [
        {
          "organisationId": "0127134797703392110"
        }
      ]
    },
    {
      "role": "PUBLIC",
      "scope": []
    }
  ],
  "iss": "https://sunbirded.org/auth/realms/sunbird",
  "name": "Demo",
  "typ": "Bearer",
  "exp": 1640408569,
  "iat": 1640322173
}
```

* Addminutils will invoke the get user roles API and append the roles and orgs information to JWT token, sign it and then issue it to the user

New flow on Portal and Mobile for anonymous and logged sessions![](<../../../../DevOps/devops-kn-hw2/images/storage/RBAC Drawings-Issuing JWT Adminutils-20210729-054419.jpg>)

* The portal and mobile both will do a recaptcha check and pass the recaptcha response to backend for verification (portal backend in case of portal, android recapthca check in case of mobile)
* Once recaptcha response is verified, an API call is made for anonymous session to fetch a token for the user
* As of now we will allow only the portal and mobile app to invoke these register APIs on behalf of the user. The register API is protected by a JWT token that is injected only in mobile and portal
* These tokens (which are issued to portal and mobile on behalf of the user) will have a higher rate limit (maybe 500 per hour)
* A anonymous user can also directly obtain a token, how to do that is mentioned somewhere below in this post, but such token will have a very low ratelimit (maybe like 100 per hour)
* Kong ACL’s will be removed as we will not require any ACL checks, the API authroriztion check will be handled by OPA and Envoy sidecars

Internal communication between services

* Backend services can invoke APIs such as system APIs, metadata APIs etc anytime within the system (say backend batch job, Flink jobs, Samza jobs etc)
* The services will be either injected with a token that is accepted by all services (and also passes the OPA checks) OR they will be routed via a separate service like private ingress which will attach a token to the request and forward to the backend
* This token will have no expiry and can be used only for invoking the system, meta APIs
* Using this token, user context APIs cannot be invoked
* User context APIs will always require a user token

Registered users can obtain a token

* As a registered user on the system you can obtain access tokens to invoke APIs for use cases like development, bulk content creation etc
* There are two ways you can invoke the APIs
  * First option is to login on the system using Portal and use the connect.sid cookie for all your APIs via postman / curl. These APIs need to be routed via Portal endpoint and cannot use the /api endpoint
  * Second way is to obtain a token first from keycloak, then use the keycloak’s refresh token to obtain a new token from adminutils which will have your roles information. You can use the access token issued by adminutils to invoke APIs using the /api endpoints
* In either approach, what APIs you can access is decided by what roles you have on the system

![](<../../../../DevOps/devops-kn-hw2/images/storage/RBAC Drawings-User Request Tokens-20210729-063002.jpg>)

* Note: Kong validating the Keycloak’s refresh token is not yet tested. But since the refresh token from keycloak is of type HS256, and we know the secret to be used to verify the HS256 signature and the iss to be used in Kong for validation (the domain), so we should be able to validate the keycloak token signature in kong also by onboarding a consumer with iss and the secret

External systems can obtain a token

* Any external system that requires access to API’s, can sigup as an user on Sunbird and then use one of the mentioned flows to generate access token
* API access as usual will be based on the role of the user account on Sunbird
* Any special API access can be granted by Sunbird admin by assigning the appropriate roles on the system
* If the external system requires user context API’s for other users, then they can authenticate on Sunbird as the user and then use the user specific token for any use cases involved in their end (similar to VDN authentication)
* We can also have a button on the portal UI to get the access token after login (similar to the ops support tool)

External systems can obtain a token as anonymous

* These are some special scenarios
* In this design, anonymous access can only be done using the Portal / Mobile
* For other systems where they need anonymous APIs access, we can expose an open endpoint (rate limitted by IP) from where a token will be issued
* These will have very low rate limits to avoid APIs being accessed unknowingly as telemetry data, streaming url etc, will go unnoticed
* This use case should be avoided if possible and APIs / tokens can be accessed / obtained only by signing up as a user on the system

Adding more fine grained roles and Rate Limits

* We should have more fine grained roles so we can have ensure a user gets only specific set of APIs and not a wider set of APIs
* Additional roles like below can be identified and introduced in the system
  * ORG\_MANAGER
  * CONTENT\_PUBLISHER
* We can also introduce redis for storing rate limits as this will be a true ratelimit, instead of the local pod based rate limits in Kong

***

\[\[category.storage-team]] \[\[category.confluence]]
