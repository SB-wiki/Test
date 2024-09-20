# KeyCloak-6.0.1-upgrade

```
* [03/04 Feb 2020](#03/04-feb-2020)
* [18/19 Nov 2019](#18/19-nov-2019)
```

AboutThe current KeyCloak (KC) running in production is 3.2.0 and we want to upgrade to 6.0.1. [SC-1271 System JIRA](https://browse/SC-1271)

Why 6.0.1?

1. 7.0.0 got released on Aug 24, 2019 (two days back from this document update) and no significant functionality or gap exists in 6.0.1. Expecting 6.0.1 to be more stable, since its [release](https://www.keycloak.org/2019/04/keycloak-601-released.html) on Apr 24, 2019.
2. KC community seems to have adopted continuous delivery model, which means “ _no breaking changes, but rather deprecating old APIs allowing time to migrate to new APIs._ ”Source - [https://www.keycloak.org/2019/04/versioning.html](https://www.keycloak.org/2019/04/versioning.html).&#x20;

What is not changing?

* Existing customization on KC - themes, logos, configurations
* Postgres database to back KC specific tables/data.
* Cassandra federation to store user details.

What is changing?

* _._

Deployment planThe picture calls it a blue green deployment only for the purpose of distinction that it is not an in-place upgrade.

![](<../../../../User/Fullexport2/images/storage/KC upgrade 6.0.1-Page-1.png>)

Migration steps **Pre-requisites**

1. Take backup of postgresql db.
2. Delete  KEYCLOAK\_HOME/standalone/data/tx-object-store/
3. Backup old installation (Configuration, themes and so on)
4. Download the 6.0.1 keycloak server archive and extract to desired location
5. Checkout and make build from below branch (this has changes done to support KC 6.0.1) - [https://github.com/project-sunbird/sunbird-auth/tree/SC-1271](https://github.com/project-sunbird/sunbird-auth/tree/SC-1271)

**Steps to migrate**

1. Stop the monit and KC 3.2.0 server.
2. Copy the artifact built by Keycloak Build Job( with latest code for 6.0.1)
3. copy the KEYCLOAK\_HOME/standalone/ directory from the 3.2.0 installation to 6.0.1.
4. copy the KEYCLOAK\_HOME/domain/ directory from the 3.2.0 installation to 6.0.1.

**NOTE: Don’t copy the entire modules directory. Only copy modifications done.**

1. Run the below scripts from 6.0.1

above step will migrate database automatically

**For Manual upgrade (Recommended when previous automated migration fails).**

1. To enable manual upgrading of the database schema, set the migrationStrategy property value to "manual" for the default connectionsJpa provider:

```xml
<spi name="connectionsJpa">
                <provider name="default" enabled="true">
                    <properties>
                        <property name="dataSource" value="java:jboss/datasources/KeycloakDS"/>
                        <property name="initializeEmpty" value="true"/>
                        <property name="migrationStrategy" value="manual"/>
                        <property name="migrationExport" value="${jboss.home.dir}/keycloak-database-update.sql"/>
                    </properties>
                </provider>
            </spi>
```

&#x20;        When you start the server with this configuration it checks if the database needs to be migrated. The required changes are written to an SQL file that you can review and manually run against the database.

Testing (by dev/devops)

* All the users who were legitimate users continue to remain so - no impacts.
* At least 2 restarts of KC server 6.0.1 after upgrade is successful.
* Take a dump of dev data from Postgres and re-run.

Testing recommended&#x20;

* Ability of previously logged in mobile users to continue/maintain their session.

Troubleshooting

| # | Status                   | Problem                                                                 | Details                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | Solution |
| - | ------------------------ | ----------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| 1 | Resolved (10th Oct 2019) | Operation ("add") failed - address: (one of it dependencies is missing) | Operation ("add") failed - address: (\[ ("subsystem" => "datasources"), ("jdbc-driver" => "postgresql") ]) - failure description: "WFLYJCA0115: Module for driver \[org.postgresql] or one of it dependencies is missing: \[org.postgresql]" 10:08:06,848 ERROR \[[org.jboss.as](http://org.jboss.as).controller.management-operation] (ServerService Thread Pool -- 42) WFLYCTL0013: Operation ("add") failed - address: (\[ ("subsystem" => "datasources"), ("jdbc-driver" => "org.postgresql") ]) |          |

OR

```bash
org.wildfly.extension.undertow.deployment.UndertowDeploymentService.startContext(UndertowDeploymentService.java:97)

at org.wildfly.extension.undertow.deployment.UndertowDeploymentService$1.run(UndertowDeploymentService.java:78)
at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
at java.util.concurrent.FutureTask.run(FutureTask.java:266)
at org.jboss.threads.ContextClassLoaderSavingRunnable.run(ContextClassLoaderSavingRunnable.java:35)
at org.jboss.threads.EnhancedQueueExecutor.safeRun(EnhancedQueueExecutor.java:1982)
at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.doRunTask(EnhancedQueueExecutor.java:1486)
at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1377)
at java.lang.Thread.run(Thread.java:748)
at org.jboss.threads.JBossThread.run(JBossThread.java:485)
Caused by: org.postgresql.util.PSQLException: Connection to localhost:5432 refused. Check that the hostname and port are correct and that the postmaster is accepting TCP/IP connections.
at org.postgresql.core.v3.ConnectionFactoryImpl.openConnectionImpl(ConnectionFactoryImpl.java:280)
at org.postgresql.core.ConnectionFactory.openConnection(ConnectionFactory.java:49)
at org.postgresql.jdbc.PgConnection.<init>(PgConnection.java:195)
at org.postgresql.Driver.makeConnection(Driver.java:454)
at org.postgresql.Driver.connect(Driver.java:256)
at java.sql.DriverManager.getConnection(DriverManager.java:664)
at java.sql.DriverManager.getConnection(DriverManager.java:247)
at org.postgresql.ds.common.BaseDataSource.getConnection(BaseDataSource.java:94)
at org.postgresql.ds.PGPoolingDataSource.getConnection(PGPoolingDataSource.java:312)
```

\| Check for correct version of postgresql jar and its folder location. The driver and the module.xml are in folder \modules\system\layers\keycloak\org\postgresql\main (Our Folder location was incorrect in deployment steps) | | 2 | Resolved (10th Oct 2019) | ICMP Port Unreachable and LogManager error of type WRITE\_FAILURE: Could not write to syslog | LogManager error of type WRITE\_FAILURE: Could not write to syslog [java.net](http://java.net).PortUnreachableException: ICMP Port Unreachable at [java.net](http://java.net).PlainDatagramSocketImpl.send(Native Method) at [java.net](http://java.net).DatagramSocket.send(DatagramSocket.java:693) at org.jboss.logmanager.handlers.UdpOutputStream.write(UdpOutputStream.java:52) at org.jboss.logmanager.handlers.SyslogHandler.sendMessage(SyslogHandler.java:579) at org.jboss.logmanager.handlers.SyslogHandler.doPublish(SyslogHandler.java:540) at org.jboss.logmanager.ExtHandler.publish(ExtHandler.java:76) | Check for PORT is open or not and Permission | | 3 | Resolved (15th Oct 2019) | liquibase ValidationFailedException (jpa-changelog ) | Failed to start service jboss.deployment.unit."keycloak-server.war".undertow-deployment: org.jboss.msc.service.StartException in service jboss.deployment.unit."keycloak-server.war".undertow-deployment: java.lang.RuntimeException: RESTEASY003325: Failed to construct public org.keycloak.services.resources.KeycloakApplication(javax.servlet.ServletContext,org.jboss.resteasy.core.Dispatcher) | 1. Recommended - If this occurs, likely that the database backup was taken with server running OR that the migration like activity was attempted with partial success earlier. One way, is to stop the KC server and re-try. If this still persists, then see recommended procedure here - S No. 4. 2. HACK

```sql
SELECT * form databasechangelog where id = '3.3.0'; 
UPDATE databasechangelog SET md5sum = ‘7:94edff7cf9ce179e7e85f0cd78a3cf2c’ WHERE id=‘3.3.0’;
```

NOTE: Check and update the value accordingly | | 4 | Resolved (18th Oct 2019) | Data Issue (Faced in DEV ENV) |

1. ERROR: could not create unique index "constraint\_web\_origins" DETAIL: Key (client\_id, value)=(9a901d18-377b-4615-9b89-677b544be3c5, [http://localhost](http://localhost)) is duplicated.
2. ERROR: could not create unique index "constraint\_redirect\_uris" DETAIL: Key (client\_id, value)=(b41cad3e-df3d-49f8-afde-a6522b28577a, [http://oauth2callback](http://oauth2callback)) is duplicated.
3. ERROR: could not create unique index "constr\_realm\_supported\_locales" DETAIL: Key (realm\_id, value)=(sunbird, de) is duplicated.
4. ERROR: could not create unique index "constr\_realm\_events\_listeners" DETAIL: Key (realm\_id, value)=(master, jboss-logging) is duplicated.
5. ERROR: could not create unique index "constraint\_composite\_role" DETAIL: Key (composite, child\_role)=(81ad7dc1-f07b-4b96-a320-c28f972c5245, 443d9e1a-ed37-4d5f-a57d-f860df03c874) is duplicated
6. Query Failed for ALTER TABLE public.USER\_ENTITY ADD NOT\_BEFORE INT DEFAULT 0 NOT NULL;
7. ERROR: Related to data duplicate in databasechangelog

```java
2020-01-20 08:47:53,609 ERROR [org.jboss.msc.service.fail] (ServerService Thread Pool -- 63) MSC000001: Failed to start service jboss.deployment.unit."keycloak-server.war".undertow-deployment: org.jboss.msc.service.StartException in service jboss.deployment.unit."keycloak-server.war".undertow-deployment: java.lang.RuntimeException: RESTEASY003325: Failed to construct public org.keycloak.services.resources.KeycloakApplication(javax.servlet.ServletContext,org.jboss.resteasy.core.Dispatcher)
	at org.wildfly.extension.undertow.deployment.UndertowDeploymentService$1.run(UndertowDeploymentService.java:81)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.run(FutureTask.java:266)
	at org.jboss.threads.ContextClassLoaderSavingRunnable.run(ContextClassLoaderSavingRunnable.java:35)
	at org.jboss.threads.EnhancedQueueExecutor.safeRun(EnhancedQueueExecutor.java:1982)
	at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.doRunTask(EnhancedQueueExecutor.java:1486)
	at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1377)
	at java.lang.Thread.run(Thread.java:748)
	at org.jboss.threads.JBossThread.run(JBossThread.java:485)
Caused by: java.lang.RuntimeException: RESTEASY003325: Failed to construct public org.keycloak.services.resources.KeycloakApplication(javax.servlet.ServletContext,org.jboss.resteasy.core.Dispatcher)
	at org.jboss.resteasy.core.ConstructorInjectorImpl.construct(ConstructorInjectorImpl.java:164)
	at org.jboss.resteasy.spi.ResteasyProviderFactory.createProviderInstance(ResteasyProviderFactory.java:2750)
	at org.jboss.resteasy.spi.ResteasyDeployment.createApplication(ResteasyDeployment.java:364)
	at org.jboss.resteasy.spi.ResteasyDeployment.startInternal(ResteasyDeployment.java:277)
	at org.jboss.resteasy.spi.ResteasyDeployment.start(ResteasyDeployment.java:89)
	at org.jboss.resteasy.plugins.server.servlet.ServletContainerDispatcher.init(ServletContainerDispatcher.java:119)
	at org.jboss.resteasy.plugins.server.servlet.HttpServletDispatcher.init(HttpServletDispatcher.java:36)
	at io.undertow.servlet.core.LifecyleInterceptorInvocation.proceed(LifecyleInterceptorInvocation.java:117)
	at org.wildfly.extension.undertow.security.RunAsLifecycleInterceptor.init(RunAsLifecycleInterceptor.java:78)
	at io.undertow.servlet.core.LifecyleInterceptorInvocation.proceed(LifecyleInterceptorInvocation.java:103)
	at io.undertow.servlet.core.ManagedServlet$DefaultInstanceStrategy.start(ManagedServlet.java:303)
	at io.undertow.servlet.core.ManagedServlet.createServlet(ManagedServlet.java:143)
	at io.undertow.servlet.core.DeploymentManagerImpl$2.call(DeploymentManagerImpl.java:583)
	at io.undertow.servlet.core.DeploymentManagerImpl$2.call(DeploymentManagerImpl.java:554)
	at io.undertow.servlet.core.ServletRequestContextThreadSetupAction$1.call(ServletRequestContextThreadSetupAction.java:42)
	at io.undertow.servlet.core.ContextClassLoaderSetupAction$1.call(ContextClassLoaderSetupAction.java:43)
	at org.wildfly.extension.undertow.security.SecurityContextThreadSetupAction.lambda$create$0(SecurityContextThreadSetupAction.java:105)
	at org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1502)
	at org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1502)
	at org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1502)
	at org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1502)
	at io.undertow.servlet.core.DeploymentManagerImpl.start(DeploymentManagerImpl.java:596)
	at org.wildfly.extension.undertow.deployment.UndertowDeploymentService.startContext(UndertowDeploymentService.java:97)
	at org.wildfly.extension.undertow.deployment.UndertowDeploymentService$1.run(UndertowDeploymentService.java:78)
	... 8 more
Caused by: java.lang.RuntimeException: Exception invoking method [listUnrunChangeSets] on object [liquibase.Liquibase@1454dd10], using arguments [null,(),false]
	at org.keycloak.common.util.reflections.Reflections.invokeMethod(Reflections.java:385)
	at org.keycloak.connections.jpa.updater.liquibase.LiquibaseJpaUpdaterProvider.getLiquibaseUnrunChangeSets(LiquibaseJpaUpdaterProvider.java:284)
	at org.keycloak.connections.jpa.updater.liquibase.LiquibaseJpaUpdaterProvider.validateChangeSet(LiquibaseJpaUpdaterProvider.java:252)
	at org.keycloak.connections.jpa.updater.liquibase.LiquibaseJpaUpdaterProvider.validate(LiquibaseJpaUpdaterProvider.java:225)
	at org.keycloak.connections.jpa.DefaultJpaConnectionProviderFactory.migration(DefaultJpaConnectionProviderFactory.java:296)
	at org.keycloak.connections.jpa.DefaultJpaConnectionProviderFactory.lambda$lazyInit$0(DefaultJpaConnectionProviderFactory.java:182)
	at org.keycloak.models.utils.KeycloakModelUtils.suspendJtaTransaction(KeycloakModelUtils.java:678)
	at org.keycloak.connections.jpa.DefaultJpaConnectionProviderFactory.lazyInit(DefaultJpaConnectionProviderFactory.java:133)
	at org.keycloak.connections.jpa.DefaultJpaConnectionProviderFactory.create(DefaultJpaConnectionProviderFactory.java:81)
	at org.keycloak.connections.jpa.DefaultJpaConnectionProviderFactory.create(DefaultJpaConnectionProviderFactory.java:59)
	at org.keycloak.services.DefaultKeycloakSession.getProvider(DefaultKeycloakSession.java:195)
	at org.keycloak.models.jpa.JpaRealmProviderFactory.create(JpaRealmProviderFactory.java:51)
	at org.keycloak.models.jpa.JpaRealmProviderFactory.create(JpaRealmProviderFactory.java:33)
	at org.keycloak.services.DefaultKeycloakSession.getProvider(DefaultKeycloakSession.java:195)
	at org.keycloak.services.DefaultKeycloakSession.realmLocalStorage(DefaultKeycloakSession.java:152)
	at org.keycloak.models.cache.infinispan.RealmCacheSession.getRealmDelegate(RealmCacheSession.java:148)
	at org.keycloak.models.cache.infinispan.RealmCacheSession.getMigrationModel(RealmCacheSession.java:141)
	at org.keycloak.migration.MigrationModelManager.migrate(MigrationModelManager.java:84)
	at org.keycloak.services.resources.KeycloakApplication.migrateModel(KeycloakApplication.java:246)
	at org.keycloak.services.resources.KeycloakApplication.migrateAndBootstrap(KeycloakApplication.java:187)
	at org.keycloak.services.resources.KeycloakApplication$1.run(KeycloakApplication.java:146)
	at org.keycloak.models.utils.KeycloakModelUtils.runJobInTransaction(KeycloakModelUtils.java:227)
	at org.keycloak.services.resources.KeycloakApplication.<init>(KeycloakApplication.java:137)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
	at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
	at org.jboss.resteasy.core.ConstructorInjectorImpl.construct(ConstructorInjectorImpl.java:152)
	... 31 more
Caused by: liquibase.exception.ValidationFailedException: Validation Failed:
     1 change sets check sum
          META-INF/jpa-changelog-3.3.0.xml::3.3.0::keycloak was: 7:f0a84880deb5f3d7153ace0b8f1cfa29 but is now: 7:94edff7cf9ce179e7e85f0cd78a3cf2c

	at liquibase.changelog.DatabaseChangeLog.validate(DatabaseChangeLog.java:266)
	at liquibase.Liquibase.listUnrunChangeSets(Liquibase.java:1189)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.keycloak.common.util.reflections.Reflections.invokeMethod(Reflections.java:379)
	... 58 more


```

|

1. For public.realm\_supported\_locales (realm\_id, value)

```sql
ALTER TABLE REALM_SUPPORTED_LOCALES ADD COLUMN id SERIAL;
select count(*) from public.REALM_SUPPORTED_LOCALES;
DELETE FROM REALM_SUPPORTED_LOCALES a USING REALM_SUPPORTED_LOCALES b WHERE a.id < b.id AND a.value = b.value;
select count(*) from public.REALM_SUPPORTED_LOCALES;
ALTER TABLE REALM_SUPPORTED_LOCALES DROP COLUMN id;
```

1. For public.composite\_role (composite, child\_role)

```sql
ALTER TABLE composite_role ADD COLUMN id SERIAL;
select count(*) from public.composite_role;
DELETE FROM composite_role a USING composite_role b WHERE a.id < b.id AND a.composite = b.composite AND a.child_role = b.child_role;
select count(*) from public.composite_role;
ALTER TABLE composite_role DROP COLUMN id;
```

1. For public.realm\_events\_listeners(realm\_id, value)

```sql
ALTER TABLE realm_events_listeners ADD COLUMN id SERIAL;
select count(*) from public.realm_events_listeners;
DELETE FROM realm_events_listeners a USING realm_events_listeners b WHERE a.id < b.id AND a.realm_id = b.realm_id AND a.value = b.value;
select count(*) from public.realm_events_listeners;
ALTER TABLE realm_events_listeners DROP COLUMN id;
```

1. For public.redirect\_uris (client\_id, value)

```sql
ALTER TABLE redirect_uris ADD COLUMN id SERIAL;
select count(*) from public.redirect_uris;
DELETE FROM redirect_uris a USING redirect_uris b WHERE a.id < b.id AND a.client_id = b.client_id AND a.value = b.value;
select count(*) from public.redirect_uris;
ALTER TABLE redirect_uris DROP COLUMN id;
```

1. For public.web\_origins (client\_id, value)

```sql
ALTER TABLE web_origins ADD COLUMN id SERIAL;
select count(*) from public.web_origins;
DELETE FROM web_origins a USING web_origins b WHERE a.id < b.id AND a.client_id = b.client_id AND a.value = b.value;
select count(*) from public.web_origins;
ALTER TABLE web_origins DROP COLUMN id;
```

1. For public.user\_entity

```sql
ALTER TABLE public.USER_ENTITY DROP COLUMN  NOT_BEFORE;
```

1. For public.databasechangelog

```sql
ALTER TABLE databasechangelog ADD COLUMN serid SERIAL;
select count(*) from public.databasechangelog;
DELETE FROM databasechangelog a USING databasechangelog b WHERE a.serid < b.serid AND a.author = b.author AND a.md5sum = b.md5sum;
select count(*) from public.databasechangelog;
ALTER TABLE databasechangelog DROP COLUMN serid;
```

\| | 5 | Resolved (21st Oct 2019) | Keycloak server not starting - Issue related to TCPPING | ERROR \[org.jboss.msc.service.fail] (ServerService Thread Pool -- 58) MSC000001: Failed to start service [org.wildfly.clustering.jgroups.channel.ee](http://org.wildfly.clustering.jgroups.channel.ee): org.jboss.msc.service.StartException in service [org.wildfly.clustering.jgroups.channel.ee](http://org.wildfly.clustering.jgroups.channel.ee): java.lang.IllegalStateException: java.lang.IllegalArgumentException: java.security.PrivilegedActionException: java.lang.IllegalArgumentException: Unrecognized TCPPING properties: \[num\_initial\_members, timeout] at org.wildfly.clustering.service.FunctionalService.start(FunctionalService.java:70) at org.wildfly.clustering.service.AsyncServiceConfigurator$AsyncService.lambda$start$0(AsyncServiceConfigurator.java:117) at org.jboss.threads.ContextClassLoaderSavingRunnable.run(ContextClassLoaderSavingRunnable.java:35) at org.jboss.threads.EnhancedQueueExecutor.safeRun(EnhancedQueueExecutor.java:1982) at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.doRunTask(EnhancedQueueExecutor.java:1486) at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1377) at java.lang.Thread.run(Thread.java:748) at org.jboss.threads.JBossThread.run(JBossThread.java:485) | use the below TCPPING configuration :

```xml
<protocol type="TCPPING">
    <property name="initial_hosts">10.10.10.10[7600],20.20.20.20[7600]</property>
 </protocol>
```

NOTE : From JDG 7.1 num\_initial\_members and timeout property will not work. Red Hat JBoss Data Grid 7.1 uses JGroups 4.0.0.CR2, in which the TCPPING timeout value no longer exists. So in standalone-ha.xml file change

```xml
<stack name="tcp">
                    <transport type="TCP" socket-binding="jgroups-tcp"/>
                    <protocol type="TCPPING">
                    <property name="initial_hosts">11.2.4.5[7600]</property>
                    </protocol>
                    <protocol type="MERGE3"/>
                    <protocol type="VERIFY_SUSPECT"/>
                    <protocol type="pbcast.NAKACK2"/>
                    <protocol type="UNICAST3"/>
                    <protocol type="pbcast.STABLE"/>
                    <protocol type="pbcast.GMS"/>
                    <protocol type="MFC"/>
                    <protocol type="FD_ALL"/>
                    <protocol type="FD_SOCK"/>
                    <protocol type="FRAG3"/>
                </stack>
```

\| | 6 | Resolved (19th Nov 2019) | using HTTPS results in a call to HTTP for all generated Keycloak links (Getting Access Denied and invalid token (wrong ISS) ) |

```
Error while authentication in portal: invalid token (wrong ISS)
```

access denied (403) | Use the below configuration inside standalone-ha.xml or standalone.xml

```xml
<subsystem xmlns="urn:jboss:domain:undertow:6.0">
   <buffer-cache name="default"/>
   <server name="default-server">
      <ajp-listener name="ajp" socket-binding="ajp"/>
      <http-listener name="default" socket-binding="http" redirect-socket="https"
          proxy-address-forwarding="true"/>
      ...
   </server>
   ...
</subsystem>
```

Add the **proxy-address-forwarding** attribute to the **http-listener** element. Set the value to true. Ref: [https://www.keycloak.org/docs/8.0/server\_installation/#identifying-client-ip-addresses](https://www.keycloak.org/docs/8.0/server\_installation/#identifying-client-ip-addresses) |

Observations/Updates24 March 2020Refer to the deployment diagram above. This is a blue green deployment. i.e., we will bring in a new KC 6.0.1 server. And therefore procedure is as follows:

1. Stop the 3.2.0 server.&#x20;
2. Take a copy of the 3.2.0 keycloak postgres database.&#x20;
3. Restore the 3.2.0 database with a new name, say kc601db.
4. Install KC 6.0.1.
5. Modify the standalone-ha.xml to reflect the new database name and the other KC 6.0.1 instance.
6. Remove the older 3.2.0 KC from KC load balancer.
7. Point the new 6.0.1 KC in the KC load balancer.
8. Start the KC 6.0.1 service.

#### 03/04 Feb 2020

* Issue with keycloak standalone cluster with high availability mode (both server were not able to communicate with each other)
* Followed the steps as per link [http://www.mastertheboss.com/jboss-server/jboss-cluster/how-to-configure-jboss-eap-and-wildfly-to-use-tcpping](http://www.mastertheboss.com/jboss-server/jboss-cluster/how-to-configure-jboss-eap-and-wildfly-to-use-tcpping) but didn't worked.
*   Then after some POC , added TCP stack as below and it worked

    for keycloak-1:  &#x20;

```xml
 <channels default="ee">
                <channel name="ee" stack="tcp"/>
            </channels>
            <stacks default="tcp">

<stack name="tcp">
                    <transport type="TCP" socket-binding="jgroups-tcp"/>
                    <protocol type="TCPPING">
                        <property name="initial_hosts">keycloak-2 ip[7600]
                        </property>
                        <property name="port_range">10</property>
                   <!--     <property name="timeout">3000</property>
                        <property name="num_initial_members">2</property> -->
                    </protocol>
                   ....
                </stack>
```

keycloak-2:

```xml
 <channels default="ee">
                <channel name="ee" stack="tcp"/>
            </channels>
            <stacks default="tcp">

<stack name="tcp">
                    <transport type="TCP" socket-binding="jgroups-tcp"/>
                    <protocol type="TCPPING">
                        <property name="initial_hosts">keycloak-1 ip[7600]
                        </property>
                        <property name="port_range">10</property>
                 <!--       <property name="timeout">3000</property>
                        <property name="num_initial_members">2</property> -->
                    </protocol>
                    ....
                </stack>
```

&#x20;       &#x20;

Dec 5 and subsequent testing5/12/2019 - \*Defects reported so far reported with KC 6.0.1\*

SB-16124 - User is not able to create the contents getting error message "Failed to save the content"

> Workspace invoking /userinfo - API didn’t success response all the times

> Raised [https://issues.jboss.org/browse/KEYCLOAK-12388](https://issues.jboss.org/browse/KEYCLOAK-12388)

> get the public key and tries to compare JWT passed.

> backend RSATokenVerifier.verifyToken() -> no REST API called

[https://project-sunbird.atlassian.net/browse/SB-16176](https://project-sunbird.atlassian.net/browse/SB-16176) - When the user tries to login to the portal he is getting "You took too long to sign in.Sign in process starting from beginning”

> QA Concern is time limit is too less. This error happens too often.

[https://project-sunbird.atlassian.net/browse/SB-16096](https://project-sunbird.atlassian.net/browse/SB-16096) - While logging into the portal user is getting access denied.

> 403 - Access denied - Intermittent - in both 3.2.0 and 6.0.1

[https://project-sunbird.atlassian.net/browse/SB-16217](https://project-sunbird.atlassian.net/browse/SB-16217) - Staging Platform: Post yesterday's change (SB-16124), user redirected to in-correct page after login

> Try clearing your cookies messages

> Downgrades and upgrades on the same browser causing this.

#### 18/19 Nov 2019

* Access denied error with error as wrong iss (issuer). When decoding the jwt, we see the issuer is [http://dev.sunbirded.org](http://dev.sunbirded.org), whereas portal expects it to be [https://dev.sunbirded.org](https://dev.sunbirded.org).
* This was fixed later by adding this in standalone-ha.xml \_proxy-address-forwarding=true. \_

13 Nov 2019

* Devops attempted KC production data in a 2 server KC model (as-is in production). This was successful with the steps documented above

21 Oct 2019 week

Devops declared steps are working fine in dev (with pending theme changes).14 Oct 2019 weekKeyCloak server upgrade has different statuses in each environment

6 Sept 2019

* Positive results after upgradation
  * Generating token works via postman, and partially from portal page (requires upgrade of [keycloak-nodejs-connect](https://github.com/project-sunbird/keycloak-nodejs-connect))
  * [https://xxx/auth/realms/sunbird/login-actions/authenticate?code=82Ux6m7RUP8V8DphK5mHmiZDL7tnoqA1SD7uh80HYSo\&execution=721694b9-68a3-40c7-adaf-bba2ae142fc2\&client\_id=portal](https://dev.sunbirded.org/auth/realms/sunbird/login-actions/authenticate?code=82Ux6m7RUP8V8DphK5mHmiZDL7tnoqA1SD7uh80HYSo\&execution=721694b9-68a3-40c7-adaf-bba2ae142fc2\&client\_id=portal)
  * [http://10.1.1.5:8080/auth/realms/sunbird/login-actions/authenticate?session\_code=rzm5MGKfSxVs6QepF0loCj43OBkaF0Ea5Rs\_CHL0JuM\&execution=721694b9-68a3-40c7-adaf-bba2ae142fc2\&client\_id=portal\&tab\_id=zyoMWhVXs4g](http://10.1.1.5:8080/auth/realms/sunbird/login-actions/authenticate?session\_code=rzm5MGKfSxVs6QepF0loCj43OBkaF0Ea5Rs\_CHL0JuM\&execution=721694b9-68a3-40c7-adaf-bba2ae142fc2\&client\_id=portal\&tab\_id=zyoMWhVXs4g)
  * Note the change in the query param name, that likely causes a failure presently.
  * The migration steps mentioned in this document suffice. No new steps discovered.
  * The migration steps do not depend upon the load of the database (not proportional to the number of users).
  * The keycloak-auth jar upgrade in SC-1271 is good enough.
* Devops created a KC machine outside the dev infra but that had trust. So, this needs to be purged and moved to dev infra itself.
* Devops probably need to change the deploy script to update the 'themes' properly.

&#x20;        &#x20;

&#x20;        &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
