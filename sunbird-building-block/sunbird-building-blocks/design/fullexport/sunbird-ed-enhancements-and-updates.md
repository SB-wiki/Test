# Sunbird-Ed-Enhancements-and-Updates

### Introduction

As we embark on the journey to design and develop Ed solution tailored to our specific educational needs, we face a critical decision: should we modify and extend an existing comprehensive Sunbird Ed BB which is K12 specific implementation, or should we create a new, simpler Ed implementation  that reuses some of Sunbird Ed's existing features and code?

This design document seeks to provide a clear, comparative analysis of these two approaches. By exploring the pros and cons of modifying an existing, robust software versus building a new, streamlined solution.

### Approach 1: Modifying Sunbird Ed

In this approach, the existing Sunbird Ed platform will be modified to simplify adaptation, which involves removing certain features, modifying others, generalizing some, and adding new ones as needed.

### Approach 2: Building a New Light version with Reused Sunbird Ed Code

In contrast, this approach involves developing a new, simplified Sunbird Ed by selectively reusing components from Sunbird Ed's codebase. This allows us to create a lightweight solution tailored precisely to our needs while avoiding the complexity of modifying a large existing system.

Below explains the comparison between the two approaches

| **Aspect**     | **Modification**                                                   | **Building new light weight**                                                                                                     |
| -------------- | ------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| Complexity     | High complexity due to a large number of features                  | Reduced complexity by focusing on essential features                                                                              |
| Generalization | Need modification of all the features                              | Can be build in generic way to customize                                                                                          |
| Tech debt      | It will be there with unused code and out dated tech stack verions | Automatically removed since required components will taken from existing code and also easy to update to latest version as parts. |
| Theme          | Needs creation of complete new theme from scratch                  | Can reuse the existing components and build simple modifiable theme                                                               |
|                |                                                                    |                                                                                                                                   |

***

\[\[category.storage-team]] \[\[category.confluence]]
