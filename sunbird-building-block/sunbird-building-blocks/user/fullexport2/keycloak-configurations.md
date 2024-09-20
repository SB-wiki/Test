# KeyCloak-configurations

Current to: release-2.6.5

Status: Live (not published/frozen). Working copy.

```
* [Clients](#clients)
* [Flows and settings](#flows-and-settings)
* [Libraries being used](#libraries-being-used)
* [Terminology](#terminology)
* [References](#references)
```

Objective

This document is aimed to be a one-stop store for the configurations performed on KeyCloak and the reasoning behind those configurations.

#### Clients

Quoted from [KeyCloak documentation](https://www.keycloak.org/docs/6.0/server\_admin/) - _Clients are entities that can request KeyCloak to authenticate a user. Most often, clients are applications and services that want to use KeyCloak to secure themselves and provide a single sign-on solution. Clients can also be entities that just want to request identity information or an access token so that they can securely invoke other services on the network that are secured by KeyCloak._

The following lists the clients we have today in KeyCloak:

1. Consumption clients
   1. Portal team
   2. google-auth
   3. google-auth-android
   4. trampoline
   5. trampoline-android
   6. android
   7. portal
   8. Mobile team
   9. android
2. Backend clients
   1. Platform-user
   2. admin-cli → Proposed to create a new client 'lms'.

The following clients are present by default (after installation of KeyCloak) in a realm. These are best not used. Most of these have direct grants disabled and are marked for either 'confidential' or 'bearer-only' accesses, which is good and secure.

1. account
2. admin-cli
3. broker
4. realm-management
5. security-admin-console

Usage

| #  | Client name         | Access type  | Direct grants enabled | Used for          |
| -- | ------------------- | ------------ | --------------------- | ----------------- |
| 1. | google-auth         |              |                       |                   |
| 2. | google-auth-android |              |                       |                   |
| 3. | trampoline          |              |                       |                   |
| 4. | trampoline-android  |              |                       |                   |
| 5. | android             |              |                       |                   |
| 6. | portal              | public       | Disabled              |                   |
| 7. | android             |              |                       |                   |
| 8. | admin-cli lms       | confidential | Enabled               | To generate links |

1. For email verification of signed up user,
2. Update password

|

All the clients listed above except lms should have Direct Grants disabled. → \_TBD: 1) \_ _This needs fix and cross-check of other clients.. 2) Why should even lms use this, can't it use 'client credentials'  as grant type to generate these links._

From the [Managing clients](https://www.keycloak.org/docs/6.0/server\_admin/#\_clients) documentation, it is clear that only few clients require access type public, to allow browser login. For those that are used by internal services, it is best recommended to use a client secret.

#### Flows and settings

To be filled

#### Libraries being used

| Repo           | library with version                           | Modified (Y/N) | Comments                                                                                                                               |
| -------------- | ---------------------------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| sunbird-utils  | org.keycloak.keycloak-admin-client 3.2.0.Final | N              | Used by Platform-User team                                                                                                             |
| Player-service | keycloak-connect version - 6.0                 | Y              | 1.Generation of the token. 2.Validation of token. 3.Redirection to keyalcok auth page. 4.Protect routes that need the user to login in |
|                |                                                |                |                                                                                                                                        |

#### Terminology

Sourced from [KeyCloak documentation](https://www.keycloak.org/docs/latest/server\_admin/index.html#core-concepts-and-terms)&#x20;

Direct Grants _A way for a client to obtain an access token on behalf of a user via a REST invocation_

Clients _Clients are entities that can request KeyCloak to authenticate a user. Most often, clients are applications and services that want to use KeyCloak to secure themselves and provide a single sign-on solution. Clients can also be entities that just want to request identity information or an access token so that they can securely invoke other services on the network that are secured by KeyCloak._

Resource Owner Password Credentials Grant (Direct Access Grants) _This is referred to in the Admin Console as Direct Access Grants. This is used by REST clients that want to obtain a token on behalf of a user. It is one HTTP POST request that contains the credentials of the user as well as the id of the client and the client’s secret (if it is a confidential client). The user’s credentials are sent within form parameters. The HTTP response contains identity, access, and refresh tokens._

#### References

1. Replication - [https://github.com/keycloak/keycloak-documentation/blob/master/server\_installation/topics/cache/replication.adoc](https://github.com/keycloak/keycloak-documentation/blob/master/server\_installation/topics/cache/replication.adoc)
2. Infinispan caches - [https://www.keycloak.org/docs/latest/server\_installation/](https://www.keycloak.org/docs/latest/server\_installation/)

Source doc (for author's reference) : [https://docs.google.com/document/d/1p8LAxWnMNKIjzsr\_K\_UlKJWIoDA-\_5UcqoZwpv2JP9s/edit#](https://docs.google.com/document/d/1p8LAxWnMNKIjzsr\_K\_UlKJWIoDA-\_5UcqoZwpv2JP9s/edit) . → TBD: Remove this.

***

\[\[category.storage-team]] \[\[category.confluence]]
