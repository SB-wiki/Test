# Sunbird-Elasticsearch-migration-to-multi-index

#### Problem Statement

Since multiple types are deprecated for Elasticsearch 6.x, There is no way to create a new index with multiple type other than migration from older version. This creates challenges as below.

1. New adopters cannot have sunbird in it's current state.
2. old static mapping update call doesn't work on migrated index with multiple types.

&#x20;[SB-11532 System JIRA](https://browse/SB-11532)

#### Solution Approach

Solution approaches are [documented in detail here](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1017249999/Mapping+type+removal+in+Elasticsearch). This document will concentrate on multi index approach. The multi index approach is divided into two parts

1. Create new indexes with the settings and mappings from old indexes
2. migration of data of old indexes with each type into separate indexes of single type.
3. Code changes to point to different indexes in different flows

#### Problem Statement

How to create new index with the setting and mappings from old indexes?

#### Solution Approach

For creating new index with original settings and mappings, first we need to get the settings and mappings of the old indices and then we use that setting and mappings to create new index

**get settings of an index**

```js
Request
GET /{indexName}/_settings

Response

{
  "searchindex" : {
    "settings" : {
      "index" : {
        "number_of_shards" : "5",
        "provided_name" : "searchindex",
        "creation_date" : "1540294977064",
        "analysis" : {
          "filter" : {
            "mynGram" : {
              "token_chars" : [
                "letter",
                "digit",
                "whitespace",
                "punctuation",
                "symbol"
              ],
              "min_gram" : "1",
              "type" : "ngram",
              "max_gram" : "20"
            }
          },
          "analyzer" : {
            "cs_index_analyzer" : {
              "filter" : [
                "lowercase",
                "mynGram"
              ],
              "type" : "custom",
              "tokenizer" : "standard"
            },
            "keylower" : {
              "filter" : "lowercase",
              "type" : "custom",
              "tokenizer" : "keyword"
            },
            "cs_search_analyzer" : {
              "filter" : [
                "lowercase",
                "standard"
              ],
              "type" : "custom",
              "tokenizer" : "standard"
            }
          }
        },
        "number_of_replicas" : "1",
        "uuid" : "HtjuANPTQH6Q3s4T9wTG3Q",
        "version" : {
          "created" : "5010199",
          "upgraded" : "6030099"
        }
      }
    }
  }
}

example 

curl -X GET http://11.2.3.58:9200/searchindex/_settings


```

With the response we need to prepare the settings for new indexes, copying the analysis and analyzer field and ignoring index specific fields like uuid, provided\_name etc.

**get mapping of the index type**

```js
Request
GET /{indexName}/_mapping/{type}

Response

{"searchindex":{"mappings":{"user":{"_all":{"enabled":true},"dynamic_templates":[{"longs":{"match_mapping_type":"long","mapping":{"fields":{"raw":{"type":"long"}},"type":"long"}}},{"booleans":{"match_mapping_type":"boolean","mapping":{"fields":{"raw":{"type":"boolean"}},"type":"boolean"}}},{"doubles":{"match_mapping_type":"double","mapping":{"fields":{"raw":{"type":"double"}},"type":"double"}}},{"dates":{"match_mapping_type":"date","mapping":{"fields":{"raw":{"type":"date"}},"type":"date"}}},{"strings":{"match_mapping_type":"string","mapping":{"analyzer":"cs_index_analyzer","copy_to":"all_fields","fielddata":true,"fields":{"raw":{"type":"text","fielddata":true,"analyzer":"keylower"}},"search_analyzer":"cs_search_analyzer","type":"text"}}}],"properties":{"all_fields":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower"}},"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer"},"channel":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"completeness":{"type":"long","fields":{"raw":{"type":"long"}}},"countryCode":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"createdBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"createdDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"dob":{"type":"date","fields":{"raw":{"type":"date"}}},"email":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"emailVerified":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"encEmail":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"encPhone":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"firstName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"framework":{"type":"object"},"gender":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"id":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"identifier":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"isDeleted":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"language":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"lastName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"loginId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"maskedEmail":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"missingFields":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"organisations":{"properties":{"approvalDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"approvaldate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"hashTagId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"id":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"isApproved":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"isDeleted":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"isRejected":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"orgJoinDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"orgName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"organisationId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"orgjoindate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"roles":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"updatedDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"phone":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"phoneVerified":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"phoneverified":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"profileVisibility":{"properties":{"address":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"firstName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"gender":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"location":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"roles":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"rootOrgId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"rootOrgName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"skills":{"properties":{"createdBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"createdOn":{"type":"date","fields":{"raw":{"type":"date"}}},"endorsementCount":{"type":"long","fields":{"raw":{"type":"long"}}},"endorsersList":{"properties":{"endorseDate":{"type":"date","fields":{"raw":{"type":"date"}}},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"id":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"lastUpdatedBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"lastUpdatedOn":{"type":"date","fields":{"raw":{"type":"date"}}},"skillName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"skillNameToLowercase":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"status":{"type":"long","fields":{"raw":{"type":"long"}}},"updatedBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"updatedDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userType":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}}}}}


example
curl -X GET \
  http://localhost:9200/searchindex/_mapping/user \
  -H 'cache-control: no-cache


```

to prepare the mapping as input to create index we need to

* copy the inner json of the index starting from mapping as root
* change the original type name to \_doc as per 6.x convention
* Enabling \[\_all] is disabled in 6.0. hence we need to remove that configuration ("\_all":{"enabled":true})
* for searchindex the mapping type needs to be static, hence dynamic field should be set to false and dynamic\_template field should be removed.

Once we have the settings and mappings prepared we can create index with the settings

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

creating indexes through cURL commands

\[\[Elasticsearch mapping update job steps|Elasticsearch-mapping-update-job-steps]]

#### Problem Statement

How to migrate old index data with multiple types data to new indexes with single type

#### Solution Approach&#x20;

The old data can be migrated to new indexes with

1. reindex API in elasticsearch
2. sync functionality in sunbird

**pros and cons**

| approach    | pros                                                                               | cons                                            | comments |
| ----------- | ---------------------------------------------------------------------------------- | ----------------------------------------------- | -------- |
| reindex API | can apply settings like size, throttling etc.no involvement of sunbird application |                                                 |          |
| sync flow   |                                                                                    | need to modify to include support for all types |          |

#### Problem Statement

How can we use reindex API to migrate data?

#### Solution Approach

POST /\_reindex call can be made with proper arguments

```js
Request

POST /_reindex
{
  "source": {
    "index": "{oldIndexName}",
    "type": "{type}"
  },
  "dest": {
    "index": "{newIndexName}",
    "type" : "_doc"
  }
}

Response

{
    "took": 632,
    "timed_out": false,
    "total": 114,
    "updated": 0,
    "created": 114,
    "deleted": 0,
    "batches": 1,
    "version_conflicts": 0,
    "noops": 0,
    "retries": {
        "bulk": 0,
        "search": 0
    },
    "throttled_millis": 0,
    "requests_per_second": -1,
    "throttled_until_millis": 0,
    "failures": []
}


example

curl -X POST \
  http://localhost:9200/_reindex \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
  "source": {
    "index": "searchindex",
    "type": "org"
  },
  "dest": {
    "index": "org",
    "type" : "_doc"
  }
}'
```

[Additional details](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html)

The reindex API need to be called for

* user
* org
* usercourses
* cbatch
* badgeassociations
* usernotes
* userprofilevisibility
* location

System requirementIncrease the heap memory from 2GB to 4GB in “/etc/elasticsearch/cs-node-1/jvm.options” before calling reindex API

#### cURL command for reindex data from old index to new

dashedreindex curl commandcurl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"user"},"dest":{"index":"user","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"org"},"dest":{"index":"org","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"location"},"dest":{"index":"location","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"usernotes"},"dest":{"index":"usernotes","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"badgeassociations"},"dest":{"index":"badgeassociations","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"cbatch"},"dest":{"index":"cbatch","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"userprofilevisibility"},"dest":{"index":"userprofilevisibility","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"usercourses"},"dest":{"index":"usercourses","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"announcement"},"dest":{"index":"announcement","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"announcementtype"},"dest":{"index":"announcementtype","type":"\_doc"\}}'

curl -X POST [http://{es-ip}:{es-port}/\_reindex](http://localhost:9200/\_reindex) -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"metrics"},"dest":{"index":"metrics","type":"\_doc"\}}'

#### Open Questions

1. sunbirddataaudit index is used to log some of the request auditing in elasticsearch. Is it still needed and supported with new multi index way. (AuditLogActions.java has details of which API being audited currently)
2. sunbirdplugin index is used based on the API call, the type is passed into the request. need discussion as how to support it in new multi index format.
3. Currently health check url for elasticsearch checks if "searchindex" exists or not, since we are having multiple index for different entity how do we verify health check for elasticsearch? do we just check user index or all indexes or some other way.

***

\[\[category.storage-team]] \[\[category.confluence]]
