# Additional-variables-to-run-Core-services-only

**In common.yml**

ekstep\_env: qa                                                                                                             # qa or dev or prod env of ekstep which you want ot connect

sunbird\_content\_repo\_api\_base\_url: "[https://qa.ekstep.in/api](https://qa.ekstep.in/api)"                                    # qa or dev or prod env url of ekstep which you want ot connect

sunbird\_analytics\_api\_base\_url: [https://qa.ekstep.in/api](https://qa.ekstep.in/api)                                              # qa or dev or prod env url of ekstep which you want ot connect

sunbird\_search\_service\_api\_base\_url: [https://qa.ekstep.in/api/search](https://qa.ekstep.in/api/search)                        # qa or dev or prod env url of ekstep which you want ot connect

sunbird\_cloud\_storage\_urls: 'https://s3.ap-south-1.amazonaws.com/ekstep-public-\{{ekstep\_s3\_env\}}/,https://ekstep-public-\{{ekstep\_s3\_env\}}.s3-ap-south-1.amazonaws.com/'                                # This value can be same as this line

sunbird\_ekstep\_proxy\_base\_url: [https://qa.ekstep.in/](https://qa.ekstep.in/)                                                  # qa or dev or prod env url of ekstep which you want ot connect

upstream\_url: "ekstep-public-\{{ekstep\_s3\_env\}}.[s3-ap-south-1.amazonaws.com](http://s3-ap-south-1.amazonaws.com)"      # This value can be same as this line

learningservice\_ip:                                                                                                        # Dummy IP or provide IP of swarm manager

keycloak\_auth\_server\_url: "\{{proto\}}://\{{ proxy\_server\_name \}}:8080/auth"                 # This value can be same as this line. If using a LB for keycloak, remove port :8080

**In secrets.yml**

core\_vault\_sunbird\_ekstep\_api\_key:                                                                             # ekstep key

**(After onboarding consumer take the value of api-management-test-user update the below variables)**

core\_vault\_sunbird\_api\_auth\_token:                                                                             # sunbird key after onboarding consumers

core\_vault\_kong\_\_test\_jwt:                                                                                            # sunbird key after onboarding consumers

***

\[\[category.storage-team]] \[\[category.confluence]]
