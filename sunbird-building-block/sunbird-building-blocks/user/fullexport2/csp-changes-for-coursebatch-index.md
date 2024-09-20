For Cloud Service Provider(CSP) related change, we need to update the certificate template urls in course_batch index for course-service.

 **NOTE:** 


1. Take the backup of course-batch index.


1. During testing doc count in course-batch index was 10400.


1. Total time taken to complete the steps was approx 40min.



 **pre-requisite:**  Execute below command to get few sample records and compare the data before and after the whole task is completed.


```
curl --location --request GET 'localhost:9200/course-batch/_search' \
--header 'Content-Type: application/json' \
--data-raw '{
    "from":1,
    "size":2,
  "query": {
    "bool": {
      "must_not": {
        "exists": {
          "field": "_id"
        }
      }
    }
  }
}
'
```

### Steps for courseBatch index update:

1. First create a temporary index (coursebatch_v3) 

    


```
curl --location --request PUT 'localhost:9200/coursebatch_v3?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
    "settings": {
        "index": {
            "number_of_shards": "5",
            "number_of_replicas": "1",
            "analysis": {
                "filter": {
                    "mynGram": {
                        "token_chars": [
                            "letter",
                            "digit",
                            "whitespace",
                            "punctuation",
                            "symbol"
                        ],
                        "min_gram": "1",
                        "type": "ngram",
                        "max_gram": "20"
                    }
                },
                "analyzer": {
                    "cs_index_analyzer": {
                        "filter": [
                            "lowercase",
                            "mynGram"
                        ],
                        "type": "custom",
                        "tokenizer": "standard"
                    },
                    "keylower": {
                        "filter": "lowercase",
                        "type": "custom",
                        "tokenizer": "keyword"
                    },
                    "cs_search_analyzer": {
                        "filter": [
                            "lowercase",
                            "standard"
                        ],
                        "type": "custom",
                        "tokenizer": "standard"
                    }
                }
            }
        }
    }
}'
```

1.  update the mapping using below given curl

    


```
curl --location --request PUT 'localhost:9200/coursebatch_v3/_mapping/_doc' \
--header 'Content-Type: application/json' \
--data-raw '{
    "dynamic": false,
    "properties": {
        "all_fields": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower"
                }
            },
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer"
        },
        "batchId": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "courseId": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "createdBy": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "createdDate": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "createdFor": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "description": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "endDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
         "enrollmentEndDate": {
           "type": "date",
           "fields": {
              "raw":  {
                  "type": "date"
               }
           }
        },
        "enrollmentType": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "id": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "identifier": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "mentors": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "name": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "startDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "status": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "updatedDate": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "participantCount": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "completedCount": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "reportUpdatedOn": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "cert_templates": {
            "type": "nested"
        }
    }
}'
```

1.    create ingest pipeline using below given curl


    1. found the search api response, get the value of “cert_templates” which is old blob url and the host-name of them need to be replaced with new cname, it will be varies wrto environment.

     **NOTE:**   Update the new csp domain url in below curl (replace new url in below curl mentioned at  **new.csp.domain.url.net** )


```
curl --location --request PUT 'localhost:9200/_ingest/pipeline/update-course-batch-template-url?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
    "description": "This Pipeline Will update azure template url  to aws template url",
    "processors": [
        {
            "script": {
                 "lang": "painless",
                 "source": "if (null != ctx.cert_templates) { for (entry in ctx.cert_templates.entrySet()) {\n\t\t\tif (null != entry.getValue().url)\n\t\t\tentry.getValue().url = entry.getValue().url.replace(\"https://ntpproductionall.blob.core.windows.net/\", \"https://new.csp.domain.url.net/\");\n\t\t\n\t\t\tif (null != entry.getValue().previewUrl)\n\t\t\tentry.getValue().previewUrl = entry.getValue().previewUrl.replace(\"https://ntpproductionall.blob.core.windows.net/\", \"https://new.csp.domain.url.net/\");\n\t\t}}"
            }
        }
    ]
}'
```


    
1.    reindex the data using below given curl

    


```
curl --location --request POST 'localhost:9200/_reindex?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source": {
    "index": "course-batch"
  },
  "dest": {
    "index": "coursebatch_v3",
    "pipeline": "update-course-batch-template-url"
  }
}'
```

1.   run the below curl and match the count of doc in both the index for verification, it should be same

    


```
curl --location --request GET 'http://localhost:9200/_cat/indices?v'
```

1.   run the below curl to verify the url modification, check the field “cert_templates” contains the new cname.


```
 curl -X GET "localhost:9200/coursebatch_v3/_doc/0131595144460451844?pretty" -H 'Content-Type: application/json'
```

1.   delete the original index (as per current release we are not using alias feature in course service)

    


```
curl --location --request DELETE 'localhost:9200/course-batch?pretty'
```

1. create index course-batch 

    


```
curl --location --request PUT 'localhost:9200/course-batch?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
    "settings": {
        "index": {
            "number_of_shards": "5",
            "number_of_replicas": "1",
            "analysis": {
                "filter": {
                    "mynGram": {
                        "token_chars": [
                            "letter",
                            "digit",
                            "whitespace",
                            "punctuation",
                            "symbol"
                        ],
                        "min_gram": "1",
                        "type": "ngram",
                        "max_gram": "20"
                    }
                },
                "analyzer": {
                    "cs_index_analyzer": {
                        "filter": [
                            "lowercase",
                            "mynGram"
                        ],
                        "type": "custom",
                        "tokenizer": "standard"
                    },
                    "keylower": {
                        "filter": "lowercase",
                        "type": "custom",
                        "tokenizer": "keyword"
                    },
                    "cs_search_analyzer": {
                        "filter": [
                            "lowercase",
                            "standard"
                        ],
                        "type": "custom",
                        "tokenizer": "standard"
                    }
                }
            }
        }
    }
}'
```

1. update mapping of course-batch index

    


```
curl --location --request PUT 'localhost:9200/course-batch/_mapping/_doc' \
--header 'Content-Type: application/json' \
--data-raw '{
    "dynamic": false,
    "properties": {
        "all_fields": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower"
                }
            },
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer"
        },
        "batchId": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "courseId": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "createdBy": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "createdDate": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "createdFor": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "description": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "endDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
         "enrollmentEndDate": {
           "type": "date",
           "fields": {
              "raw":  {
                  "type": "date"
               }
           }
        },
        "enrollmentType": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "id": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "identifier": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "mentors": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "name": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "startDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "status": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "updatedDate": {
            "type": "text",
            "fields": {
                "raw": {
                    "type": "text",
                    "analyzer": "keylower",
                    "fielddata": true
                }
            },
            "copy_to": [
                "all_fields"
            ],
            "analyzer": "cs_index_analyzer",
            "search_analyzer": "cs_search_analyzer",
            "fielddata": true
        },
        "participantCount": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "completedCount": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "reportUpdatedOn": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "cert_templates": {
            "type": "nested"
        }
    }
}'
```

1. run the reindex curl mentioned below 

    


```
curl --location --request POST 'localhost:9200/_reindex?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source": {
    "index": "coursebatch_v3"
  },
  "dest": {
    "index": "course-batch"
  }
}'
```

1.  verify the doc count, which shows total document counts not altered during reindexing.

    


```
curl --location --request GET 'http://localhost:9200/_cat/indices?v'
```




*****

[[category.storage-team]] 
[[category.confluence]] 
