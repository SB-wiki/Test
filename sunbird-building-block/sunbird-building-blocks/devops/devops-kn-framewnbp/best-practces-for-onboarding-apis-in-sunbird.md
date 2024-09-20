We in Sunbird are highly integrable and API’s play a vital role in achieving this, We follow a set of standards in Onboarding New API’s, consider a simple API block to help understand how to update ansible template for new API’s 




# Fork the sunbird repo and edit kong-api/defaults/main.yml file and raise a PR.

```
git clone https://github.com/YourGitId/sunbird-devops.git
vi kong-api/defaults/main.yml
# Raise a PR to latest release branch in sunbird-devops
```
 **API SNIPPET AND ITS DESCRIPTION:** 
```
  - name: createOrg
    uris: "{{ org_service_prefix }}/v1/create"
    upstream_url: "{{ learning_service_url }}/v1/org/create"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'orgCreate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ small_request_size_limit }}"
```

* Line 1 gives the friendly description for the API to be onboarded.


* Line 2  **uris**  describes how the request is received from the APP/User to the API manager KONG. Make sure you use the correct prefix for your API, if you don’t have a prefix please create one and use it as a variable as in this case it is  **org_service_prefix.** 


* Line 3  **upstream_url** describes how the request need to be routed from the API manager kong to the Backend Service, Make sure you are using a correct Backend prefix and it is variablized in this example it is  **learning_service_url.** 


* Line 5  **Plugins** indicate what are the plugins being used by this API, we use  **jwt** plugin for authentication,  **statsd plugin** for recording API metrics and it is a must for any API we onboard.


* Line 9 We have fine grained access control for the Consumers we create, to acheive this the ACL Block which describes what’s the correct ACL that is best suited for this API being onboarded. In our case it is  **config.whitelist: ['orgCreate']**  which clearly distinguishes the Creation permission for the organization. For more information on the Existing ACL’s in sunbird please refer this [Document](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1202847861/Onboarding+Consumers). If you don’t find a suitable ACL, please create a new ACL as per the standards mentioned in this [Document](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1202847861/Onboarding+Consumers).


* Line 12  **rate-limiting**  block defines on how many calls can be made for this API, we can restrict the API calls to this service based on the hits expected per hour, per minute or even per second or a combination of all, as a standard notation we limit per hour, Please feel free to use limits per minute/second if there is any such usecase, we have a set of variables to choose from for applying the rate limits, please pick the one from the below snippet.  **config.policy: local** this indicates that the limits apply to the kong-instances locally and not shared for the entire cluster, which means if we restrict API with say 10K limits per hour and we are running 2 kong instances, then per hour we can have 20k requests fired through kong, if we set policy as  **cluster**  then the rate limits will be shared between the cluster.  **config.limit_by: credential** this indicated that the rate-limiting gets applied to the jwt credentail, available options for limit_by are credential, ip, consumer.




```
# Variables for rate-limiting
small_rate_limit_per_hour
medium_rate_limit_per_hour 
x_medium_rate_limit_per_hour 
large_rate_limit_per_hour 
x2_large_rate_limit_per_hour
x_large_rate_limit_per_hour 
premium_consumer_small_rate_limit_per_hour 
premium_consumer_medium_rate_limit_per_hour
premium_consumer_large_rate_limit_per_hour 
```

* Line 16 This block for  **request-size-limiting** indicates that how much data payload size should be accepted by this API in MB. Please choose this from the available set of variables mentioned below.




```
# variables for request-size-limiting
small_request_size_limit
medium_request_size_limit
large_request_size_limit
```




*****

[[category.storage-team]] 
[[category.confluence]] 
