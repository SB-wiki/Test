# Design-doc-to-support-license-attribute-in-org-(SB-15446)

### \*

* [Solution:](design-doc-to-support-license-attribute-in-org-sb-15446.md#solution:) Problem statement:  Each channel need to have license attribute , that can be consumed by content creator during content creation time. Content creator can either select license attached with channel or he/she can select another license from list of available license.

### Solution:

1. &#x20;Supporting an extra attribute during org creation (license as text) , this attribute is optional and if passed by user system will have only null/empty validation.
2. &#x20;This attribute will be applicable for rootOrg only , if passed for suborg creation/updation system will silently ignore it.
3. license attribute can be passed during rootOrg update call as well.
4. If license attribute is coming during rootOrg creation time then system will pass license attribute in channel registration api.
5. &#x20;If license is passed during updated org api call then system will make update channel api call to update license details.
6. Incase channel registration/updation api failed then system won't do any further processing , it will throw error to caller.
7. System is not going to store license value inside organisation.

Notes: inside user-service we are taking attribute as "license" and knowledge platform (Kp) is using this attribute as "defaultLicense".

***

\[\[category.storage-team]] \[\[category.confluence]]
