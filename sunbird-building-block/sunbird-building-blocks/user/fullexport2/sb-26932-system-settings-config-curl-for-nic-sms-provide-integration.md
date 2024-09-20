
## Curl to update System Setting table for smsTemplateConfig



```
curl --location --request POST '{{host}}/api/data/v1/system/settings/set' \
--header 'Content-Type: application/json' \
--header 'Authorization: {{api-auth-key}}' \
--header 'x-authenticated-user-token: {{keycloak-auth-token}}' \
--data-raw '{
  "request": {
                "id": "smsTemplateConfig",
                "field": "smsTemplateConfig",
                "value": "{\"91SMS\":{\"OTP to verify your phone number on $installationName is $otp. This is valid for $otpExpiryInMinutes minutes only.\":\"1307161224258194219\",\"OTP to reset your password on $installationName is $otp. This is valid for $otpExpiryInMinutes minutes only.\":\"1307161253593694015\",\"Your ward has requested for registration on $installationName using this phone number. Use OTP $otp to agree and create the account. This is valid for $otpExpiryInMinutes minutes only.\":\"1307161253600214425\",\"Welcome to $instanceName. Your user account has now been created. Click on the link below to  set a password  and start using your account: $link\":\"1307161353857474082\",\"You can now access your diksha state teacher account using $phone. Please log out and login once again to see updated details.\":\"1307161353855560999\",\"VidyaDaan: Your nomination for $content has not been accepted. Thank you for your interest. Please login to https:\\/\\/vdn.diksha.gov.in for details.\":\"1307161353848661841\",\"VidyaDaan: Your nomination for $content is accepted. Please login to https:\\/\\/vdn.diksha.gov.in to start contributing content.\":\"1307161353863933335\",\"VidyaDaan: Your Content $content has not been approved by the project owner. Please login to https:\\/\\/vdn.diksha.gov.in for details.\":\"1307161353861214243\",\"VidyaDaan: Your Content $content has been approved by the project owner.\":\"1307161353859625404\",\"VidyaDaan: Your Content $contentName for the project $projectName has been approved by the project owner. Please login to $url for details.\":\"1307162444865933051\",\"VidyaDaan: Your Content $contentName for the project $projectName has been approved by the project owner with few changes. Please login to $url for details.\":\"1307162444868558038\",\"VidyaDaan: Your Content $contentName has not been accepted by your organization upon review. Please login to $url for details.\":\"1307162400992655061\",\"All your diksha usage details are merged into your accountAll your diksha usage details are merged into your account $installationName . The account $account has been deleted\":\"1307161353851530988\",\"Use OTP $otp to edit the contact details for your Diksha profile.\":\"1307163542373112822\"},\"NIC\":{\"NCERT: OTP to verify your phone number on $installationName is $otp. This is valid for $otpExpiryInMinutes minutes only.\":\"1007162851000583212\",\"NCERT: OTP to reset your password on $installationName is $otp. This is valid for $otpExpiryInMinutes minutes only.\":\"1007162851007549778\",\"NCERT: Your ward has requested for registration on $installationName using this phone number. Use OTP $otp to agree and create the account. This is valid for $otpExpiryInMinutes minutes only.\":\"1007162851045686096\",\"NCERT: Welcome to $instanceName. Your user account has now been created. Click on the link below to  set a password  and start using your account: $link\":\"1007162805254274946\",\"NCERT: You can now access your diksha state teacher account using $phone. Please log out and login once again to see updated details.\":\"1007162849410876095\",\"NCERT: Your nomination for $content has not been accepted. Thank you for your interest. Please login to $url for details.\":\"1007162805271660929\",\"NCERT: Your nomination for $content is accepted. Please login to $url to start contributing content.\":\"1007162805276881827\",\"NCERT: Your Content $content has not been approved by the project owner. Please login to $url for details.\":\"1007162805282556398\",\"NCERT: Your Content $contentName for the project $projectName has been approved by the project owner. Please login to $url for details.\":\"1007162805293127426\",\"NCERT: Your Content $contentName for the project $projectName has been approved by the project owner with few changes. Please login to $url for details.\":\"1007162805289863491\",\"NCERT: Your Content $contentName has not been accepted by your organization upon review. Please login to $url for details.\":\"1007162805285679055\",\"NCERT: All your diksha usage details are merged into your account $installationName . The account $account has been deleted\":\"1007162851061503958\"}}"
           
            }
}'

```






*****

[[category.storage-team]] 
[[category.confluence]] 
