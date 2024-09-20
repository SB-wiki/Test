# Jenkins-Setup

**Jenkins Setup – First Run**

1. SSH to the Jenkins server

\| **git clone https://github.com/project-sunbird/sunbird-devops.git** **cd sunbird-devops && git checkout tags/release-2.0.0 -b release-2.0.0** **cd deploy/jenkins** **sudo bash jenkins-server-setup.sh** |

2. Once the **jenkins-server-setup.sh** script completes, open jenkins in browser by typing **domain-name:8080 / public-ip:8080**
3. Enter the initial password. Follow the on screen instructions.
4. Choose install suggested plugin
5. Create a admin user
6. Choose the default jenkins URL. You can either change this to your domain name or public IP. If in doubt, just use whatever is displayed on screen as this can be changed later if required in Jenkins configuration.
7. Switch back to the terminal session on the Jenkins server

\| **sudo bash jenkins-plugins-setup.sh** _**Enter the URL as localhost:8080**_ _**Enter the admin username and password**_ |

8. Now go to Manage Jenkins -> Manage Plugins -> Update Center -> Check status of plugin install. If any plugins failed to install, install them manually by visiting the plugins section of Jenkins
9. Now switch back to the terminal session on the Jenkins server

\| **cp envOrder.txt.sample envOrder.txt** **vi envOrder.txt** |

10. Update the environment list as per your infrastructure in ascending order. For example if you have only dev and production, your **envOrder.txt** will look like

\|   **dev=0** \*\* production=1\*\* |

11. Now run the **jenkins-jobs-setup.sh** script

\| **sudo bash jenkins-jobs-setup.sh** |

12. Follow the onscreen instruction of the script. Provide choice as yes for all questions. The options are case sensitive, the script will display the accepted options.
13. Once the script completes copying the job config, go to the browser and restart jenkins using  **public-ip:8080/restart OR domain-name:8080/restart**
14. Go to **http://\<jenkins\_domain>/credentials/store/system/domain/\_/newCredentials**
15. Select Username with Password
16. Enter the username and password of the github account where the private repo will be hosted.
17. Enter a unique long string for the ID field such as **private-repo-creds**
18. You can provide the description as private repo credentails and click OK.
19. **Goto http://\<jenkins\_domain>/configure**
20. Choose the check box named “Environment variables”
21. Click on Add and enter the following Name, Value pairs

| **Name**                         | **Value**                                                                                                                                                                                                                                                                       |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ANSIBLE\_FORCE\_COLOR**        | true                                                                                                                                                                                                                                                                            |
| **ANSIBLE\_HOST\_KEY\_CHECKING** | false                                                                                                                                                                                                                                                                           |
| **ANSIBLE\_STDOUT\_CALLBACK**    | debug                                                                                                                                                                                                                                                                           |
| **hub\_org**                     | docker hub organization / username eg: In sunbird/player image, sunbird is the hub\_org                                                                                                                                                                                         |
| **private\_repo\_branch**        | The branch name in the private repository which you would like to use. This branch will have the inventory and secrets                                                                                                                                                          |
| **private\_repo\_credentials**   | The unique string which you provided for ID field while entering the github repo credentials. eg:  **private-repo-creds**                                                                                                                                                       |
| **private\_repo\_url**           | The github URL to your private repo. You can visit your private repo and click on clone button, which will display the https URL to your private repository. Only https URL is currently supporrted.                                                                            |
| **public\_repo\_branch**         | This is the branch or tag from where Jenkinsfile will be picked up. You can set this value as refs/tags/release-1.14.0 if you want to build from tags or provide the value of development branch like release-1.15 (not recommened since development branches are not stable).  |
| **override\_private\_branch**    | true                                                                                                                                                                                                                                                                            |
| **override\_public\_branch**     | true                                                                                                                                                                                                                                                                            |

22. Scroll down to “Global Pipeline Libraries” section and click Add. Provide the values as below

| **Name**                   | Value                                                                                                                                                                                                                                                                                                                                                  |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Library Name**           | deploy-conf                                                                                                                                                                                                                                                                                                                                            |
| **Default version**        | Tag name of the jenkins shared library. This should be same version of the release you are going to build and deploy. For example, if you decide to use tags release-2.0.0 as your base, jenkins shared library tag will be release-2.0.0-shared-lib. When you upgrade to tag release-2.1.0, this value should get changed to release-2.1.0-shared-lib |
| **Retrieval method**       | Modern SCM                                                                                                                                                                                                                                                                                                                                             |
| **Source Code Management** | Git                                                                                                                                                                                                                                                                                                                                                    |
| **Project Repository**     | [https://github.com/project-sunbird/sunbird-devops.git](https://github.com/project-sunbird/sunbird-devops.git)                                                                                                                                                                                                                                         |

23. Click on Save and go to Manage Jenkins -> Configure global security
24. Choose the “Markup Formatter” as “Safe HTML”
25. Go to Manage Jenkins -> Manager Nodes -> Click master -> Click Configure -> Provide labels as “ **build-slave** ”
26. Set the number of executors to a number like 15 if your system configuration is 16 GB RAM and 4 core CPU. Adjust this number accordingly based on your system configuration
27. Restart jenkins by running  **sudo service jenkins restart**
28. Switch back to the terminal session on Jenkins server

\| **sudo su jenkins** **mkdir -p /var/lib/jenkins/secrets && cd /var/lib/jenkins/secrets** **touch deployer\_ssh\_key ops\_ssh\_key vault-pass** **chmod 400 deployer\_ssh\_key ops\_ssh\_key vault-pass** |

29. The key which you used to login to the Jenkins server will be called as **ops\_ssh\_key** from now on wards. Example:

\| **ssh -i somekey.pem ubuntu@jenkins-server-ip** Here _**somekey.pem**_ is the key you used to login to the Jenkins server which will be called as **ops\_ssh\_key** |

30. Copy the contents of the key you used to connect to VM into **ops\_ssh\_key** file
31. Create a new ssh key on your local machine or any server. We will use this for a user named **deployer** (or any name you like)
32. **ssh-keygen -f deployer\_ssh\_key** (passphrase should be empty)
33. Copy the contents of the **deployer\_ssh\_key** into **/var/lib/jenkins/secrets/deployer\_ssh\_key**
34. If your github private repo consists of ansible encrypted files, then enter the decryption password in **/var/lib/jenkins/secrets/vault-pass** . If there are no encrypted files, then enter some random value like **12345** into the **vault-pass** file. This file cannot be empty.
35. Restart Jenkins server
36. **IMPORTANT: OPEN any one of the config file from Deploy directory and save it. Without this some of the parameters will not be visible.**
37. Follow the next set of steps to create inventory, secrets and ansible hosts in the private repo.

***

\[\[category.storage-team]] \[\[category.confluence]]
