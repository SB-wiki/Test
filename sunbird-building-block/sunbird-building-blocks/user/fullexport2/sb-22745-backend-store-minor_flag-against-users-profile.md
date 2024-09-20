
* Currently consent is asked at 2 levels > content level and org level. In either of the cases don't ask the consent to the user if their age is below 18.


* PII of minors is protected, and not shared without parental consent. So existing user's who are now identified as minor's shouldn't come in the reports.


* The front end will capture the year of birth of the user (during registration or on boarding) - which needs to be stored by the backend.


* Introduce a ‘Minor-Flag’ in user read api response, which will be populated based on whether or not the user is above the age of 18





Solution:


* User table has a column ‘dob’ which can be used to store the year of birth along with month and date as ‘12-31'. UI will pass only the year of birth and backend will append the rest, which is configured in property file.



For example: If UI sends 2001, dob value will be ‘2001-12-31’


* MinorFlag can be calculated on the fly, this will help to avoid creating a batch job to keep the flag updated in Jan 1st of every year. When a user read request is made, calculate the minor flag and add in response.



For example, If the dob is stored as  ‘2004-12-31’, the minor flag will return 'true', until 2023 jan 1st.





*****

[[category.storage-team]] 
[[category.confluence]] 
