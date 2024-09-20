
### Organisation
An org contains these following attributes, which are being used at most of the data products in use. All of these must intersect well to give the right counts.


* isrootorg = boolean, whether or not it is a root org.


    * 1 for tenants


    * 0 for suborgs (schools/departments/etc)



    
* locationids = array of location uuids (see table detail below)


    * For a rootOrg which is usually a tenant (state), there is only 1 location uuid. In some rootOrgs, the location doesn’t apply at all. So, its' optional.


    * For a subOrg, mostly we would find 3 location uuids and their types would be state, district, block.



    
* status = boolean, whether or not it is active.


    * 1 active org


    * 0 inactive (deleted org)



    
* rootorgid = text


    * same as id for rootOrgs


    * the id of the rootOrg for subOrgs



    
* channel = text


    * Usually a two letter string that denotes a unique hashtagid registered in the global index


    * The channel is ‘exactly’ same for rootOrg-subOrg combination



    
* slug = text


    * A set of characters, usually 2 to 4 in length, that can be used in a URL. Most often the channel and slug are same, but its not guaranteed.



    


### Location

* id = text, uuid


* type = text, one of state, district, block, cluster


* parentid = text, uuid




### Procedure
Execute the following per channel to understand the mismatches that could exist.


```
# URL - https://gist.github.com/indrajra/d9cd96aa57260e54d7f485b875b2188d 
copy data from the above URL and paste it to OrgSetupVerifier.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of OrgSetupVerifier.scala}}
OrgSetupVerifier.main("{cassandra ip}", "{channel name}")
```

### Observations
The following are problems we have encountered so far in environments - dev, staging, pre-prod and a few cases in prod as well.


1. status = null or 0 in Cassandra 

    The ElasticSearch has it 1, but status is not set in Cassandra. This cannot happen usually, but we may have orgs data created of the past. Or it could be a wrong query/API that set the status in Cassandra without sync’ing to ElasticSearch


1. locationids are not set or referring to non-existent locations

    Case: not set - we have heard observations that district or block is not found for a subOrg. 

    Case: set but invalid - location table is populated once per tenant and is likely to be enhanced as adoption spans geographies. The orgs must always refer to valid locationids. This validation happens when you update/create orgs via APIs. However, it might be a case that the locations were deleted after org creation/update leading to invalid data.


1. channel of rootOrg and subOrg mismatch

    This is unexpected and is usually a data driven problem.


1. rootorgid refers to an org whose channel is different

    The channel and rootorgid must also converge to another org in the system, which has isrootorg=1.







*****

[[category.storage-team]] 
[[category.confluence]] 
