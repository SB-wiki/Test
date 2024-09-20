
### Problem Statement
Since we are moving to multi index format and static mapping there should be a way in accordance with CI/CD to update mapping whenever a new field is added as required.

[SB-11346 System JIRA](https:///browse/SB-11346)


### Solution Approach
A jenkins job can be added to update mapping for indexes. The jenkins needs to be configured to perform below steps


1. verify if the index exists or not?
1. if index does not exists, create index with create file.
1. If index is available it calls the update mapping.


### Job Path
job path[/job/OpsAdministration/job/staging/job/Core/job/EsMapping/](http://10.20.0.9:8080/job/OpsAdministration/job/staging/job/Core/job/EsMapping/)




### Problem Statement
How to verify if an index exists or not


### Solution Approach
A HEAD http call can be used to verify if index exists or not


```js
Request

HEAD /{indexName}

Response status code with details

200 - index exists
404 - index missing 


example

curl --head http://{es-ip}:{es-port}/user 


```

### Problem Statement
How to create an index?


### Solution Approach
An index can be created by providing settings and mapping arguments as below


```js
Request
 
PUT /{indexName}
 
{
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
    },
    "mappings": {
        "_doc": {
            "dynamic":false,
            "properties": {
                "activeStatus": {
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
                "address": {
                    "properties": {
                        "addType": {
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
                        "addressLine1": {
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
                        "addressLine2": {
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
                        "city": {
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
                        "country": {
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
                        "state": {
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
                        "updatedBy": {
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
                        "userId": {
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
                        "zipcode": {
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
                        }
                    }
                },
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
                "appointmentType": {
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
                "authenticationStatus": {
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
                "avatar": {
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
                "badgeAssertions": {
                    "properties": {
                        "assertionId": {
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
                        "assertionid": {
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
                        "badgeClassImage": {
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
                        "badgeClassName": {
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
                        "badgeId": {
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
                        "badgeclassimage": {
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
                        "badgeclassname": {
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
                        "badgeid": {
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
                        "createdTS": {
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
                        "createdTs": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "createdts": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
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
                        "issuerId": {
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
                        "userId": {
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
                        }
                    }
                },
                "badges": {
                    "properties": {
                        "badgeTypeId": {
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
                        "receiverId": {
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
                        }
                    }
                },
                "batches": {
                    "properties": {
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
                        "enrolledOn": {
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
                        "lastAccessedOn": {
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
                        "progress": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        }
                    }
                },
                "channel": {
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
                "classSubjectTaught": {
                    "properties": {
                        "classes": {
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
                        "subjects": {
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
                        }
                    }
                },
                "completeness": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                },
                "countryCode": {
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
                "disabilityType": {
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
                "dob": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "education": {
                    "properties": {
                        "address": {
                            "properties": {
                                "addressLine1": {
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
                                "addressLine2": {
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
                                "city": {
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
                                "state": {
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
                                "updatedBy": {
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
                                "zipcode": {
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
                                }
                            }
                        },
                        "addressId": {
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
                        "boardOrUniversity": {
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
                        "degree": {
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
                        "grade": {
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
                        "percentage": {
                            "type": "double",
                            "fields": {
                                "raw": {
                                    "type": "double"
                                }
                            }
                        },
                        "updatedBy": {
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
                        "userId": {
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
                        "yearOfPassing": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        }
                    }
                },
                "email": {
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
                "encEmail": {
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
                "encPhone": {
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
                "firstName": {
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
                "framework": {
                    "properties": {
                        "board": {
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
                        "gradeLevel": {
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
                        "medium": {
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
                        "subject": {
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
                        }
                    }
                },
                "fullName": {
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
                "gender": {
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
                "grade": {
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
                "highestAcademicQualification": {
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
                "highestEnglishQualification": {
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
                "highestMathQualification": {
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
                "highestSSTQualification": {
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
                "highestScienceQualification": {
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
                "highestTeacherQualification": {
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
                "highestVernacularLanguageQualification": {
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
                "isDeleted": {
                    "type": "boolean",
                    "fields": {
                        "raw": {
                            "type": "boolean"
                        }
                    }
                },
                "isMasterTrainer": {
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
                "jobProfile": {
                    "properties": {
                        "address": {
                            "properties": {
                                "addressLine1": {
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
                                "addressLine2": {
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
                                "city": {
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
                                "state": {
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
                                "updatedBy": {
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
                                "zipcode": {
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
                                }
                            }
                        },
                        "addressId": {
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
                        "endDate": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
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
                        "isCurrentJob": {
                            "type": "boolean",
                            "fields": {
                                "raw": {
                                    "type": "boolean"
                                }
                            }
                        },
                        "jobName": {
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
                        "joiningDate": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "orgId": {
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
                        "orgName": {
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
                        "role": {
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
                        "subject": {
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
                        "updatedBy": {
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
                        "userId": {
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
                        }
                    }
                },
                "language": {
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
                "lastName": {
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
                "lastUpdatedOn": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "location": {
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
                "locationIds": {
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
                "loginId": {
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
                "maskEmail": {
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
                "maskPhone": {
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
                "maskedEmail": {
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
                "maskedPhone": {
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
                "masterTrainerSubjects": {
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
                "missingFields": {
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
                "organisations": {
                    "properties": {
                        "addedBy": {
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
                        "addedByName": {
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
                        "approvalDate": {
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
                        "approvaldate": {
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
                        "approvedBy": {
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
                        "hashTagId": {
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
                        "orgLeftDate": {
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
                        "orgName": {
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
                        "organisationId": {
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
                        "orgjoindate": {
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
                        "position": {
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
                        "roles": {
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
                        "updatedBy": {
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
                        "userId": {
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
                        }
                    }
                },
                "phone": {
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
                "profileVisibility": {
                    "properties": {
                        "address": {
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
                        "dob": {
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
                        "education": {
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
                        "email": {
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
                        "firstName": {
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
                        "gender": {
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
                        "grades": {
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
                        "jobProfile": {
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
                        "language": {
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
                        "location": {
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
                        "loginId": {
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
                        "phone": {
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
                        "profileSummary": {
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
                        "skills": {
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
                        "socialMedia": {
                            "properties": {
                                "in": {
                                    "properties": {
                                        "url": {
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
                                        }
                                    }
                                },
                                "twitter": {
                                    "properties": {
                                        "url": {
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
                                        }
                                    }
                                }
                            }
                        },
                        "subject": {
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
                        "subjects": {
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
                        "test": {
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
                        "userId": {
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
                        "userName": {
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
                        "userSkills": {
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
                        "webPages": {
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
                        }
                    }
                },
                "provider": {
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
                "regOrgId": {
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
                "registryId": {
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
                "roles": {
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
                "rootOrgId": {
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
                "rootOrgName": {
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
                "schoolCode": {
                    "type": "double",
                    "fields": {
                        "raw": {
                            "type": "double"
                        }
                    }
                },
                "schoolJoiningDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "serviceJoiningDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "skills": {
                    "properties": {
                        "addedAt": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "addedBy": {
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
                        "createdOn": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "endorsementCount": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        },
                        "endorsementcount": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        },
                        "endorsers": {
                            "properties": {
                                "0283452c-a607-4184-9806-1fac2f16d5b9": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "39d460e8-80ef-4045-8fe0-de4a78e78bc4": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "3d45fbd8-b911-4cc5-b503-61215902d780": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "48a2fbc6-df85-4a41-8e68-7057986aee5a": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "62354c16-29c7-419c-8d30-a30491bef7c3": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "7526ab9d-e8a6-478b-83e2-6ff1296c302e": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "9645e749-39f0-4b73-993d-09e633eeea1d": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "a1355233-6b82-4660-86f5-73b95c03aec9": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "a3d4151b-4d3e-4068-8950-d5b27b10487e": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "b2fff05d-dfc9-497c-840e-5675a2b78e57": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "be7efb23-6af9-4d92-82b3-a4d78fcfa2f6": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "c9f23b5f-cd4c-42db-9a24-1f3ebc60dc9a": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "d5efd1ab-3cad-4034-8143-32c480f5cc9e": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                }
                            }
                        },
                        "endorsersList": {
                            "properties": {
                                "endorseDate": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "userId": {
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
                                }
                            }
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
                        "lastUpdatedBy": {
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
                        "lastUpdatedOn": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "skillName": {
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
                        "skillNameToLowercase": {
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
                        "userId": {
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
                "subject": {
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
                "teacherInBRC": {
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
                "teacherInCRC": {
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
                "teacherSchoolBoardAffiliation": {
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
                "teacherStatus": {
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
                "teacherType": {
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
                "trainingsCompleted": {
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
                "updatedBy": {
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
                "userId": {
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
                "userName": {
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
                "userType": {
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
                "vernacularLanguageStudied": {
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
                "webPages": {
                    "properties": {
                        "type": {
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
                        "url": {
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
                        }
                    }
                }
            }
        }
    }
}
 
Response
 
{
    "acknowledged": true,
    "shards_acknowledged": true,
    "index": "content"
}
 
example
 
curl -X PUT \
  http://localhost:9200/user \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
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
    },
    "mappings": {
        "_doc": {
            "dynamic":false,
            "properties": {
                "activeStatus": {
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
                "address": {
                    "properties": {
                        "addType": {
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
                        "addressLine1": {
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
                        "addressLine2": {
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
                        "city": {
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
                        "country": {
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
                        "state": {
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
                        "updatedBy": {
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
                        "userId": {
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
                        "zipcode": {
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
                        }
                    }
                },
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
                "appointmentType": {
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
                "authenticationStatus": {
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
                "avatar": {
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
                "badgeAssertions": {
                    "properties": {
                        "assertionId": {
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
                        "assertionid": {
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
                        "badgeClassImage": {
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
                        "badgeClassName": {
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
                        "badgeId": {
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
                        "badgeclassimage": {
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
                        "badgeclassname": {
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
                        "badgeid": {
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
                        "createdTS": {
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
                        "createdTs": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "createdts": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
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
                        "issuerId": {
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
                        "userId": {
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
                        }
                    }
                },
                "badges": {
                    "properties": {
                        "badgeTypeId": {
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
                        "receiverId": {
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
                        }
                    }
                },
                "batches": {
                    "properties": {
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
                        "enrolledOn": {
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
                        "lastAccessedOn": {
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
                        "progress": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        }
                    }
                },
                "channel": {
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
                "classSubjectTaught": {
                    "properties": {
                        "classes": {
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
                        "subjects": {
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
                        }
                    }
                },
                "completeness": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                },
                "countryCode": {
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
                "disabilityType": {
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
                "dob": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "education": {
                    "properties": {
                        "address": {
                            "properties": {
                                "addressLine1": {
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
                                "addressLine2": {
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
                                "city": {
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
                                "state": {
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
                                "updatedBy": {
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
                                "zipcode": {
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
                                }
                            }
                        },
                        "addressId": {
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
                        "boardOrUniversity": {
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
                        "degree": {
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
                        "grade": {
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
                        "percentage": {
                            "type": "double",
                            "fields": {
                                "raw": {
                                    "type": "double"
                                }
                            }
                        },
                        "updatedBy": {
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
                        "userId": {
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
                        "yearOfPassing": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        }
                    }
                },
                "email": {
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
                "encEmail": {
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
                "encPhone": {
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
                "firstName": {
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
                "framework": {
                    "properties": {
                        "board": {
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
                        "gradeLevel": {
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
                        "medium": {
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
                        "subject": {
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
                        }
                    }
                },
                "fullName": {
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
                "gender": {
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
                "grade": {
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
                "highestAcademicQualification": {
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
                "highestEnglishQualification": {
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
                "highestMathQualification": {
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
                "highestSSTQualification": {
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
                "highestScienceQualification": {
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
                "highestTeacherQualification": {
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
                "highestVernacularLanguageQualification": {
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
                "isDeleted": {
                    "type": "boolean",
                    "fields": {
                        "raw": {
                            "type": "boolean"
                        }
                    }
                },
                "isMasterTrainer": {
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
                "jobProfile": {
                    "properties": {
                        "address": {
                            "properties": {
                                "addressLine1": {
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
                                "addressLine2": {
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
                                "city": {
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
                                "state": {
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
                                "updatedBy": {
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
                                "zipcode": {
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
                                }
                            }
                        },
                        "addressId": {
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
                        "endDate": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
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
                        "isCurrentJob": {
                            "type": "boolean",
                            "fields": {
                                "raw": {
                                    "type": "boolean"
                                }
                            }
                        },
                        "jobName": {
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
                        "joiningDate": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "orgId": {
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
                        "orgName": {
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
                        "role": {
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
                        "subject": {
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
                        "updatedBy": {
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
                        "userId": {
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
                        }
                    }
                },
                "language": {
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
                "lastName": {
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
                "lastUpdatedOn": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "location": {
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
                "locationIds": {
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
                "loginId": {
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
                "maskEmail": {
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
                "maskPhone": {
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
                "maskedEmail": {
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
                "maskedPhone": {
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
                "masterTrainerSubjects": {
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
                "missingFields": {
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
                "organisations": {
                    "properties": {
                        "addedBy": {
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
                        "addedByName": {
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
                        "approvalDate": {
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
                        "approvaldate": {
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
                        "approvedBy": {
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
                        "hashTagId": {
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
                        "orgLeftDate": {
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
                        "orgName": {
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
                        "organisationId": {
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
                        "orgjoindate": {
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
                        "position": {
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
                        "roles": {
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
                        "updatedBy": {
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
                        "userId": {
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
                        }
                    }
                },
                "phone": {
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
                "profileVisibility": {
                    "properties": {
                        "address": {
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
                        "dob": {
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
                        "education": {
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
                        "email": {
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
                        "firstName": {
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
                        "gender": {
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
                        "grades": {
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
                        "jobProfile": {
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
                        "language": {
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
                        "location": {
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
                        "loginId": {
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
                        "phone": {
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
                        "profileSummary": {
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
                        "skills": {
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
                        "socialMedia": {
                            "properties": {
                                "in": {
                                    "properties": {
                                        "url": {
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
                                        }
                                    }
                                },
                                "twitter": {
                                    "properties": {
                                        "url": {
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
                                        }
                                    }
                                }
                            }
                        },
                        "subject": {
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
                        "subjects": {
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
                        "test": {
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
                        "userId": {
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
                        "userName": {
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
                        "userSkills": {
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
                        "webPages": {
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
                        }
                    }
                },
                "provider": {
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
                "regOrgId": {
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
                "registryId": {
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
                "roles": {
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
                "rootOrgId": {
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
                "rootOrgName": {
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
                "schoolCode": {
                    "type": "double",
                    "fields": {
                        "raw": {
                            "type": "double"
                        }
                    }
                },
                "schoolJoiningDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "serviceJoiningDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "skills": {
                    "properties": {
                        "addedAt": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "addedBy": {
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
                        "createdOn": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "endorsementCount": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        },
                        "endorsementcount": {
                            "type": "long",
                            "fields": {
                                "raw": {
                                    "type": "long"
                                }
                            }
                        },
                        "endorsers": {
                            "properties": {
                                "0283452c-a607-4184-9806-1fac2f16d5b9": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "39d460e8-80ef-4045-8fe0-de4a78e78bc4": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "3d45fbd8-b911-4cc5-b503-61215902d780": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "48a2fbc6-df85-4a41-8e68-7057986aee5a": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "62354c16-29c7-419c-8d30-a30491bef7c3": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "7526ab9d-e8a6-478b-83e2-6ff1296c302e": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "9645e749-39f0-4b73-993d-09e633eeea1d": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "a1355233-6b82-4660-86f5-73b95c03aec9": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "a3d4151b-4d3e-4068-8950-d5b27b10487e": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "b2fff05d-dfc9-497c-840e-5675a2b78e57": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "be7efb23-6af9-4d92-82b3-a4d78fcfa2f6": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "c9f23b5f-cd4c-42db-9a24-1f3ebc60dc9a": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "d5efd1ab-3cad-4034-8143-32c480f5cc9e": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                }
                            }
                        },
                        "endorsersList": {
                            "properties": {
                                "endorseDate": {
                                    "type": "date",
                                    "fields": {
                                        "raw": {
                                            "type": "date"
                                        }
                                    }
                                },
                                "userId": {
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
                                }
                            }
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
                        "lastUpdatedBy": {
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
                        "lastUpdatedOn": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "skillName": {
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
                        "skillNameToLowercase": {
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
                        "userId": {
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
                "subject": {
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
                "teacherInBRC": {
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
                "teacherInCRC": {
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
                "teacherSchoolBoardAffiliation": {
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
                "teacherStatus": {
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
                "teacherType": {
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
                "trainingsCompleted": {
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
                "updatedBy": {
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
                "userId": {
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
                "userName": {
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
                "userType": {
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
                "vernacularLanguageStudied": {
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
                "webPages": {
                    "properties": {
                        "type": {
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
                        "url": {
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
                        }
                    }
                }
            }
        }
    }
}'
```


Job cURL commandsINLINEcd sunbird-utils/elasticsearch-util/src/main/resources/indices

curl -X PUT [http://{es-ip}:{es-port}/user](http://localhost:9200/user) -H 'Content-Type: application/json' -d @user.json

curl -X PUT [http://{es-ip}:{es-port}/org](http://localhost:9200/org) -H 'Content-Type: application/json' -d @org.json

curl -X PUT [http://{es-ip}:{es-port}/location](http://localhost:9200/location) -H 'Content-Type: application/json' -d @location.json

curl -X PUT [http://{es-ip}:{es-port}/usernotes](http://localhost:9200/usernotes) -H 'Content-Type: application/json' -d @usernotes.json

curl -X PUT [http://{es-ip}:{es-port}/badgeassociations](http://localhost:9200/badgeassociations) -H 'Content-Type: application/json' -d @badgeassociations.json

curl -X PUT [http://{es-ip}:{es-port}/cbatch](http://localhost:9200/cbatch) -H 'Content-Type: application/json' -d @cbatch.json

curl -X PUT [http://{es-ip}:{es-port}/cbatc](http://localhost:9200/cbatch)hstats -H 'Content-Type: application/json' -d @cbatchstats.json

curl -X PUT [http://{es-ip}:{es-port}/userprofilevisibility](http://localhost:9200/userprofilevisibility) -H 'Content-Type: application/json' -d @userprofilevisibility.json

curl -X PUT [http://{es-ip}:{es-port}/usercourses](http://localhost:9200/usercourses) -H 'Content-Type: application/json' -d @usercourses.json

curl -X PUT [http://{es-ip}:{es-port}/announcement](http://localhost:9200/announcement) -H 'Content-Type: application/json' -d @announcement.json

curl -X PUT [http://{es-ip}:{es-port}/announcementtype](http://localhost:9200/announcementtype) -H 'Content-Type: application/json' -d @announcementtype.json

curl -X PUT [http://{es-ip}:{es-port}/metrics](http://localhost:9200/metrics) -H 'Content-Type: application/json' -d @metrics.json




### Problem Statement
How to call update mapping API


### Solution Approach
update mapping can be called with a PUT mapping call on index


```js
Request

PUT /{indexName}/_mapping/{typeName}

indexName - name of the index ex- user, org etc.
typeName - by default for new indexes default type name would be _doc

Request Body

{
    "dynamic": false,
    "properties": {
        "activeStatus": {
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
        "address": {
            "properties": {
                "addType": {
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
                "addressLine1": {
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
                "addressLine2": {
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
                "city": {
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
                "country": {
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
                "state": {
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
                "updatedBy": {
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
                "userId": {
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
                "zipcode": {
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
                }
            }
        },
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
        "appointmentType": {
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
        "authenticationStatus": {
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
        "avatar": {
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
        "badgeAssertions": {
            "properties": {
                "assertionId": {
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
                "assertionid": {
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
                "badgeClassImage": {
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
                "badgeClassName": {
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
                "badgeId": {
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
                "badgeclassimage": {
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
                "badgeclassname": {
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
                "badgeid": {
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
                "createdTS": {
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
                "createdTs": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "createdts": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
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
                "issuerId": {
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
                "userId": {
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
                }
            }
        },
        "badges": {
            "properties": {
                "badgeTypeId": {
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
                "receiverId": {
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
                }
            }
        },
        "batches": {
            "properties": {
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
                "enrolledOn": {
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
                "lastAccessedOn": {
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
                "progress": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                }
            }
        },
        "channel": {
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
        "classSubjectTaught": {
            "properties": {
                "classes": {
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
                "subjects": {
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
                }
            }
        },
        "completeness": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "countryCode": {
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
        "disabilityType": {
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
        "dob": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "education": {
            "properties": {
                "address": {
                    "properties": {
                        "addressLine1": {
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
                        "addressLine2": {
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
                        "city": {
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
                        "state": {
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
                        "updatedBy": {
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
                        "zipcode": {
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
                        }
                    }
                },
                "addressId": {
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
                "boardOrUniversity": {
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
                "degree": {
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
                "grade": {
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
                "percentage": {
                    "type": "double",
                    "fields": {
                        "raw": {
                            "type": "double"
                        }
                    }
                },
                "updatedBy": {
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
                "userId": {
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
                "yearOfPassing": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                }
            }
        },
        "email": {
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
        "encEmail": {
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
        "encPhone": {
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
        "firstName": {
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
        "framework": {
            "properties": {
                "board": {
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
                "gradeLevel": {
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
                "medium": {
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
                "subject": {
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
                }
            }
        },
        "fullName": {
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
        "gender": {
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
        "grade": {
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
        "highestAcademicQualification": {
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
        "highestEnglishQualification": {
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
        "highestMathQualification": {
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
        "highestSSTQualification": {
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
        "highestScienceQualification": {
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
        "highestTeacherQualification": {
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
        "highestVernacularLanguageQualification": {
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
        "isDeleted": {
            "type": "boolean",
            "fields": {
                "raw": {
                    "type": "boolean"
                }
            }
        },
        "isMasterTrainer": {
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
        "jobProfile": {
            "properties": {
                "address": {
                    "properties": {
                        "addressLine1": {
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
                        "addressLine2": {
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
                        "city": {
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
                        "state": {
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
                        "updatedBy": {
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
                        "zipcode": {
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
                        }
                    }
                },
                "addressId": {
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
                "endDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
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
                "isCurrentJob": {
                    "type": "boolean",
                    "fields": {
                        "raw": {
                            "type": "boolean"
                        }
                    }
                },
                "jobName": {
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
                "joiningDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "orgId": {
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
                "orgName": {
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
                "role": {
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
                "subject": {
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
                "updatedBy": {
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
                "userId": {
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
                }
            }
        },
        "language": {
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
        "lastName": {
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
        "lastUpdatedOn": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "location": {
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
        "locationIds": {
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
        "loginId": {
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
        "maskEmail": {
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
        "maskPhone": {
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
        "maskedEmail": {
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
        "maskedPhone": {
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
        "masterTrainerSubjects": {
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
        "missingFields": {
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
        "organisations": {
            "properties": {
                "addedBy": {
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
                "addedByName": {
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
                "approvalDate": {
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
                "approvaldate": {
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
                "approvedBy": {
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
                "hashTagId": {
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
                "orgLeftDate": {
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
                "orgName": {
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
                "organisationId": {
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
                "orgjoindate": {
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
                "position": {
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
                "roles": {
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
                "updatedBy": {
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
                "userId": {
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
                }
            }
        },
        "phone": {
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
        "profileVisibility": {
            "properties": {
                "address": {
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
                "dob": {
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
                "education": {
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
                "email": {
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
                "firstName": {
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
                "gender": {
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
                "grades": {
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
                "jobProfile": {
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
                "language": {
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
                "location": {
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
                "loginId": {
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
                "phone": {
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
                "profileSummary": {
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
                "skills": {
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
                "socialMedia": {
                    "properties": {
                        "in": {
                            "properties": {
                                "url": {
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
                                }
                            }
                        },
                        "twitter": {
                            "properties": {
                                "url": {
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
                                }
                            }
                        }
                    }
                },
                "subject": {
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
                "subjects": {
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
                "test": {
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
                "userId": {
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
                "userName": {
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
                "userSkills": {
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
                "webPages": {
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
                }
            }
        },
        "provider": {
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
        "regOrgId": {
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
        "registryId": {
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
        "roles": {
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
        "rootOrgId": {
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
        "rootOrgName": {
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
        "schoolCode": {
            "type": "double",
            "fields": {
                "raw": {
                    "type": "double"
                }
            }
        },
        "schoolJoiningDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "serviceJoiningDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "skills": {
            "properties": {
                "addedAt": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "addedBy": {
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
                "createdOn": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "endorsementCount": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                },
                "endorsementcount": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                },
                "endorsers": {
                    "properties": {
                        "0283452c-a607-4184-9806-1fac2f16d5b9": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "39d460e8-80ef-4045-8fe0-de4a78e78bc4": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "3d45fbd8-b911-4cc5-b503-61215902d780": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "48a2fbc6-df85-4a41-8e68-7057986aee5a": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "62354c16-29c7-419c-8d30-a30491bef7c3": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "7526ab9d-e8a6-478b-83e2-6ff1296c302e": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "9645e749-39f0-4b73-993d-09e633eeea1d": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "a1355233-6b82-4660-86f5-73b95c03aec9": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "a3d4151b-4d3e-4068-8950-d5b27b10487e": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "b2fff05d-dfc9-497c-840e-5675a2b78e57": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "be7efb23-6af9-4d92-82b3-a4d78fcfa2f6": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "c9f23b5f-cd4c-42db-9a24-1f3ebc60dc9a": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "d5efd1ab-3cad-4034-8143-32c480f5cc9e": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        }
                    }
                },
                "endorsersList": {
                    "properties": {
                        "endorseDate": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "userId": {
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
                        }
                    }
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
                "lastUpdatedBy": {
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
                "lastUpdatedOn": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "skillName": {
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
                "skillNameToLowercase": {
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
                "userId": {
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
        "subject": {
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
        "teacherInBRC": {
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
        "teacherInCRC": {
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
        "teacherSchoolBoardAffiliation": {
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
        "teacherStatus": {
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
        "teacherType": {
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
        "trainingsCompleted": {
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
        "updatedBy": {
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
        "userId": {
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
        "userName": {
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
        "userType": {
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
        "vernacularLanguageStudied": {
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
        "webPages": {
            "properties": {
                "type": {
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
                "url": {
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
                }
            }
        }
    }
}

Response

{
    "acknowledged": true
}

Example

curl -X PUT \
  http://localhost:9200/user/_mapping/_doc \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "dynamic": false,
    "properties": {
        "activeStatus": {
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
        "address": {
            "properties": {
                "addType": {
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
                "addressLine1": {
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
                "addressLine2": {
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
                "city": {
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
                "country": {
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
                "state": {
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
                "updatedBy": {
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
                "userId": {
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
                "zipcode": {
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
                }
            }
        },
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
        "appointmentType": {
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
        "authenticationStatus": {
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
        "avatar": {
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
        "badgeAssertions": {
            "properties": {
                "assertionId": {
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
                "assertionid": {
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
                "badgeClassImage": {
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
                "badgeClassName": {
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
                "badgeId": {
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
                "badgeclassimage": {
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
                "badgeclassname": {
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
                "badgeid": {
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
                "createdTS": {
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
                "createdTs": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "createdts": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
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
                "issuerId": {
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
                "userId": {
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
                }
            }
        },
        "badges": {
            "properties": {
                "badgeTypeId": {
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
                "receiverId": {
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
                }
            }
        },
        "batches": {
            "properties": {
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
                "enrolledOn": {
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
                "lastAccessedOn": {
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
                "progress": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                }
            }
        },
        "channel": {
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
        "classSubjectTaught": {
            "properties": {
                "classes": {
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
                "subjects": {
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
                }
            }
        },
        "completeness": {
            "type": "long",
            "fields": {
                "raw": {
                    "type": "long"
                }
            }
        },
        "countryCode": {
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
        "disabilityType": {
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
        "dob": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "education": {
            "properties": {
                "address": {
                    "properties": {
                        "addressLine1": {
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
                        "addressLine2": {
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
                        "city": {
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
                        "state": {
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
                        "updatedBy": {
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
                        "zipcode": {
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
                        }
                    }
                },
                "addressId": {
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
                "boardOrUniversity": {
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
                "degree": {
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
                "grade": {
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
                "percentage": {
                    "type": "double",
                    "fields": {
                        "raw": {
                            "type": "double"
                        }
                    }
                },
                "updatedBy": {
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
                "userId": {
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
                "yearOfPassing": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                }
            }
        },
        "email": {
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
        "encEmail": {
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
        "encPhone": {
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
        "firstName": {
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
        "framework": {
            "properties": {
                "board": {
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
                "gradeLevel": {
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
                "medium": {
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
                "subject": {
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
                }
            }
        },
        "fullName": {
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
        "gender": {
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
        "grade": {
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
        "highestAcademicQualification": {
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
        "highestEnglishQualification": {
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
        "highestMathQualification": {
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
        "highestSSTQualification": {
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
        "highestScienceQualification": {
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
        "highestTeacherQualification": {
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
        "highestVernacularLanguageQualification": {
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
        "isDeleted": {
            "type": "boolean",
            "fields": {
                "raw": {
                    "type": "boolean"
                }
            }
        },
        "isMasterTrainer": {
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
        "jobProfile": {
            "properties": {
                "address": {
                    "properties": {
                        "addressLine1": {
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
                        "addressLine2": {
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
                        "city": {
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
                        "state": {
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
                        "updatedBy": {
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
                        "zipcode": {
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
                        }
                    }
                },
                "addressId": {
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
                "endDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
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
                "isCurrentJob": {
                    "type": "boolean",
                    "fields": {
                        "raw": {
                            "type": "boolean"
                        }
                    }
                },
                "jobName": {
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
                "joiningDate": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "orgId": {
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
                "orgName": {
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
                "role": {
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
                "subject": {
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
                "updatedBy": {
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
                "userId": {
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
                }
            }
        },
        "language": {
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
        "lastName": {
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
        "lastUpdatedOn": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "location": {
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
        "locationIds": {
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
        "loginId": {
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
        "maskEmail": {
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
        "maskPhone": {
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
        "maskedEmail": {
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
        "maskedPhone": {
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
        "masterTrainerSubjects": {
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
        "missingFields": {
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
        "organisations": {
            "properties": {
                "addedBy": {
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
                "addedByName": {
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
                "approvalDate": {
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
                "approvaldate": {
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
                "approvedBy": {
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
                "hashTagId": {
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
                "orgLeftDate": {
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
                "orgName": {
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
                "organisationId": {
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
                "orgjoindate": {
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
                "position": {
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
                "roles": {
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
                "updatedBy": {
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
                "userId": {
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
                }
            }
        },
        "phone": {
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
        "profileVisibility": {
            "properties": {
                "address": {
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
                "dob": {
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
                "education": {
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
                "email": {
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
                "firstName": {
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
                "gender": {
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
                "grades": {
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
                "jobProfile": {
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
                "language": {
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
                "location": {
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
                "loginId": {
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
                "phone": {
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
                "profileSummary": {
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
                "skills": {
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
                "socialMedia": {
                    "properties": {
                        "in": {
                            "properties": {
                                "url": {
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
                                }
                            }
                        },
                        "twitter": {
                            "properties": {
                                "url": {
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
                                }
                            }
                        }
                    }
                },
                "subject": {
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
                "subjects": {
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
                "test": {
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
                "userId": {
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
                "userName": {
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
                "userSkills": {
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
                "webPages": {
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
                }
            }
        },
        "provider": {
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
        "regOrgId": {
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
        "registryId": {
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
        "roles": {
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
        "rootOrgId": {
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
        "rootOrgName": {
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
        "schoolCode": {
            "type": "double",
            "fields": {
                "raw": {
                    "type": "double"
                }
            }
        },
        "schoolJoiningDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "serviceJoiningDate": {
            "type": "date",
            "fields": {
                "raw": {
                    "type": "date"
                }
            }
        },
        "skills": {
            "properties": {
                "addedAt": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "addedBy": {
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
                "createdOn": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "endorsementCount": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                },
                "endorsementcount": {
                    "type": "long",
                    "fields": {
                        "raw": {
                            "type": "long"
                        }
                    }
                },
                "endorsers": {
                    "properties": {
                        "0283452c-a607-4184-9806-1fac2f16d5b9": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "39d460e8-80ef-4045-8fe0-de4a78e78bc4": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "3d45fbd8-b911-4cc5-b503-61215902d780": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "48a2fbc6-df85-4a41-8e68-7057986aee5a": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "62354c16-29c7-419c-8d30-a30491bef7c3": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "7526ab9d-e8a6-478b-83e2-6ff1296c302e": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "9645e749-39f0-4b73-993d-09e633eeea1d": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "a1355233-6b82-4660-86f5-73b95c03aec9": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "a3d4151b-4d3e-4068-8950-d5b27b10487e": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "b2fff05d-dfc9-497c-840e-5675a2b78e57": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "be7efb23-6af9-4d92-82b3-a4d78fcfa2f6": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "c9f23b5f-cd4c-42db-9a24-1f3ebc60dc9a": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "d5efd1ab-3cad-4034-8143-32c480f5cc9e": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        }
                    }
                },
                "endorsersList": {
                    "properties": {
                        "endorseDate": {
                            "type": "date",
                            "fields": {
                                "raw": {
                                    "type": "date"
                                }
                            }
                        },
                        "userId": {
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
                        }
                    }
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
                "lastUpdatedBy": {
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
                "lastUpdatedOn": {
                    "type": "date",
                    "fields": {
                        "raw": {
                            "type": "date"
                        }
                    }
                },
                "skillName": {
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
                "skillNameToLowercase": {
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
                "userId": {
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
        "subject": {
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
        "teacherInBRC": {
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
        "teacherInCRC": {
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
        "teacherSchoolBoardAffiliation": {
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
        "teacherStatus": {
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
        "teacherType": {
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
        "trainingsCompleted": {
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
        "updatedBy": {
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
        "userId": {
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
        "userName": {
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
        "userType": {
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
        "vernacularLanguageStudied": {
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
        "webPages": {
            "properties": {
                "type": {
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
                "url": {
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
                }
            }
        }
    }
}'


```


job cURL commands for update mappingsINLINEcd sunbird-utils/elasticsearch-util/src/main/resources/mappings

curl -X PUT [http://{es-ip}:{es-port}/user/_mapping/_doc](http://localhost:9200/user/_mapping/_doc) -H 'Content-Type: application/json' -d @user-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/org/_mapping/_doc](http://localhost:9200/org/_mapping/_doc) -H 'Content-Type: application/json' -d @org-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/location/_mapping/_doc](http://localhost:9200/location/_mapping/_doc) -H 'Content-Type: application/json' -d @location-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/usernotes/_mapping/_doc](http://localhost:9200/usernotes/_mapping/_doc) -H 'Content-Type: application/json' -d @usernotes-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/badgeassociations/_mapping/_doc](http://localhost:9200/badgeassociations/_mapping/_doc) -H 'Content-Type: application/json' -d @badgeassociations-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/cbatch/_mapping/_doc](http://localhost:9200/cbatch/_mapping/_doc) -H 'Content-Type: application/json' -d @cbatch-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/cbatchstats/_mapping/_doc](http://localhost:9200/cbatch/_mapping/_doc) -H 'Content-Type: application/json' -d @cbatchstats-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/userprofilevisibility/_mapping/_doc](http://localhost:9200/userprofilevisibility/_mapping/_doc) -H 'Content-Type: application/json' -d @userprofilevisibility-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/usercourses/_mapping/_doc](http://localhost:9200/usercourses/_mapping/_doc) -H 'Content-Type: application/json' -d @usercourses-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/announcement/_mapping/_doc](http://localhost:9200/announcement/_mapping/_doc) -H 'Content-Type: application/json' -d @announcement-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/announcementtype/_mapping/_doc](http://localhost:9200/announcementtype/_mapping/_doc) -H 'Content-Type: application/json' -d @announcementtype-mapping.json

curl -X PUT [http://{es-ip}:{es-port}/metrics/_mapping/_doc](http://localhost:9200/metrics/_mapping/_doc) -H 'Content-Type: application/json' -d @metrics-mapping.json




### Create index files


250250250250250250250250250250250


### mapping update files


250250250250250250250250250250250









*****

[[category.storage-team]] 
[[category.confluence]] 
