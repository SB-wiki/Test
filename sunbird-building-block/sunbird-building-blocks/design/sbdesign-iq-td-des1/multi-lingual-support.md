# Multi-Lingual-Support

## Objective

Achieve multi-lingual support in inQuiry

## Fields that needs multilingual support

* body
* answer
* instructions
* feedback
* hints

## User Flow

### Scenario 1 : Create and consume questions & question set in any language

1. Creator / Editor
   1. A dropdown will be present at the beginning of Question or Question set creation.
   2. A default list of languages will be available in the drop down. Additional languages to be displayed in the dropdown list can be configured.
   3. The language will be pre-selected as English by default.
   4. The user will be able to choose any language from the dropdown menu.
   5. Allow free-text ie. the user should be able to type a language that is not in the drop down
   6. Upon selecting a language, the corresponding language code is stored.
   7. Option 1 :
   8. There will be a drop-down across each of the fields, for which multiple languages are supported.
   9. The language selected for the first field, will be retained as the default for the rest of the fields, unless selected otherwise.&#x20;
   10. Eg. While creating a question set, if the creator first chooses the language for the ‘instructions’ field as `Hindi`, the rest of the fields - ‘body’, ‘options’ etc, should automatically have ‘Hindi’ as default language.
   11. Option 2 :
   12. There will be only one drop down where the language is selected, and will be applied for all fields within a question/question set.
   13. Option 3:
   14. Dropdown for language selection will be present at 3 places :
   15. At Question Set Root node, where it will cover the following fields :
   16. Name (Need to add QuML spec)
   17. Instructions
   18. At each Section, where it will cover the following fields :
   19. Instruction
   20. At each Question, where it will cover the following fields:
   21. Question body
   22. Options
   23. Solution
   24. Feedback
   25. Hint
   26. Creator is able to type or copy paste in any language (question body/instruction/options..).
   27. Validate if the entered language is same as the selected language.
   28. If the entered language is different from the selected language, an error message will be displayed. This is not going to be a validation, it will just be an alert.
2. Player
   1. A dropdown option will be present at the beginning of the Question or Question set, that is selected for playing.
   2. For eg : Alongside the button for editing the player configurations, add another dropdown for the language selection.
   3. The drop down will be populated based on the languages that are available in the question set or question
   4. Eg 1 : If a question set contains questions that are in English and in Hindi, the dropdown will show English & Hindi only.
   5. The user will be able to choose any language based on the available languages in the dropdown.
   6. No support for free-text ie the user can only choose from the existing options and cannot enter any type in a new entry
   7. At the question set level
   8. The player will only display the questions in the question set, which are present in the selected language.
   9. For eg:&#x20;
   10. There are 10 questions in a question set. Questions 1,2 & 3 have only English data (body) and&#x20;
   11. questions 4,5,6 & 7 have entries in Hindi and English i.e. the same question is present in both the languages.
   12. &#x20;Questions 8, 9 & 10 have entries only in Hindi.
   13. Upon selecting Hindi from the dropdown, the question set will contain questions 4,5,6,7,8,9,10
   14. At each question level
   15. A dropdown option will be present at the beginning (could be near the progress bar info legend)
   16. The dropdown will display only the languages in which the question body is present.
   17. Upon selecting a language from the dropdown, the question will be displayed in the selected language.
   18. By default the language will be English
   19. If the options are not present in the selected language, display the options from the default language.
   20. _Selecting value on the question drop-down could override the question set drop-down?_

### Scenario 2 : Create a Question / Question Set in multiple languages

1. Creator
   1. &#x20;User should be able to choose the language(s) from a dropdown and create a question in that language
   2. Creator will be able to select maximum five languages
   3. Dropdown for language selection will be present at 3 places :
   4. At Question Set Root node, where it will cover the following fields :
   5. Name (not multi-lingual right now)
   6. Instructions
   7. At each Section, where it will cover the following fields :
   8. Instruction
   9. At each Question, where it will cover the following fields:
   10. Question body
   11. Options
   12. Solution
   13. Feedback
   14. Hint
   15. Incase the user selects a non-english language, the Google Input Tool prompt pops-up in the selected language.
   16. Incase of MCQ (or other interactive questions), the creator can enter the options in the selected language.
   17. If the language of the entered text is different from the selected language, an error message will be displayed. This is not going to be a validation, it will just be an alert.
   18. Corresponding text boxes for entering questions are displayed for all the selected languages
   19. A button can be displayed which can display the translated text on-demand.
   20. The text box will have the translation of the original text (primary language) in the selected language, which can be edited by the creator.
   21. User will be able to copy the options from any of the previously entered set of options (for eg. in-case of MCQ with options which are numeric values)
   22. User could enter the options for the corresponding language
   23. Similarly for instructions and other fields
2. Player
   1. A dropdown will be present at the beginning of the Question or Question set, that is selected for playing.
   2. The user will be able to choose any language based on the available languages in the dropdown.
   3. The language in the dropdown will be populated based on the languages in which the question / question set is available.
   4. The drop down can have multi-select options ie the user will be able to select multiple languages
   5. Player will be able to select maximum of two languages.
   6. The question / question set will be rendered in the selected language/languages
   7. The question level language selection will override the question set level language selection ie, the user will be able to view the question is any language that is available in the dropdown
   8. \[Question] What will happen when the questions/option/etc has a media file (eg. image) in all the different language entries and while rendering more than one language, the same media will be shown twice?

Reference :

![](<../../../../Design/sbdesign-iq-td-des1/images/storage/Screenshot 2023-02-23 at 11.31.55 AM.png>) ![](<../../../../Design/sbdesign-iq-td-des1/images/storage/Screenshot 2023-02-23 at 11.47.55 AM.png>)

### Scenario 3 : The Editor and Player should support rendering in any language

1. Creator
   1. Will be able to choose any language based on their preference, before entering the Editor
   2. The form on the editor will be loaded in the selected language. Eg : labels, Info etc
   3. Assumption : The entries for the labels and texts for various languages is already stored.
   4. Support scenario 1 & scenario 2
2. Player
   1. Will be able to choose any language based on their preference, before entering the Editor/ Player
   2. Assumption : The dropdown contains only the languages for which is entry to required fields \[TBD]
   3. All the questions, questions sets in the selected language will be loaded.
   4. Select a question of question set to play
   5. Assumption : The entries for the items under menu etc (TBD) are entered in the selected language
   6. Support scenario 1 & scenario 2

***

\[\[category.storage-team]] \[\[category.confluence]]
