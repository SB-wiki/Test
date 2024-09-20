# CORE-Installation

#### PREREQUISITES

#### Below steps needs to be followed as per the precedence.

#### 1. Update inventory of Core hosts, groupvars and secrets

2. create a container in azure blob and make it public for content publish **Run the Below Jobs** **OpsAdministration** :
3. Bootstrap                                                                                                               # Creates Deployer User
4. SwarmBootstrap                                                                                                    # Creates Swarm with manager and agent nodes

**Builds** :

1. Adminutils                                                                                                              # Builds Adminutils container
2. API MANAGER                                                                                                      # Builds API Manager Container
3. API MANAGER Echo                                                                                             # Builds API Manager echo Container
4. Badger                                                                                                                  # Builds Badger Container
5. Cassandra                                                                                                            # Creates a jar for migration purpose
6. Content                                                                                                                 # Builds Content Service Container
7. Learner                                                                                                                 # Builds Learner Service Container
8. Player                                                                                                                   # Builds Player Service Container
9. Proxy                                                                                                                    # Builds Proxy container
10. Telemetry                                                                                                           # Builds Telemetry container

**Artifacts** :

(Make Sure all Artifacts are uploaded)

**Provision** :

1. (Deploy) ApplicationES                                                                                          # From Deploy Folder Deploy ApplicationES this will Provision Elasticsearch and create indices necessay for Sunbird Core
2. Postgres                                                                                                                # Provisions Postgres
3. PostgresDbUpdate                                                                                                # Creates the databases, assign roles, create users

**Deploy** :

1. Adminutil                                                                                                               # Deploy Adminutil Container
2. API Manager                                                                                                         # deploys API Manger Kong and API manager echo
3. OnboardAPIS                                                                                                        # Onboards All API's to sunbird
4. OnboardConsumers (Take the jwt token from Jenkins Output and update core\_vault\_ekstep\_api\_key, core\_vault\_sunbird\_api\_auth\_token) # Onboards New consumer to sunbird and generates API key specific to Consumer
5. (Provision) Cassandra                                                                                           # Provisions Cassandra and create Keyspaces required for Sunbird Core
6. Cassandra                                                                                                             # Does Migration if required
7. (Provision) Keycloak                                                                                              # Provisions Keycloak by installing prerequisites like java and env vars of learner
8. keycloak                                                                                                                 # Deploys keycloak service to VM
9. Proxy                                                                                                                   # Deploys Proxy, Handles all routing within the swarm
10. KeycloakRealm                                                                                                   # Creates Sunbird Realm, (After Creation of Realm configure keycloak by using Below Steps.)

**Configuration Steps Required in Keycloak**   a. Login to keycloak using username admin and password as given in private "secrets.yml" file. # Login to keycloak by using /auth

&#x20; b. Take the sso\_public\_key by navigating to: sunbird Realm > Realm Settings > keys > click Public Key(copy the key and update core\_vault\_sso\_public\_key)

&#x20; c. create Admin Role: Roles > Add Role > add details in the form(Role Name: admin) > save > Enable Composite Roles > Under Composite Roles > Select (offline\_access, uma\_administration) and click add selected,  Permissions(enable Permissions).

&#x20; d. assign permissions to admin-cli client: clients > admin-cli > Settings > Implicit Flow Enabled (ON) > Root URL: [https://dev.sunbird.cf](https://dev.sunbird.cf) (your Domain) > Valid Redirect URIs: [https://dev.sunbird.cf/\*](https://dev.sunbird.cf/\*) (Add another Link by clicking on "+") > Valid Redirect URIs: [https://dev.sunbird.cf/](https://dev.sunbird.cf/) > Base URL: / > Admin URL: [https://dev.sunbird.cf/\*](https://dev.sunbird.cf/\*) > Save

&#x20; e. clients > admin-cli > Roles > Add Role: Role Name: admin (Save)> composite Roles (ON) > Composite Roles > Realm Roles > add admin,offline\_access,uma\_authorization > Permissions > Permissions Enabled (ON)

12. Player                                                                                                                    # Deploys Player service, used to display Frontend of App
13. Learner                                                                                                                 # Deploys Learner Service, handles user management, helps in searching content
14. Content                                                                                                                 # Deploys Content service, Helps in creation of content
15. Telemetry                                                                                                              # Deploys Telemetry Service, Helps in sending telemetry to kafka
16. Telemetrydatapipeline                                                                                           # Deploys logstash container, which sends telemetry to kafka

***

\[\[category.storage-team]] \[\[category.confluence]]
