# Ansible-Variables-Updates

**Steps to follow:** **Updating variables**

1. **git clone https://github.com/project-sunbird/sunbird-devops**
2. **git checkout tags/release-1.14.0 -b release-1.14.0**
3. **git checkout tags/release-2.0.0 -b release-2.0.0**
4. **cd sunbird-devops/private\_repo**
5. \*\*git diff release-1.14.0 ansible \*\*   OR  **git diff --word-diff=porcelain release-1.14.0 ansible**

This will show the differences in variables between release-2.0.0 and release-1.14.0. If the line is in green, it means its newly added. If the line is in red, it means it has been removed.

Optional: Create a new branch in your private repo (In order to keep a older inventory copy as backup)

Update your private repo with the new variables and inventory group name changes as show by the diff command. Commit your changes and push it to your private repo branch.

***

\[\[category.storage-team]] \[\[category.confluence]]
