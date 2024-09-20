-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: META-INF/jpa-changelog-master.xml
-- Ran at: 11/24/23, 6:45 AM
-- Against: sunbirddevbb@devbb-pg11@jdbc:postgresql://10.5.3.9:5432/keycloak_3017_21_2?adaptiveFetch=false&adaptiveFetchMaximum=-1&adaptiveFetchMinimum=0&allowEncodingChanges=false&ApplicationName=PostgreSQL+JDBC+Driver&autosave=never&binaryTransfer=true&binaryTransferDisable=&binaryTransferEnable=&cancelSignalTimeout=10&cleanupSavepoints=false&connectTimeout=10&databaseMetadataCacheFields=65536&databaseMetadataCacheFieldsMiB=5&defaultRowFetchSize=0&disableColumnSanitiser=false&escapeSyntaxCallMode=select&groupStartupParameters=false&gssEncMode=allow&gsslib=auto&hideUnprivilegedObjects=false&hostRecheckSeconds=10&jaasApplicationName=pgjdbc&jaasLogin=true&loadBalanceHosts=false&loginTimeout=0&logServerErrorDetail=true&logUnclosedConnections=false&preferQueryMode=extended&preparedStatementCacheQueries=256&preparedStatementCacheSizeMiB=5&prepareThreshold=5&quoteReturningIdentifiers=true&readOnly=false&readOnlyMode=transaction&receiveBufferSize=-1&reWriteBatchedInserts=false&sendBufferSize=-1&socketTimeout=0&sslResponseTimeout=5000&sspiServiceClass=POSTGRES&targetServerType=any&tcpKeepAlive=false&tcpNoDelay=true&unknownLength=2147483647&useSpnego=false&xmlFactoryFactory=
-- Liquibase version: 4.16.1
-- *********************************************************************

SET SEARCH_PATH TO public, "$user","public";

-- Changeset META-INF/jpa-changelog-8.0.0.xml::8.0.0-adding-credential-columns::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.CREDENTIAL ADD USER_LABEL VARCHAR(255);

ALTER TABLE public.CREDENTIAL ADD SECRET_DATA TEXT;

ALTER TABLE public.CREDENTIAL ADD CREDENTIAL_DATA TEXT;

ALTER TABLE public.CREDENTIAL ADD PRIORITY INTEGER;

ALTER TABLE public.FED_USER_CREDENTIAL ADD USER_LABEL VARCHAR(255);

ALTER TABLE public.FED_USER_CREDENTIAL ADD SECRET_DATA TEXT;

ALTER TABLE public.FED_USER_CREDENTIAL ADD CREDENTIAL_DATA TEXT;

ALTER TABLE public.FED_USER_CREDENTIAL ADD PRIORITY INTEGER;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', NOW(), 76, '8:215a31c398b363ce383a2b301202f29e', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-8.0.0.xml::8.0.0-updating-credential-data-not-oracle-fixed::keycloak
SET SEARCH_PATH TO public, "$user","public";

UPDATE public.CREDENTIAL SET CREDENTIAL_DATA = CONCAT('{"hashIterations":', HASH_ITERATIONS, ',"algorithm":"', ALGORITHM, '"}'), PRIORITY = '10', SECRET_DATA = CONCAT('{"value":"', REPLACE(VALUE, '"', '\\"'), '","salt":"__SALT__"}') WHERE TYPE = 'password' OR TYPE = 'password-history';

UPDATE public.CREDENTIAL SET CREDENTIAL_DATA = CONCAT('{"subType":"totp","digits":', DIGITS, ',"period":', PERIOD, ',"algorithm":"', ALGORITHM, '"}'), PRIORITY = '20', SECRET_DATA = CONCAT('{"value":"', REPLACE(VALUE, '"', '\\"'), '"}'), TYPE = 'otp' WHERE TYPE = 'totp';

UPDATE public.CREDENTIAL SET CREDENTIAL_DATA = CONCAT('{"subType":"hotp","digits":', DIGITS, ',"counter":', COUNTER, ',"algorithm":"', ALGORITHM, '"}'), PRIORITY = '20', SECRET_DATA = CONCAT('{"value":"', REPLACE(VALUE, '"', '\\"'), '"}'), TYPE = 'otp' WHERE TYPE = 'hotp';

UPDATE public.FED_USER_CREDENTIAL SET CREDENTIAL_DATA = CONCAT('{"hashIterations":', HASH_ITERATIONS, ',"algorithm":"', ALGORITHM, '"}'), PRIORITY = '10', SECRET_DATA = CONCAT('{"value":"', REPLACE(VALUE, '"', '\\"'), '","salt":"__SALT__"}') WHERE TYPE = 'password' OR TYPE = 'password-history';

UPDATE public.FED_USER_CREDENTIAL SET CREDENTIAL_DATA = CONCAT('{"subType":"totp","digits":', DIGITS, ',"period":', PERIOD, ',"algorithm":"', ALGORITHM, '"}'), PRIORITY = '20', SECRET_DATA = CONCAT('{"value":"', REPLACE(VALUE, '"', '\\"'), '"}'), TYPE = 'otp' WHERE TYPE = 'totp';

UPDATE public.FED_USER_CREDENTIAL SET CREDENTIAL_DATA = CONCAT('{"subType":"hotp","digits":', DIGITS, ',"counter":', COUNTER, ',"algorithm":"', ALGORITHM, '"}'), PRIORITY = '20', SECRET_DATA = CONCAT('{"value":"', REPLACE(VALUE, '"', '\\"'), '"}'), TYPE = 'otp' WHERE TYPE = 'hotp';

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', NOW(), 77, '8:83f7a671792ca98b3cbd3a1a34862d3d', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-8.0.0.xml::8.0.0-updating-credential-data-oracle-fixed::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', NOW(), 78, '8:f58ad148698cf30707a6efbdf8061aa7', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-8.0.0.xml::8.0.0-credential-cleanup-fixed::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.CREDENTIAL ALTER COLUMN COUNTER DROP DEFAULT;

ALTER TABLE public.CREDENTIAL ALTER COLUMN DIGITS DROP DEFAULT;

ALTER TABLE public.CREDENTIAL ALTER COLUMN PERIOD DROP DEFAULT;

ALTER TABLE public.CREDENTIAL ALTER COLUMN ALGORITHM DROP DEFAULT;

ALTER TABLE public.CREDENTIAL DROP COLUMN DEVICE;

ALTER TABLE public.CREDENTIAL DROP COLUMN HASH_ITERATIONS;

ALTER TABLE public.CREDENTIAL DROP COLUMN VALUE;

ALTER TABLE public.CREDENTIAL DROP COLUMN COUNTER;

ALTER TABLE public.CREDENTIAL DROP COLUMN DIGITS;

ALTER TABLE public.CREDENTIAL DROP COLUMN PERIOD;

ALTER TABLE public.CREDENTIAL DROP COLUMN ALGORITHM;

DROP TABLE public.CREDENTIAL_ATTRIBUTE;

ALTER TABLE public.FED_USER_CREDENTIAL ALTER COLUMN COUNTER DROP DEFAULT;

ALTER TABLE public.FED_USER_CREDENTIAL ALTER COLUMN DIGITS DROP DEFAULT;

ALTER TABLE public.FED_USER_CREDENTIAL ALTER COLUMN PERIOD DROP DEFAULT;

ALTER TABLE public.FED_USER_CREDENTIAL ALTER COLUMN ALGORITHM DROP DEFAULT;

ALTER TABLE public.FED_USER_CREDENTIAL DROP COLUMN DEVICE;

ALTER TABLE public.FED_USER_CREDENTIAL DROP COLUMN HASH_ITERATIONS;

ALTER TABLE public.FED_USER_CREDENTIAL DROP COLUMN VALUE;

ALTER TABLE public.FED_USER_CREDENTIAL DROP COLUMN COUNTER;

ALTER TABLE public.FED_USER_CREDENTIAL DROP COLUMN DIGITS;

ALTER TABLE public.FED_USER_CREDENTIAL DROP COLUMN PERIOD;

ALTER TABLE public.FED_USER_CREDENTIAL DROP COLUMN ALGORITHM;

DROP TABLE public.FED_CREDENTIAL_ATTRIBUTE;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', NOW(), 79, '8:79e4fd6c6442980e58d52ffc3ee7b19c', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-8.0.0.xml::8.0.0-resource-tag-support::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.MIGRATION_MODEL ADD UPDATE_TIME BIGINT DEFAULT 0 NOT NULL;

CREATE INDEX IDX_UPDATE_TIME ON public.MIGRATION_MODEL(UPDATE_TIME);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', NOW(), 80, '8:87af6a1e6d241ca4b15801d1f86a297d', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.0.xml::9.0.0-always-display-client::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.CLIENT ADD ALWAYS_DISPLAY_IN_CONSOLE BOOLEAN DEFAULT FALSE NOT NULL;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', NOW(), 81, '8:b44f8d9b7b6ea455305a6d72a200ed15', 'addColumn tableName=CLIENT', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.0.xml::9.0.0-drop-constraints-for-column-increase::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', NOW(), 82, '8:2d8ed5aaaeffd0cb004c046b4a903ac5', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.0.xml::9.0.0-increase-column-size-federated-fk::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.FED_USER_CONSENT ALTER COLUMN CLIENT_ID TYPE VARCHAR(255) USING (CLIENT_ID::VARCHAR(255));

ALTER TABLE public.KEYCLOAK_ROLE ALTER COLUMN CLIENT_REALM_CONSTRAINT TYPE VARCHAR(255) USING (CLIENT_REALM_CONSTRAINT::VARCHAR(255));

ALTER TABLE public.RESOURCE_SERVER_POLICY ALTER COLUMN OWNER TYPE VARCHAR(255) USING (OWNER::VARCHAR(255));

ALTER TABLE public.USER_CONSENT ALTER COLUMN CLIENT_ID TYPE VARCHAR(255) USING (CLIENT_ID::VARCHAR(255));

ALTER TABLE public.USER_ENTITY ALTER COLUMN SERVICE_ACCOUNT_CLIENT_LINK TYPE VARCHAR(255) USING (SERVICE_ACCOUNT_CLIENT_LINK::VARCHAR(255));

ALTER TABLE public.OFFLINE_CLIENT_SESSION ALTER COLUMN CLIENT_ID TYPE VARCHAR(255) USING (CLIENT_ID::VARCHAR(255));

ALTER TABLE public.RESOURCE_SERVER_PERM_TICKET ALTER COLUMN OWNER TYPE VARCHAR(255) USING (OWNER::VARCHAR(255));

ALTER TABLE public.RESOURCE_SERVER_PERM_TICKET ALTER COLUMN REQUESTER TYPE VARCHAR(255) USING (REQUESTER::VARCHAR(255));

ALTER TABLE public.RESOURCE_SERVER_RESOURCE ALTER COLUMN OWNER TYPE VARCHAR(255) USING (OWNER::VARCHAR(255));

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', NOW(), 83, '8:e290c01fcbc275326c511633f6e2acde', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.0.xml::9.0.0-recreate-constraints-after-column-increase::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', NOW(), 84, '8:c9db8784c33cea210872ac2d805439f8', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.1.xml::9.0.1-add-index-to-client.client_id::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_CLIENT_ID ON public.CLIENT(CLIENT_ID);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', NOW(), 85, '8:95b676ce8fc546a1fcfb4c92fae4add5', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.1.xml::9.0.1-KEYCLOAK-12579-drop-constraints::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', NOW(), 86, '8:38a6b2a41f5651018b1aca93a41401e5', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.1.xml::9.0.1-KEYCLOAK-12579-add-not-null-constraint::keycloak
SET SEARCH_PATH TO public, "$user","public";

UPDATE public.KEYCLOAK_GROUP SET PARENT_GROUP = ' ' WHERE PARENT_GROUP IS NULL;

ALTER TABLE public.KEYCLOAK_GROUP ALTER COLUMN  PARENT_GROUP SET NOT NULL;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', NOW(), 87, '8:3fb99bcad86a0229783123ac52f7609c', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.1.xml::9.0.1-KEYCLOAK-12579-recreate-constraints::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', NOW(), 88, '8:64f27a6fdcad57f6f9153210f2ec1bdb', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-9.0.1.xml::9.0.1-add-index-to-events::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_EVENT_TIME ON public.EVENT_ENTITY(REALM_ID, EVENT_TIME);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', NOW(), 89, '8:ab4f863f39adafd4c862f7ec01890abc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-11.0.0.xml::map-remove-ri::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.REALM DROP CONSTRAINT FK_TRAF444KK6QRKMS7N56AIWQ5Y;

ALTER TABLE public.KEYCLOAK_ROLE DROP CONSTRAINT FK_KJHO5LE2C0RAL09FL8CM9WFW9;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', NOW(), 90, '8:13c419a0eb336e91ee3a3bf8fda6e2a7', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-12.0.0.xml::map-remove-ri::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.REALM_DEFAULT_GROUPS DROP CONSTRAINT FK_DEF_GROUPS_GROUP;

ALTER TABLE public.REALM_DEFAULT_ROLES DROP CONSTRAINT FK_H4WPD7W4HSOOLNI3H0SW7BTJE;

ALTER TABLE public.CLIENT_SCOPE_ROLE_MAPPING DROP CONSTRAINT FK_CL_SCOPE_RM_ROLE;

ALTER TABLE public.GROUP_ROLE_MAPPING DROP CONSTRAINT FK_GROUP_ROLE_ROLE;

ALTER TABLE public.CLIENT_DEFAULT_ROLES DROP CONSTRAINT FK_8AELWNIBJI49AVXSRTUF6XJOW;

ALTER TABLE public.SCOPE_MAPPING DROP CONSTRAINT FK_P3RH9GRKU11KQFRS4FLTT7RNQ;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', NOW(), 91, '8:e3fb1e698e0471487f51af1ed80fe3ac', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-12.0.0.xml::12.1.0-add-realm-localization-table::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE TABLE public.REALM_LOCALIZATIONS (REALM_ID VARCHAR(255) NOT NULL, LOCALE VARCHAR(255) NOT NULL, TEXTS TEXT NOT NULL);

ALTER TABLE public.REALM_LOCALIZATIONS ADD PRIMARY KEY (REALM_ID, LOCALE);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', NOW(), 92, '8:babadb686aab7b56562817e60bf0abd0', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::default-roles::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.REALM ADD DEFAULT_ROLE VARCHAR(255);

-- WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
INSERT INTO public.keycloak_role (ID, CLIENT_REALM_CONSTRAINT, CLIENT_ROLE, DESCRIPTION, NAME, REALM_ID, REALM) VALUES ('09013573-931d-4626-8115-e01813f2fe6a', 'sunbird', FALSE, '${role_default-roles-sunbird}', 'default-roles-sunbird', 'sunbird', 'sunbird');

UPDATE public.realm SET DEFAULT_ROLE = '09013573-931d-4626-8115-e01813f2fe6a' WHERE REALM.ID='sunbird';

INSERT INTO public.COMPOSITE_ROLE (COMPOSITE, CHILD_ROLE) SELECT '09013573-931d-4626-8115-e01813f2fe6a', ROLE_ID FROM public.REALM_DEFAULT_ROLES WHERE REALM_ID = 'sunbird';

INSERT INTO public.COMPOSITE_ROLE (COMPOSITE, CHILD_ROLE) SELECT '09013573-931d-4626-8115-e01813f2fe6a', public.CLIENT_DEFAULT_ROLES.ROLE_ID FROM public.CLIENT_DEFAULT_ROLES INNER JOIN public.CLIENT ON public.CLIENT.ID = public.CLIENT_DEFAULT_ROLES.CLIENT_ID AND public.CLIENT.REALM_ID = 'sunbird';

INSERT INTO public.keycloak_role (ID, CLIENT_REALM_CONSTRAINT, CLIENT_ROLE, DESCRIPTION, NAME, REALM_ID, REALM) VALUES ('fadccd93-42a7-4416-aaa3-2bdfd5d20987', 'master', FALSE, '${role_default-roles-master}', 'default-roles-master', 'master', 'master');

UPDATE public.realm SET DEFAULT_ROLE = 'fadccd93-42a7-4416-aaa3-2bdfd5d20987' WHERE REALM.ID='master';

INSERT INTO public.COMPOSITE_ROLE (COMPOSITE, CHILD_ROLE) SELECT 'fadccd93-42a7-4416-aaa3-2bdfd5d20987', ROLE_ID FROM public.REALM_DEFAULT_ROLES WHERE REALM_ID = 'master';

INSERT INTO public.COMPOSITE_ROLE (COMPOSITE, CHILD_ROLE) SELECT 'fadccd93-42a7-4416-aaa3-2bdfd5d20987', public.CLIENT_DEFAULT_ROLES.ROLE_ID FROM public.CLIENT_DEFAULT_ROLES INNER JOIN public.CLIENT ON public.CLIENT.ID = public.CLIENT_DEFAULT_ROLES.CLIENT_ID AND public.CLIENT.REALM_ID = 'master';

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 93, '8:72d03345fda8e2f17093d08801947773', 'addColumn tableName=REALM; customChange', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::default-roles-cleanup::keycloak
SET SEARCH_PATH TO public, "$user","public";

DROP TABLE public.REALM_DEFAULT_ROLES;

DROP TABLE public.CLIENT_DEFAULT_ROLES;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 94, '8:61c9233951bd96ffecd9ba75f7d978a4', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::13.0.0-KEYCLOAK-16844::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_OFFLINE_USS_PRELOAD ON public.OFFLINE_USER_SESSION(OFFLINE_FLAG, CREATED_ON, USER_SESSION_ID);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 95, '8:ea82e6ad945cec250af6372767b25525', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::map-remove-ri-13.0.0::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.DEFAULT_CLIENT_SCOPE DROP CONSTRAINT FK_R_DEF_CLI_SCOPE_SCOPE;

ALTER TABLE public.CLIENT_SCOPE_CLIENT DROP CONSTRAINT FK_C_CLI_SCOPE_SCOPE;

ALTER TABLE public.CLIENT_SCOPE_CLIENT DROP CONSTRAINT FK_C_CLI_SCOPE_CLIENT;

ALTER TABLE public.CLIENT DROP CONSTRAINT FK_P56CTINXXB9GSK57FO49F9TAC;

ALTER TABLE public.CLIENT_SCOPE DROP CONSTRAINT FK_REALM_CLI_SCOPE;

ALTER TABLE public.KEYCLOAK_GROUP DROP CONSTRAINT FK_GROUP_REALM;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 96, '8:d3f4a33f41d960ddacd7e2ef30d126b3', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::13.0.0-KEYCLOAK-17992-drop-constraints::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 97, '8:1284a27fbd049d65831cb6fc07c8a783', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::13.0.0-increase-column-size-federated::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.CLIENT_SCOPE_CLIENT ALTER COLUMN CLIENT_ID TYPE VARCHAR(255) USING (CLIENT_ID::VARCHAR(255));

ALTER TABLE public.CLIENT_SCOPE_CLIENT ALTER COLUMN SCOPE_ID TYPE VARCHAR(255) USING (SCOPE_ID::VARCHAR(255));

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 98, '8:9d11b619db2ae27c25853b8a37cd0dea', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::13.0.0-KEYCLOAK-17992-recreate-constraints::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 99, '8:3002bb3997451bb9e8bac5c5cd8d6327', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-13.0.0.xml::json-string-accomodation-fixed::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.REALM_ATTRIBUTE ADD VALUE_NEW TEXT;

UPDATE public.REALM_ATTRIBUTE SET VALUE_NEW = VALUE;

ALTER TABLE public.REALM_ATTRIBUTE DROP COLUMN VALUE;

ALTER TABLE public.REALM_ATTRIBUTE RENAME COLUMN VALUE_NEW TO VALUE;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', NOW(), 100, '8:dfbee0d6237a23ef4ccbb7a4e063c163', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-14.0.0.xml::14.0.0-KEYCLOAK-11019::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_OFFLINE_CSS_PRELOAD ON public.OFFLINE_CLIENT_SESSION(CLIENT_ID, OFFLINE_FLAG);

CREATE INDEX IDX_OFFLINE_USS_BY_USER ON public.OFFLINE_USER_SESSION(USER_ID, REALM_ID, OFFLINE_FLAG);

CREATE INDEX IDX_OFFLINE_USS_BY_USERSESS ON public.OFFLINE_USER_SESSION(REALM_ID, OFFLINE_FLAG, USER_SESSION_ID);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', NOW(), 101, '8:75f3e372df18d38c62734eebb986b960', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-14.0.0.xml::14.0.0-KEYCLOAK-18286::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', NOW(), 102, '8:7fee73eddf84a6035691512c85637eef', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-14.0.0.xml::14.0.0-KEYCLOAK-18286-revert::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', NOW(), 103, '8:7a11134ab12820f999fbf3bb13c3adc8', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-14.0.0.xml::14.0.0-KEYCLOAK-18286-supported-dbs::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_CLIENT_ATT_BY_NAME_VALUE ON public.CLIENT_ATTRIBUTES(NAME, (value::varchar(250)));

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', NOW(), 104, '8:c0f6eaac1f3be773ffe54cb5b8482b70', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-14.0.0.xml::14.0.0-KEYCLOAK-18286-unsupported-dbs::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', NOW(), 105, '8:18186f0008b86e0f0f49b0c4d0e842ac', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-14.0.0.xml::KEYCLOAK-17267-add-index-to-user-attributes::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_USER_ATTRIBUTE_NAME ON public.USER_ATTRIBUTE(NAME, VALUE);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', NOW(), 106, '8:09c2780bcb23b310a7019d217dc7b433', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-14.0.0.xml::KEYCLOAK-18146-add-saml-art-binding-identifier::keycloak
SET SEARCH_PATH TO public, "$user","public";

-- WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', NOW(), 107, '8:276a44955eab693c970a42880197fff2', 'customChange', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-15.0.0.xml::15.0.0-KEYCLOAK-18467::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.REALM_LOCALIZATIONS ADD TEXTS_NEW TEXT;

UPDATE public.REALM_LOCALIZATIONS SET TEXTS_NEW = TEXTS;

ALTER TABLE public.REALM_LOCALIZATIONS DROP COLUMN TEXTS;

ALTER TABLE public.REALM_LOCALIZATIONS RENAME COLUMN TEXTS_NEW TO TEXTS;

ALTER TABLE public.REALM_LOCALIZATIONS ALTER COLUMN  TEXTS SET NOT NULL;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', NOW(), 108, '8:ba8ee3b694d043f2bfc1a1079d0760d7', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-17.0.0.xml::17.0.0-9562::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_USER_SERVICE_ACCOUNT ON public.USER_ENTITY(REALM_ID, SERVICE_ACCOUNT_CLIENT_LINK);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', NOW(), 109, '8:5e06b1d75f5d17685485e610c2851b17', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-18.0.0.xml::18.0.0-10625-IDX_ADMIN_EVENT_TIME::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_ADMIN_EVENT_TIME ON public.ADMIN_EVENT_ENTITY(REALM_ID, ADMIN_EVENT_TIME);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', NOW(), 110, '8:4b80546c1dc550ac552ee7b24a4ab7c0', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-19.0.0.xml::19.0.0-10135::keycloak
SET SEARCH_PATH TO public, "$user","public";

-- WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('f1e29715-91d7-4f2a-b11f-c10786f737e5', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('26320feb-8a5d-49e4-80c5-20eb7428a11e', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('7ce7cdda-311e-44c7-b47f-180ca8314548', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('c2d24d3f-65ca-46de-9cd8-3eeb71a7f83d', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('7d86da86-b107-4ec7-bfe7-84f202d4030c', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('647aa742-d849-41d2-b174-c06b59e6d5b6', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('21529800-33dd-11eb-adc1-0242ac120002', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('14cac0be-1218-4f9a-9de6-e492c13f5fba', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('4e8f751d-5caa-489f-a281-636b56576cee', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('586ad4d3-c063-4df0-91c1-9d4ab64da7ca', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('28b4c88c-a847-4176-b252-6c58b36c1ff0', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('58bb9963-f040-4217-b080-002ab0ef6b65', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('349dad8b-6e03-4f22-8368-50a43ba08f6f', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('411709bb-52a0-4466-80ec-0350007b2033', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('8c12290d-d62f-48ce-913b-c93bf995ca59', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('da893beb-6ac7-420d-b51b-f05dadf56bbc', 'post.logout.redirect.uris', '+');

INSERT INTO public.client_attributes (CLIENT_ID, NAME, VALUE) VALUES ('79c518d7-b41a-4e6f-be42-4ef365824100', 'post.logout.redirect.uris', '+');

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', NOW(), 111, '8:af510cd1bb2ab6339c45372f3e491696', 'customChange', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-20.0.0.xml::20.0.0-12964-supported-dbs::keycloak
SET SEARCH_PATH TO public, "$user","public";

CREATE INDEX IDX_GROUP_ATT_BY_NAME_VALUE ON public.GROUP_ATTRIBUTE(NAME, (value::varchar(250)));

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', NOW(), 112, '8:05c99fc610845ef66ee812b7921af0ef', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-20.0.0.xml::20.0.0-12964-unsupported-dbs::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', NOW(), 113, '8:314e803baf2f1ec315b3464e398b8247', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-20.0.0.xml::client-attributes-string-accomodation-fixed::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.CLIENT_ATTRIBUTES ADD VALUE_NEW TEXT;

UPDATE public.CLIENT_ATTRIBUTES SET VALUE_NEW = VALUE;

ALTER TABLE public.CLIENT_ATTRIBUTES DROP COLUMN VALUE;

ALTER TABLE public.CLIENT_ATTRIBUTES RENAME COLUMN VALUE_NEW TO VALUE;

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', NOW(), 114, '8:56e4677e7e12556f70b604c573840100', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-21.0.2.xml::21.0.2-17277::keycloak
SET SEARCH_PATH TO public, "$user","public";

-- WARNING The following SQL may change each run and therefore is possibly incorrect and/or invalid:
UPDATE public.required_action_provider SET ALIAS = 'TERMS_AND_CONDITIONS', PROVIDER_ID = 'TERMS_AND_CONDITIONS' WHERE ALIAS='terms_and_conditions';

UPDATE public.user_required_action SET REQUIRED_ACTION = 'TERMS_AND_CONDITIONS' WHERE REQUIRED_ACTION='terms_and_conditions';

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', NOW(), 115, '8:8806cb33d2a546ce770384bf98cf6eac', 'customChange', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-21.1.0.xml::21.1.0-19404::keycloak
SET SEARCH_PATH TO public, "$user","public";

ALTER TABLE public.RESOURCE_SERVER_POLICY ALTER COLUMN DECISION_STRATEGY TYPE SMALLINT USING (DECISION_STRATEGY::SMALLINT);

ALTER TABLE public.RESOURCE_SERVER_POLICY ALTER COLUMN LOGIC TYPE SMALLINT USING (LOGIC::SMALLINT);

ALTER TABLE public.RESOURCE_SERVER ALTER COLUMN POLICY_ENFORCE_MODE TYPE SMALLINT USING (POLICY_ENFORCE_MODE::SMALLINT);

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', NOW(), 116, '8:fdb2924649d30555ab3a1744faba4928', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', 'EXECUTED', NULL, NULL, '4.16.1', '0808329493');

-- Changeset META-INF/jpa-changelog-21.1.0.xml::21.1.0-19404-2::keycloak
SET SEARCH_PATH TO public, "$user","public";

INSERT INTO public.databasechangelog (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', NOW(), 117, '8:1c96cc2b10903bd07a03670098d67fd6', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', 'MARK_RAN', NULL, NULL, '4.16.1', '0808329493');

