# Data-Encryption

### \*

* [Problem Statement:](data-encryption.md#problem-statement:)
* [Solution for point 1:](data-encryption.md#solution-for-point-1:)
* [Solution for point 2: ](data-encryption.md#solution-for-point-2: )
* [Solution for point 3: ](data-encryption.md#solution-for-point-3: )
* [Solution for point 4: ](data-encryption.md#solution-for-point-4: )
* [Approach 2:](data-encryption.md#approach-2:) Background  In sunbird all user private data are stored as encrypted.  Currently sunbird is using **Salt**   based encryption service and there is only one salt is used for data encryption and decryption.

### Problem Statement:

New encryption service is using multi key based encryption. So now user private data can be encrypted with different-2 key value. This will lead following problems:

1. &#x20;User search using email , phone and userName or get user by email, phone
2. Get user by externalid, idType and provider
3. Providing user search response with decrypted attribute.
4. Checking user phone and email uniqueness

### Solution for point 1:

&#x20; User data will be encrypted with different keys and store inside elasticsearch. During search by phone,email or userName , incoming value will be encrypted with all existing keys and list will be provided to ES for match.

&#x20;Because email,phone or userName are unique in system , so either one or zero record will match. Same record can be pass to user.

&#x20;Note:

&#x20; 1\. For any user we are always showing masked email, masked phone , so no need to decrypt it , only decryption need to perform for username.

&#x20; 2\. Search with email,phone and username will have some performance impact.

### Solution for point 2:&#x20;

&#x20;As requested by Rahul , no need to store user external id as encrypted , so there is no issue of encryption and decryption here.

### Solution for point 3:&#x20;

&#x20;As of now in user search we are doing decryption of username only , other fields email and phone are coming as masked value. In System user name is not mandatory and during login as well we are not asking user to use user name, instead we are asking for phone or email based login. Due to system generated user name it's difficult for user to remember it. Other user also can't identify user based on username.

Example: I created a user with first name as Amit and another person also created user with firstName as Amit, So user name can be amit2134 and amit3245.

### Solution for point 4:&#x20;

&#x20;Phone and email uniqueness can be done as suggested in Point 1.

### Approach 2:

&#x20;Define salt value for each tenant and one for default(custodian). in that way we can use multi key to encrypt data and each tenant data will be encrypted with same key always.

| Pros | Cons​​ |
| ---- | ------ |
|      |        |

1. User search can be done with private data

|

1. Search response time will increase
2. Still we can't perform phone and email uniqueness check

|

***

\[\[category.storage-team]] \[\[category.confluence]]
