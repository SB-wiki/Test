# CDN-Approach-for-design-system

### Problem Statement

Currently, each channel ( Portal, Editors, Players, Keycloak, Static site, Help center, etc ) has its own CSS codebase and therefore following challenges occur -

* To keep design consistency across all the channels, the team has to do changes in all codebases.
* Keeping all codebases in sync is difficult.&#x20;

### Proposed Solutions

A CDN and package.json GitHub branch dependency of the design system created ( [https://sunbird-ed.github.io/sunbird-style-guide/dist/](https://sunbird-ed.github.io/sunbird-style-guide/dist/) ).&#x20;

### Implementation

The CSS code will be maintained in the Design system repo only. It will follow the Sunbird's branching strategy. i.e. Each release will have its own branch. At the end of each release, the version tag will be created to do the code freeze.

#### NPM&#x20;

* This design system repo branches will be used as the package.json dependency in all the channels. Eg -&#x20;

```js
// package.json
...
"dependencies": {
	...
	"sb-design-system": "Sunbird-Ed/sunbird-style-guide#2.2.0",
	...
}
...
```

* For each release, this branch reference ( **#2.2.0** in the above example ) will be updated in the package.json with the relevant version branch.
* To pull the latest changes, will have to delete **node\_modules** folder and do the  **npm install** again.
* For the Developers who are contributing to the Design system - they can use **npm link** ( [https://docs.npmjs.com/cli/link](https://docs.npmjs.com/cli/link) )  to make a symlink to see the real-time changes.

Why GitHub branch as a dependency over NPM package publishing?NPM packages cannot be updated without version changing. Every time the change is made, a version (minor, medium, major ) jump will be there so 2 challenges -

* It will not be possible to keep the NPM package version number same as Sunbird release version.
* Every time the package-lock.json needs to be updated.

#### CDN

* For each release, a versioned file will be there on the CDN server.  Eg - [https://cdn.sunbirded.org/2.2.0/styles.min.css](https://cdn.sunbirded.org/2.2.0/styles.min.css) or [https://cdn.sunbirded.org/3.2.0/styles.min.css](https://cdn.sunbirded.org/3.2.0/styles.min.css)
* Each version will have its own folder in the name of version no. itself. Eg - **/2.2.0/styles.min.css or /2.4.0/styles.min.css**
* For each git commit, the CI build will be triggered from respective version branch and therefore respective dev CDN version will be updated. Upon approval, these version builds will be promoted to the staging, pre-prod and prod CDN servers.
* These versioned CDN URLs can be directly used in any projects by simply adding in the HTML. Eg -&#x20;

```xml
<link rel="stylesheet" type="text/css" href="https://cdn.sunbirded.org/3.2.0/styles.css">
```

### What are the benefits, user will get from using these NPM dependencies and CDN's?

There might be some cases where entire CSS might not be required. It may require a few components or layouts or fonts only.  So here is the folder structure for CDN and NPM Dependency -

```bash
base.css	# Only contains the reusable utility classes. like margins, paddings, display, positions, typography, labels etc.
common.css	# Common = base.css + layout.css
components/
	|- accordian.css	# Only contains accordion code
	|- banner.css
  	|- breadcrumb.css
  	|- cards.css
  	|- pagesections.scss
	|- ...
components.css	# Concated code of above components folder css files
fonts/
	|- notosans.css	# Base64 encoded font files
	|- notonastaliq.css
	|- notobengali.css
	|- ...
fonts.css	# Concated code of above fonts folder css files
layout.css # containers, layout base structures, header, footer etc.,
pages/     # individual page UI css, for example offline help center styles, CBSE program styles
	|- helpcenter.css
	|- ...
pages.css	# Concated code of above fonts folder css files
semantic-merged.css	# semantic-merged.css = semantic.min.css + Customization Override code + RTL overrides of Semantic
styles.css # All styles concated into styles.css
variables.css # Only contains the CSS & sass variables used for all UI components in Design System.
vendors/  # thirdparty plugins used
	|- slick.css
	|- izitoast.css
	|- ...
vendors.css	# Concated code of above vendor folder css files
```

### Usage

#### CDN

* If you would like to use the entire design system you can use by adding the following code in the head of the HTML. Eg-&#x20;

```xml
<link rel="stylesheet" type="text/css" href="https://cdn.sunbirded.org/3.2.0/styles.css">
```

* If you would like to use certain components only and nothing else, you will require variables and those components CSS files. Eg -&#x20;

```xml
<link rel="stylesheet" type="text/css" href="https://cdn.sunbirded.org/3.2.0/variables.css">
<link rel="stylesheet" type="text/css" href="https://cdn.sunbirded.org/3.2.0/components/cards.css">
```

* If you would like to use only Noto Sans (English) font, you can use -&#x20;

```xml
<link rel="stylesheet" type="text/css" href="https://cdn.sunbirded.org/3.2.0/fonts/notosans.css">
```

* If you would like to use concated Noto Sans fonts of all languages you can use -&#x20;

```xml
<link rel="stylesheet" type="text/css" href="https://cdn.sunbirded.org/3.2.0/fonts.css">
```

#### NPM

* Add the dependency in package.json file and do npm i -&#x20;

```js
// package.json
...
"dependencies": {
	...
	"sb-design-system": "Sunbird-Ed/sunbird-style-guide#2.2.0",
	...
}
...
```

* Add stylesheet in angular.json file -&#x20;

```js
// angular.json
...
"styles": [
	...
	"node_modules/docs/src/assets/styles/styles.scss"
	...
]
...
```

falseRedIn Progress

Related Jira Ticket - [SB-13649 System JIRA](https://browse/SB-13649)

***

\[\[category.storage-team]] \[\[category.confluence]]
