# HTML-&-CSS-Guidelines-(v1.0)

Google Doc (Contains same) - [https://docs.google.com/document/d/1RqZqAQAmUhJqaMCL26iIvx9MS03MxKbby9My\_Fbt1Do/edit#](https://docs.google.com/document/d/1RqZqAQAmUhJqaMCL26iIvx9MS03MxKbby9My\_Fbt1Do/edit) &#x20;

JIRA Card - [https://project-sunbird.atlassian.net/browse/SB-6076](https://project-sunbird.atlassian.net/browse/SB-6076)

Goal

* To bring consistency in code quality and standards across the Project.
* To set minimum quality standards.
* An effective tool for measurements in code reviewing.
* Make easy onboarding for newcomers.

Scope areas

1. The responsive/ Mobile-first approach
2. Cross-browser compatibility
3. SEO & Social shareability
4. Web Accessibility
5. Performance
6. Security
7. Quality code -  Coding style
8. Good commenting practices

Mandatory Process

* **Code Review** - PR’s with HTML & CSS changes must be reviewed & approved by the concerned person.
* **Code Review Parameters**
* **Reuse code** - Writing CSS code must be completely avoided. The approach should be -

CSS Formatting

* When using multiple selectors in one rule declaration, give each selector its own line.
* The code should be properly intended - use 1 soft tab (2 spaces).
* Put a space before the opening brace **{** in rule declarations.
* In properties, put a space after, but not before, the **:** character.
* Put closing braces **}** of rule declarations on a new line.
* The code inside media queries should be 1 soft tab intended.
* **Declaration Order for properties** - Put declarations in order to achieve consistent code. Related property declarations should be grouped together following the order:
  * Positioning
  * Box model
  * Typographic
  * Visual
* **Quotation Marks**
* **Comments** -
  * Uses of z-index.
  * Compatibility or browser-specific hacks.
  * **TODO** - Mark todos and action items with TODO. Append action items after a colon as in TODO: action item if the code needs refactoring later.

**Bad**

\| **.avatar** **{** \*\*   \*\* **border-radius** **:** **50%** **;** \*\*   \*\* **border** **:** **2px** **solid white; }** **.no** **,** **.nope** **,** **.not\_good** **{** \*\*   // ...\*\* **}** **#lol-no** **{** \*\* // ...\*\* **}** |

**Good**

\| **.avatar** **{** \*\*   \*\* **border-radius** **:** **50%** **;** _/ For Circular Shape /_ \*\*   \*\* **border** **:** **2px** **solid white;** **}** **.one** **,** **.selector** **,** **.per-line** **{** **}** _/ CSS to override ng2select CSS_/\*\* _/ Start /_ **.profile-image** **{** \*\* \*\* \*\* border\*\* **:** **2px** **solid #eee;** **}** **@media** **screen** **and (** **min-width** **:** **992px** **) {** \*\*   .profile-image\*\* **{** \*\*      \*\* **border** **:** **2px** **solid #eee;** \*\*   }\*\* **}** _/ End /_ |

CSS Naming ConventionClasses naming should be more predictable to use and hence it needs to be consistent. Naming convention to followed -

* **Utility / Helper reusable classes** (Typically single property classes) Name of such classes should be abbreviation of property followed by value. Eg -
* **Extending Semantic UI framework components** - Such classes should follow the same naming convention Semantic UI follows. Eg -

CSS code organisation / SCSS Implementation (#SB-8105)[https://docs.google.com/document/d/1te1B983SdMEkN2MPh\_\_WqhU0kaNLR3D4OAFXONcZGBo/edit](https://docs.google.com/document/d/1te1B983SdMEkN2MPh\_\_WqhU0kaNLR3D4OAFXONcZGBo/edit)

CSS Best Practices

* **Specificity Problems -**
* **Avoid** **!important**
* **Never use IDs in CSS, ever.** They have no advantage over classes (anything you can do with an ID, you can do with a class), they cannot be reused, and their specificity is way, way too high. Even an infinite number of chained classes will not trump the specificity of one ID.
* **Do not nest selectors unnecessarily.** If **.header-nav {}** will work, never use **.header .header-nav {}** ; to do so will literally double the specificity of the selector without any benefit. ( Semantic follows this bad practice )
* **Do not qualify selectors unless you have a compelling reason to do so.** If **.nav {}** will work, do not use **ul.nav {}** ; to do so would not only limit the places you can use the .nav class, but it also increases the specificity of the selector, again, with no real gain.
* **JavaScript hooks** - Avoid binding to the same class in both your CSS and JavaScript. Conflating the two often leads to, at a minimum, time wasted during refactoring when a developer must cross-reference each class they are changing, and at its worst, developers being afraid to make changes for fear of breaking functionality. We recommend creating JavaScript-specific classes to bind to, prefixed with **.js-**

\|   Request to Book |

* \*\*Never @import css file.  \*\* Never import css file within css file because it downgrades the performance of the site. ( Currently Semantic imports Roboto font in this way and Roboto font is not used at all on the portal hence this needs fixed. )
* **No random big Z-index** . Never give random or very high z-index. Check siblings z-index and +1 to it. Giving random high z-index can cause issues later after some complexity is increased.
* **Horizontal & Vertical Box Centering** -

Avoid doing box vertical & horizontal centering by adjusting left and top properties. Use transform: translate(-50%, -50%) to avoid rewriting media specific css.

**Bad Code**

\| .center {position: absolute;top: 47%;left: 47%;} |

&#x20;     **Good Code**

\| .center {     position: absolute;     top: 50%;     left: 50%;     transform: translate(-50%, -50%);} |

* **Avoid Hard Coded Height for background images or videos** -

Avoid mentioning height. Try to use aspect ratios to avoid writing media queries.

**Bad Code**

\| .banner {background-image: url(‘path-to-image.jpg’);           background-size: contain;width: 100%;height: 100px;}@media screen and (min-width:768px){.banner {height: 200px;\}}@media screen and (min-width:992px){.banner {height: 300px;\}} |

&#x20;   **Good Code**

\| .banner {    background-image: url(‘path-to-image.jpg’);    background-size: contain;    width: 100%;    padding-top: 56.25%;  }/\*      Ratios      16:9 = 56.25 %      4:3 Ratio  = 75 %      1:1 = 100%; (Square)    \*/ |

* **Avoid Hardcoded height to any component like header, footer, card etc.**  Components will shrink and expand and their height will increase or decrease based on device size. \*\* \*\* Let component take their natural space. In this way you won't have to write code in several media queries.
* **Use shorthand properties where possible.**

**Bad Code**

\| padding-bottom: 2em;padding-left: 1em;padding-right: 1em;padding-top: 0; |

**Good Code**

\| padding: 0 1em 2em; |

* **0 and Units**

Omit unit specification after “0” values, unless required. Do not use units after 0 values unless they are required. Eg -

\| flex: 0px; /\* This flex-basis component requires a unit. \*/flex: 110px; /\* Not ambiguous without the unit, but needed in IE11. \*/margin: 0;padding: 0; |

* **Avoid workaround values for width, padding and margin**
* **Bad Width:** Eg -  93% or 86% or 49% etc

**Eg 1:** If there are 2 elements .right with width 30px and .left with rest of the space

**Bad Code**

\| .left{width: 90%;}@media screen and (min-width:768px){.left{width: 93%;\}}@media screen and (min-width:992px){.left{width: 97%;\}} |

&#x20;    **Good Code**

\| .left{      width: calc (100% - 30px);} |

\*\* \*\* In this way you can avoid writing media specific codes

&#x20; **Eg 2:** try to avoid minor adjustment padding - margin

&#x20; **Bad Code**

\| .center {padding: 1px 3px 7px 16px;} |

* **Reusable generic classes**
* **Responsive / Mobile First** - A mobile-first approach to styling means that styles are applied first to mobile devices. Advanced styles and other overrides for larger screens are then added into the stylesheet via media queries. This approach uses min-width media queries.

\*\*     \*\* **Bad Code**

\| .box {    position: relative;    float:  left;    width: 100%;   }@media screen and (min-width:768px) and (max-width:992px){     .box{           position: relative;           float:  left;           width: 75%;\}}@media screen and (min-width:992px){      .box {           position: relative;           float:  left;           width: 50%;\}}@media screen and (min-width:600px) and (max-width:767px) and (orientation:landscape){       .box {            position: relative;            float:  left;            width: 50%;\}} |

&#x20;            &#x20;

\*\*    \*\* **Good Code**

\| .box {    position: relative;    float:  left;    width: 90%;}@media screen and (min-width:768px){.box {width: 75%;\}}@media screen and (min-width:992px){.box {width: 50%;\}} |

* **Effective use of SCSS**
  * Use Mixins effectively for code consistency
  * Use variables effectively for theming
  * Use @imports & @extends for proper code organization & reusability.
  * Avoid assigning any color & font-family directly. Look for variables, if not available create a variable and assign color value to it. This will help in Theming
* **RTL**
* Try to make symmetrical things as much as possible for following properties -
* Avoid writing following properties as much as you can  -
* **Multilingual**
* Even multiple languages with the same direction can have some variations.
* Avoid following properties as much as you can  - Font-family, font-size, font-weight, etc
* **px** **vs** **em** **vs** **rem** &#x20;
  * Nesting element with em can cause decreasing size issues due to inheriting parent properties. It can also cause issue with alignments specially horizontally with variation in the font-size.&#x20;

CSS Useful References

* AirBnb Guidelines -[https://github.com/airbnb/css](https://github.com/airbnb/css)
* Google Guidelines - [https://google.github.io/styleguide/htmlcssguide.html](https://google.github.io/styleguide/htmlcssguide.html)
* CSS Tricks Guidelines - [https://css-tricks.com/css-style-guides/](https://css-tricks.com/css-style-guides/)
* Guide by @mdo - [http://codeguide.co/#css](http://codeguide.co/#css)
* Stylelint Rules  - [https://stylelint.io/user-guide/rules/](https://stylelint.io/user-guide/rules/)
* Github Guidelines - [https://styleguide.github.com/primer/principles/](https://styleguide.github.com/primer/principles/)
* Centering - [https://css-tricks.com/centering-css-complete-guide/](https://css-tricks.com/centering-css-complete-guide/)
* Mobile First Approach - [https://zellwk.com/blog/how-to-write-mobile-first-css/](https://zellwk.com/blog/how-to-write-mobile-first-css/)
* [http://wtfhtmlcss.com/](http://wtfhtmlcss.com/)
* Wordpress RTL - [https://codex.wordpress.org/Right\_to\_Left\_Language\_Support](https://codex.wordpress.org/Right\_to\_Left\_Language\_Support)
* Specificity - [https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity)

HTML Formatting

* **HTML Line-Wrapping -**

\| \<md-progress-circular    md-mode="indeterminate"    class="md-accent"    ng-show="ctrl.loading"    md-diameter="35">\</ **md-progress-circular** > |

HTML Common Mistakes

1. **DOCTYPE missing-** The DOCTYPE should always be the very first line of your HTML code and it is case sensitive.
2. **Alt attribute missing** - Relevant alt attribute to the image tag should always be added.
3. **Not closing Tags properly** - Pair tags should be closed appropriately and single tags should be closed with /.
4. **Lists** - Don’t use line breaks to show a list
5. Don’t place Block elements within Inline elements

\| [< **h4** >Heading\</ **h4** >\</ **a** >](../../../../Design/FullExport/url/)

[**Heading**](../../../../Design/FullExport/url/)**\</ h4 > |Missing script typeAvoid Inline StylesDocument doesn't have a valid hreflangImage size should not exceed the device height.  - Try to use image in 16:9 aspect ratio or more to avoid scrolling to see complete image.Must Have Meta Tags ( Including Responsiveness, SEO & Social Shareability )| < meta charset="utf-8" />< meta http-equiv="X-UA-Compatible" content="IE=edge" />< meta name="viewport" content="width=device-width, initial-scale=1" />< link rel="apple-touch-icon" sizes="180x180" href="/images/favicons/apple-touch-icon.png" />< link rel="icon" type="image/png" sizes="32x32" href="/images/favicons/favicon-32x32.png" />< link rel="icon" type="image/png" sizes="16x16" href="/images/favicons/favicon-16x16.png" />< link rel="manifest" href="/images/favicons/manifest.json" />< meta name="theme-color" content="#ffffff" />< title >\{{page.title\}}\</ title >< meta name="description" content="\{{page.description\}}"/>< link rel="canonical" href="\{{page.url\}}" />< meta property="og:type" content="website"/>< meta property="og:site\_name" content="\{{site.title\}}"/>< meta property="og:locale" content="\{{page.language\}}"/>< meta property="og:title" content="\{{page.title\}}" />< meta property="og:description" content="\{{page.description\}}" />< meta property="og:url" content="\{{page.url\}}" />< meta property="og:image" content="\{{page.image\}}" />< meta name="twitter:card" content="summary\_large\_image" />< meta name="twitter:site" content="\{{site.twitter\}}" />< meta name="twitter:creator" content="\{{site.twitter\}}" />< meta name="twitter:url" content="\{{page.url\}}" />< meta name="twitter:title" content="\{{page.title\}}" />< meta name="twitter:description" content="\{{page.description\}}" />< meta name="twitter:image" content="\{{page.image\}}" /> |Web AccessibilityTab Index - Every link or form element  or interactive element must have tabindex as per the navigation required.Alt text - Every image must have relevant & contextualized alt text -** [**https://webaim.org/techniques/alttext/**](https://webaim.org/techniques/alttext/)**ARIA - ARIA Landmark roles can help assistive technology users to quickly navigate to and past blocks of content in a web interface.Language attribute - Declaring a language attribute on the HTML element enables a screen reader to read out the text with correct pronunciation.Document Outline - Use semantic headings and structureProvide a “**[**Skip to main content**](https://a11yproject.com/posts/skip-nav-links/)**” link.Use unobtrusive JavaScript.Provide alternatives for users who do not have JavaScript enabled and for environments where JavaScript is unavailable.Associated label for all form controls (e.g. input, select etc.) (e.g. Name:)Make sure placeholder attributes are not being used in place of label tags.SecurityUse rel=noopener attribute with 3rd party website links.**  [**https://developers.google.com/web/tools/lighthouse/audits/noopener**](https://developers.google.com/web/tools/lighthouse/audits/noopener)**\[\[category.storage-team]] \[\[category.confluence]]**
