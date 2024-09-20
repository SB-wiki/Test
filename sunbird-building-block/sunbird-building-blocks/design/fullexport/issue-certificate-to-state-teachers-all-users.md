# Issue-Certificate-To-State-Teachers--All-Users

### &#x20;

Problem Statement :

#### Certificate issuer should be able to choose whether the certificates  are issued to only state teachers or all users.

[SB-16099 System JIRA](https://browse/SB-16099)

### Solution Approach :

####

Solution 1 : While adding a certificate template to a course-batch, we can add a new sub-section as " **user** " inside the criteria section, inside user we can specify a field as " **type** ". This would specify whether the certificate is applicable only for state teachers or all users.The possible values for type field can be _**STATE**_ and _**ALL**_ .Depending on the value of type field of a certificate template,Certificate issuer will be able to issue the certificate to only state teachers or all the users.

Request : _(Add Certificate Template)_

```
{

    "request":{

        "batch":{

            "courseId":"do_2128813877021900801193",

            "batchId":"0128821148183429120",

            "template":

            {

                "identifier":"template_01",

                "criteria": {

                 "enrollment": {

                    "status": 2

                    },

                 "user":{

                    "type":"STATE"

                 }

            },

            "signatoryList":\[{ }],

            "issuer":{}

                

            }

        }

    }

}




```

#### Solution 2 :In the issue certificate request body, new field " **type** " can be added.The possible values for this field can be " _**STATE**_ " and " _**ALL**_ ". Depending on the value of type, certificate issuer will issue the certificate to the correct set of users(either state teachers or all users)

#### Request : _(Issue Certificate )_

```
{

    "request":{

                  "courseId":"do_2128813877021900801193",

                  "batchId":"0128821148183429120",

                  "type:"STATE"

                  }



}
```

```
```

```
```

***

\[\[category.storage-team]] \[\[category.confluence]]
