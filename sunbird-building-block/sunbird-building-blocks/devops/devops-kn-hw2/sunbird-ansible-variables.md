
### Ansible inventory structure in private repo

```
ansible
└── inventory
    └── dev
        ├── Core
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        ├── DataPipeline
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        └── KnowledgePlatform
            ├── common.yml
            ├── hosts
            └── secrets.yml
```
Same directory structure needs to be followed in Jenkins jobs aswell.  ex: Build/Core/jobname, Artifcatupload/Core/jobname, Deploy/dev/Core/jobname.

 **common.yml**  : Any variables which needs to be overriden or if its a private variable we need update this variables in common.yml. ex: ingress ip, env name, domain name etc

 **secret.yml:**  secrets variables are updated in this file. ex:  storage keys, api keys, postgress pasword, registry secrets etc. secrets.yml is encrypted with ansible vault. below are the command to edit, encrypt, decrypt vault file.


```
ansible-vault <edit/encrypt/decrypt> ansible/inventory/dev/KnowledgePlatform/secrets.yml --vault-password-file <vault-password-file>
```

### Ansible Variables
Read about Ansible variables and its precedence from Ansible documnet [https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable)

 **default variables** :  added in ansible roles defaults file

 **group variables** : its added in all.yml and private repo common.yml

 **extra variables**  are passed from jenkins file, while running the ansible playbooks [https://github.com/project-sunbird/sunbird-devops/blob/0fd5d9a4da250ce4ac5eafad8a2aecc823c28a0d/kubernetes/pipelines/deploy_core/Jenkinsfile#L25](https://github.com/project-sunbird/sunbird-devops/blob/0fd5d9a4da250ce4ac5eafad8a2aecc823c28a0d/kubernetes/pipelines/deploy_core/Jenkinsfile#L25)







*****

[[category.storage-team]] 
[[category.confluence]] 
