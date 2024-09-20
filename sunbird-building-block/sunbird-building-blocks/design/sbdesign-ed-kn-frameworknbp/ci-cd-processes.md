# CI-CD-Processes

* Only modified or added branch will be built and updated to the staging and prod instances.
* To include or remove any of the version -
  * widgets.json file will need to be updated (Not in release 1.9)
  * if removed - the robots.txt file will have to be updated
* Each build will pull theme so that each version gets same HTML/CSS (Not in release 1.9)
* CircleCI will listen to changes of all branches except gh-pages.
* No tag based deployment.&#x20;
* Commit id will be inserted in the footer with the text "Build from commit " so that info is available from which commit it was build

There will be 3 build pipelines for Docs -&#x20;

* **Version** - build and deploy version branches after any modification
* **PR** - this will build and deploy preview site for pr
* **TOC** - whenever a toc branch is updated this build will be triggered

We are not considering build pipeline for main / marketing site in this release (1.9).&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
