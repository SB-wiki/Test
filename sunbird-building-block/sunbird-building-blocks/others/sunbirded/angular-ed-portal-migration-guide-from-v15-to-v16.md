# Angular-ED-Portal-Migration-Guide-from-V15-to-V16

* [Migration Steps](angular-ed-portal-migration-guide-from-v15-to-v16.md#migration-steps)
  * [Migrate the Sunbird-ED Library](angular-ed-portal-migration-guide-from-v15-to-v16.md#migrate-the-sunbird-ed-library)
  * [Update Angualr Material to V16](angular-ed-portal-migration-guide-from-v15-to-v16.md#update-angualr-material-to-v16)
* [Reference Link](angular-ed-portal-migration-guide-from-v15-to-v16.md#reference-link) The purpose of this document is to provide a comprehensive guide for migrating the ED portal from Angular v15 to v16. It outlines the step-by-step process of migrating the portal and highlights the challenges encountered during the migration. This guide aims to assist adopters in successfully migrating their Angular v15 portals to v16 and provides insights into overcoming common migration hurdles.

## Migration Steps

**Assess Compatibility** : Before starting the migration process, assess the compatibility of third-party dependencies, ED- libraries, and Angular-related packages with Angular v16.

### Migrate the Sunbird-ED Library

Update the Sunbird Education (ED) related libraries to be compatible with Angular version 16. This update is essential to ensure compatibility with the latest Angular features and improvements. Below is the list of libraries owned by ED that require updating:

1. [Sunbird ED portal](https://github.com/Sunbird-Ed/SunbirdEd-portal/tree/release-7.0.0)
2. [@project-sunbird/common-consumption](https://github.com/Sunbird-Ed/SunbirdEd-consumption-ngcomponents/tree/release-7.0.0\_v13\_bmgs)
3. [@project-sunbird/common-form-elements-full](https://github.com/Sunbird-Ed/SunbirdEd-forms/tree/release-6.0.0\_v14)
4. [@project-sunbird/sb-content-section](https://github.com/Sunbird-Ed/sb-content-module/tree/release-7.0.0)
5. [@project-sunbird/sb-dashlet](https://github.com/Sunbird-Ed/sb-dashlets/tree/V14\_Migration)
6. [@project-sunbird/sb-notification](https://github.com/Sunbird-Ed/sb-notification/tree/release-6.0.0\_v14)
7. [@project-sunbird/chatbot-client](https://github.com/project-sunbird/sunbird-bot-client/tree/release-6.0.0\_v13)
8. [sb-svg2pdf-v13](https://github.com/Sunbird-Ed/sb-svg2pdf/tree/release-6.0.0\_v13)
9. [@project-sunbird/web-extensions](https://github.com/project-sunbird/sunbird-ext-framework/tree/release-6.0.0/web-extensions/sunbird-web-extensions-app)
10. [@project-sunbird/discussions-ui](https://github.com/Sunbird-Lern/discussions-UI/tree/release-5.3.0\_v14)
11. [@project-sunbird/sb-themes](https://github.com/Sunbird-Ed/sb-themes/tree/8.0.0)

**Update Angular CLI** Ensure that the Angular CLI is updated to the latest compatible with Angular v16. Use npm to update Angular CLI globally:

```
npm install -g @angular/cli@16
```

&#x20;

**Update Angular Core Packages** Update Angular core packages to their latest versions compatible with Angular v15. Use the Angular CLI to update Angular core packages

```
ng update @angular/core@16 @angular/cli@16
```

Angular Update Logs

```
princekumar ~/projects/SunbirdEd-portal-inf-scroll/SunbirdEd-portal/src/app/client [8.0.0_ng16] $ ng update @angular/core@16 @angular/cli@16
The installed Angular CLI version is outdated.
Installing a temporary Angular CLI versioned 16.2.12 to perform the update.
✔ Packages successfully installed.
Using package manager: yarn
Collecting installed dependencies...
Found 117 dependencies.
Fetching dependency metadata from registry...
                  Package "ngx-bootstrap" has an incompatible peer dependency to "@angular/animations" (requires "^13.0.0" (extended), would install "16.2.12").
                  Package "@project-sunbird/sunbird-collection-editor" has an incompatible peer dependency to "@angular/common" (requires "~12.2.16" (extended), would install "16.2.12").
                  Package "@project-sunbird/sunbird-collection-editor" has an incompatible peer dependency to "@angular/core" (requires "~12.2.16" (extended), would install "16.2.12").
                  Package "common-form-elements-v9" has an incompatible peer dependency to "@angular/forms" (requires "^9.1.13" (extended), would install "16.2.12").
✖ Migration failed: Incompatible peer dependencies found.
Peer dependency warnings when installing dependencies means that those dependencies might not work correctly together.
You can use the '--force' option to ignore incompatible peer dependencies and instead address these warnings later.
  See "/private/var/folders/jn/gl6l07_x49s3qn1ky0975ncw0000gp/T/ng-OANyBa/angular-errors.log" for further details.

princekumar ~/projects/SunbirdEd-portal-inf-scroll/SunbirdEd-portal/src/app/client [8.0.0_ng16] $ ng update @angular/core@16 @angular/cli@16 --force
The installed Angular CLI version is outdated.
Installing a temporary Angular CLI versioned 16.2.12 to perform the update.
✔ Packages successfully installed.
Using package manager: yarn
Collecting installed dependencies...
Found 117 dependencies.
Fetching dependency metadata from registry...
                  Package "ngx-bootstrap" has an incompatible peer dependency to "@angular/animations" (requires "^13.0.0" (extended), would install "16.2.12").
                  Package "@project-sunbird/sunbird-collection-editor" has an incompatible peer dependency to "@angular/common" (requires "~12.2.16" (extended), would install "16.2.12").
                  Package "@project-sunbird/sunbird-collection-editor" has an incompatible peer dependency to "@angular/core" (requires "~12.2.16" (extended), would install "16.2.12").
                  Package "common-form-elements-v9" has an incompatible peer dependency to "@angular/forms" (requires "^9.1.13" (extended), would install "16.2.12").
    Updating package.json with dependency @angular/language-service @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular-devkit/build-angular @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/animations @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/cli @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/common @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/compiler @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/compiler-cli @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/core @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/forms @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/localize @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/platform-browser @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/platform-browser-dynamic @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency @angular/router @ "16.2.12" (was "15.2.10")...
    Updating package.json with dependency zone.js @ "0.13.3" (was "0.11.4")...
UPDATE package.json (9831 bytes)
✔ Packages successfully installed.
** Executing migrations of package '@angular/cli' **

❯ Remove 'defaultProject' option from workspace configuration.
  The project to use will be determined from the current working directory.
  Migration completed (No changes made).

❯ Replace removed 'defaultCollection' option in workspace configuration with 'schematicCollections'.
  Migration completed (No changes made).

❯ Update the '@angular-devkit/build-angular:server' builder configuration to disable 'buildOptimizer' for non optimized builds.
  Migration completed (No changes made).

** Executing migrations of package '@angular/core' **

❯ In Angular version 15.2, the guard and resolver interfaces (CanActivate, Resolve, etc) were deprecated.
  This migration removes imports and 'implements' clauses that contain them.
UPDATE src/app/modules/core/guard/auth-gard.service.ts (3815 bytes)
UPDATE src/app/modules/public/services/landingpage-guard/landingpage.guard.ts (1047 bytes)
UPDATE src/app/modules/public/services/pending-changes-guard/pendingchanges.guard.ts (544 bytes)
UPDATE src/app/modules/observation/guards/ml/ml.guard.ts (1604 bytes)
UPDATE src/app/modules/questionnaire/guard/can-deactivate.guard.ts (774 bytes)
  Migration completed (5 files modified).

❯ As of Angular v16, the `moduleId` property of `@Component` is deprecated as it no longer has any effect.
  Migration completed (No changes made).
```

### Update Angualr Material to V16

```
ng update @angular/material@16
```

Angular Material Update log

```
princekumar ~/projects/SunbirdEd-portal-inf-scroll/SunbirdEd-portal/src/app/client [8.0.0_ng16] $ ng update @angular/material@16 --force
Using package manager: yarn
Collecting installed dependencies...
Found 117 dependencies.
Fetching dependency metadata from registry...
                  Package "@project-sunbird/sunbird-collection-editor" has an incompatible peer dependency to "@angular/cdk" (requires "11.2.13", would install "16.2.14").
                  Package "@project-sunbird/sunbird-resource-library" has an incompatible peer dependency to "@angular/material" (requires "^15.2.2", would install "16.2.14").
                  Package "@angular/material-moment-adapter" has a missing peer dependency of "moment" @ "^2.18.1".
    Updating package.json with dependency @angular/cdk @ "16.2.14" (was "15.2.9")...
    Updating package.json with dependency @angular/material @ "16.2.14" (was "15.2.9")...
    Updating package.json with dependency @angular/material-moment-adapter @ "16.2.14" (was "15.2.9")...
UPDATE package.json (9834 bytes)
✔ Packages successfully installed.
** Executing migrations of package '@angular/cdk' **

❯ Updates the Angular CDK to v16.
    
      ✓  Updated Angular CDK to version 16
    
  Migration completed (No changes made).

** Executing migrations of package '@angular/material' **

❯ Updates the Angular Material to v16.
    
      ✓  Updated Angular Material to version 16
    
  Migration completed (No changes made).

```

After successfully migrating the portal, an error occurs when attempting to build the project. The error message indicates that the export 'ReflectiveInjector' is not found in '@angular/core'. in these 2 library

1. ./node\_modules/ng2-semantic-ui-v9/fesm2015/ng2-semantic-ui-v9.js:1092:21-56 - Error: export 'ReflectiveInjector' (imported as 'ReflectiveInjector') was not found in '@angular/core'
2. ./node\_modules/@project-sunbird/web-extensions/fesm2020/project-sunbird-web-extensions.mjs:111:26-61 - Error: export 'ReflectiveInjector' (imported as 'ReflectiveInjector') was not found in '@angular/core'

Here's a detailed description to document this issue

Build Error :: Post Angular V16 Migration

```
✔ Browser application bundle generation complete.
Warning: /Users/princekumar/projects/SunbirdEd-portal/src/app/client/src/app/modules/groups/components/activity/activity-search/activity-search.component.ts depends on '@project-sunbird/client-services/blocs'. CommonJS or AMD dependencies can cause optimization bailouts.
For more info see: https://angular.io/guide/build#configuring-commonjs-dependencies
Warning: /Users/princekumar/projects/SunbirdEd-portal/src/app/client/src/app/modules/shared-feature/components/collection-player/collection-player.component.ts depends on 'tree-model'. CommonJS or AMD dependencies can cause optimization bailouts.
For more info see: https://angular.io/guide/build#configuring-commonjs-dependencies
Warning: /Users/princekumar/projects/SunbirdEd-portal/src/app/client/src/app/modules/shared-feature/components/global-consent-pii/global-consent-pii.component.ts depends on '@project-sunbird/client-services/models'. CommonJS or AMD dependencies can cause optimization bailouts.
For more info see: https://angular.io/guide/build#configuring-commonjs-dependencies
./node_modules/ng2-semantic-ui-v9/fesm2015/ng2-semantic-ui-v9.js:1092:21-56 - Error: export 'ReflectiveInjector' (imported as 'ReflectiveInjector') was not found in '@angular/core' (possible exports: ANIMATION_MODULE_TYPE, APP_BOOTSTRAP_LISTENER, APP_ID, APP_INITIALIZER, ApplicationInitStatus, ApplicationModule, ApplicationRef, Attribute, COMPILER_OPTIONS, CSP_NONCE, CUSTOM_ELEMENTS_SCHEMA, ChangeDetectionStrategy, ChangeDetectorRef, Compiler, CompilerFactory, Component, ComponentFactory, ComponentFactoryResolver, ComponentRef, ContentChild, ContentChildren, DEFAULT_CURRENCY_CODE, DebugElement, DebugEventListener, DebugNode, DefaultIterableDiffer, DestroyRef, Directive, ENVIRONMENT_INITIALIZER, ElementRef, EmbeddedViewRef, EnvironmentInjector, ErrorHandler, EventEmitter, Host, HostBinding, HostListener, INJECTOR, Inject, InjectFlags, Injectable, InjectionToken, Injector, Input, IterableDiffers, KeyValueDiffers, LOCALE_ID, MissingTranslationStrategy, ModuleWithComponentFactories, NO_ERRORS_SCHEMA, NgModule, NgModuleFactory, NgModuleRef, NgProbeToken, NgZone, Optional, Output, PACKAGE_ROOT_URL, PLATFORM_ID, PLATFORM_INITIALIZER, Pipe, PlatformRef, Query, QueryList, Renderer2, RendererFactory2, RendererStyleFlags2, Sanitizer, SecurityContext, Self, SimpleChange, SkipSelf, TRANSLATIONS, TRANSLATIONS_FORMAT, TemplateRef, Testability, TestabilityRegistry, TransferState, Type, VERSION, Version, ViewChild, ViewChildren, ViewContainerRef, ViewEncapsulation, ViewRef, afterNextRender, afterRender, asNativeElements, assertInInjectionContext, assertPlatform, booleanAttribute, computed, createComponent, createEnvironmentInjector, createNgModule, createNgModuleRef, createPlatform, createPlatformFactory, defineInjectable, destroyPlatform, effect, enableProdMode, forwardRef, getDebugNode, getModuleFactory, getNgModuleById, getPlatform, importProvidersFrom, inject, isDevMode, isSignal, isStandalone, makeEnvironmentProviders, makeStateKey, mergeApplicationConfig, numberAttribute, platformCore, provideZoneChangeDetection, reflectComponentType, resolveForwardRef, runInInjectionContext, setTestabilityGetter, signal, untracked, ɵALLOW_MULTIPLE_PLATFORMS, ɵAfterRenderEventManager, ɵComponentFactory, ɵConsole, ɵDEFAULT_LOCALE_ID, ɵENABLED_SSR_FEATURES, ɵINJECTOR_SCOPE, ɵIS_HYDRATION_DOM_REUSE_ENABLED, ɵInitialRenderPendingTasks, ɵLContext, ɵLifecycleHooksFeature, ɵLocaleDataIndex, ɵNG_COMP_DEF, ɵNG_DIR_DEF, ɵNG_ELEMENT_ID, ɵNG_INJ_DEF, ɵNG_MOD_DEF, ɵNG_PIPE_DEF, ɵNG_PROV_DEF, ɵNOT_FOUND_CHECK_ONLY_ELEMENT_INJECTOR, ɵNO_CHANGE, ɵNgModuleFactory, ɵNoopNgZone, ɵReflectionCapabilities, ɵRender3ComponentFactory, ɵRender3ComponentRef, ɵRender3NgModuleRef, ɵRuntimeError, ɵSSR_CONTENT_INTEGRITY_MARKER, ɵTESTABILITY, ɵTESTABILITY_GETTER, ɵViewRef, ɵXSS_SECURITY_URL, ɵ_sanitizeHtml, ɵ_sanitizeUrl, ɵallowSanitizationBypassAndThrow, ɵannotateForHydration, ɵbypassSanitizationTrustHtml, ɵbypassSanitizationTrustResourceUrl, ɵbypassSanitizationTrustScript, ɵbypassSanitizationTrustStyle, ɵbypassSanitizationTrustUrl, ɵclearResolutionOfComponentResourcesQueue, ɵcompileComponent, ɵcompileDirective, ɵcompileNgModule, ɵcompileNgModuleDefs, ɵcompileNgModuleFactory, ɵcompilePipe, ɵconvertToBitFlags, ɵcreateInjector, ɵdefaultIterableDiffers, ɵdefaultKeyValueDiffers, ɵdetectChanges, ɵdevModeEqual, ɵfindLocaleData, ɵflushModuleScopingQueueAsMuchAsPossible, ɵformatRuntimeError, ɵgetDebugNode, ɵgetDirectives, ɵgetHostElement, ɵgetInjectableDef, ɵgetLContext, ɵgetLocaleCurrencyCode, ɵgetLocalePluralCase, ɵgetSanitizationBypassType, ɵgetUnknownElementStrictMode, ɵgetUnknownPropertyStrictMode, ɵglobal, ɵinjectChangeDetectorRef, ɵinternalCreateApplication, ɵisBoundToModule, ɵisEnvironmentProviders, ɵisInjectable, ɵisNgModule, ɵisPromise, ɵisSubscribable, ɵnoSideEffects, ɵpatchComponentDefWithScope, ɵpublishDefaultGlobalUtils, ɵpublishGlobalUtil, ɵregisterLocaleData, ɵresetCompiledComponents, ɵresetJitOptions, ɵresolveComponentResources, ɵsetAllowDuplicateNgModuleIdsForTest, ɵsetAlternateWeakRefImpl, ɵsetClassMetadata, ɵsetCurrentInjector, ɵsetDocument, ɵsetInjectorProfilerContext, ɵsetLocaleId, ɵsetUnknownElementStrictMode, ɵsetUnknownPropertyStrictMode, ɵstore, ɵstringify, ɵtransitiveScopesFor, ɵunregisterLocaleData, ɵunwrapSafeValue, ɵwithDomHydration, ɵɵCopyDefinitionFeature, ɵɵFactoryTarget, ɵɵHostDirectivesFeature, ɵɵInheritDefinitionFeature, ɵɵInputTransformsFeature, ɵɵNgOnChangesFeature, ɵɵProvidersFeature, ɵɵStandaloneFeature, ɵɵadvance, ɵɵattribute, ɵɵattributeInterpolate1, ɵɵattributeInterpolate2, ɵɵattributeInterpolate3, ɵɵattributeInterpolate4, ɵɵattributeInterpolate5, ɵɵattributeInterpolate6, ɵɵattributeInterpolate7, ɵɵattributeInterpolate8, ɵɵattributeInterpolateV, ɵɵclassMap, ɵɵclassMapInterpolate1, ɵɵclassMapInterpolate2, ɵɵclassMapInterpolate3, ɵɵclassMapInterpolate4, ɵɵclassMapInterpolate5, ɵɵclassMapInterpolate6, ɵɵclassMapInterpolate7, ɵɵclassMapInterpolate8, ɵɵclassMapInterpolateV, ɵɵclassProp, ɵɵcontentQuery, ɵɵdefer, ɵɵdefineComponent, ɵɵdefineDirective, ɵɵdefineInjectable, ɵɵdefineInjector, ɵɵdefineNgModule, ɵɵdefinePipe, ɵɵdirectiveInject, ɵɵdisableBindings, ɵɵelement, ɵɵelementContainer, ɵɵelementContainerEnd, ɵɵelementContainerStart, ɵɵelementEnd, ɵɵelementStart, ɵɵenableBindings, ɵɵgetCurrentView, ɵɵgetInheritedFactory, ɵɵhostProperty, ɵɵi18n, ɵɵi18nApply, ɵɵi18nAttributes, ɵɵi18nEnd, ɵɵi18nExp, ɵɵi18nPostprocess, ɵɵi18nStart, ɵɵinject, ɵɵinjectAttribute, ɵɵinvalidFactory, ɵɵinvalidFactoryDep, ɵɵlistener, ɵɵloadQuery, ɵɵnamespaceHTML, ɵɵnamespaceMathML, ɵɵnamespaceSVG, ɵɵnextContext, ɵɵngDeclareClassMetadata, ɵɵngDeclareComponent, ɵɵngDeclareDirective, ɵɵngDeclareFactory, ɵɵngDeclareInjectable, ɵɵngDeclareInjector, ɵɵngDeclareNgModule, ɵɵngDeclarePipe, ɵɵpipe, ɵɵpipeBind1, ɵɵpipeBind2, ɵɵpipeBind3, ɵɵpipeBind4, ɵɵpipeBindV, ɵɵprojection, ɵɵprojectionDef, ɵɵproperty, ɵɵpropertyInterpolate, ɵɵpropertyInterpolate1, ɵɵpropertyInterpolate2, ɵɵpropertyInterpolate3, ɵɵpropertyInterpolate4, ɵɵpropertyInterpolate5, ɵɵpropertyInterpolate6, ɵɵpropertyInterpolate7, ɵɵpropertyInterpolate8, ɵɵpropertyInterpolateV, ɵɵpureFunction0, ɵɵpureFunction1, ɵɵpureFunction2, ɵɵpureFunction3, ɵɵpureFunction4, ɵɵpureFunction5, ɵɵpureFunction6, ɵɵpureFunction7, ɵɵpureFunction8, ɵɵpureFunctionV, ɵɵqueryRefresh, ɵɵreference, ɵɵregisterNgModuleType, ɵɵresetView, ɵɵresolveBody, ɵɵresolveDocument, ɵɵresolveWindow, ɵɵrestoreView, ɵɵsanitizeHtml, ɵɵsanitizeResourceUrl, ɵɵsanitizeScript, ɵɵsanitizeStyle, ɵɵsanitizeUrl, ɵɵsanitizeUrlOrResourceUrl, ɵɵsetComponentScope, ɵɵsetNgModuleScope, ɵɵstyleMap, ɵɵstyleMapInterpolate1, ɵɵstyleMapInterpolate2, ɵɵstyleMapInterpolate3, ɵɵstyleMapInterpolate4, ɵɵstyleMapInterpolate5, ɵɵstyleMapInterpolate6, ɵɵstyleMapInterpolate7, ɵɵstyleMapInterpolate8, ɵɵstyleMapInterpolateV, ɵɵstyleProp, ɵɵstylePropInterpolate1, ɵɵstylePropInterpolate2, ɵɵstylePropInterpolate3, ɵɵstylePropInterpolate4, ɵɵstylePropInterpolate5, ɵɵstylePropInterpolate6, ɵɵstylePropInterpolate7, ɵɵstylePropInterpolate8, ɵɵstylePropInterpolateV, ɵɵsyntheticHostListener, ɵɵsyntheticHostProperty, ɵɵtemplate, ɵɵtemplateRefExtractor, ɵɵtext, ɵɵtextInterpolate, ɵɵtextInterpolate1, ɵɵtextInterpolate2, ɵɵtextInterpolate3, ɵɵtextInterpolate4, ɵɵtextInterpolate5, ɵɵtextInterpolate6, ɵɵtextInterpolate7, ɵɵtextInterpolate8, ɵɵtextInterpolateV, ɵɵtrustConstantHtml, ɵɵtrustConstantResourceUrl, ɵɵvalidateIframeAttribute, ɵɵviewQuery)
./node_modules/@project-sunbird/web-extensions/fesm2020/project-sunbird-web-extensions.mjs:111:26-61 - Error: export 'ReflectiveInjector' (imported as 'ReflectiveInjector') was not found in '@angular/core' (possible exports: ANIMATION_MODULE_TYPE, APP_BOOTSTRAP_LISTENER, APP_ID, APP_INITIALIZER, ApplicationInitStatus, ApplicationModule, ApplicationRef, Attribute, COMPILER_OPTIONS, CSP_NONCE, CUSTOM_ELEMENTS_SCHEMA, ChangeDetectionStrategy, ChangeDetectorRef, Compiler, CompilerFactory, Component, ComponentFactory, ComponentFactoryResolver, ComponentRef, ContentChild, ContentChildren, DEFAULT_CURRENCY_CODE, DebugElement, DebugEventListener, DebugNode, DefaultIterableDiffer, DestroyRef, Directive, ENVIRONMENT_INITIALIZER, ElementRef, EmbeddedViewRef, EnvironmentInjector, ErrorHandler, EventEmitter, Host, HostBinding, HostListener, INJECTOR, Inject, InjectFlags, Injectable, InjectionToken, Injector, Input, IterableDiffers, KeyValueDiffers, LOCALE_ID, MissingTranslationStrategy, ModuleWithComponentFactories, NO_ERRORS_SCHEMA, NgModule, NgModuleFactory, NgModuleRef, NgProbeToken, NgZone, Optional, Output, PACKAGE_ROOT_URL, PLATFORM_ID, PLATFORM_INITIALIZER, Pipe, PlatformRef, Query, QueryList, Renderer2, RendererFactory2, RendererStyleFlags2, Sanitizer, SecurityContext, Self, SimpleChange, SkipSelf, TRANSLATIONS, TRANSLATIONS_FORMAT, TemplateRef, Testability, TestabilityRegistry, TransferState, Type, VERSION, Version, ViewChild, ViewChildren, ViewContainerRef, ViewEncapsulation, ViewRef, afterNextRender, afterRender, asNativeElements, assertInInjectionContext, assertPlatform, booleanAttribute, computed, createComponent, createEnvironmentInjector, createNgModule, createNgModuleRef, createPlatform, createPlatformFactory, defineInjectable, destroyPlatform, effect, enableProdMode, forwardRef, getDebugNode, getModuleFactory, getNgModuleById, getPlatform, importProvidersFrom, inject, isDevMode, isSignal, isStandalone, makeEnvironmentProviders, makeStateKey, mergeApplicationConfig, numberAttribute, platformCore, provideZoneChangeDetection, reflectComponentType, resolveForwardRef, runInInjectionContext, setTestabilityGetter, signal, untracked, ɵALLOW_MULTIPLE_PLATFORMS, ɵAfterRenderEventManager, ɵComponentFactory, ɵConsole, ɵDEFAULT_LOCALE_ID, ɵENABLED_SSR_FEATURES, ɵINJECTOR_SCOPE, ɵIS_HYDRATION_DOM_REUSE_ENABLED, ɵInitialRenderPendingTasks, ɵLContext, ɵLifecycleHooksFeature, ɵLocaleDataIndex, ɵNG_COMP_DEF, ɵNG_DIR_DEF, ɵNG_ELEMENT_ID, ɵNG_INJ_DEF, ɵNG_MOD_DEF, ɵNG_PIPE_DEF, ɵNG_PROV_DEF, ɵNOT_FOUND_CHECK_ONLY_ELEMENT_INJECTOR, ɵNO_CHANGE, ɵNgModuleFactory, ɵNoopNgZone, ɵReflectionCapabilities, ɵRender3ComponentFactory, ɵRender3ComponentRef, ɵRender3NgModuleRef, ɵRuntimeError, ɵSSR_CONTENT_INTEGRITY_MARKER, ɵTESTABILITY, ɵTESTABILITY_GETTER, ɵViewRef, ɵXSS_SECURITY_URL, ɵ_sanitizeHtml, ɵ_sanitizeUrl, ɵallowSanitizationBypassAndThrow, ɵannotateForHydration, ɵbypassSanitizationTrustHtml, ɵbypassSanitizationTrustResourceUrl, ɵbypassSanitizationTrustScript, ɵbypassSanitizationTrustStyle, ɵbypassSanitizationTrustUrl, ɵclearResolutionOfComponentResourcesQueue, ɵcompileComponent, ɵcompileDirective, ɵcompileNgModule, ɵcompileNgModuleDefs, ɵcompileNgModuleFactory, ɵcompilePipe, ɵconvertToBitFlags, ɵcreateInjector, ɵdefaultIterableDiffers, ɵdefaultKeyValueDiffers, ɵdetectChanges, ɵdevModeEqual, ɵfindLocaleData, ɵflushModuleScopingQueueAsMuchAsPossible, ɵformatRuntimeError, ɵgetDebugNode, ɵgetDirectives, ɵgetHostElement, ɵgetInjectableDef, ɵgetLContext, ɵgetLocaleCurrencyCode, ɵgetLocalePluralCase, ɵgetSanitizationBypassType, ɵgetUnknownElementStrictMode, ɵgetUnknownPropertyStrictMode, ɵglobal, ɵinjectChangeDetectorRef, ɵinternalCreateApplication, ɵisBoundToModule, ɵisEnvironmentProviders, ɵisInjectable, ɵisNgModule, ɵisPromise, ɵisSubscribable, ɵnoSideEffects, ɵpatchComponentDefWithScope, ɵpublishDefaultGlobalUtils, ɵpublishGlobalUtil, ɵregisterLocaleData, ɵresetCompiledComponents, ɵresetJitOptions, ɵresolveComponentResources, ɵsetAllowDuplicateNgModuleIdsForTest, ɵsetAlternateWeakRefImpl, ɵsetClassMetadata, ɵsetCurrentInjector, ɵsetDocument, ɵsetInjectorProfilerContext, ɵsetLocaleId, ɵsetUnknownElementStrictMode, ɵsetUnknownPropertyStrictMode, ɵstore, ɵstringify, ɵtransitiveScopesFor, ɵunregisterLocaleData, ɵunwrapSafeValue, ɵwithDomHydration, ɵɵCopyDefinitionFeature, ɵɵFactoryTarget, ɵɵHostDirectivesFeature, ɵɵInheritDefinitionFeature, ɵɵInputTransformsFeature, ɵɵNgOnChangesFeature, ɵɵProvidersFeature, ɵɵStandaloneFeature, ɵɵadvance, ɵɵattribute, ɵɵattributeInterpolate1, ɵɵattributeInterpolate2, ɵɵattributeInterpolate3, ɵɵattributeInterpolate4, ɵɵattributeInterpolate5, ɵɵattributeInterpolate6, ɵɵattributeInterpolate7, ɵɵattributeInterpolate8, ɵɵattributeInterpolateV, ɵɵclassMap, ɵɵclassMapInterpolate1, ɵɵclassMapInterpolate2, ɵɵclassMapInterpolate3, ɵɵclassMapInterpolate4, ɵɵclassMapInterpolate5, ɵɵclassMapInterpolate6, ɵɵclassMapInterpolate7, ɵɵclassMapInterpolate8, ɵɵclassMapInterpolateV, ɵɵclassProp, ɵɵcontentQuery, ɵɵdefer, ɵɵdefineComponent, ɵɵdefineDirective, ɵɵdefineInjectable, ɵɵdefineInjector, ɵɵdefineNgModule, ɵɵdefinePipe, ɵɵdirectiveInject, ɵɵdisableBindings, ɵɵelement, ɵɵelementContainer, ɵɵelementContainerEnd, ɵɵelementContainerStart, ɵɵelementEnd, ɵɵelementStart, ɵɵenableBindings, ɵɵgetCurrentView, ɵɵgetInheritedFactory, ɵɵhostProperty, ɵɵi18n, ɵɵi18nApply, ɵɵi18nAttributes, ɵɵi18nEnd, ɵɵi18nExp, ɵɵi18nPostprocess, ɵɵi18nStart, ɵɵinject, ɵɵinjectAttribute, ɵɵinvalidFactory, ɵɵinvalidFactoryDep, ɵɵlistener, ɵɵloadQuery, ɵɵnamespaceHTML, ɵɵnamespaceMathML, ɵɵnamespaceSVG, ɵɵnextContext, ɵɵngDeclareClassMetadata, ɵɵngDeclareComponent, ɵɵngDeclareDirective, ɵɵngDeclareFactory, ɵɵngDeclareInjectable, ɵɵngDeclareInjector, ɵɵngDeclareNgModule, ɵɵngDeclarePipe, ɵɵpipe, ɵɵpipeBind1, ɵɵpipeBind2, ɵɵpipeBind3, ɵɵpipeBind4, ɵɵpipeBindV, ɵɵprojection, ɵɵprojectionDef, ɵɵproperty, ɵɵpropertyInterpolate, ɵɵpropertyInterpolate1, ɵɵpropertyInterpolate2, ɵɵpropertyInterpolate3, ɵɵpropertyInterpolate4, ɵɵpropertyInterpolate5, ɵɵpropertyInterpolate6, ɵɵpropertyInterpolate7, ɵɵpropertyInterpolate8, ɵɵpropertyInterpolateV, ɵɵpureFunction0, ɵɵpureFunction1, ɵɵpureFunction2, ɵɵpureFunction3, ɵɵpureFunction4, ɵɵpureFunction5, ɵɵpureFunction6, ɵɵpureFunction7, ɵɵpureFunction8, ɵɵpureFunctionV, ɵɵqueryRefresh, ɵɵreference, ɵɵregisterNgModuleType, ɵɵresetView, ɵɵresolveBody, ɵɵresolveDocument, ɵɵresolveWindow, ɵɵrestoreView, ɵɵsanitizeHtml, ɵɵsanitizeResourceUrl, ɵɵsanitizeScript, ɵɵsanitizeStyle, ɵɵsanitizeUrl, ɵɵsanitizeUrlOrResourceUrl, ɵɵsetComponentScope, ɵɵsetNgModuleScope, ɵɵstyleMap, ɵɵstyleMapInterpolate1, ɵɵstyleMapInterpolate2, ɵɵstyleMapInterpolate3, ɵɵstyleMapInterpolate4, ɵɵstyleMapInterpolate5, ɵɵstyleMapInterpolate6, ɵɵstyleMapInterpolate7, ɵɵstyleMapInterpolate8, ɵɵstyleMapInterpolateV, ɵɵstyleProp, ɵɵstylePropInterpolate1, ɵɵstylePropInterpolate2, ɵɵstylePropInterpolate3, ɵɵstylePropInterpolate4, ɵɵstylePropInterpolate5, ɵɵstylePropInterpolate6, ɵɵstylePropInterpolate7, ɵɵstylePropInterpolate8, ɵɵstylePropInterpolateV, ɵɵsyntheticHostListener, ɵɵsyntheticHostProperty, ɵɵtemplate, ɵɵtemplateRefExtractor, ɵɵtext, ɵɵtextInterpolate, ɵɵtextInterpolate1, ɵɵtextInterpolate2, ɵɵtextInterpolate3, ɵɵtextInterpolate4, ɵɵtextInterpolate5, ɵɵtextInterpolate6, ɵɵtextInterpolate7, ɵɵtextInterpolate8, ɵɵtextInterpolateV, ɵɵtrustConstantHtml, ɵɵtrustConstantResourceUrl, ɵɵvalidateIframeAttribute, ɵɵviewQuery)
Error: src/app/app.module.ts:41:14 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
 41     imports: [
                 ~
 42         BrowserAnimationsModule,
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
... 
 66         AppRoutingModule // don't add any module below this because it contains wildcard route
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 67     ],
    ~~~~~
Error: src/app/app.module.ts:41:14 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
 41     imports: [
                 ~
 42         BrowserAnimationsModule,
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
... 
 66         AppRoutingModule // don't add any module below this because it contains wildcard route
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 67     ],
    ~~~~~
Error: src/app/app.module.ts:43:9 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
43         CoreModule,
           ~~~~~~~~~~
Error: src/app/app.module.ts:46:9 - error NG6002: 'SuiModalModule' does not appear to be an NgModule class.
46         SuiModalModule,
           ~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/modal/modal.module.d.ts:1:22
    1 export declare class SuiModalModule {
                           ~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiModalModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/app.module.ts:59:9 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
59         SharedFeatureModule,
           ~~~~~~~~~~~~~~~~~~~
Error: src/app/app.module.ts:60:9 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
60         UserOnboardingModule,
           ~~~~~~~~~~~~~~~~~~~~
Error: src/app/modules/badging/badging.module.ts:11:14 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
 11     imports: [
                 ~
 12         CommonModule,
    ~~~~~~~~~~~~~~~~~~~~~
... 
 16         MatTooltipModule
    ~~~~~~~~~~~~~~~~~~~~~~~~
 17     ],
    ~~~~~
Error: src/app/modules/badging/badging.module.ts:13:9 - error NG6002: 'SuiModule' does not appear to be an NgModule class.
13         SuiModule,
           ~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/sui.module.d.ts:1:22
    1 export declare class SuiModule {
                           ~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/certificate/certificate.module.ts:34:5 - error NG6002: 'SuiModalModule' does not appear to be an NgModule class.
34     SuiModalModule,
       ~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/modal/modal.module.d.ts:1:22
    1 export declare class SuiModalModule {
                           ~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiModalModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/certificate/certificate.module.ts:37:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
37     SharedModule,
       ~~~~~~~~~~~~
Error: src/app/modules/certificate/certificate.module.ts:39:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
39     PlayerHelperModule,
       ~~~~~~~~~~~~~~~~~~
Error: src/app/modules/certificate/certificate.module.ts:40:5 - error NG6002: 'SuiSelectModule' does not appear to be an NgModule class.
40     SuiSelectModule,
       ~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/select/select.module.d.ts:1:22
    1 export declare class SuiSelectModule {
                           ~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiSelectModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/certificate/certificate.module.ts:41:5 - error NG6002: 'SuiDropdownModule' does not appear to be an NgModule class.
41     SuiDropdownModule,
       ~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/dropdown/dropdown.module.d.ts:1:22
    1 export declare class SuiDropdownModule {
                           ~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiDropdownModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/certificate/certificate.module.ts:42:5 - error NG6002: 'SuiPopupModule' does not appear to be an NgModule class.
42     SuiPopupModule,
       ~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/popup/popup.module.d.ts:1:22
    1 export declare class SuiPopupModule {
                           ~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiPopupModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/certificate/certificate.module.ts:45:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
45     SharedFeatureModule
       ~~~~~~~~~~~~~~~~~~~
Error: src/app/modules/content-search/content-search.module.ts:23:9 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
23         SharedFeatureModule,
           ~~~~~~~~~~~~~~~~~~~
Error: src/app/modules/content-search/content-search.module.ts:30:9 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
30         SharedModule,
           ~~~~~~~~~~~~
Error: src/app/modules/content-search/content-search.module.ts:32:9 - error NG6002: 'SuiModalModule' does not appear to be an NgModule class.
32         SuiModalModule, SuiProgressModule, SuiAccordionModule,
           ~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/modal/modal.module.d.ts:1:22
    1 export declare class SuiModalModule {
                           ~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiModalModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/content-search/content-search.module.ts:32:25 - error NG6002: 'SuiProgressModule' does not appear to be an NgModule class.
32         SuiModalModule, SuiProgressModule, SuiAccordionModule,
                           ~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/progress/progress.module.d.ts:1:22
    1 export declare class SuiProgressModule {
                           ~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiProgressModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/content-search/content-search.module.ts:32:44 - error NG6002: 'SuiAccordionModule' does not appear to be an NgModule class.
32         SuiModalModule, SuiProgressModule, SuiAccordionModule,
                                              ~~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/accordion/accordion.module.d.ts:1:22
    1 export declare class SuiAccordionModule {
                           ~~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiAccordionModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/content-search/content-search.module.ts:33:9 - error NG6002: 'SuiTabsModule' does not appear to be an NgModule class.
33         SuiTabsModule, SuiSelectModule, SuiDimmerModule, SuiCollapseModule, SuiDropdownModule, SbSearchFilterModule,
           ~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/tabs/tab.module.d.ts:1:22
    1 export declare class SuiTabsModule {
                           ~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiTabsModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/content-search/content-search.module.ts:33:24 - error NG6002: 'SuiSelectModule' does not appear to be an NgModule class.
33         SuiTabsModule, SuiSelectModule, SuiDimmerModule, SuiCollapseModule, SuiDropdownModule, SbSearchFilterModule,
                          ~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/select/select.module.d.ts:1:22
    1 export declare class SuiSelectModule {
                           ~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiSelectModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/content-search/content-search.module.ts:33:41 - error NG6002: 'SuiDimmerModule' does not appear to be an NgModule class.
33         SuiTabsModule, SuiSelectModule, SuiDimmerModule, SuiCollapseModule, SuiDropdownModule, SbSearchFilterModule,
                                           ~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/dimmer/dimmer.module.d.ts:1:22
    1 export declare class SuiDimmerModule {
                           ~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiDimmerModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/content-search/content-search.module.ts:33:58 - error NG6002: 'SuiCollapseModule' does not appear to be an NgModule class.
33         SuiTabsModule, SuiSelectModule, SuiDimmerModule, SuiCollapseModule, SuiDropdownModule, SbSearchFilterModule,
                                                            ~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/collapse/collapse.module.d.ts:1:22
    1 export declare class SuiCollapseModule {
                           ~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiCollapseModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/content-search/content-search.module.ts:33:77 - error NG6002: 'SuiDropdownModule' does not appear to be an NgModule class.
33         SuiTabsModule, SuiSelectModule, SuiDimmerModule, SuiCollapseModule, SuiDropdownModule, SbSearchFilterModule,
                                                                               ~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/dropdown/dropdown.module.d.ts:1:22
    1 export declare class SuiDropdownModule {
                           ~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiDropdownModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:29:5 - error NG6002: 'SuiSelectModule' does not appear to be an NgModule class.
29     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule,
       ~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/select/select.module.d.ts:1:22
    1 export declare class SuiSelectModule {
                           ~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiSelectModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:29:22 - error NG6002: 'SuiModalModule' does not appear to be an NgModule class.
29     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule,
                        ~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/modal/modal.module.d.ts:1:22
    1 export declare class SuiModalModule {
                           ~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiModalModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:29:38 - error NG6002: 'SuiAccordionModule' does not appear to be an NgModule class.
29     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule,
                                        ~~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/accordion/accordion.module.d.ts:1:22
    1 export declare class SuiAccordionModule {
                           ~~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiAccordionModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:29:58 - error NG6002: 'SuiPopupModule' does not appear to be an NgModule class.
29     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule,
                                                            ~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/popup/popup.module.d.ts:1:22
    1 export declare class SuiPopupModule {
                           ~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiPopupModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:29:74 - error NG6002: 'SuiDropdownModule' does not appear to be an NgModule class.
29     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule,
                                                                            ~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/dropdown/dropdown.module.d.ts:1:22
    1 export declare class SuiDropdownModule {
                           ~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiDropdownModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:29:93 - error NG6002: 'SuiProgressModule' does not appear to be an NgModule class.
29     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule,
                                                                                               ~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/progress/progress.module.d.ts:1:22
    1 export declare class SuiProgressModule {
                           ~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiProgressModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:30:5 - error NG6002: 'SuiRatingModule' does not appear to be an NgModule class.
30     SuiRatingModule, SuiCollapseModule,
       ~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/rating/rating.module.d.ts:1:22
    1 export declare class SuiRatingModule {
                           ~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiRatingModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:30:22 - error NG6002: 'SuiCollapseModule' does not appear to be an NgModule class.
30     SuiRatingModule, SuiCollapseModule,
                        ~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/collapse/collapse.module.d.ts:1:22
    1 export declare class SuiCollapseModule {
                           ~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiCollapseModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/core/core.module.ts:31:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
31     SharedModule,
       ~~~~~~~~~~~~
Error: src/app/modules/core/core.module.ts:38:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
38     LocationModule,
       ~~~~~~~~~~~~~~
Error: src/app/modules/core/core.module.ts:39:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
39     NotificationModule,
       ~~~~~~~~~~~~~~~~~~
Error: src/app/modules/dashboard/dashboard.module.ts:47:5 - error NG6002: 'ChartsModule' does not appear to be an NgModule class.
47     ChartsModule,
       ~~~~~~~~~~~~
  node_modules/ng2-charts/lib/charts.module.d.ts:1:22
    1 export declare class ChartsModule {
                           ~~~~~~~~~~~~
    This likely means that the library (ng2-charts) which declares ChartsModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/dashboard/dashboard.module.ts:48:5 - error NG6002: 'SuiModule' does not appear to be an NgModule class.
48     SuiModule,
       ~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/sui.module.d.ts:1:22
    1 export declare class SuiModule {
                           ~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/dashboard/dashboard.module.ts:49:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
49     SharedModule,
       ~~~~~~~~~~~~
Error: src/app/modules/dashboard/dashboard.module.ts:54:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
54     DiscussionModule,
       ~~~~~~~~~~~~~~~~
Error: src/app/modules/dashboard/dashboard.module.ts:60:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
60     SharedFeatureModule,
       ~~~~~~~~~~~~~~~~~~~
Error: src/app/modules/dial-code-search/dial-code-search.module.ts:19:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
19     CoreModule,
       ~~~~~~~~~~
Error: src/app/modules/dial-code-search/dial-code-search.module.ts:20:5 - error NG6002: This import contains errors, which may affect components that depend on this NgModule.
20     SharedModule,
       ~~~~~~~~~~~~
Error: src/app/modules/dial-code-search/dial-code-search.module.ts:22:5 - error NG6002: 'SuiSelectModule' does not appear to be an NgModule class.
22     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule, SuiDimmerModule,
       ~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/select/select.module.d.ts:1:22
    1 export declare class SuiSelectModule {
                           ~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiSelectModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/dial-code-search/dial-code-search.module.ts:22:22 - error NG6002: 'SuiModalModule' does not appear to be an NgModule class.
22     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule, SuiDimmerModule,
                        ~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/modal/modal.module.d.ts:1:22
    1 export declare class SuiModalModule {
                           ~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiModalModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/dial-code-search/dial-code-search.module.ts:22:38 - error NG6002: 'SuiAccordionModule' does not appear to be an NgModule class.
22     SuiSelectModule, SuiModalModule, SuiAccordionModule, SuiPopupModule, SuiDropdownModule, SuiProgressModule, SuiDimmerModule,
                                        ~~~~~~~~~~~~~~~~~~
  node_modules/ng2-semantic-ui-v9/modules/accordion/accordion.module.d.ts:1:22
    1 export declare class SuiAccordionModule {
                           ~~~~~~~~~~~~~~~~~~
    This likely means that the library (ng2-semantic-ui-v9) which declares SuiAccordionModule is not compatible with Angular Ivy. Check if a newer version of the library is available, and update if so. Also consider checking with the library's authors to see if the library is expected to be compatible with Ivy.
Error: src/app/modules/dial-code-search/dial-code-search.module.ts:22:58 - error NG6002: 'SuiPopupModule' does not appear to be an NgModule class.

```

1.  Updated the @project-sunbird/web-extensions : “8.0.1” library to V16 and resolved the ReflectiveInjector Error and updated the latest package in Portal issue got resolved

    PR link : [https://github.com/project-sunbird/sunbird-ext-framework/pull/62/files](https://github.com/project-sunbird/sunbird-ext-framework/pull/62/files)
2.  Updated the @project-sunbird/ng2-semantic-ui : “8.0.3” library to V16 and resolved the ReflectiveInjector Error and updated the latest package in Portal instead of ng2-semantic-ui-v9 and the issue got resolved

    PR link : [https://github.com/project-sunbird/ng2-semantic-ui/tree/8.0.0\_v16](https://github.com/project-sunbird/ng2-semantic-ui/tree/8.0.0\_v16)

## Reference Link

Jira Ticket : [ED-3612 System Jira](https://browse/ED-3612)

Angular MIgration Guide: [https://update.angular.io/?l=3\&v=14.0-15.0](https://update.angular.io/?l=3\&v=14.0-15.0)

***

\[\[category.storage-team]] \[\[category.confluence]]
