# ETB-2.0---Reserve-Dial-code-API-specification

**Overview** As per the current design discussion, LP will be providing two APIs for reserving the dialcodes for textbook and releasing a specific number of dialcodes from the textbook respectively.

For storing the reserved dialcodes list against a textbook, there will be a metadata named \*\*reservedDialcodes. \*\*

As part of reserve API, asked number of dialcodes will get generated and  \*\*reservedDialcodes \*\* metadata of particular textbook will get updated.

As part of release API, asked number of dialcodes will be release post validating dialcodes used in TOC and reserved dialcodes list.

**Reserved Dialcode API:** **POST - content/v3/dialcode/reserve/{content\_id}** **Request Header:** **Authorisation: //Authorisation keyContent-Type: application/json'X-Channel-Id: //Channel for which dialcode are getting generated'** **Request Body**

```
{
    "id": "ekstep.learning.content.dialcode.reserve",
    "ver": "3.0",
    "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn",
    "params":
    {
        "did": "", // device UUID from which API is called
        "key": "", // API key (dynamic)
        "msgid": "" // unique request message id, UUID
    },
    "request":
    {
    	"dialcode": {
			"count": 10, // The total number of dialcodes to be reserved for the content. It should not more than 250. (count-already_reserved_dialcodes) should be the number of dialcodes that has to be generated and appended to the reservedDialcodes list.
			"publisher": "NCERTPUBLISHER", // Publisher of the dialcodes
		}
	}
}
```

**Validation Logic:**

* Dialcode will be generated using content Id as batchCode.
* Content should belong to same channel.
* Content should be of Type Textbook.
* Publisher should be validated.
* Total number of reserved dialcodes request should not be more than 250.
* The existing reservedDialcode value should be subtracted from the count value - for generating new dialcode and appending to the reservedDialcode list.
* If the content already have list of reserved dialcodes, the new dialcodes should be appended.
* If the requested dialcode count is less or equal to the already reserved dialcode list, it should throw client exception with list of already reserved dialcodes list.

**Release Dialcode API:** **PATCH - content/v3/dialcode/release/{content\_id}** **Request Header:** **Authorisation: //Authorisation keyContent-Type: application/json'** **Request Body**

```
{
    
}
```

**Validation Logic:**

* Content should belong to same channel.
* Content should be of Type Textbook
* If all the reserved dialcodes are utilised. It will throw exception.
* If there is not dialcode reserved for the content, it will throw exception.
* API should release all the the unused dialcodes (not used in any of the children of the textbook)

***

\[\[category.storage-team]] \[\[category.confluence]]
