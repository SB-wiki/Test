  * [Problem statement:](#problem-statement:)
  * [Intent:](#intent:)
  * [Approach 1: Inline styles at the creation](#approach-1:-inline-styles-at-the-creation)
  * [Approach 2: Adding  classes for the tags](#approach-2:-adding--classes-for-the-tags)
  * [](#)
  * [Conclusion:](#conclusion:)
  * [Actions Items: ](#actions-items:-)

## Problem statement:
QUML Spec style should support questions rending with default view and it should also support for extending the default view.


## Intent:
As part of Question set creation, each question in a question set should be rendered properly in all the possible screens with different resolutions at consumption and it should be extendable by the other adaptors to represent the same questions in a different form.


## Approach 1: Inline styles at the creation


Here we will have the inline css add to the HTML tags so the it will render properly in the screen below is the sample HTML but there is no easy way to change the styling by player or other adaptor 


```html
<figure class="image" style="width:25%;">
  <img src="/assets/public/content/do_11320764935163904015/artifact/2020101299.png" alt="do_11320764935163904015" data-asset-variable="do_11320764935163904015">
</figure>
```



## Approach 2: Adding  classes for the tags
In this case, we will add the CSS classes accordingly  for each HTML tag and the consumer of this question can implement the classes according to their need question will render based on it




```html
<figure class="image image_resized resize-25">
  <img src="/assets/public/content/do_11320764935163904015/artifact/2020101299.png" alt="do_11320764935163904015" data-asset-variable="do_11320764935163904015">
</figure>
```

## 



Approach 3: Adding the classes along with default implementation of them 
In this case, we will add the CSS classes accordingly  for each HTML tag and the consumer of this question can implement the classes according to their need question will render based on it and even we have default style added to the question so that it will have a default view


```html
<style>
.image {
  height: 100%
  width: 100%
}
.image_resized {
  height: 50%
  width: 50%
}
.resize-25 {
  width: 25%
}
<style>
<figure class="image image_resized resize-25">
  <img src="/assets/public/content/do_11320764935163904015/artifact/2020101299.png" alt="do_11320764935163904015" data-asset-variable="do_11320764935163904015">
</figure>
```

## Conclusion:
We will create styles for each resolution and provide them as CDN or API which can be used by consumption (player) or other adaptors can use it or update them with their own requirement.




## Actions Items: 



1. Externalize the styles as CDN or API endpoint - 


1. Adding styles property to QUML Spec - 


1. Using this new styles property in the player - 

    

    

    

    

    

    





*****

[[category.storage-team]] 
[[category.confluence]] 
