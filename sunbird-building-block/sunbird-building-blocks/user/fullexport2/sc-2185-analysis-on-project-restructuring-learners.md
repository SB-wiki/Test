This design is to finalise on restructuring of sunbird-lms-service to reduce the complexity of adding new modules and to solve issues on circling dependencies. Analysing the current project structure and the new proposals to see which is more adaptable and simpler and then decide on the new project structure.

Current structure:


```none
sunbird-lms-service
|------actors
|        |------sunbird-lms-mw
|                |------mw-service
|                |------mw-actors
|                         |------actor-common
|                         |------location
|                         |------organisation
|                         |------systemsettings (System settings API files)
|                         |------user (User API related files)
|                         |------sunbird-utils
|                                   |------auth-verifier
|                                   |------sunbird-cassandra-utils
|                                   |------sunbird-es-utils
|                                   |------sunbird-notification
|                                   |------sunbird-platform-core
|                                            |------actor-core
|                                            |------actor-util
|                                            |------common-util
|                                            |------sunbird-commons
|------service
|        |------Controllers/Filters/RequestValidators
|------reports
```
Cons: 


* Not very organised, so creates confusion while adding new functionality


* Too many layers of modules which cause circle dependency sometimes



Approach 1:


```none
sunbird-lms-service
|------actors(with separate modules- with model/sevice/dao/util folder in each module)
|        |------location(model/sevice/dao/util folders inside)
|        |------organisation
|        |------systemsettings (System settings API files)
|        |------user (User API related files-create/update/read/search/roles/consent/migrate/tnc/merge/block)
|        |------feed
|        |------notes
|        |------tenantpreference
|        |------notifications
|        |------uploads
|        |------otp
|        |------datasync
|------sunbird-cassandra-utils
|------sunbird-es-utils
|------sunbird-notification
|------sunbird-platform-core
|        |------actor-core
|        |------actor-util(actor clients which is calling specific actors)
|------sunbird-common-utils(keycloak,exception,cache,logging,azure,sso,kafka,gmailauth,admiutil,formapi,request,response,datasecurity)
|------sunbird-telemetry-utils
|------service
|        |------Controllers/Filters/RequestValidators
|------reports
```
Pros: 


* Easier to adapt to Approach 1, as concept is similar to existing one, only that the complex layering is taken out. 


* If any functionality needs to be deleted, that is easy in this approach.


* Also later stage, Cassandra/es/notification/telemetry can be moved to other repos, by retaining only learner specific code.



Cons:


* Not easy to change to plugin different DB


* Circle dependency will still occur



Approach 2:


```none
sunbird-lms-service
|------actors(separate actor/service/dao/model/util folders with functionality folders inside, not modules)
|------sunbird-cassandra-utils
|------sunbird-es-utils
|------sunbird-notification
|------sunbird-platform-core
|        |------actor-core
|        |------actor-util(actor clients which is calling specific actors)
|------sunbird-common-utils(keycloak,exception,cache,logging,azure,sso,kafka,gmailauth,admiutil,formapi,request,response,datasecurity)
|------sunbird-telemetry-utils
|------service
|        |------Controllers/Filters/RequestValidators
|------reports
```
Pros: 


* Easy to plugin different DB, as we need to change only dao folder


* In later stage, Cassandra/es/notification/telemetry can be moved to other repos, by retaining only learner specific code.



Cons:


* If any functionality needs to be deleted, that is not easy in this approach.


* Not easy to adapt as the current structure is not maintained in this way



Approach 3:


```
sunbird-lms-service
|------platform-controller (Filters/RequestValidators/Controllers[akka-play framework] - functionality wise folders like location/org/user inside)
          \location
				\controller
				\validator
          \organisation
				\controller
				\validator
          \user
				\controller
				\validator
          \filters
          \modules
          \util
|------platform-service (separate actor/service/dao/model/util folders with functionality folders inside, not modules)
			\location
				\actor
				\service
				\dao
				\model
				\util
			\organisation	
				\actor
				\service
				\dao
				\model
				\util
			\user
				\actor
				\service
				\dao
				\model
				\util
|------platform-core
|        |------sunbird-telemetry-utils
|        |------sunbird-cassandra-utils
|        |------sunbird-es-utils
|        |------sunbird-notification
|        |------actor-core(BaseActor/Base Router/RequestRouter/BackgroundRequestRouter/BaseMWService/SunbirdMWService)
|        |------platform-common(keycloak,exception,cache,logging,azure,sso,kafka,gmailauth,admiutil,formapi,request,response,datasecurity)
|------reports
```
Approach 4:


```
sunbird-lms-service
|------platform-controller (Filters/RequestValidators/Controllers[akka-play framework] - functionality wise folders like location/org/user inside)
			\controller
				\location
					\vaidator
				\organisation
					\vaidator
				\user
					\vaidator			
			\filters
			\modules
			\util
|------platform-service (separate actor/service/dao/model/util folders with functionality folders inside, not modules)
            \actor
				\location
				\organisation
				\user
			\service
				\location
				\organisation
				\user
			\dao
				\location
				\organisation
				\user
			\util
			\model
|------platform-core
|        |------sunbird-telemetry-utils
|        |------sunbird-cassandra-utils
|        |------sunbird-es-utils
|        |------sunbird-notification
|        |------actor-core(BaseActor/Base Router/RequestRouter/BackgroundRequestRouter/BaseMWService/SunbirdMWService)
|        |------platform-common(keycloak,exception,cache,logging,azure,sso,kafka,gmailauth,admiutil,formapi,request,response,datasecurity)
|------reports
```
Solution:

Planning to go by approach 4. There was a thought to use separate repo to maintain new code, but as it will be difficult to maintain it, planning to go ahead with folder level changes in 4.1 release and then refactoring each functionality from 4.2 release



*****

[[category.storage-team]] 
[[category.confluence]] 
