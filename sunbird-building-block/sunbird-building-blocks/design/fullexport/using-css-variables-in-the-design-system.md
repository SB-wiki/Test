# Using-CSS-variables-in-the-design-system

### Background

&#x20;Since we are using ng2-semantic UI In the portal some of the components are dynamically generated. we can't change the style of dynamically generated HTML since there is view encapsulation.

So we are using  ::ng-deep to add styles to dynamically generated HTML and we need to add styles in the component.scss itself.&#x20;

### Problem

If we take away all the design system SCSS files and convert into a main.css file and send it using CDN. Component SCSS file which is using that Scss variables will break because final main.css which is served to the portal does not contain Scss variables anymore because while converting Scss to CSS all variables are converted to their actual value.

### Solution

CSS variables to the rescue, If we use CSS variables in portal and design system and if we take away all the design system SCSS files and convert to main.css file, component SCSS still be able to access the CSS variables since there are natively supported in browsers.

Speaking of browser support, it is supported in modern browsers. It is not supported in IE11 (there is polyfill to support IE ([https://www.npmjs.com/package/css-vars-ponyfill](https://www.npmjs.com/package/css-vars-ponyfill)))

And Using CSS variables it is easy to achieve themes.

***

\[\[category.storage-team]] \[\[category.confluence]]
