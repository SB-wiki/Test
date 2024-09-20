For Cloud Service Provider(CSP) related change, we need to update the certificate template urls in course_batch index for sunbird-RC service.

 **NOTE:** 


1. Take the backup of trainingcertificate index.


1. During testing doc count in trainingcertificate index was 6393483.


1. Total time taken to complete the steps was approx 2Hr.



 **pre-requisite:**  Execute below command to get few sample records and compare the data before and after the whole task is completed.


```
curl --location --request GET 'localhost:9200/trainingcertificate/_search' \
--header 'Content-Type: application/json' \
--data-raw '{
    "query": {
        "match_all": {}
    }
}
'
```

### Steps for trainingcertificate index update:

1. First create a temporary index (trainingcertificatev3)

    


```
curl -X PUT "localhost:9200/trainingcertificatev3?pretty"
```

1. create ingest pipeline using below given curl


    1. From the search api response get the old blob host value from “templateUrl” field and keep the old blob host value in below contains method and in replace method first parameter and enter the second parameter with the cname value.

     **NOTE:** Update the new csp domain url in below curl (replace new url in below curl mentioned at [ **new.csp.domain.url.net** ](http://new.csp.domain.url.net))

    


```
curl --location --request PUT 'localhost:9200/_ingest/pipeline/update-rc-template-url?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
    "description": "This Pipeline Will update azure template url  to aws template url",
    "processors": [
        {
            "script": {
                "lang": "painless",
                "source": "\nif (ctx.templateUrl != null && !ctx.templateUrl.isEmpty() && ctx.templateUrl.contains(\"https://ntpproductionall.blob.core.windows.net\")) {\n\t\t\tctx.templateUrl = ctx.templateUrl.replace(\"https://ntpproductionall.blob.core.windows.net\", \"https://new.csp.domain.url.net\");\n\t\t}\n\t\tif (ctx._osSignedData != null && !ctx._osSignedData.isEmpty() && ctx._osSignedData.contains(\"https://ntpproductionall.blob.core.windows.net\")) {\n\t\t\tctx._osSignedData = ctx._osSignedData.replace(\"https://ntpproductionall.blob.core.windows.net\", \"https://new.csp.domain.url.net\");\n\t\t}"
            }
        }
    ]
}'
```


    
1. reindex the data using below given curl

    


```
curl --location --request POST 'localhost:9200/_reindex?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source": {
    "index": "trainingcertificate"
  },
  "dest": {
    "index": "trainingcertificatev3",
    "pipeline": "update-rc-template-url"
  }
}'
```

1. run the below curl and match the count of doc in both the index for verification, it should be same

    


```
curl --location --request GET 'http://localhost:9200/_cat/indices?v'

```

1. run the below curl to verify the url modification

    


```
curl -X GET "localhost:9200/trainingcertificatev3/_doc/3fe70c0b-c238-4475-96d6-c231b87d8853?pretty" -H 'Content-Type: application/json'
```

1. delete the original index (as per current release we are not using alisa feature in sunbird-RC)

    


```
curl --location --request DELETE 'localhost:9200/trainingcertificate?pretty'

```

1. create index trainingcertificate

    


```
curl -X PUT "localhost:9200/trainingcertificate?pretty"
```

1. run the reindex curl mentioned below

    


```
curl --location --request POST 'localhost:9200/_reindex?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source": {
    "index": "trainingcertificatev3"
  },
  "dest": {
    "index": "trainingcertificate"
  }
}'
```

1. verify the doc count, the count of the documents must be same before and after reindex.

    


```
curl --location --request GET 'http://localhost:9200/_cat/indices?v'
```




*****

[[category.storage-team]] 
[[category.confluence]] 
