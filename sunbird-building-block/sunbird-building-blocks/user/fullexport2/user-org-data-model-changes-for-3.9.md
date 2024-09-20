 **ORG** \[orgId, orgType, isTenant]  **_// expanded orgType definition_** orgType is a bitset which represents multiple aspects about the type of the org. E.g. a board can be a sourcing org as well a contribution org, a large school could also be a sourcing org. Basically the data model supports multiple combinations and support adding more bits in future for representing additional aspects.


* Bit 1 → isContributor    // indicates whether the org contributes content or not


* Bit 2 → isSchool            // indicates whether the org is a school or not


* Bit 3 → isBoard             // indicates whether the org is a board or not


* Bit 4 → isContributionOrg // whether the org is a contribution org or not, reusable for VDN. Need to check impact of making content orgs non-root before separating content orgs from boards.


* Bit 5 → isSourcingOrg // sourcing org in case of VDN



Example orgtype data:


1. board:                     101 => 5    // assumed that board can also contribute content


1. content org:            101 => 5   // same as board for now, can change in future based on root org impact


1. School:                    010 => 2


1. School (+contributor):                   011 => 3      // future


1. board (+sourcing org):              10101 => 21    // future


1. school (+sourcing org):             10010 => 18    // future



Notes:


* The code should interpret this bitset and return a map of flags - isBoard → true, isSchool → false, etc.


* In ES too it should be put in this flag structure so that it is searchable.



 **USER_ORG** (userId, orgId, associationMechanism bitset, additionalInfo)//newThis table is for capturing the association between User and Org. Various aspects that need to be answered as part of the association:


*  **How**  - sso, self declaration, invitation, system upload, workflow approval →  **associationMechanism** can be used for denoting the “How” part by using Enum which can be extended further as required. To be stored as a numeric value.


*  **Who**  - self, system →  **updatedBy** can be used for storing “who” information


*  **When**  - timestamp →  **updatedDate** can be used for storing “when” information


*  **What**  &  **any additional metadata**  - relationship label, designation, contract type, workflow details etc. → these can be stored in JSON format in  **additionalInfo** . This will not be interpreted by the user/org system.



Example use cases and value for  **associationMechanism** :


* u1, board1, sso


* u1, school1, sso


* u1, school2, self-declaration


* u2, school2, self-declaration


* u2, board2, sso


* u2, school2, sso


* u3, school3, self-declaration


* u7, board1, system-upload


* u4, contrib1, sso


* u5, contrib1, invite


* u6, contrib2, self-declaration


* u8, board2, workflow-approval



Notes:


* The code should interpret this bitset and return a map of flags - isSSO → true, isSelfDeclaration → false, etc.


* In ES too it should be put in this flag structure so that it is searchable.



 **USER_ROLE** \[userId, role, scope]  **_// as per_** [[ **_RBAC design_** |RBAC-Technical-Design]]The scope will define applicability of the role. It is a json field and can have org, project (VDN), course, subject, etc. For 3.9 it will have org alone. Existing roles from user org should be migrated here. 

Examples:


* u1, ADMIN, \[{org=board1}]


* u2, CONTRIBUTOR, \[{org=school1}] 


* u9, SOURCING_REVIEWER, \[{project=p1}, {project=p2}]





*****

[[category.storage-team]] 
[[category.confluence]] 
