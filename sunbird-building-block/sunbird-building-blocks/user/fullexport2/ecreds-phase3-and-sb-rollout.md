# Ecreds---Phase3-and-SB-rollout

### \*

* [Design points](ecreds-phase3-and-sb-rollout.md#design-points)
* [Overall solution](ecreds-phase3-and-sb-rollout.md#overall-solution)
* [Component interaction](ecreds-phase3-and-sb-rollout.md#component-interaction)
* [Open questions](ecreds-phase3-and-sb-rollout.md#open-questions)
* [How to create a HTML template zip file?](ecreds-phase3-and-sb-rollout.md#how-to-create-a-html-template-zip-file?)
* [API endpoints (proposed and enhancements)](ecreds-phase3-and-sb-rollout.md#api-endpoints-\(proposed-and-enhancements\))
  * [cert-service](ecreds-phase3-and-sb-rollout.md#cert-service)
* [Schema design](ecreds-phase3-and-sb-rollout.md#schema-design)
  * [organisation](ecreds-phase3-and-sb-rollout.md#organisation)
  * [FAQ](ecreds-phase3-and-sb-rollout.md#faq) About Refer to PRD \[\[eCreds|eCreds]] for the over workflows.

### Design points

* The repository - [cert-service](https://github.com/project-sunbird/cert-service) hosts both the SDK and the service.
* The service will follow the same stack as used in KP, LMS platforms - Play, Akka.
* The service will only create the certificates. Optionally, can send email/sms to users with link to their certificate. The consumer that is triggering certificate generation can choose to send notification.
* The QR code generation and Cloud storage components from KP are re-used here in the SDK.
* The SDK doesn't rely upon any env variable - they are either parameterised or available as fields, as the case maybe.
* The service doesn't choose any defaults for certificate generation, including keys, names. The container for storage is defaulted, but will be allowed for override in the API call.
* The service relies on [enc-service](https://github.com/project-sunbird/enc-service) for signing and verification and management of keys. Local laptop perf measurements using jmeter for this service are available [here](https://project-sunbird.atlassian.net/wiki/spaces/OS/pages/1037762563/Sunbird+enc-service).
* The org table will be enhanced to contain key identifiers to be associated with that specific org.&#x20;
* The new table 'user\_creds' will be created with the following columns as given below.
* All the payload called out in this document comply to the [EkStep API](https://github.com/ekstep/Common-Design/wiki/API-Specifications) specification. For input, pass the object under "request" and take "response" for the reverse direction.

### Overall solution

In 2.3.5, a bunch of steps need to be executed by Devops/Dev/Impl team before certificates can be issued. These are detailed here - \[\[How to: ECreds - SB 2.3.0/5|How-to--ECreds---SB-2.3.0-5]]

### Component interaction

![](<../../../../User/Fullexport2/images/storage/eCreds\_solution\_and\_arch-Page-1 -existing.png>)

### Open questions

1. Signatory image is still pending from PM.

Resolved

1. Should we use only name and not use phone, email due to privacy concerns? The OB v2 spec allows to hash PII. Example:  _sha256$28d50415252ab6c689a54413da15b083034b66e5PV review - Avoid phone and email. Try using Diksha Identifier._
2.  In the DIAL code model, each QR code is unique. Should ECreds QR code be similar? Since the certificate uuid is the primary identifier, can we propose one QR code, say 1 dial code that takes in the certificate uuid param.

    _PV review - Let's call that access code. The access code will be the form of authentication we will have to prevent these pages being indexed by search engine. Propose to have the data within the URL of the form domain/certs/{uuid\_of\_certificate}_
3.  Which service responds to QR code scan - the one that must render "View certificate", "Verify", "Recommendations", "Peer certifications"?

    _Rayulu - portal content service will do this._
4.  We attach html template to the course. We are yet to identify how other details such as issuer, signatory, certificate names must be codified.

    DC review - Courses team will create a course metadata where all this will be set.
5.  Read that iText version 7 seems to be promising for HTML to PDF conversion. Need testing (at the moment we don't have the html template, expect closure only by next week)

    Platform-User - The conversion is 2+second and can work with external css, images, which is good. The timing is ok for now.

### How to create a HTML template zip file?

Go to the directory (certificate template) which contains index.html, CSS & fonts, use the command mentioned here to create a zip file.&#x20;

| OS                                             | Cmd                   |
| ---------------------------------------------- | --------------------- |
| mac                                            |                       |
| \`\`\`                                         |                       |
| zip -r fileName.zip . -x ".\*" -x "\_\_MACOSX" |                       |
| \`\`\`                                         |                       |
|                                                |                       |
| ubuntu                                         | zip -r fileName.zip . |

### API endpoints (proposed and enhancements)

#### cert-service

1\. POST /v1/certs/generateRequest (2.3.5)

```js
{
    "params": {},
    "request": {
      "certificate": {
         "data": [{ // Mandatory
           "recipientName": "",  // Mandatory, the name of the recipient
	       "recipientId": "",     // Optional, user identifier within sunbird. Expect courses team to fill this (so mandatory for them). 
           "validFrom": "",  // Optional, defaults to current date-time
           "expiry": "",   // Optional, defaults to life-time validity
         }],
      "courseName": "",  // Optional, the name of the course
      "name": "",     // Mandatory, the certificate name
      "description": "",  // Optional, the certificate description
      "logo": "",   // Optional, certificate logo
      "issuedDate": "", // Optional, defaults to current date-time
      "issuer": {  // Mandatory
	 	"name": "Sunbird", // Mandatory
		"publicKey": ["1", "2"], // Mandatory, all keys associated with this issuer
		"url": "" // Mandatory 
	   },
       "signatoryList":  [{ // Mandatory, at least one is expected 
	    	"name": "",  // Mandatory, the name of the signatory
		    "id": "",   // Mandatory, the identifier (can be a URN, http URI)
     		"designation": "" // Mandatory, the designation
            "image": "" // Mandatory, the signatory image URL
	    }],
	    "keys": { // Optional generally, Mandatory for SB. If keys is not provided, then the verificationType of the cert is Hosted.
		   "id": "2",   // Mandatory, the keypair identifier using which to sign the certificate
     	},
     	"htmlTemplate": "zipfoldername_or_httpUrl", // Mandatory. This could be relative local, cloud or public http url.
        "tag": "" // Optional generally, Mandatory for SB. Use batch identifier of an SB course
        "orgId" : "" // Optional generally, Mandatory for SB. Use root org id
      }
   }
}
```

If the key identifiers do not qualify a http endpoint, the cert-service will presume it is an internal enc-service key and expand it to [https://enc-service:8013/keys/1](https://enc-service:8013/keys/1)

Request (2.5.0)

```js
{
    "params": {},
    "request": {
      "certificate": {
         "data": [{ // Mandatory
           "recipientName": "",  // Mandatory, the name of the recipient
	       "recipientId": "",     // Optional, user identifier within sunbird. Expect courses team to fill this (so mandatory for them). 
           "validFrom": "",  // Optional, defaults to current date-time
           "expiry": "",   // Optional, defaults to life-time validity
         }],
      "courseName": "",  // Mandatory, the name of the course
      "name": "",     // Mandatory, the certificate name
      "description": "",  // Optional, the certificate description
      "logo": "",   // Optional, certificate logo
      "issuedDate": "", // Optional, defaults to current date-time
      "issuer": {  // Mandatory
	 	"name": "Sunbird", // Mandatory
		"url": "" // Mandatory 
	   },
       "criteria": { // Optional, defaults to "course completion certificate"
         "narrative": "What was the criteria for issuing this certificate".
       },
       "signatoryList":  [{ // Mandatory, at least one is expected 
	    	"name": "",  // Mandatory, the name of the signatory
		    "id": "",   // Mandatory, the identifier (can be a URN, http URI)
     		"designation": "" // Mandatory, the designation
            "image": "" // Mandatory, the signatory image URL
	    }],
	    "keys": { // Optional generally, Mandatory for SB. If keys is not provided, then the verificationType of the cert is Hosted.
		   "id": "2",   // Mandatory, the keypair identifier using which to sign the certificate
     	},
     	"htmlTemplate": "zipfoldername_or_httpUrl", // Mandatory. This could be relative local, cloud or public http url.
        "tag": "" // Optional generally, Mandatory for SB. Use a combination of org and batch identifier of an SB course.
	    "basePath": "http://dev.sunbirded.org/public/certs" // domain and slug (/public/certs)
      }
   }
}
```

Response

```js
"certificate": [
   {  
	   "recipientId": "", // This will the be exact recipientId passed in the request
	   "id" : "", // The unique identifier to this certificate
       "jsonUrl" "", // The relative http json url (this will be internal portal link, not a public link - container path will not be exposed) 
	   "pdfUrl": "" ,// The relative http PDF url (this will be internal portal link, not a public link - container path will not be exposed)
	   "jsonData": "",// certificate json data
	   "accessCode":""// code to access the certificate
   }
}
```

Request/Response 3.2.0Please refer to this document - \[\[SC-1855 Certificate @ Scale#Request|SC-1855-Certificate-@-Scale]]

2.POST /v1/certs/verifyThis is to verify the JSON certificate data. Verifies certificate signature value and expiry date.&#x20;

&#x20;a) The certificate contains a signature in the signature field. The signature is encrypted using the awarding body's(Issuer) private key.  Signature is verified by using encryption service verify API which takes signature value, issuer's public key id, and certificate object in the request and returns "true" if the signature is valid else "false"

&#x20;b) If a certificate contains an expiry date, The expiry date is compared with the current date. and checks whether the certificate is expired or not&#x20;

| Current Date | Expiry Date | valid |
| ------------ | ----------- | ----- |
| 2019-10-11   | 2019-10-11  | false |
| 2019-10-11   | 2019-10-12  | true  |
| 2019-10-11   | 2019-10-09  | false |

In the request either we can pass certificate JSON in the param "data" or id of the certificate (URL) in the param "id". If the request contains id, we are downloading the certificate from the cloud and verifying it.

\*\*Request \*\* a) which contains certificate JSON

```
{
    "params": {},
    "request": {
        "certificate": {
            "data": {//mandatory , this is certificate json
                "id": "http://localhost:9000/certs/r01284093466818969624/8a58dc05-2706-4527-a7c5-1620a91e6a82.json",
                "type": [
                    "Assertion",
                    "Extension",
                    "extensions:CertificateExtension"
                ],
                "issuedOn": "2019-09-30T17:18:31Z",
                "recipient": {
                    "identity": "123-123-45555-2344-1333",
                    "type": [
                        "id"
                    ],
                    "hashed": false,
                    "name": "John",
                    "@context": "http://localhost:9000/certs/v1/context.json"
                },
                "badge": {
                    "id": "http://localhost:9000/certs/r01284093466818969624/Badge.json",
                    "type": [
                        "BadgeClass"
                    ],
                    "name": "",
                    "description": "",
                    "criteria": {
                        "type": [
                            "Criteria"
                        ],
                        "id": "http://localhost:9000/certs/r01284093466818969624",
                        "narrative": ""
                    },
                    "issuer": {
                        "context": "http://localhost:9000/certs/v1/context.json",
                        "id": "http://localhost:9000/certs/Issuer.json",
                        "type": [
                            "Issuer"
                        ],
                        "name": "",
                        "url": "",
                        "publicKey": [
                            "http://localhost:9000/certs/7_publicKey.json",
                            "http://localhost:9000/certs/8_publicKey.json"
                        ]
                    },
                    "@context": "http://localhost:9000/certs/v1/context.json"
                },
                "expires": "2020-09-01T12:52:25Z",
                "verification": {
                    "type": [
                        "SignedBadge"
                    ],
                    "creator": "http://localhost:9000/certs/2_publicKey.json"
                },
                "revoked": false,
                "signatory": [
                    {
                        "identity": "CEO",
                        "type": [
                            "Extension",
                            "extensions:SignatoryExtension"
                        ],
                        "hashed": false,
                        "designation": "CEO",
                        "image": "https://daily.jstor.org/wp-content/uploads/2014/11/NapoleonSignature2_1050x700.jpg",
                        "@context": "http://localhost:9000/certs/v1/extensions/SignatoryExtension/context.json"
                    }
                ],
                "validFrom": "2019-09-01T12:52:25Z",
                "signature": {
                    "type": "LinkedDataSignature2015",
                    "creator": "http://localhost:9000/certs/2_publicKey.json",
                    "created": "2019-09-30T11:48:32.118Z",
                    "signatureValue": "fClYnCD9XKzXd7KCwIvh9E4ecnyLpN7Y1HLLbxHF+cbYqcQ7+pLnZCqtQzGWqAxjGcdKXzB7PYUN/jiCNiXXv5hVlKCrNG4mvb8ROc2APN48kpsOdVqGQPHbBBNsQSvIct/ToG/9nmY9CAGDob+db+gnMj92jDwTsO/eYQTVjPwFCgGpZvodkF8efOhm5D7KOTIcCMV8ZO74+3kdZspweVJrg703wwKDsP+E7FYopG8aFBCufjv4F6Ue2gFb3FzPsbsqIm75Oy3MRpKWMGeMIWXfJ/0mwtVnAsJQe5ShoVGb+uY2wlTlRlLx5tl0p5RaVveiy1fKuyoDmFTWsQq7cg="
                },
                "@context": "http://localhost:9000/certs/v1/context.json"
            }
        }
    }
}
```

**Request** b)which contains the id of the certificate

```
{
    "params": {},
    "request": {
        "certificate": {
            "id": "http://localhost:9000/certs/27bf11c4-b28e-4805-a284-d3a1391533bd.json"
        }
    }
}
```

**Response**

| operation | httpCode | result                        |
| --------- | -------- | ----------------------------- |
| success   | 200      | valid + messages + errorCount |
| failure   | 400      | validation error message      |

&#x20; the response will be in the following format.

```
{
    "id": null,
    "ver": null,
    "ts": null,
    "params": null,
    "responseCode": "OK",
    "result": {
        "response": {
            "valid": true,
            "messages": [],//array of error messages
            "errorCount": 0 //number of errors
        }
    }
}
```

For example request with invalid signature and expiry date

```
{
    "params": {},
    "request": {
        "certificate": {
            "data": {
                "id": "http://localhost:9000/certs/01284093466818969624/811fe1ab-38cd-46da-9cd0-a29dc7566a0d.json",
                "type": [
                    "Assertion",
                    "Extension",
                    "extensions:CertificateExtension"
                ],
                "issuedOn": "2019-10-09T18:32:28Z",
                "recipient": {
                    "identity": "123-123-45555-2344-1333",
                    "type": [
                        "id"
                    ],
                    "hashed": false,
                    "name": "John",
                    "@context": "http://localhost:9000/certs/v1/context.json"
                },
                "badge": {
                    "id": "http://localhost:9000/certs/01284093466818969624/Badge.json",
                    "type": [
                        "BadgeClass"
                    ],
                    "name": "Java Programming Masterclass for Software Developers",
                    "description": "Course completion certificate issues by State",
                    "criteria": {
                        "type": [
                            "Criteria"
                        ],
                        "id": "http://localhost:9000/certs/01284093466818969624",
                        "narrative": "Course completion certificate issues by State"
                    },
                    "issuer": {
                        "context": "http://localhost:9000/certs/v1/context.json",
                        "id": "http://localhost:9000/certs/Issuer.json",
                        "type": [
                            "Issuer"
                        ],
                        "name": "Gujarat Council of Educational Research and Training",
                        "url": "https://gcert.gujarat.gov.in/gcert/",
                        "publicKey": [
                            "http://localhost:9000/certs/keys/7_publicKey.json",
                            "http://localhost:9000/certs/keys/2_publicKey.json"
                        ]
                    },
                    "@context": "http://localhost:9000/certs/v1/context.json"
                },
                "expires": "2019-09-01T12:52:25Z",
                "verification": {
                    "type": [
                        "SignedBadge"
                    ],
                    "creator": "http://localhost:9000/certs/keys/2_publicKey.json"
                },
                "revoked": false,
                "signatory": [
                    {
                        "identity": "CEO",
                        "type": [
                            "Extension",
                            "extensions:SignatoryExtension"
                        ],
                        "hashed": false,
                        "designation": "CEO",
                        "image": "https://daily.jstor.org/wp-content/uploads/2014/11/NapoleonSignature2_1050x700.jpg",
                        "@context": "http://localhost:9000/certs/v1/extensions/SignatoryExtension/context.json"
                    }
                ],
                "signature": {
                    "type": "LinkedDataSignature2015",
                    "creator": "http://localhost:9000/certs/2_publicKey.json",
                    "created": "2019-10-09T13:02:29.450",
                    "signatureValue": "Pou3g2jaBhXkWSICKLKZPYy2FjxsUPPLQF5aRk1tOymlo+5qj3+PMYSjbTPgM3LZhiJhUvL+FC1D6xry/MzrxdD2S87sKIlbt4OWL0IEJbY2EKmJi5+48LoqrZVIDoHesqnZUO5d2gdzi4bnafWyWD6AeXiPD21GnbYhsTtdcBcJ1fY65OieJWKd9h80srwzSKmgRaVngqV50dzRJcRHcFdikkHwStSNfbs6t0bmKZO4u8lweyMXMYTCKaXxS8L9Tqu/g4B1hWHwuAGa83BzJDPGv2aZpyer2GSJVc6eAkRrTP4128m493g4TWkqlGaqaOsxHeRrrgtAjrHSXT5lpQ=="
                },
                "@context": "http://localhost:9000/certs/v1/context.json"
            }
        }
    }
}
```

\*\*Response \*\*

```
{
    "id": null,
    "ver": null,
    "ts": null,
    "params": null,
    "responseCode": "OK",
    "result": {
        "response": {
            "valid": false,
            "messages": [
                "ERROR: Assertion.signature - certificate is not valid , signature verification failed",
                "ERROR: Assertion.expires - certificate has been expired"
            ],
            "errorCount": 2
        }
    }
}
```

**3.POST /v1/certs/download**

**Request**

```js
{ 
  "params": {}, 
  "request": { 
       "url": "/relativePath1",  // Mandatory, The relative path to the cloud container.
       "expiry": 3600            // Mandatory, Integer, in seconds.
   }
}
```

**learner-service** **1.POST private/user/v1/certs/add (Private API, will not require auth token)** lms-service (learner-service)Deposits a certificate to the user. Think of this as a public store that any part can deposit certificates to the user. We will make this public with some auth token then. This is just to reason out why this data is stored here and a similar copy will be stored in user\_courses table as well.&#x20;

user\_courses table will be used to show up the 'Profile' page for the list of enrollments and accomplishments

user\_creds table will be used (in future) to showcase work. For now, it is mainly used to validate the access code.

Request

```js
{
  "params": {},
  "request": 
  {
    "userId": "", 	// Mandatory, The certificate recipient
	"id": "",  // Mandatory, The certificate UUID
	"accessCode": "",  // Mandatory, Access code beneath the QR code
    "jsonData": {
     },   // Mandatory, Raw json data(Object)
    "pdfUrl": "",   // Mandatory, PDF url,
     "courseId":"", //optional parameter will be store inside store map
     "batchId":"",  //optional parameter will be store inside store map
	 "oldId":"",    //optional parameter. If it contains old cert-id need to be deleted(soft/hard)
  }
}
```

Response

| Operation | HttpCode | Result                                       |
| --------- | -------- | -------------------------------------------- |
| Success   | 200      | None                                         |
| Failure   | 400      | None errmsg = "validation error", err = 1001 |

Changes proposed: Case:1

* &#x20;while re-issuing certificate if the old certificate need to be soft delete we need to maintain the certificate details, so for this we can add a flag "isDeleted" with value true is certificate is deleted and false means valid issued certificate and new entry is added for re-issued certificate.
* For the re-issue certificate there can be one more column added which can have old cert-id

Case:2

* &#x20; There is no need to maintain certificate details for delete scenario

2.POST / **private** /user/v1/certs/validate (Private API, will not require auth token)Validates the certificate id matches the access code supplied. We don't want crawlers to capture the pages and this access code makes the intent explicit and a human hand necessary. The Portal team has agreed that the details in this call will be hidden from the URL.

Request

```js
{
    "params": {},
    "request": 
    {
	  "certId": "",  // The certificate UUID
	  "accessCode": ""  // Access code beneath the QR code
    }
}
```

Response

| Operation | HttpCode | Result                                                                                   |
| --------- | -------- | ---------------------------------------------------------------------------------------- |
| Success   | 200      | json + pdf + batchId + courseId                                                          |
| Failure   | 400      | None errmsg = "Invalid access code", err = 1001 errmsg = "Invalid signature", err = 2001 |

200 Ok returns a result with the following format

Changes suggested with release-2.5.0:

3.POST /org/v1/assign/key Enhancements to add keys to the org.

In 2.3, this can blindly add a set of keys to the org. In future, there will be validations added to ensure the keys are not shared by other orgs.

Request

```js
{
	"orgId": "",  // The org to which the keys need to be added
	"signKeys": ["4", "2"],   // List of keys that need to be added
    "encKeys":["5"]
}
```

Response

| Operation | HttpCode | Result                                    |
| --------- | -------- | ----------------------------------------- |
| Success   | 200      | None                                      |
| Failure   | 400      | None errmsg = "Invalid orgId", err = 1001 |

4.POST /user/v1/certs/downloadThis is to download the pdf data. This request must go to cert-service to get a signed URL to the pdf.

Requestx-authentication-header is mandated.

```js
{
    "params": {},
    "request": 
     {
        "pdfUrl": ""   // Mandatory, relative PDF URL
     }
}
```

Response

| Operation | HttpCode | Result                                                |
| --------- | -------- | ----------------------------------------------------- |
| Success   | 200      | response: {     signedPdfUrl: "" // Absolute PDF URL} |
| Failure   | 404      | Not available                                         |

5.PATCH /private/user/v1/certs/mergeThis is to merge the user certificate data. If certificates with "fromAccountId" is exists then those details will be updated with "toAccountId".

Requestx-authentication-header is mandated.

```js
{
    "params": {},
    "request": 
     {
        "fromAccountId": "621170e2-f09f-47fc-ac74-f2ebe5f536b2",
        "toAccountId" : "ff855d27-594b-4fd9-983a-b826c2d5df4e"
     }
}
```

Response

| Operation | HttpCode | Result                              |
| --------- | -------- | ----------------------------------- |
| Success   | 200      | result: {     "status": "SUCCESS" } |
| Failure   | 404      | Not available                       |

```
```

### Schema design

These schema changes will be implemented as part of regular schema update Jenkins job and will be preserved in [cassandra-migration repo](https://github.com/project-sunbird/sunbird-utils/tree/master/cassandra-migration).

#### organisation

New column 'keys' with map\<String, Array> to capture the intended use of the keys and the key identifiers themselves. No validations are going to be made. It is up to the root org to manage its own keys. They may choose to use the same set of keys for both encryption and signing. This will be populated only for 'root-org', at least not in 2.3 for sub-org.

_Example_ :

sign → 1, 2, 7, 8

enc → 3, 4

This translates to the following:

1\.  Use keys with id 1, 2, 7, 8 for signing certificates.

2\.  Use keys 3, 4 for encrypting and storing values. This is not going to be used in SB currently, but would be of use when we pull in registry support.

user\_cert

| userId (string) | Id (string)               | store (map\<string, string>)                     | accessCode (string)      | createdAt | updatedAt |
| --------------- | ------------------------- | ------------------------------------------------ | ------------------------ | --------- | --------- |
| user id         | Identifier/certificate id | json → Raw json data, pdf → link to storage pdf  | text beneath the QR code |           |           |

#### FAQ

1.  Response message is this - "message": "/home/sunbird/conf/0125450863553740809\_certificatess/index.html (No such file or directory)"

    _Likely that the zip file has a parent directory or that zip was created in some other way. Please refer to section "How to create a HTML template zip file" here._

***

\[\[category.storage-team]] \[\[category.confluence]]
