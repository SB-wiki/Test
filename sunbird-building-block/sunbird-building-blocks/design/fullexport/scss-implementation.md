# SCSS-Implementation

Google Doc ( Contains same ) - [https://docs.google.com/document/d/1te1B983SdMEkN2MPh\_\_WqhU0kaNLR3D4OAFXONcZGBo/edit#](https://docs.google.com/document/d/1te1B983SdMEkN2MPh\_\_WqhU0kaNLR3D4OAFXONcZGBo/edit)&#x20;

JIRA Card - [https://project-sunbird.atlassian.net/browse/SB-8105](https://project-sunbird.atlassian.net/browse/SB-8105)

Current CSS ImplementationFollowing CSS files have been included in the angular.json file or have been imported in Style.css file

\| **File** | **Version used** | **Imported In** | **Available in CSS / LESS / SCSS** | **The code length of the un-minified version** | | src/assets/styles/semantic.min.css | 2.2.13 | angular.json | LESS | | | node\_modules/font-awesome/css/font-awesome.css | 4.7.0 | angular.json | SCSS, LESS and CSS | | | node\_modules/izitoast/dist/css/iziToast.min.css | 1.3.0 | angular.json | CSS | 1738 | | node\_modules/fine-uploader/fine-uploader/fine-uploader-gallery.min.css | 5.16.2 | angular.json | CSS | 470 | | node\_modules/fine-uploader/fine-uploader/fine-uploader-new.min.css | 5.16.2 | style.css | CSS | 354 | | src/assets/libs/semantic-ui-tree-picker/semantic-ui-tree-picker.css | | angular.json | CSS | 154 | | node\_modules/jquery.fancytree/dist/skin-awesome/ui.fancytree.css | | angular.json | CSS & LESS | 534 | | node\_modules/angular2-multiselect-dropdown/themes/default.theme.css | | angular.json | CSS | 70 | | node\_modules/slick-carousel/slick/slick.css | | style.css | CSS, SCSS and LESS | 117 | | node\_modules/slick-carousel/slick/slick-theme.css | | style.css | CSS, SCSS and LESS | 204 | | src/styles.css | | angular.json | CSS | 3550 |

Project Requirements

* Multi-lingual & RTL
* Theming
* Better code organization
* Code reusability

Challenges in Current Implementation **3rd Party Components ( Eg - Slick, Angular2-multiselect ) -**

* Most used 3rd party Angular components do not support RTL & Theming.
* In order to override their style, extra CSS is written in the style.css file which is bloating the project. And each new line of extra code is against the performance.
* The style.css needs to be organised better to indicate how customising the look and feel is possible.

**Style.css** -

* Most of the code can be replaced with the reusable CSS classes.
* The code which cannot be replaced with reusable classes can split and be moved component specific SCSS file and can be corrected to fulfil the requirements of RTL and theming.
* The current style.css code cannot be removed directly without dependency verification.

Why SCSS?Considering Theming, Multilingual variations ( LTR,  RTL, Font-family, Font-size etc) and better code organization SCSS seems to fit the requirements for the following available features -

* Variables ( useful for theming )
* Nesting ( RTL )
* Partials & Extends ( Code reusability )
* Mixins ( Code consistency )
* Imports ( Code organization )

Proposed Approach

* Angular.json file needs to update to support SCSS. The styleext value will be modified from CSS to SCSS.
* Angular.json file will only include 3 files -
  * Semantic.min.css
  * Font-awesome.scss
  * Style.scss
* Current style.css file code will be moved to legacy.scss file for cleanup.
* All 3rd party Angular component and used lib (Except Semantic UI & Font awesome) will be ported/converted to SCSS and kept inside the client/src/app/styles/components/ folder. Also, variables file will be imported to access the variables.
* Sunbird’s own components styles will be converted to SCSS.

**Details**

* Semantic.min.css will be the LESS compiled themed output. All the Less code and generated CSS file will stay in the semantic folder inside client/src/app/styles/semantic/. This folder will follow the theming implementation guidelines of Semantic itself.
* Font-awesome will be imported from the npm package itself.
* Style.scss will import all the SCSS files from the client/src/app/styles/components/ folder.

**SCSS conversion steps for 3rd party components** &#x20;

* Copy file into the client/src/app/styles/components/  folder
* Change the file extension to .scss
* Change the colour values to SCSS variable wherever it is impacting the theming stuff.
* Add / Change / Remove the properties that are affecting the RTL implementation.
* Add the comments of all changes made for above 2 points in the file itself so that changes are known during version up-gradation.
* Import this file into style.scss file.

**SCSS conversion steps for Sunbird own components** &#x20;

* Change the file extension to .scss
* Modify the styleUrls in component metadata
* Change the colour values to SCSS variable wherever it is impacting the theming stuff.
* Add / Change / Remove the properties that are affecting the RTL implementation.

Code Organization client/src/app/styles/

```
client/src/app/styles/

 - semantic/
 - reusables/
     - mixins/
        - margin.scss
        - padding.scss
        - background.scss
        - display.scss

        - .. (others)
    - variables.scss
    - fonts.scss

    - fonts-hi.scss

    - fonts-ur.scss
    - margins.scss
    - margins-rtl.scss
    - paddings.scss
    - paddings-rtl.scss
    - backgrounds.scss

    - semantic-ui-rtl.css
    - ..(others)
- components/
   - suipopup.scss
   - suipopup-rtl.scss
   - angular2-select.scss
   - angular2-select-rtl.scss
    - ..
 - legacy.scss

 - styles.scss
```

* Legacy.scss file code is something which is used somewhere and will be removed in the near future as it does not comply with the current guidelines.
* All CSS guidelines complying code will be moved to the respective correct locations and remove from the legacy.scss file.
* After the initial cleanup legacy.scss file code classes are something which is not to be used in future at any place.
* Semantic UI does not have a lot of reusable utility classes which can be used in freestyle.  Reusable Utility classes will be added inside the reusables folder. Mixins folder will contain [Bourbon](https://www.bourbon.io/) which is a very nice mixin lib to generate reusable utility classes.
* Defaults - direction is ltr and language is English.
* Eg of code organization -

Writing CSS in Angular components SCSS files?

* Components CSS file provides a lot of advantages like encapsulation to protect harms from outer CSS code and code modularity (CSS code coming in the packaged form in the component itself ). But again this code is not reusable in another component until and unless some provisions are made.
* Writing non-reusable code is like increasing the size of code.
* The approach should be like -

[https://angular.io/guide/component-styles](https://angular.io/guide/component-styles)

***

\[\[category.storage-team]] \[\[category.confluence]]
