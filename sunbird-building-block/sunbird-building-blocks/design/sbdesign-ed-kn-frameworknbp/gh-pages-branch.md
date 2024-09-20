# gh-pages-branch

* This branch will store the generated site
* Only the updated version folder will get updated.
* latest stable/ & 1.9 ( latest version no.) folder will be duplicate symlinked.&#x20;
* Purpose of creating latest/ folder is that if someone refers the latest URL somewhere, the user lands to latest docs always.
* the base url of each version will be the version folder.
  * &#x20;Eg - For `docs.sunbird.org/1.8/features/administrator/dashboard` will be `/1.8/`
  * The reason is it easy to understand docs team&#x20;

### Folder structure

```
index.html
widgets.json
css/
js/
images/
robots.txt
CNAME
latest/
1.9/
1.8/
```

***

\[\[category.storage-team]] \[\[category.confluence]]
