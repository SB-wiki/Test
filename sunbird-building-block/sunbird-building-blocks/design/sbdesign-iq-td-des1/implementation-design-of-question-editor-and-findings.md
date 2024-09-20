# Implementation-Design-of-Question-Editor-and-findings

Confluence Doc: [Design: Separation of question-set & collection editor](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3181051923/Design+Separation+of+question-set+collection+editor)

As per the above document, we’ve finalized the following approach:

* The base editor is not required as a separate NPM package.
* The Sunbird collection editor can be imported as an NPM package into the questionSet editor or any other editor.
* All the capabilities/features of the sunbird collection editor will be available in the NPM library, even though questionSet or any other editors are not using those features.

![](../../../../Design/sbdesign-iq-td-des1/images/storage/wA2f14peneeltsly8z6pHkrUIYUT6-DXwQQqvfGvlMbyYKOVcY3jK4xfkpqDy2QlRtYtl9t\_KnjN7ELIISwIt5m2uEKx5W7Fn6HEjGOb1ZGk8F3V0HUfw22KaijR6ZXEWhJh-zy8Xrc-1NVBknxygQHslrTDpmAxx8IcInFLxBy9qi34x7\_vj0mFAajCBg)With the above approach in mind, we can separate out all the question-set-related components, and services into a new library (Question-set-editor). This way, we’ll have two separate libraries

1. **editor** (All the capabilities needs to create any content collection)
2. **Question Set Editor** (Which has all the question-set related capabilities as well as some common capabilities from collection-editor)

Currently, Collection-editor has a lot of capabilities such as creating content collections, units, fancy-tree, various players (including v1 content-player), and CSV upload. Many of the components are not required for Question Set editors such as players, and dial-code. These components are again dependent on third-party libraries.

So, when Question-set-editor imports the collection module, we need to install all the peer-dependencies listed in the collection-editor module, even if we're not using that component.

For example:- If collection-editor is dependent on the @project-sunbird/sunbird-video-player. We need to install dependent packages such as video.js, videojs-contrib-quality-levels and videojs-http-source-selector

To solve this problem, we can use the secondary entry points, it will tree-shake the unwanted code and keep the library modular so that any new user can use the required module and its dependent packages only.

Reference: [https://github.com/ng-packagr/ng-packagr/blob/main/docs/secondary-entrypoints.md](https://github.com/ng-packagr/ng-packagr/blob/main/docs/secondary-entrypoints.md#example-folder-layout-for-secondary-entry-points)

Below is the possible folder structure for the collection editor:

![](../../../../Design/sbdesign-iq-td-des1/images/storage/PFv4p0gK1t6r\_uSN70YuDggBwkqkoIXIEWrV6QNyjSAIlIrkSGxLvwEa7e8BT1i2ipFeULiVIg9TRWRvddM4MTQn02VEY2XAUQ\_Ii7RuO\_PMNp4mo2\_LkMaJhWjgGZY2xXDcCcHK0kibFeQKXcqeh8n4hmVxndvhqSMgmabqdU0ObK8tNvkIvY8heZzCzQ)Check out how it is beneficial for any library to have a secondary entry point

As part of the above POC, the following scenarios are checked:

1. Use the core library
2. Use the core library with a secondary point
3. Use a core library having peer-dependency
4. Use a secondary point with a peer-dependency
5. Use a secondary point in the lazy-loaded route
6. Test if a core library has some services. The dial-code module (secondary entry point) also depends on the core services.
7. Test if the core library has some services. The client component (let's say the question component) also depends on the core services.
8. Check if all tests are running correctly for all the components (including secondary entry points)
9. Test whether the internal use of components between secondary points works properly

All these scenarios are tested here: [https://github.com/itsvick/building-block](https://github.com/itsvick/building-block)

Identify a list of external libraries required for each editor after separation

**Collection-editor:**

1. @project-sunbird/sunbird-epub-player-v9
2. @project-sunbird/sunbird-pdf-player-v9
3. @project-sunbird/sunbird-video-player-v9
4. epubjs
5. export-to-csv
6. video.js
7. videojs-contrib-quality-levels
8. videojs-http-source-selector

\*\*QuestionSet Editor: \*\*

1. katex
2. mathjax-full
3. @project-sunbird/ckeditor-build-classic
4. @project-sunbird/sunbird-resource-library

**Not in use:**

1. alphanum-sort
2. fine-uploader
3. gulp-svgmin
4. gulp
5. Karma-mocha-reporter

The list of distributed components after separation will be:

[https://github.com/itsvick/building-block/blob/main/component-ditribution.txt](https://github.com/itsvick/building-block/blob/main/component-ditribution.txt)

#### Secondary Entry points in the Angular library

Test multiple scenarios with secondary points and dependency

1. \*\*Create a library (Collection-editor) with peer-dependency \*\*

* let's saywe have added **lodash-es** as peer-dependency
* lodash-es is ES Module
* We have used some functions of it (e.g. \_.filter) in one of the components of the library here - _user-list.component_
* We have deep-imported the module

**Observations:**

* Client application compulsory needs to install lodash-es module while installing collection-editor library otherwise it will throw an error
* lodash-es will be bundled in the final build of the application if _user-list.component_ is used in any of the components of an application
* When lodash-es bundles to the build, it will take full size here 84KB
* Lodash-es will be tree-shaken by webpack or angular build if not being used.
* Total size = 84 KB

![](../../../../Design/sbdesign-iq-td-des1/images/storage/L17aFqFjv6XlGe3q4E1R4cii3bBwnmxGpBzgl8bG41CtmByia2ivfSCu-hajOWjnTjjS3jRGLFrkTSiZY8me4wH1Xa9BdE6dWSMyVFb7cHvC\_70vB5gvlKDLdHjyrtK5Al1MQdE-ISXNl6R3hm7jetN-hozsYRcGd59toRPOBB8fJtjtBjzHqA3sEGlR6Q)

**2. Add a new module with a secondary Entry point**

* Let's create a dial code module that does not have any dependency
* Use it in the application

**Observations:**

* As the dial code component is pure code and not dependent on any other third-party library, final application bundle size should be almost the same here 84.2 KB

**3. Add a new module with a secondary entry point and peer-dependency**

* Let's create new module name \_awesome-time \_
* Add moment.js as peer-dependency in the main package.json of the library
* Moment.js is a UMD package.
* Use some functions of moment.js
*   As moment.js is a UMD module imported, the full library is as follows:

    import \* as a moment from "moment";

**Observations**

* Client compulsory application needs to install the moment module while installing the collection-editor library, otherwise, it will throw an error.
* As soon as the awesome-time module is imported to app.module of the application, the pp bundle size is increased to 160.84 KB even if the _awesome-time.component_ is not yet used in the application yet.
* Almost the same size 160.94 KB (with the slight difference of tree shaken component code) is showing when actually using the awesome-time component which is dependent on moment.js
* Moment.js will not be tree shaken by webpack/angular even if not being used but installed.

**4. Add peer-dependency as optional for one of the modules or secondary point**

* Let’s add moment.js as an optional dependency in library package.json
* No need to change anything in the secondary entry point code

**Observations:**

* No need to install the optional dependency package that is moment until being used (until the awesome-time.module is not imported)
* Once imported, it will be bundled into the final application build.
* For the UMD package, it will be bundled as soon as we import the awesome.time.module for the ES module it will be tree shaken until actually used in the code.
* The bundle size is 160.8

![](../../../../Design/sbdesign-iq-td-des1/images/storage/pcxgujSJFWike4kztpNikUjZ-V75P7jxbQdnEyYHf9N85UtdJjVZPfuddgDPnOlJrO3uXqlGj7NP0fwNvy7w7qc-CNO3E\_2Bf04aCabJN3jSv76Wb2kxeB7O2EB2mnfhNvpyXVN2cunhhDQ3-lL8p05ORq1hIyAshjtHaEq12r9ssgUT80SOoORvZi2ZIQ)

**5. Use a secondary point in the lazy-loaded route**

* Create timer.module in the client application
* Import awesome.module in it

**Observations:**

* The bundle size is the same as importing in app.module
* But with a lazy loaded module/route, Angular will create a different chunk file for the module
* Moment.js will be a part of this lazy-loaded module, not a main module
* So it will help to reduce the initial app load, but users can use the same functionality by visiting a particular route.

![](../../../../Design/sbdesign-iq-td-des1/images/storage/mhM2ljYiJbreirtWtYUoBF272DhJmRiK2h3SBfW9ja91l4Omhy15SCXXSRQGdjpaVGkBX24SBrth03wx3ZcjCSh1qdYNhszPU0KA5XxoF6LE8LyXRkuN5VkQVJEuKhIaiKqWDljtBDNTzPBPbQBd0aDiuK4-4s6w-iD608mgtBvUKLvwgtbHzAYWcn66og)

**Test the following scenarios:**

*   Internal use of secondary entry points

    Secondary —> Secondary → works

    Secondary —> src (core module) → works

    Core module —> Secondary → works

    All possible combinations work as long as there is no circular dependency

    Test cases implementation for all the components of secondary entry points
* Test case coverage report for the library components along with secondary entry point module

***

\[\[category.storage-team]] \[\[category.confluence]]
