# SB-20865--Migrate-certificate-data-from-Cassandra-to-Blog-storage-for-already-issue-certificate

```
* [Overview ](#overview-)
* [Prerequisite](#prerequisite)
```

#### Overview

With cert-registry and related changes done with ticket[/SB-20811](https://project-sunbird.atlassian.net/browse/SB-20811), migration of existing certificate is required.

**Steps for data migration**

1. Between dates, d1 and d2, get the list of certificates issued from ES&#x20;
2. For each certificate get a record from Cassandra
3. If row.jsonurl is empty || data.printURI is non-empty

* &#x20;Upload the data into Cloud Store
* &#x20;Update Cassandra with the following changes. Remove the data.printURI and append row.jsonURL with the uploaded artifact URL&#x20;
* Sync ES so that the data JSON object is available for the portal to display course name, issued on details

Using the following query, get the data from ES and Note down the count before running the script

```
curl --location --request POST '{{host}}/api/certreg/v1/certs/search' \
--header 'Content-Type: application/json' \
--header 'Authorization: {{api-key}}' \
--data-raw '{
    "request": {
        "_source": [
            "identifier"
        ],
        "query": {
            "bool": {
                "must": [
                    {
                        "bool": {
                            "must_not": {
                                "exists": {
                                    "field": "data"
                                }
                            }
                        }
                    },
                    {
                        "bool": {
                            "must_not": {
                                "exists": {
                                    "field": "jsonUrl"
                                }
                            }
                        }
                    },
                    {
                        "range": {
                            "createdAt": {
                                "gte": "2020-08-01",
                                "lte": "2020-10-01"
                            }
                        }
                    }
                ]
            }
        }
    }
}'
```

**Problem Statement** : We cannot get all the records at one search call, in ES the limit is 10000.  **Solution** :  Search using scroll in ES ([Scroll | Elasticsearch Reference](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/search-request-scroll.html))While a search request returns a single page of results, the scroll API can be used to retrieve large numbers of results (or even all results) from a single search request, in much the same way as you would use a cursor on a traditional database.

```
curl --location --request POST '11.2.3.58:9200/certs/_search?scroll=1m' \
--header 'Content-Type: application/json' \
--data-raw '{
    "_source": [
        "identifier",
    ],
    "size": 10000,
    "query": {
        "bool": {
            "must": [
                {
                    "bool": {
                        "must_not": {
                            "exists": {
                                "field": "data"
                            }
                        }
                    }
                },
                {
                    "bool": {
                        "must_not": {
                            "exists": {
                                "field": "jsonUrl"
                            }
                        }
                    }
                },
                {
                    "range": {
                        "createdAt": {
                            "gte": "2020-08-01",
                            "lte": "2020-10-01"
                        }
                    }
                }
            ]
        }
    }
}'
```

The result from the above request includes a **\_scroll\_id** , which should be passed to the scroll API in order to retrieve the next batch of results.

```
curl --location --request GET '11.2.3.58:9200/_search/scroll' \
--header 'Content-Type: application/json' \
--data-raw '{
    "scroll": "1h",
    "scroll_id": ""
}'
```

#### **Prerequisite** :

* Connection to Cassandra and ES
* require the following env variables to be set  ([reference](https://github.com/project-sunbird/sunbird-devops/blob/release-3.4.0/ansible/roles/stack-sunbird/templates/sunbird\_cert-service.env))
* the values for env vars should be the same as cert-service env variables
* Add only one IP for es\_conn\_info

```
sunbird_cassandra_host
sunbird_cassandra_keyspace (sunbird)
sunbird_cassandra_port
es_conn_info
CLOUD_STORAGE_TYPE
AZURE_STORAGE_SECRET
AZURE_STORAGE_KEY
CONTAINER_NAME
sunbird_cert_domain_url
```

**Steps to run the script** [Git Hub Repo](https://github.com/project-sunbird/cert-service/tree/release-3.4.0/certificate-migration)

1. mvn clean install
2. cd target
3. java -jar certificate-migration-1.0-SNAPSHOT-jar-with-dependencies.jar

**Steps To Verify**

* Compare the count given post script.
* Hit the following API:&#x20;

```
curl --location --request POST 'https://staging.ntp.net.in/api/certreg/v1/certs/search' \
--header 'Content-Type: application/json' \
--header 'Authorization: {{api-key}}' \
--data-raw '{
    "request": {
        "_source": [
            "identifier"
        ],
        "query": {
            "bool": {
                "must": [
                    {
                        "bool": {
                            "must_not": {
                                "exists": {
                                    "field": "data"
                                }
                            }
                        }
                    },
                    {
                        "bool": {
                            "must_not": {
                                "exists": {
                                    "field": "jsonUrl"
                                }
                            }
                        }
                    },
                    {
                        "range": {
                            "createdAt": {
                                "gte": "2020-08-01",
                                "lte": "2020-10-01"
                            }
                        }
                    }
                ]
            }
        }
    }
}'
```

* Get the count from the res, compare count after running and before running&#x20;
*   Check the logs to get the total records corrected, skipped&#x20;

    _Total records: {} Total Records corrected: {} ,Certificates Successfully updated in cassandra: {} Successfully synced in ES : {}, Certificates Skipped : {} , certificates not found in cassandra : {}_

    _Certificates failed count : {}_
* At the end of the run, the program will generate the file named  update\_cassandra\_success\_record.txt,update\_es\_success\_record.txt  which has certId, so it is easy to identify the records which are successfully processed...
* Login to Cassandra
* select id,jsonUrl,updatedAt and data from from the table cert-registry( **select id,jsonUrl,updatedat from sunbird.cert\_registry;** )
* verify the column jsonUrl, updatedAt and data should be updated for the certId taken from file generated or logs. Data should not be containing printUri, updatedAt should be a recent date when jar starts executing.
* And In ES, hit the following API by providing certId (any id, which got updated) in req, In the response data object should be present

```
curl --location --request POST 'https://staging.ntp.net.in/api/certreg/v1/certs/search' \
--header 'Content-Type: application/json' \
--header 'Authorization: {{api-key}}' \
--data-raw '{
    "request": {
        "_source": [],
        "query": {
            "match_phrase": {
                "_id": "certId"
            }
        }
    }
}'
```

***

\[\[category.storage-team]] \[\[category.confluence]]
