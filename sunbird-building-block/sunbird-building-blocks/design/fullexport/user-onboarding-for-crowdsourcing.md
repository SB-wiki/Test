# User-onboarding-for-crowdsourcing

### ​Introduction:

This document describes the design approach of crowdsourcing user onboarding using programs link.

### Background:

Jira Issue ​[SB-16608: User Onboarding for ContributionOpen](https://project-sunbird.atlassian.net/browse/SB-16608)

### Problem Statement:

1. How to onboard user using program link?
2. How custodian users can onboard into the program?
3. How to restrict the usage limit of the program? Otherwise, it will lead to spam usage of the storage which is exposed to the public programs.

### Key design problems:

1. How to map program & container specific to the program?
2. How to load a program for custodian users?
3. How to generate a sharable short URL?

### Workflow:

![](<../../../../Design/FullExport/images/storage/program crowdsourcing.jpg>)

### 1. How to map program & container specific to the program?

As part of program creation, the blob container with programId should be created.

Any API from the program's portal will have a **request header with programId** . So that in the API manager(back-end) can identify the request is specific to the program.

**Sample API**

https://dev.sunbirded.org/plugin/program/v1/read/1f6bac30-2546-11ea-b725-f3f2f57686cb?userId=95e4942d-cbe8-477d-aebd-ad8sde4b4c8

* Request Headers:

added new field “programid“

```
GET /plugin/program/v1/read/1f6bac30-2546-11ea-b725-f3f2f57686cb?userId=95e4942d-cbe8-477d-aebd-ad8e6de4bfc8 HTTP/1.1
Host: dev.sunbirded.org
Connection: keep-alive
X-App-Id: dev.sunbird.portal
ts: 2020-01-29T10:32:19+05:30
X-msgid: c9a03ad5-6e04-b095-00dd-9ea0c7dc93c4
programid: 1f6bac30-2546-11ea-b725-f3f2f57686cb
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36
Accept: application/json
X-Source: web
X-Device-ID: 553da31e86134197adsd2460667085483
Sec-Fetch-Site: same-origin
Sec-Fetch-Mode: cors
Referer: https://dev.sunbirded.org/contribute/program/1f6bac30-2546-11ea-b725-f3f2f57686cb
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.9,sv;q=0.8
Cookie: connect.sid=s%3Ap3rXyhYcZ4Kdafjlo7k0YryEGn.3zc87q4rD75rzJcdfdN1nXNBxJh7J6%2FqmCa7%2BO%2BlyX4
```

This helps for the below API’s

1. **SignedURL to upload asset** :
   1. Any asset like image, video, PDf, etc.. specific to the program to upload into blob storage directly CF requires signed URL. Based on programID in the request headers, KP can return signed URL(blob container specific to program) specific to the program.
   2. This doesn’t require any changes on the editor(CF) side. It will directly upload to the signed URL.
2. **Publish content/Textbook**
   1. Any content/textbook published in the program can be copied to sunbird main container-based of programId present in the request headers.
3.

### 2. How to load a program for custodian users?

While the user redirects to programs portal page after login success, auto-enroll the user to the program. The portal will send user details in the program context object.

In the program's landing page, verify the user has access to this program. If not auto-enroll the user to the program.

If the user belongs to OrgA & programs belongs to Org B(not default channel) then show an alert message saying user doesn’t have access to this program.

### 3. How to generate a sharable short URL?

Use the program configuration **slug** property to generate a short URL.

```
{
  "slug": "sunbird-testprep",
  "invitation": "false" // default false. When the invitation 
}
```

Sample Program link: [https://dev.sunbirded.org/contribute/program/sunbird-testprep](https://dev.sunbirded.org/contribute/program/487cb6e0-2547-11ea-b725-f3f2f57686cb)

**cons:**

* How to make sure slug property will have always unique?

Clarifications:

1. How admin will generate/get a sharable link?
2. is it language-specific?

### Related articles

Programs portal architecture: ​[Programs portal: Architecture](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1131741213/Programs+portal%3A+Architecture)

***

\[\[category.storage-team]] \[\[category.confluence]]
