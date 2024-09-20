# The-Design-Approach-for-Bundle-Katex-library-only-if-Math-formula-is-used-in-the-question.

**Bundling Katex Library only when Math Formula is used in Question.**

**Existing Behavior** :

Currently, we are generating the QuestionSet ECML by using BasePlugin 'toECML' function, So we were bundling every Dependency by comparing String of QuestionBody.data.

**Approach:**

Stage-manager.js in content-editor,

Apply filter on toECML on stage-manager of content-editor, we have plugin object containing the questionBody,

* Validation of question whether having math formula or not, using questionBody object which contains question text compare whether having 'data-math' && 'math-text'.

JSON.parse(plugin.\_question.body).data.data.question.text

*   Validation of Question-options whether having math formula or not, using questionBody which contain

    * **MTF** question contain: **optionsLHS** & **optionsRHS** on questionBody
    * **MCQ** questions contain: **options** or **sentence** (Reordering questions)
    * **FTB** questions contain: **answer** objects

    apply filter for each options(MCQ), sentence(MCQ), answer(FTB), optionLHS & optionRHS containing 'data-math' && 'math-text'.

Once we validated having 'data-math' && 'math-text' on questions and options, we enable or disable

katex libraries on ECML. If 'data-math' && 'math-text' is available in questions or options we are enable them to load on manifest dependency on ECML, if they are not, removing Katex libraries from manifest dependency on ECML.

Workflow:

![](<../../../../Design/FullExport/images/storage/untitled (1).png>)

***

\[\[category.storage-team]] \[\[category.confluence]]
