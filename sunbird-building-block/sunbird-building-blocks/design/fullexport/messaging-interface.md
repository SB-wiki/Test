# Messaging-Interface

\| | | | | Draft Specification | |

\| | Shailesh Kochhar, Pramod Verma | | |

|                     |
| ------------------- |
| ---                 |
| ---                 |
| ---                 |
| ---                 |
| ---                 |
| ---                 |
|                     |
|                     |
| Draft Specification |
|                     |

\| | Shailesh Kochhar, Pramod Verma | | | | |

OverviewDifferent kinds of collaboration possible

* Real-time, syncronous
* Threaded conversations, asyncronous
* Q\&A, asyncronous

This doc covers the functional interface which must be implemented by messaging services to allow its real-time synchronous collaboration capability to be exposed within Sunbird.

The functional interface will provide an implementation of the Sunbird abstractions which enable sending and receiving of messages.

ArchitectureSunbird provides plugin points for installing

1. a messaging interface for clients
2. a messaging service adapter which can connect with a messaging service backend.

The Sunbird client (web/mobile) will install a client plugin allowing it to connect to the messaging backend via the messaging interface exposed by the Sunbird server.&#x20;

![Architecture for Messaging Service Integration](<../../../../Design/FullExport/images/storage/Sunbird Messaging Integration.jpg>)

EntitiesThe messaging interface provides an abstraction over messaging services to enable one-or-more messaging providers to plug-in to Sunbird. The interface provides the means to manipulate and manage:

* **Participants** : each participant in a group messaging session is associated with an account. Consider three types of accounts: user, guest and bot
* **Identity** : each user account will be associated with a Sunbird identity, it can also be associated with other third-party identities
* **Rooms** : equivalent of a group chat. Multiple accounts can participate in a room
* **Sessions** : are associated with devices which the participant uses. Multiple sessions may be initiated from a single device
* **Events** : are an abstraction over forms of content. A message is one event type.
* **Devices** : provide a means for offline management of encryption keys. A device is not always a physical entity, a browser is also a device

Participant managementFor a participant to send/receive messages, she/he/it must be registered with the messaging service. Registered participants must authenticate to interact with the service and perform operations.

Register: POST /msg/client/v1/register?medium=?type=Register a user account with profile details using the messaging backend chosen by the instance administrator.

* This API may be used to register two types of user accounts (see Registering Bots for details on registering bot accounts)
* Once the registration is successful, the server must issue the client an authenticatedUserToken which must be used in subsequent API calls from this device
* The server will attempt to generate an account with the provided username, however, if the username is not available, the server will return a corresponding error.
* The selected username must conform to the constraints specified below, if it does not meet the constraints, the server will return a corresponding error.

Request

| Parameter              | Type   | Description                                                                                                                                                                                                                     |
| ---------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _Query Parameters_     |        |                                                                                                                                                                                                                                 |
| medium                 | String | The medium through which the user’s identity is to be validated. One of email or sms. _**Required**_                                                                                                                            |
| type                   | String | The type of registration. One of guest or user                                                                                                                                                                                  |
| _JSON Body Parameters_ |        |                                                                                                                                                                                                                                 |
| username               | String | The desired username for the user. The username must be a minimum of six characters and may use any of the following characters \[0-9a-zA-Z\_ - .]If it is omitted, the server must generate a username for the account.        |
| deviceId               | String | ID of the client device. This is used to register a device for the new account. If it is omitted, the server must generate a deviceId for this device.                                                                          |
| firstName              | String | The first name of the new user.                                                                                                                                                                                                 |
| lastName               | String | The last name of the new user.                                                                                                                                                                                                  |
| address                | String | The address being used to register the user which will be attached to this account. _**Required**_ If medium is email, this should be an email address. If medium is sms, this should be a phone number in international format |
| sessionId              | Int    | The ID of the validation session which sent a token to the address. _**Required**_ (see validationCode API)                                                                                                                     |
| validationCode         | String | A valid code received by the user. _**Required**_ (see validationCode API)                                                                                                                                                      |

_Example_

```
POST /msg/client/v1/register?medium=sms&type=user

Content-type: application/json

{

    “username”: “chacha_chaudhary”,

    “password”: “a_very_weak_password”,

    “deviceId”: “f071ade8716bcc24”,

    “firstName”: “Chacha”,

    “lastName”: “Chaudhary”,

    “address”: “+919999000111”,

    “sessionId”: 4176451,

    “validationCode”: “SB-418912”,

}
```

Response: Status 200Indicates that a new account has been created for the user

```
{

    “username”: “chacha_chaudhary”,

    “userAddress”: “chacha_chaudhary@org.sunbird.msg.slack”,

    “deviceId”: “f071ade8716bcc24”,

    “authenticatedUserToken”: “brainworksfasterthanacomputer”

}
```

Response: Status 400Indicates that there was an error in the request which made it invalid. This may be one of the following error codes

* ERR\_USERNAME\_UNAVAILABLE: The username provided is already being used
* ERR\_USERNAME\_INVALID: The username provided is not a valid username
* ERR\_ADDRESS\_INVALID: The address provided is not in a valid format for the medium
* ERR\_CODE\_INVALID: The validationCode provided is not valid for the address
* ERR\_CODE\_EXPIRED: The validationCode provided has expired

```
{

    “errcode”: “ERR_USERNAME_INVALID”,

    “error”: “Username is not allowed to contain the ‘?’ character”

}
```

Response: Status 429The request was rate-limited because of too many requests

Register Bot: POST /msg/client/v1/registerBotRequest Code: POST /msg/client/v1/identity/code/request?medium=Request that a code be sent to the user to validate their ownership of a identity address using either email or sms medium

Request

\| Parameter | Type | Description | | _URL Parameters_ | | medium | String | The medium through which to send the validation token, can either be email or sms | | _JSON Body Parameters_ | | clientSecret | String | Unique client secret used to identify the attempt to validate the user’s address. The secret can use the following characters \[0-9a-zA-Z.=\_-] _**Required**_ | | address | String | The address where to send the validation code. _**Required**_ If the medium is email, this should be an email addressIf the medium is sms, this should be a phone number in international format (including country code) | | attemptNumber | Integer | The count of the attempt being made to send the validation code, multiple requests with the same attemptNumber may be ignored. _**Required**_ |

_Example_

```
POST /msg/client/v1/identity/code/request?medium=sms

Content-type: application/json

{

    “clientSecret”: “this_is_a_very_poor_client_secret”,

    “address”: “+919999000111”,

     “attemptNumber”: 1

}
```

Response: Status 200Indicates that a validation code has been sent, the sessionId will be required when confirming the code

```
{

    “sessionId”: 4176451

}
```

Response: Status 400Indicates that there was an error in the request which made it invalid. This may be one of the following error codes

* ERR\_ADDRESS\_INVALID: The address provided is not in a valid format
* ERR\_TOO\_MANY\_ATTEMPTS: The number of attempts has exceeded the maximum allowed by the service. May vary based on the service backend.

```
{

    “errcode”: “ERR_ADDRESS_INVALID”,

    “error”: “The address provided is not a valid email”

}
```

Validate Identity: POST /msg/client/v1/identity/code/validate?medium=Validate that a messaging user is the owner of an identity address. This method could be called multiple times for a given username with different mediums. It is up to the service to provide the capability to have multiple identities for the same medium.

Request

\| Parameter | Type | Description | | _URL Parameters_ | | medium | String | The medium through which to send the validation token, can either be email or sms | | _JSON Body Parameters_ | | username | String | The username for the account to connect the identity with. The username is required if this call is made without an authenticatedUserToken in the header | | address | String | The address being used to register the user which will be attached to this account. _**Required**_ If medium is email, this should be an email address.If medium is sms, this should be a phone number in international format | | sessionId | Int | The ID of the validation session which sent a token to the address. _**Required**_ (see validationCode API) | | validationCode | String | A valid code received by the user. _**Required**_ (see validationCode API) |

_Example_

```
POST /msg/client/v1/identity/code/validate?medium=sms

Content-type: application/json

{

    “username”: “chacha_chaudhary”,

    “address”: “+919999000111”,

    “sessionId”: 4176451,

    “validationCode”: “SB-418912”,

}
```

Response: Status 200Indicates that the address has been linked to the username provided.

```
{

    “status”: “OK”

}
```

Response: Status 400Indicates that there was an error in the request which made it invalid. This may be one of the following error codes

* ERR\_ADDRESS\_INVALID: The address provided is not in a valid format
* ERR\_CODE\_INVALID: The validationCode provided is not valid for the address
* ERR\_CODE\_EXPIRED: The validationCode provided has expired

```
{

    “errcode”: “ERR_ADDRESS_INVALID”,

    “error”: “The address provided is not a valid email”

}
```

Login: POST /msg/client/v1/loginAuthenticates a user using an authentication method from:

* Mobile number/OTP
* OIDC identity
* Username/one-time use token

The client first makes an empty login request which will return a 401 Unauthorised response and a sessionId in the response body. The client then uses this sessionId in subsequent requests to complete the login sequence.

Once the user has been authenticated, the server should issue the user an authenticatedUserToken which can be used for future authorization needs (eg: when making API calls).

Request

\| Parameter | Type | Description | | _JSON Body Parameters_ | | sessionId | Int | The id of the login session initiated. A new sessionId can be generated by sending an empty request. _**Required**_ | | type | Enum | The type of authentication protocol to use. _**Required**_ Can be one of org.sunbird.msg.login.otp, org.sunbird.msg.login.oidc, org.sunbird.msg.login.token | | identity | IdentityObject | Identity information for the user who is logging in. _**Required**_ | | identity.medium | Enum | The medium of the identity which is being passed. _**Required**_ Can be one of [org.sunbird.msg.id](http://org.sunbird.msg.id).email, [org.sunbird.msg.id](http://org.sunbird.msg.id).phone, [org.sunbird.msg.id](http://org.sunbird.msg.id).oidc | | identity.address | String | The identity address of the user who is logging in. Required when identity.medium is [org.sunbird.msg.id](http://org.sunbird.msg.id).email, [org.sunbird.msg.id](http://org.sunbird.msg.id).phone | | identity.uri | String | The identity URI for authenticating the user who is logging in. Required when identity.medium is [org.sunbird.msg.id](http://org.sunbird.msg.id).oidc | | token | String | The one-time use token to confirm the user’s identity. Required when type is org.sunbird.msg.login.otp or org.sunbird.msg.login.token |

Login with OTPTo login using an OTP, the client sets the type parameter to org.sunbird.msg.login.otp, the identity.medium to org.sunbird.msg.id.phone and identity.address to the recipient’s phone number. The token is the OTP requested using the validate identity endpoint.

Login via token is analogous to login via OTP with the type and medium being set appropriately. The token can be received via any communication channel.

_Example_

```
POST /msg/client/v1/login

Content-type: application/json

{

    “sessionId”: 9817263

    “type”: “org.sunbird.msg.login.otp”,

    “identity”: {

        “medium”: “org.sunbird.msg.id.phone”,

        “address”: “+919999000111”,

    },

    “token”: “SB-419817”,

}
```

Login with OIDCTo login using an OIDC Identity Provider (IdP), the client sets the type parameter to org.sunbird.msg.login.oidc, the identity.medium to [org.sunbird.msg.id](http://org.sunbird.msg.id).oidc and identity.uri to the OIDC Authorization Request URI.

If the server allows logging in via the IdP selected, it redirects the client to visit the OIDC Authorization Request URI (via the appropriate HTTP response). The server should encode a callback endpoint into the Authorization Request URI.

The client presents the user with the OAuth2 consent page allowing access to the user’s identity information.

If the user authorises the request, the IdP will redirect the client to the redirect\_uri along with an auth code. The redirect\_uri should have been set to point to a server endpoint which acts as a confidential OIDC client. The server uses the auth code to request an access token from the IdP and retrieve the user’s identity information. This completes the OIDC login flow.

Once the OIDC login flow is completed on the server, the client makes a subsequent request to the login endpoint with the same sessionId and receives a success response.

* Initiating the OIDC request

```
POST /msg/client/v1/login

Content-type: application/json

{

    “sessionId”: 9817263

    “type”: “org.sunbird.msg.login.oidc”,

    “identity”: {

        “medium”: “[org.sunbird.msg.id](http://org.sunbird.msg.id).oidc”,

        “uri”: “[https://demo.open-sunbird.org/auth/realms/sunbird/protocol/openid-connect/auth?client_id=org.sunbird.msg&state=abc&scope=openid&response_type=code](https://demo.open-sunbird.org/auth/realms/sunbird/protocol/openid-connect/auth?client_id=org.sunbird.msg&state=abc&scope=openid&response_type=code)

    },

}
```

* Completing the OIDC request

```
POST /msg/client/v1/login

Content-type: application/json

{

    “sessionId”: 9817263

    “type”: “org.sunbird.msg.login.oidc”,

}
```

Response: Status 200Indicates that the user has been authenticated

```
{

    “username”: “chacha_chaudhary”,

    “userId”: “chacha_chaudhary@org.sunbird.msg.slack”,

    “deviceId”: “f071ade8716bcc24”,

    “authenticatedUserToken”: “brainworksfasterthanacomputer”

}
```

Response: Status 401Indicates that the request is missing authentication credentials

```
{

    “errcode”: “ERR_USER_UNAUTHORIZED”,

    “err”: “Not authorized to make this request”,

    “sessionId”: 9817263

}
```

Response: Status 403Indicates that the authentication has failed.

```
{

    “errcode”: “ERR_USER_AUTHENTICATION_FAILED”,

    “err”: “The credentials provided do not match a valid user”

}
```

Response: Status 400Indicates that there was an error in the request which made it invalid

Logout: POST /msg/client/v1/logoutThis logs out the user from the active session and makes the authenticatedUserToken unuseable for subsequent requests.

Request _Example_

```
{}
```

Response: Status 200Indicates that the user has been logged out of this device session

Room (Channel/Group) managementCreate a room: POST /msg/client/v1/room/event/createThis endpoint creates a new room where subsequent events and messages can be dispatched. Room creation is itself an event which is the origin of subsequent events in the room. The room contains Sunbird metadata which can be used for discovery.

Rooms have two additional settings which control membership of the room. First is visibility which determines if the room is visible in public listings of the rooms available. The second is joinability which determines if the room can be joined without an invitation.

Request

\| Parameter | Type | Description | | _JSON Body Parameters_ | | visibility | Enum | Controls the visibility of the room in room listing APIs. Must be one of unlisted or listed. If visibility is unlisted, then the room will not appear in room lists. If omitted, defaults to unlisted | | membershipType | Enum | Controls the ability of users to join the room. Must be one of invite-only, token or open. If membershipType is invite-only, then new users must be added to the room. If membershipType is token, then a user must provide a token to join the room. If omitted, defaults to invite-only | | name | String | The name to be given to the room. This will be displayed to other users and is recommended to be human-readable. Allowed characters are \[0-9a-z\_-/.] _**Required**_ | | topic | String | A topic for the room to help users understand what the room is intended for. May be omitted | | contextUrl | String | A URL linking the room to a Sunbird context. _**Required**_ | | invite | List(InviteObject) | A list of messaging service usernames/userAddresses who will be invited to join the room | | invite\_external | List(InviteObject) | A list of invitees identified by external identifiers. (see the example below for the InviteObject) | | version | Int | The version of the room object being created. Default to 1 |

_Example_

```
POST /msg/client/v1/room/event/create

Content-type: application/json

{

    “visibility”: “listed”,

    “membershipType”: “open”,

    “name”: “chalis-chor”,

    “topic”: “Chacha ke aadmi”,

    “contextUrl”: “[https://demo.sunbird.org/org/deade-f01945801-cee1](https://demo.sunbird.org/org/deade-f01945801-cee1)”,

    “invite”: \[{

        “medium”: “[org.sunbird.msg.id](http://org.sunbird.msg.id).userAddress”,

        “address”: “chacha_chaudhary@org.sunbird.msg.slack”,

    }],

    “invite_external”: \[{

        “medium”: “[org.sunbird.msg.id](http://org.sunbird.msg.id).email”,

        “address”: “sabu@[example.com](http://example.com)”,

    }],

    “version”: 1

}
```

Response: Status 200Indicates that the room was created successfully and returns the roomAddress.

```
{

    “roomAddress”: “flibbertigibbet@org.sunbird.msg.slack”

}
```

Response: Status 400Indicates that the room was not created because of an error encountered when processing the request. The error could be one of

* ERR\_ROOM\_UNAVAILABLE: The room name chosen is unavailable
* ERR\_VISIBILITY\_UNSUPPORTED: The chosen visibility is unsupported by the service
* ERR\_MEMBERSHIP\_TYPE\_UNSUPPORTED: The chosen joinability is unsupported by the service
* ERR\_VERSION\_UNSUPPORTED: The room version selected is not supported by the service

```
{

    “errcode”: “ERR_ROOM_UNAVILABLE”,

    “err”: “Room with name ‘chalis-chor’ already exists”

}
```

Add/Remove/Ban member(s): POST /msg/client/v1/room/event/send?type=membershipThis event adds/removes new members to the room using

* RoomAddress
* UserId
* PrivilegeLevel (only for adding members)

Set the name/topic for the room: PUT /msg/client/v1/room/event/send?type=metadataThis event changes room metadata using

* RoomAddress
* Name/Topic

User-to-room messaging

#### Send message event: POST /msg/client/v1/room/msg/send?msgId=

Sends a message to a room. The interface supports sending multiple types of messages to a room. Not every service implementation will support the universe of message types. It is up to the client to handle errors when sending messages which are unsupported by the server.

Request

\| Parameter | Type | Description | | _Query parameters_ | | msgId | String | A client generated message identifier which is unique across messages. This is used to provide idempotency guarantees. | | _JSON Body parameters_ | | type | String | The type of event being sent to the room. _**Required**_ Must be org.sunbird.msg.event.room.message | | roomAddress | String | The room to which the message is to be sent. _**Required**_ | | msg | MessageObject | An event containing the body of the message to send to the room. _**Required**_ |

_MessageObject_

\| Parameter | Type | Description | | msgtype | Enum | Type of message being sent. _**Required**_ Could be any one of org.sunbird.msg.text, org.sunbird.msg.action,org.sunbird.msg.notice,org.sunbird.msg.image,org.sunbird.msg.audio, org.sunbird.msg.video,org.sunbird.msg.contact,org.sunbird.msg.location,org.sunbird.msg.file | | body | String | A string containing the message body to send to the room. |

_Example_

```
POST /msg/client/v1/room/msg/send?msgId=hep146j1982h1019dngwcn985ahcd928

Content-type: application/json

{

    “type”: “org.sunbird.msg.event.room.message”,

    “roomAddress”: “flibbertigibbet@org.sunbird.msg.slack”,

    “msg”: {

        “msgtype”: “org.sunbird.msg.text”,

        “body”: “hello world!”

    }

}
```

Response: Status 200Indicates that the message was sent successfully to the room and returns the eventId.

```
{

    “eventId”: “greatsuccess!@org.sunbird.msg.slack”

}
```

Response: Status 400Indicates that the message was not sent because of an error encountered when processing the request. The error could be one of

* ERR\_ROOM\_INVALID: The roomAddress given is not a valid room.
* ERR\_EVENT\_TYPE\_INVALID: The event type sent is not a message event
* ERR\_EVENT\_TYPE\_UNSUPPORTED: The event type sent is not supported by the service
* ERR\_MESSAGE\_TYPE\_INVALID: The message type sent is not a valid message type
* ERR\_MESSAGE\_TYPE\_UNSUPPORTED: The message type sent is not supported by the service
* ERR\_MESSAGE\_INVALID: The message sent is not a valid message of msgtype

```
{

    “errcode”: “ERR_MESSAGE_INVALID”,

    “err”: “body field is required for messages of type org.sunbird.msg.text”

}
```

Send another event type: POST /msg/client/v1/room/event/send?type=

* RoomAddress
* EventType
* EventBody

Fetch message events: GET /msg/client/v1/room/msg/listFetches messages from a room. Messages in a room are paginated. This interface provides support for both forward and backward pagination. The interface may return types of messages which may not be supported by the client. The client MUST fallback to display the textual representation of a message type which it does not support.

Request

\| Parameter | Type | Description | | _JSON Body parameters_ | | type | String | The type of event being fetched from the room. _**Required**_ Must be org.sunbird.msg.event.room.message | | roomAddress | String | The room from where the messages are to be read. _**Required**_ | | from | String | A token pointing to the point where to start reading messages from. _**Required**_ This parameter is typically set from the response to a previous /room/msg/list call. It also takes two sentinel values start and end. start lists messages from the beginning of the room’s history, while end lists messages from the end of the room’s history. | | to | String | A point to where to stop reading messages. Can be a pagination token or an eventId | | dir | Enum | Direction in which to list messages. One of f or b | | limit | Int | Maximum number of messages to read. Defaults to 10. The server may choose to return fewer messages than the limit specified. |

_Example_

```
GET /msg/client/v1/room/msg/list?msgId=hep146j1982h1019dngwcn985ahcd928

Content-type: application/json

{

    “type”: “org.sunbird.msg.event.room.message”,

    “roomAddress”: “flibbertigibbet@org.sunbird.msg.slack”,

    “from”: “end”,

    “dir”: “b”,

    “limit”: 15

}
```

Response: Status 200Returns messages from the room starting at from and ending with a token to request the next batch of messages.

\| Parameter | Type | Description | | start | String | The token where the pagination starts. This will be the token passed in from. | | end | String | The token where the pagination ends. This token can be passed as the from parameter in the next call to /room/msg/list | | dir | String | The direction in which the pagination is proceeding | | messages | List(MessageEvent) | A list of message events. |

_MessageEvent_

\| Parameter | Type | Description | | type | String | The type of event being fetched from the room. _**Required**_ Must be org.sunbird.msg.event.room.message | | roomAddress | String | The roomAddress where the event was sent | | eventId | String | A unique identifier for the event. This can be used by clients to de-duplicate events if needed. | | sender | String | A fully-qualified user id of the message sender | | sentTs | Int | The unix-epoch timestamp on the server when the message was sent. | | msg | MessageObject | A message object defined in the [Send message](https://docs.google.com/document/d/1s-zDjail6x3Ukv6SKXC7HAQvQbS2oLJteAViERff9fU/edit#heading=h.mulapge4j8v7) endpoint |

_Example_

```
{

    “start”: “end”,

    “end”: “jbtxl-w891837kdfg-k127-8428kdkdghj-k12473”,

    “dir”: “b”,

    “messages”: \[{

        “type”: “org.sunbird.msg.event.room.message”,

        “roomAddress”: “flibbertigibbet@org.sunbird.msg.slack”,

        “eventId”: “jbtxl-w894375wenv-k319-2747ncijrfhs-k16371”,

        “sender”: “sabu@org.sunbird.msg.slack”,

        “sentTs”: 1444903112581,

        “msg”: {

            “msgtype”: “org.sunbird.msg.text”,

            “body”: “hello world!”

         }

    }, {

        “type”: “org.sunbird.msg.event.room.message”,

        “roomAddress”: “flibbertigibbet@org.sunbird.msg.slack”,

        “eventId”: “jbtxl-w891837kdfg-k127-8428kdkdghj-k12473”,

        “sender”: “chacha_chaudhary@org.sunbird.msg.slack”,

        “sentTs”: 1444903111337,

        “msg”: {

            “msgtype”: “org.sunbird.msg.text”,

            “body”: “hello world!”

        }

    }]

}
```

Response: Status 400Indicates that messages could not be retrieved because of an error encountered when processing the request. The error could be one of

* ERR\_ROOM\_INVALID: The roomAddress given is not a valid room.
* ERR\_FROM\_INVALID: The start point from where to read messages is not valid.
* ERR\_TO\_INVALID: The end point where to stop reading messages is not valid.
* ERR\_DIR\_INVALID: The direction given is not valid.

```
{

    “errcode”: “ERR_FROM_INVALID”,

    “err”: “The from field value: `latest` is not valid.”

}
```

Leave the room

***

\[\[category.storage-team]] \[\[category.confluence]]
