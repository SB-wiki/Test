
## About
The user index is around 1.5 TB (3 TB with replication) in our load testing environment with just 10 million users and this is taking up most of the ES disc space. The user index mapping has been reviewed and optimised to reduce the index size without limiting any of the search capabilities.


## Steps to re-index the data with the new mapping:

1. First check the number of  **number_of_shards**  &  **number_of_replicas**  from old user index by running below curl 

    


```
curl --location --request GET 'http://localhost:9200/_cat/indices/%2A?v=&s=index:desc'
```

1. Create new user index with name as userv{x} // x is version number , by running the below curl 


```
curl --location --request PUT 'localhost:9200/{new_index_name}?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
    "settings": {
        "index": {
            "number_of_shards": "{number_of_shards}",
            "number_of_replicas": "0", // set replica number to zero for faster reindexing
            "refresh_interval": "-1", // Add this setting for faster reindexing
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
                        "min_gram": "3",
                        "type": "ngram",
                        "max_gram": "10"
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


Note : Verify the index settings from the given [link](https://github.com/project-sunbird/sunbird-lms-service/blob/release-3.7.0/actors/sunbird-lms-mw/actors/sunbird-utils/sunbird-es-utils/src/main/resources/indices/user.json)

3.  Once index created , update the mapping by running below curl


```
curl --location --request PUT 'localhost:9200/{new_index_name}/_mapping/_doc' \
--header 'Content-Type: application/json' \
--data-raw '{
  "dynamic": false,
  "properties": {
    "managedBy": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "activeStatus": {
      "type": "keyword",
      "index": false
    },
    "address": {
      "type": "object"
    },
    "appointmentType": {
      "type": "keyword",
      "index": false
    },
    "authenticationStatus": {
      "type": "keyword",
      "index": false
    },
    "avatar": {
      "type": "keyword",
      "index": false
    },
    "badgeAssertions": {
      "type": "object"
    },
    "badges": {
      "type": "object"
    },
    "batches": {
      "type": "object"
    },
    "channel": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "classSubjectTaught": {
      "type": "object"
    },
    "completeness": {
      "type": "long",
      "index": false
    },
    "countryCode": {
      "type": "keyword",
      "index": false
    },
    "createdBy": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "createdDate": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "disabilityType": {
      "type": "keyword",
      "index": false
    },
    "dob": {
      "type": "date",
      "fields": {
        "raw": {
          "type": "date"
        }
      }
    },
    "education": {
      "type": "object"
    },
    "email": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      }
    },
    "prevUsedEmail": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      }
    },
    "emailVerified": {
      "type": "boolean",
      "fields": {
        "raw": {
          "type": "boolean"
        }
      }
    },
    "emailverified": {
      "type": "boolean",
      "fields": {
        "raw": {
          "type": "boolean"
        }
      }
    },
    "employmentState": {
      "type": "keyword",
      "index": false
    },
    "encEmail": {
      "type": "keyword",
      "index": false
    },
    "encPhone": {
      "type": "keyword",
      "index": false
    },
    "firstName": {
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
    "framework": {
      "properties": {
        "board": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "gradeLevel": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "id": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          }
        },
        "medium": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "subject": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        }
      }
    },
    "fullName": {
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
    "gender": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "grade": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "highestAcademicQualification": {
      "type": "keyword",
      "index": false
    },
    "highestEnglishQualification": {
      "type": "keyword",
      "index": false
    },
    "highestMathQualification": {
      "type": "keyword",
      "index": false
    },
    "highestSSTQualification": {
      "type": "keyword",
      "index": false
    },
    "highestScienceQualification": {
      "type": "keyword",
      "index": false
    },
    "highestTeacherQualification": {
      "type": "keyword",
      "index": false
    },
    "highestVernacularLanguageQualification": {
      "type": "keyword",
      "index": false
    },
    "id": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "identifier": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "isDeleted": {
      "type": "boolean",
      "fields": {
        "raw": {
          "type": "boolean"
        }
      }
    },
    "isMasterTrainer": {
      "type": "keyword",
      "index": false
    },
    "jobProfile": {
      "type": "object"
    },
    "language": {
      "type": "keyword",
      "index": false
    },
    "lastName": {
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
    "lastUpdatedOn": {
      "type": "date",
      "fields": {
        "raw": {
          "type": "date"
        }
      }
    },
    "location": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      }
    },
    "locationIds": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "loginId": {
      "type": "keyword",
      "index": false
    },
    "maskEmail": {
      "type": "keyword",
      "index": false
    },
    "maskPhone": {
      "type": "keyword",
      "index": false
    },
    "maskedEmail": {
      "type": "keyword",
      "index": false
    },
    "maskedPhone": {
      "type": "keyword",
      "index": false
    },
    "masterTrainerSubjects": {
      "type": "keyword",
      "index": false
    },
    "missingFields": {
      "type": "keyword",
      "index": false
    },
    "organisations": {
      "properties": {
        "addedBy": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          }
        },
        "addedByName": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "approvalDate": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "approvaldate": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "approvedBy": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          }
        },
        "hashTagId": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          }
        },
        "id": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          }
        },
        "isApproved": {
          "type": "boolean",
          "fields": {
            "raw": {
              "type": "boolean"
            }
          }
        },
        "isDeleted": {
          "type": "boolean",
          "fields": {
            "raw": {
              "type": "boolean"
            }
          }
        },
        "isRejected": {
          "type": "boolean",
          "fields": {
            "raw": {
              "type": "boolean"
            }
          }
        },
        "orgJoinDate": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "orgLeftDate": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "orgName": {
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
        "organisationId": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          }
        },
        "orgjoindate": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "position": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          }
        },
        "roles": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "text",
              "analyzer": "keylower"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "updatedBy": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          }
        },
        "updatedDate": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          },
          "analyzer": "cs_search_analyzer",
          "search_analyzer": "cs_search_analyzer"
        },
        "userId": {
          "type": "keyword",
          "fields": {
            "raw": {
              "type": "keyword"
            }
          }
        }
      }
    },
    "phone": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      }
    },
    "prevUsedPhone": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      }
    },
    "phoneVerified": {
      "type": "boolean",
      "fields": {
        "raw": {
          "type": "boolean"
        }
      }
    },
    "phoneverified": {
      "type": "boolean",
      "fields": {
        "raw": {
          "type": "boolean"
        }
      }
    },
    "profileSummary": {
      "type": "keyword",
      "index": false
    },
    "profileVisibility": {
      "type": "object"
    },
    "provider": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "regOrgId": {
      "type": "keyword",
      "index": false
    },
    "registryId": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "roles": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "rootOrgId": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "rootOrgName": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "schoolCode": {
      "type": "double",
      "index": false
    },
    "schoolJoiningDate": {
      "type": "date",
      "index": false
    },
    "serviceJoiningDate": {
      "type": "date",
      "index": false
    },
    "skills": {
      "type": "object"
    },
    "status": {
      "type": "long",
      "fields": {
        "raw": {
          "type": "long"
        }
      }
    },
    "subject": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "teacherInBRC": {
      "type": "keyword",
      "index": false
    },
    "teacherInCRC": {
      "type": "keyword",
      "index": false
    },
    "teacherSchoolBoardAffiliation": {
      "type": "keyword",
      "index": false
    },
    "teacherStatus": {
      "type": "keyword",
      "index": false
    },
    "teacherType": {
      "type": "keyword",
      "index": false
    },
    "tncAcceptedOn": {
      "type": "date",
      "fields": {
        "raw": {
          "type": "date"
        }
      }
    },
    "tncAcceptedVersion": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "trainingsCompleted": {
      "type": "keyword",
      "index": false
    },
    "updatedBy": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "updatedDate": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "userId": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "keyword"
        }
      }
    },
    "userName": {
      "type": "keyword",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      }
    },
    "userType": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_search_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "vernacularLanguageStudied": {
      "type": "keyword",
      "index": false
    },
    "webPages": {
      "type": "object"
    }
  }
}'
```
Note : Verify the index mapping settings from the given [link](https://github.com/project-sunbird/sunbird-lms-service/blob/release-3.7.0/actors/sunbird-lms-mw/actors/sunbird-utils/sunbird-es-utils/src/main/resources/mappings/user-mapping.json)

4. Once mapping update, run the reindex curl  


```
curl --location --request POST 'localhost:9200/_reindex?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source": {
    "index": "{old_user_index_name}"
  },
  "dest": {
    "index": "{new_user_index_name}"
  }
}'
```
5. After reindexing , update the index with correct number of replica and refresh interval, by below curl


```
curl --location --request PUT 'localhost:9200/{new_index_name}/_settings?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "index" : {
    "number_of_replicas" : 1, // update this number as per the first curl response
    "refresh_interval": "1s" // refreash interval should be always 1s
  }
}'
```
6.  After updating replica , add alias to the new index with alias name as  **user_alias**  , by below curl




```
curl --location --request PUT 'localhost:9200/{new_index_name}/_alias/user_alias?pretty'
```
Note : If alias name changed other than  **user_alias,** update the learner env for  **user_index_alias** 



7. Deploy the learner (release-3.7.0) and check the disk usage , replica number for the new index by running the below curl


```
curl --location --request GET 'http://localhost:9200/_cat/indices/%2A?v=&s=index:desc'
```




*****

[[category.storage-team]] 
[[category.confluence]] 
