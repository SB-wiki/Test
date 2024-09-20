# Setting-stronger-rules-for-password-(Ref--SC-1319)

### About&#x20;

The current user created in sunbird has no password policies associated with it. And we want to set some stronger set of rules for password.  [SC-1319 System JIRA](https://browse/SC-1319)

### Why Stronger password policy&#x20;

In sunbird users can set their password as they want. Such settings are fine for development but unacceptable in production environment. Consequences of insecure password can include the loss of personal data.

### Proposed set of rules for password

1. Minimum of 8 characters
2. At least 1 numeric value
3. At least one special character

Suggestion (To include the below password policy)

1. The password is not allowed to be the same as username.

What is not changing?

1. Changing password policy will not affect the existing user password, until they try to reset their password.

What is changing?

1. Password policy for sunbird user via keycloak
2. new user will be forced to provide the strong password as per our password policy

Password policy types (Default provided by keycloak)  Ref :  [https://www.keycloak.org/docs/latest/server\_admin/index.html#\_password-policies](https://www.keycloak.org/docs/latest/server\_admin/index.html#\_password-policies)

1. HashAlgorithm (Passwords are not set as clear plain text, instead hashed using standard hash algorithm)
2. Hashing Iterations (Specifies the number of times password will be hashed before it stored , default is 20000)
3. Digits (Number of digits required to be in password)
4. Lowercase characters (Number of lowercase letters required to be in password)
5. Uppercase characters (Number of uppercase letters required to be in password)
6. Not Username (password should not be same as username)
7. Regular expression (define Perl regular expression to match the password pattern)
8. Expire password (The number of days for which the password is valid)
9. Not Recently Used (it stores the history of password)
10. Password Blacklist (This policy checks , if given password contains in blacklist file)

Steps for setting password policy in keycloak

| SNo. | Steps                                                   | Screen                                                                        |
| ---- | ------------------------------------------------------- | ----------------------------------------------------------------------------- |
| 1    | Login to admin console                                  | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-9-29.png)  |
| 2    | Select the Realm                                        | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-17-1.png)  |
| 3    | Go to Authentication tab on left side of admin console  | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-15-51.png) |
| 4    | Go to Password Policy tab on top of Authentication page | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-21-58.png) |

\| | 5 | Click on Add Policy drop down menu and add the policy | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-24-51.png)

\| | 6 | Add Minimum Length policy | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-25-42.png)

\| | 7 | Add Digits Policy | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-26-26.png)

\| | 8 | Add Special Character Policy | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-27-11.png)

\| | 9 | Click on save Button | ![](../../../../User/Fullexport2/images/storage/image2019-9-25\_15-28-49.png)

|

### Open Question

1. Do we force logout/reset password for existing user

Implementation Design :&#x20;

[https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/1122566187/Stronger+rule+of+password+SC-1345](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/1122566187/Stronger+rule+of+password+SC-1345)

***

\[\[category.storage-team]] \[\[category.confluence]]
