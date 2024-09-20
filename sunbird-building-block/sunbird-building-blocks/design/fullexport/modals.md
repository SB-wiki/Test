# Modals

\| [https://app.invisionapp.com/d/main#/console/16496654/342077612/preview](https://app.invisionapp.com/d/main#/console/16496654/342077612/preview) |

| [https://edcarroll.github.io/ng2-semantic-ui/#/modules/modal](https://edcarroll.github.io/ng2-semantic-ui/#/modules/modal)                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------ |
| ---                                                                                                                                              |
| [https://app.invisionapp.com/d/main#/console/16496654/342077612/preview](https://app.invisionapp.com/d/main#/console/16496654/342077612/preview) |
| [https://edcarroll.github.io/ng2-semantic-ui/#/modules/modal](https://edcarroll.github.io/ng2-semantic-ui/#/modules/modal)                       |

### 3 variations of Modals:

\| size | Mobile Behaviour | Tablet Behaviour | Computer Behaviour | | width = 300px  & height = 250px | width = 300px  & height = 250px | width = 300px  & height = 250px | | width = 100% & max-height = 480px | width = 100% & max-height = 480px | width = 720px & max-height = 480px | | Entire screen | Entire screen | Entire screen | | --- | --- | --- | --- |

| ---                               |
| --------------------------------- |
| ---                               |
| width = 300px  & height = 250px   |
| width = 100% & max-height = 480px |
| Entire screen                     |

### HTML Template:

```xml
<sui-modal
[isClosable]="true"
[size]="'normal'"
[transitionDuration]="0"
(dismissed)="whateverFunction();"
#modal>

<!--Header-->
<div class="header">
	heading
</div>
<!--/Header-->

<!--Content-->
<div class="content">
	content
</div>
<!--/Content-->

<!--Footer-->
<div class="actions">
	<button class="ui secondary button">Secondary Button</button>
    <button class="ui primary button">Primary Button</button>
</div>
<!--/Footer-->

</sui-modal>
```

***

\[\[category.storage-team]] \[\[category.confluence]]
