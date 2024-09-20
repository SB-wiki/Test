# CircleCI-Configuration-

Create a CircleCi configuration in the repository root directory. i.e _**.circleci/config.yml**_

**Sample jobs configuration:**

```
version: 2
jobs:
  build:
    working_directory: ~/project
    docker:
      - image: circleci/node:4.8.2-jessie
    steps:
      - checkout
      - run:
          name: Update npm
          command: 'sudo npm install -g npm@latest'
      - restore_cache:
          key: dependency-cache-{{ checksum "package-lock.json" }}
      - run:
          name: Install npm wee
          command: npm install
      - save_cache:
          key: dependency-cache-{{ checksum "package-lock.json" }}
          paths:
            - node_modules
```

Find the pre-build CircleCI docker images here: [https://circleci.com/docs/2.0/circleci-images/](https://circleci.com/docs/2.0/circleci-images/)

**Adding jobs to the workflow:**

```
workflows:
  version: 2
  build_and_test:
    jobs:
      - build
```

**Complete config file with multiple job configuration:**

```
version: 2
jobs:
  build:
    working_directory: ~/project
    docker:
      - image: circleci/node:4.8.2-jessie
    steps:
      - checkout
      - run:
          name: Update npm
          command: 'sudo npm install -g npm@latest'
      - restore_cache:
          key: dependency-cache-{{ checksum "package-lock.json" }}
      - run:
          name: Install npm wee
          command: npm install
      - save_cache:
          key: dependency-cache-{{ checksum "package-lock.json" }}
          paths:
            - node_modules

  test:
    docker:
      - image: circleci/node:4.8.2-jessie
      - image: mongo:3.4.4-jessie
    steps:
      - checkout
      - run:
          name: Test
          command: npm test
      - run:
          name: Generate code coverage
          command: './node_modules/.bin/nyc report --reporter=text-lcov'
      - store_artifacts:
          path: test-results.xml
          prefix: tests
      - store_artifacts:
          path: coverage
          prefix: coverage



workflows:
  version: 2
  build_and_test:
    jobs:
      - build
      - test
```

**Configuration for setting up email notification for PR:**

```
commands:
  notify_job_status:
    steps:
     - run:
         name: On success
         when: on_success
         command: |
                 curl -X POST -u $GITHUB_USER_TOKEN:x-oauth-basic -d '{"body": "'@${CIRCLE_PR_USERNAME}' Build Success!" }' 'https://api.github.com/repos/'${CIRCLE_PROJECT_USERNAME}'/'${CIRCLE_PROJECT_REPONAME}'/issues/'${CIRCLE_PR_NUMBER}'/comments'
             
     - run:
         name: On fail
         when: on_fail
         command: |
                 curl -X POST -u $GITHUB_USER_TOKEN:x-oauth-basic -d '{"body": "'@${CIRCLE_PR_USERNAME}' Build Failed, Please check" }' 'https://api.github.com/repos/'${CIRCLE_PROJECT_USERNAME}'/'${CIRCLE_PROJECT_REPONAME}'/issues/'${CIRCLE_PR_NUMBER}'/comments'
```

**Complete Job config file example:**

```
version: 2.1

commands:
  notify_job_status:
    steps:
     - run:
         name: On success
         when: on_success
         command: |
                 curl -X POST -u $GITHUB_USER_TOKEN:x-oauth-basic -d '{"body": "'@${CIRCLE_PR_USERNAME}' Build Success!" }' 'https://api.github.com/repos/'${CIRCLE_PROJECT_USERNAME}'/'${CIRCLE_PROJECT_REPONAME}'/issues/'${CIRCLE_PR_NUMBER}'/comments'
             
     - run:
         name: On failure
         when: on_failure
         command: |
                 curl -X POST -u $GITHUB_USER_TOKEN:x-oauth-basic -d '{"body": "'@${CIRCLE_PR_USERNAME}' Build Failed, Please check" }' 'https://api.github.com/repos/'${CIRCLE_PROJECT_USERNAME}'/'${CIRCLE_PROJECT_REPONAME}'/issues/'${CIRCLE_PR_NUMBER}'/comments'



jobs:
  ep-build:
    working_directory: ~/dp/data-pipeline
    machine: true
    steps:
      - checkout:
          path: ~/dp
      - restore_cache:
          key: dependency-cache-{{ checksum "pom.xml" }}
      - save_cache:
          key: dependency-cache-{{ checksum "pom.xml" }}
          paths: ~/.m2
      - run:
          name: sonar
          command: |
                 mvn verify -Dlog4j.configuration=./logs sonar:sonar -Dsonar.projectKey=project-sunbird_sunbird-data-pipeline -Dsonar.organization=project-sunbird -Dsonar.host.url=https://sonarcloud.io -Dsonar.coverage.jacoco.xmlReportPaths=/home/circleci/dp/data-pipeline/assessment-aggregator/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/content-cache-updater/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/de-normalization/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/de-duplication/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/derived-de-duplication/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/device-profile-updater/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/druid-events-validator/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/ep-core/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/ep-telemetry-reader/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/events-router/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/telemetry-extractor/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/telemetry-location-updater/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/telemetry-router/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/telemetry-validator/target/coverage-reports/jacoco-ut/jacoco.xml,/home/circleci/dp/data-pipeline/user-cache-updater/target/coverage-reports/jacoco-ut/jacoco.xml
      - notify_job_status


workflows:
  version: 2.1
  build_and_test:
    jobs:
      - ep-build
```

\*\*Links for reference:  \*\*

**https://circleci.com/docs/2.0/config-intro/**

**https://circleci.com/docs/2.0/sample-config/**

***

\[\[category.storage-team]] \[\[category.confluence]]
