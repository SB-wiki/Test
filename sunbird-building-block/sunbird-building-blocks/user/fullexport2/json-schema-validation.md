# Overview :

Using JSON Schema validator to validate the request can be a very efficient and easy thing to validate the request, this can also have some of its cons but fortunately, the pros are more than the cons.

### **Problem statement:** Ticket ref: [SC-1088](https://project-sunbird.atlassian.net/browse/SC-1088)

previously we are using the pure Java code to validate the request so to change some validation it requires a lot of code changes.

**Proposed solution:** we can use  JSON  some pre-defined library called org.everit.json.schema ([everit-lib](https://github.com/everit-org/json-schema)), which uses a JSON schema, after which validation of the request will be a cup of tea for us.

**Approach 1** : in JSON-schema validation, we can also create the JSON-schema file according to individual APIs.  i.e each API will have its own schema and will validate the request from its respective file.

**Approach 2** \*\*: \*\*  In JSON-schema validation,  it is also possible to have references to the attributes (in another JSON schema file), more reusability & readability can be achieved .

```js
"$schema": "http://json-schema.org/draft-07/schema",
  "type": "object",
  "properties": {
    "Person": {
      "$ref": "#/definitions/Person"
    }
  },
  "title":"User",
  "required": [
    "Person"
  ],
  "definitions": {
    "Person": {
      "$id": "#/properties/Person",
      "type": "object",
      "title": "The Person Schema",
      "required": [
        "nationalIdentifier",
        "name",
        "gender",
        "dob"
      ],
      "additionalProperties": false,
      "properties": {
        "signatures": {
          "$id": "#/properties/signatures",
          "type": "array",
          "items": {
            "$ref": "Signature.json#/definitions/Signature"             //given refrences to another json-schema file.
          },
          "$comment": "Placeholder for all verifiable claims"
        },
        "nationalIdentifier": {
          "$id": "#/properties/nationalIdentifier",
          "type": "string",
          "$comment": "Nationality"
        },
        "name": {
          "$id": "#/properties/name",
          "type": "string",
          "title": "Full name"
        },
        "gender": {
          "$id": "#/properties/gender",
          "$ref": "Common.json#/definitions/Gender"
        },
        "dob": {
          "$id": "#/properties/birthDate",
          "$ref": "Common.json#/definitions/Date"
        }
}}
```

\*\* Approach 3: \*\*  In JSON-schema validation, we can put all user attributes in a single JSON-schema file and verify the request from the respective schema file. but this may create the problem to validate the id's in an update request, so we need to explicitly write the code to validate the id in the request.

```js
"$id": "https://example.com/person.schema.json",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "User",
  "type": "object",
  "properties": {
    "firstName": {
      "type": "string",
      "description": "The person's first name."
    },
    "lastName": {
      "type": "string",
      "description": "The person's last name."
    },
    "age": {
      "description": "Age in years which must be equal to or greater than zero.",
      "type": "integer",
      "minimum": 0
    }
  }
} 
```

```


Notes : 
```

* we are also proposing to validate the request from the Akka layer. (to make it an async call, to  avoid blocking of main thread)

\*\* \*\*

***

\[\[category.storage-team]] \[\[category.confluence]]
