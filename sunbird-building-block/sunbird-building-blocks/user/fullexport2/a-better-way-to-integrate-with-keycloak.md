# A-better-way-to-integrate-with-KeyCloak

#### \* [4](a-better-way-to-integrate-with-keycloak.md#4)

```
* [Terminology](#terminology)
* [Triggers](#triggers)
* [Summary  ](#summary  )
* [Workflows - existing and proposed](#workflows---existing-and-proposed)
* [Database schema changes](#database-schema-changes)
* [Mitigation](#mitigation)
* [Release plan](#release-plan)
```

Objective This document outlines the ways in which an identity management system, like KeyCloak could be integrated with Sunbird. This document is written in the timeframe of SB 2.5.0-2.6.0.

#### Terminology

KeyCloak and identity management system are synonymously used to refer to an OpenID compliant system.

#### Triggers

There were couple of triggers to re-think on this design and architecture, namely

1. Design review with security expert.
2. SSO implementation at root org level.
3. Separate credentials store and other user attributes store.
4. Several security features being asked for by the solution - shadow database, name check for account takeovers.

#### Summary &#x20;

1. KeyCloak is an identity management system. Currently, it is manages only credentials. Along with it, let it manage few other attributes - such as email, last/first login time to start with.&#x20;
2. The word 'manage' is used to reflect the architectural principle - separation of concerns. No other service must be managing or taking over ownership of these attributes. The identity management system will be the truth always.
3. The attributes can still be cached for performance reasons and so all services must know it is a cache only.
4. TODO: Needs a little more thought/discussion. The single datastore of Cassandra continue to exist, but the user table could be split - part of the information going to Postgres tables with attributes, rest in Cassandra.
5. There are some business questions that need to be answered - listed in the business questions section below.

Technical changesGeneral

1.  The JWT will be going till the browser.

    Currently, the portal service backend encapsulates this token and issues a session object to the browser. While we still allow the session constructs, the JWT will be additionally part of the session management. This change is just so as to minimise the impact of changes (subjected to implementation).
2. Use KeyCloak REST APIs rather than admin-sdk in backend-services. APIs are much more friendly in messaging and reliable, than SDKs that require library upgrades often. First preference will be to APIs with fallback to SDK in only special needs.
3. Add Google as an identity provider in KeyCloak.&#x20;

Signup

1. Signup page will be delivered from KeyCloak. The portal service backend (content-service) will have only keycloak client dependencies to verify token.
2. v1/user/create will use KeyCloak REST APIs to create a user. Currently, it creates the user in primary datastore (Cassandra) and lets know KC of the password - this needs be managed by KeyCloak only.

Business decisions/changes

1. Can a root-org onboarding be initiated by SSO only and through an identity management package (customised KeyCloak)?&#x20;
   1. This would mean that shadow db based onboarding/csv bulk upload of users will cease to exist. These things can continue to onboard to the tenant's identity management system.
2. Some good robust secure changes to the following features expected to come. For example, account merge/migrate can ask for password to prove ownership, powered by identity management system rather than by explicit custom code:
   1. Forgot password
   2. Account migrate
   3. Account merge

#### Workflows - existing and proposed

SignupLoginForgot password

#### Database schema changes

#### Mitigation

#### Release plan

***

\[\[category.storage-team]] \[\[category.confluence]]
