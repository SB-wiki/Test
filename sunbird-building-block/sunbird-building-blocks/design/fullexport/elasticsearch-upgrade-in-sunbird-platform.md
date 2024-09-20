# Elasticsearch-upgrade-in-Sunbird-Platform

Problem StatementSunbird is using ES 5.4.3 whereas other platforms (LP/DP) are running on ES 6.3. Hence the Sunbird ES 5.4.3 needs to be upgraded to 6.3.

[SB-11085 System JIRA](https://browse/SB-11085)

Solution ApproachTo accomplish the upgrade we can take below approach

Full cluster restart[Steps](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/restart-upgrade.html)

1. Disable shard allocation
2. Stop indexing and sync flush
3. shutdown all nodes
4. upgrade each nodes and provide stored data path
5. Start each upgraded node
6. reenable allocation which was disabled in first step

backup and restore process. Steps -

1. Register a repository in the existing ES 5.4.3
2. Create a snapshot of the data from ES
3. Register the same repo in the new ES 6.3
4. Call the restore API in ES 6.3 for the snapshot created in step 2

Pros and cons

| Approach             | pros             | cons                      |
| -------------------- | ---------------- | ------------------------- |
| Full cluster restart |                  | downtime                  |
| Backup and restore   | minimal downtime | needs extra running nodes |

**Note**

Snapshots are incremental which means that once sunbird in pointing to the new ES 6.3, we can repeat the snapshot and backup process to push any mew data created in between.

Problem StatementHow to register a repository?

SolutionFor registering a repository, we need to define/add path.repo in elastisearch.yml as below

```
#
# Path to directory where to store the data (separate multiple locations by comma):
#
#path.data: /path/to/data
#
# Path to log files:
#
#path.logs: /path/to/logs
#
path.repo: ["/home/elastic/repo"]] ]></ac:plain-text-body></ac:structured-macro><p style="margin-left: 30.0px;">Once we restart the elasticsearch with this config, It needs an API call as below</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="4efda984-efbe-4ae9-806a-747fae8a0873"><ac:plain-text-body><![CDATA[Request

PUT /_snapshot/{repoName}
{
  "type": "fs",
  "settings": {
        "location": "{location}", //the location where the repo should be, the  value should be present in path.repo
        "compress": true
  }
}

Response

{
    "acknowledged": true
}


example

curl -X PUT \
  http://localhost:9200/_snapshot/repo \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 1b3d36e5-0609-47e4-8e19-d2dc945acddd' \
  -H 'cache-control: no-cache' \
  -d '{
  "type": "fs",
  "settings": {
        "location": "/home/elastic/repo",
        "compress": true
  }
}'
```

Please note that created repo can be verified by below API call

```
Request
GET /_snapshot/{repoName}

Response
{
  "type": "fs",
  "settings": {
        "location": "home/elastic/repo",
        "compress": true
  }
}
```

Problem StatementHow to create a snapshot in repo?

SolutionOnce the repository is created, we can take snapshot by below API

```
Request
PUT /_snapshot/{repoName}/{snapshotName}

Response
{
    "accepted": true
}

example

curl -X PUT \
  http://localhost:9200/_snapshot/repo/snapshot_1 \
  -H 'cache-control: no-cache'


```

&#x20;It starts the snapshot process and the status of this process can be verified as below

```
Request
GET /_snapshot/{repoName}/{snapshotName}

Response
{
    "snapshots": [
        {
            "snapshot": "snapshot",
            "uuid": "Ht4gT_joQKKEoBF-Qcj5Vg",
            "version_id": 5010199,
            "version": "5.1.1",
            "indices": [
                "searchindex",
                "sunbirdplugin",
                "sunbirddataaudit",
                ".kibana"
            ],
            "state": "SUCCESS",
            "start_time": "2019-03-08T07:07:22.416Z",
            "start_time_in_millis": 1552028842416,
            "end_time": "2019-03-08T07:07:25.128Z",
            "end_time_in_millis": 1552028845128,
            "duration_in_millis": 2712,
            "failures": [],
            "shards": {
                "total": 16,
                "failed": 0,
                "successful": 16
            }
        }
    ]
}
```

[Further details and considerations](https://www.elastic.co/guide/en/elasticsearch/reference/5.4/modules-snapshots.html#\_snapshot)

Problem StatementHow to restore a snapshot?

SolutionA snapshot created can be restored by calling the below API, however it should be ensured that the same repository is registered where we want to restore

```
Request
POST /_snapshot/{repoName}/{snapshotName}/_restore

Response
{
    "accepted": true
}

example

curl -X POST \
  http://localhost:9200/_snapshot/repo/snapshot/_restore \
  -H 'cache-control: no-cache'
```

Problem StatementHow to get the status of snapshot or recovery process

SolutionBelow API is used to get the status

```
Request
GET /_snapshot/{repoName}/{snapshotName}/_status

Response

{
    "snapshots": [
        {
            "snapshot": "snapshot",
            "repository": "repo",
            "uuid": "Ht4gT_joQKKEoBF-Qcj5Vg",
            "state": "SUCCESS",
            "shards_stats": {
                "initializing": 0,
                "started": 0,
                "finalizing": 0,
                "done": 16,
                "failed": 0,
                "total": 16
            },
            "stats": {
                "number_of_files": 187,
                "processed_files": 187,
                "total_size_in_bytes": 88761315,
                "processed_size_in_bytes": 88761315,
                "start_time_in_millis": 1552028842507,
                "time_in_millis": 2589
            },
            "indices": {
                ".kibana": {
                    "shards_stats": {
                        "initializing": 0,
                        "started": 0,
                        "finalizing": 0,
                        "done": 1,
                        "failed": 0,
                        "total": 1
                    },
                    "stats": {
                        "number_of_files": 7,
                        "processed_files": 7,
                        "total_size_in_bytes": 20398,
                        "processed_size_in_bytes": 20398,
                        "start_time_in_millis": 1552028842507,
                        "time_in_millis": 59
                    },
                    "shards": {
                        "0": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 7,
                                "processed_files": 7,
                                "total_size_in_bytes": 20398,
                                "processed_size_in_bytes": 20398,
                                "start_time_in_millis": 1552028842507,
                                "time_in_millis": 59
                            }
                        }
                    }
                },
                "sunbirdplugin": {
                    "shards_stats": {
                        "initializing": 0,
                        "started": 0,
                        "finalizing": 0,
                        "done": 5,
                        "failed": 0,
                        "total": 5
                    },
                    "stats": {
                        "number_of_files": 5,
                        "processed_files": 5,
                        "total_size_in_bytes": 805,
                        "processed_size_in_bytes": 805,
                        "start_time_in_millis": 1552028842508,
                        "time_in_millis": 1143
                    },
                    "shards": {
                        "0": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028843643,
                                "time_in_millis": 8
                            }
                        },
                        "1": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028843619,
                                "time_in_millis": 5
                            }
                        },
                        "2": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028843215,
                                "time_in_millis": 6
                            }
                        },
                        "3": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028842712,
                                "time_in_millis": 6
                            }
                        },
                        "4": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028842508,
                                "time_in_millis": 17
                            }
                        }
                    }
                },
                "sunbirddataaudit": {
                    "shards_stats": {
                        "initializing": 0,
                        "started": 0,
                        "finalizing": 0,
                        "done": 5,
                        "failed": 0,
                        "total": 5
                    },
                    "stats": {
                        "number_of_files": 11,
                        "processed_files": 11,
                        "total_size_in_bytes": 326568,
                        "processed_size_in_bytes": 326568,
                        "start_time_in_millis": 1552028842553,
                        "time_in_millis": 133
                    },
                    "shards": {
                        "0": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 4,
                                "processed_files": 4,
                                "total_size_in_bytes": 284725,
                                "processed_size_in_bytes": 284725,
                                "start_time_in_millis": 1552028842649,
                                "time_in_millis": 37
                            }
                        },
                        "1": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028842595,
                                "time_in_millis": 8
                            }
                        },
                        "2": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028842625,
                                "time_in_millis": 6
                            }
                        },
                        "3": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 1,
                                "processed_files": 1,
                                "total_size_in_bytes": 161,
                                "processed_size_in_bytes": 161,
                                "start_time_in_millis": 1552028842553,
                                "time_in_millis": 7
                            }
                        },
                        "4": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 4,
                                "processed_files": 4,
                                "total_size_in_bytes": 41360,
                                "processed_size_in_bytes": 41360,
                                "start_time_in_millis": 1552028842589,
                                "time_in_millis": 40
                            }
                        }
                    }
                },
                "searchindex": {
                    "shards_stats": {
                        "initializing": 0,
                        "started": 0,
                        "finalizing": 0,
                        "done": 5,
                        "failed": 0,
                        "total": 5
                    },
                    "stats": {
                        "number_of_files": 164,
                        "processed_files": 164,
                        "total_size_in_bytes": 88413544,
                        "processed_size_in_bytes": 88413544,
                        "start_time_in_millis": 1552028842654,
                        "time_in_millis": 2442
                    },
                    "shards": {
                        "0": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 34,
                                "processed_files": 34,
                                "total_size_in_bytes": 17551249,
                                "processed_size_in_bytes": 17551249,
                                "start_time_in_millis": 1552028843668,
                                "time_in_millis": 985
                            }
                        },
                        "1": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 35,
                                "processed_files": 35,
                                "total_size_in_bytes": 23112334,
                                "processed_size_in_bytes": 23112334,
                                "start_time_in_millis": 1552028843238,
                                "time_in_millis": 1096
                            }
                        },
                        "2": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 41,
                                "processed_files": 41,
                                "total_size_in_bytes": 18857283,
                                "processed_size_in_bytes": 18857283,
                                "start_time_in_millis": 1552028842792,
                                "time_in_millis": 812
                            }
                        },
                        "3": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 25,
                                "processed_files": 25,
                                "total_size_in_bytes": 11087982,
                                "processed_size_in_bytes": 11087982,
                                "start_time_in_millis": 1552028842654,
                                "time_in_millis": 543
                            }
                        },
                        "4": {
                            "stage": "DONE",
                            "stats": {
                                "number_of_files": 29,
                                "processed_files": 29,
                                "total_size_in_bytes": 17804696,
                                "processed_size_in_bytes": 17804696,
                                "start_time_in_millis": 1552028844359,
                                "time_in_millis": 737
                            }
                        }
                    }
                }
            }
        }
    ]
}
```

Problem StatementCluster consideration while backup and restore

SolutionFor cluster implementation, the path.repo should be configured on all nodes with the same value which will be shared file storage.

We can also use [s3 for elasticsearch backup and restore](https://medium.com/@federicopanini/elasticsearch-backup-snapshot-and-restore-on-aws-s3-f1fc32fbca7f)&#x20;

References

1. [https://www.elastic.co/guide/en/elasticsearch/reference/5.5/modules-snapshots.html](https://www.elastic.co/guide/en/elasticsearch/reference/5.5/modules-snapshots.html)
2. [https://www.elastic.co/guide/en/elasticsearch/plugins/5.5/repository-s3.html](https://www.elastic.co/guide/en/elasticsearch/plugins/5.5/repository-s3.html)
3. [https://www.elastic.co/guide/en/elasticsearch/reference/6.3/restart-upgrade.html](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/restart-upgrade.html)

***

\[\[category.storage-team]] \[\[category.confluence]]
