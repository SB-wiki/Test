This is a rough document, the process will be streamlined in a future release when we move private kong to Kubernetes. As of now, these APIs need to be added for private kong under the private API list under ansible/roles/internal-kong-api/defaults/main.yml. These API's and the roles / deployment files will be made available on in a future release.




```
private_ml_core_prefix: /private/mlcore
private_ml_project_prefix: /private/mlprojects
private_ml_survey_prefix: /private/mlsurvey

ml_survey_private_url: "http://{{private_ingressgateway_ip}}/ml-survey"
ml_core_private_url:  "http://{{private_ingressgateway_ip}}/ml-core"
ml_project_private_url: "http://{{private_ingressgateway_ip}}/ml-projects"

  - name: EntitiesUpload
    uris: "{{ private_ml_survey_prefix }}/api/v1/entities/bulkCreate"
    upstream_url: "{{ ml_survey_private_url }}/v1/entities/bulkCreate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'registryUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: EntitiesUpdate
    uris: "{{ private_ml_survey_prefix }}/api/v1/entities/bulkUpdate"
    upstream_url: "{{ ml_survey_private_url }}/v1/entities/bulkUpdate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'registryUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: EntitiesMapping
    uris: "{{ private_ml_survey_prefix }}/api/v1/entities/mappingUpload"
    upstream_url: "{{ ml_survey_private_url }}/v1/entities/mappingUpload"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'registryUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UploadUserRoles
    uris: "{{ private_ml_survey_prefix }}/api/v1/userRoles/bulkCreate"
    upstream_url: "{{ ml_survey_private_url }}/v1/userRoles/bulkCreate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'mlApp'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchUserRoles
    uris: "{{ private_ml_survey_prefix }}/api/v1/userRoles/list"
    upstream_url: "{{ ml_survey_private_url }}/v1/userRoles/list"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'mlApp'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: RateObservation
    uris: "{{ private_ml_survey_prefix }}/api/v1/observationSubmissions/rate"
    upstream_url: "{{ ml_survey_private_url }}/v1/observationSubmissions/rate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'observationUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: GenerateObservationLink
    uris: "{{ private_ml_survey_prefix }}/api/v1/solutions/getObservationSolutionLink"
    upstream_url: "{{ ml_survey_private_url }}/v1/solutions/getObservationSolutionLink"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: CreateChildSurveySolution
    uris: "{{ private_ml_survey_prefix }}/api/v1/surveys/importSurveryTemplateToSolution"
    upstream_url: "{{ ml_survey_private_url }}/v1/surveys/importSurveryTemplateToSolution"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: GenerateSurveyLink
    uris: "{{ private_ml_survey_prefix }}/api/v1/surveys/getLink"
    upstream_url: "{{ ml_survey_private_url }}/v1/surveys/getLink"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateQuestions
    uris: "{{ private_ml_survey_prefix }}/api/v1/questions/bulkUpdate"
    upstream_url: "{{ ml_survey_private_url }}/v1/questions/bulkUpdate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UploadQuestions
    uris: "{{ private_ml_survey_prefix }}/api/v1/questions/bulkCreate"
    upstream_url: "{{ ml_survey_private_url }}/v1/questions/bulkCreate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: MapProgramToObservationSolution
    uris: "{{ private_ml_survey_prefix }}/api/v1/solutions/importFromSolution”
    upstream_url: "{{ ml_survey_private_url }}/v1/solutions/importFromSolution"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: MapProgramToSurveySolution
    uris: "{{ private_ml_survey_prefix }}/api/v1/surveys/mapSurverySolutionToProgram”
    upstream_url: "{{ ml_survey_private_url }}/v1/surveys/mapSurverySolutionToProgram"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchUserExtension
    uris: "{{ private_ml_survey_prefix }}/api/v1/userExtension/getProfile"
    upstream_url: "{{ ml_survey_private_url }}/v1/userExtension/getProfile"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'useraccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: CreateProgram
    uris: "{{ private_ml_core_prefix }}/api/v1/programs/create"
    upstream_url: "{{ ml_core_private_url }}/v1/programs/create"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchEntityType
    uris: "{{ private_ml_survey_prefix }}/api/v1/entityTypes/list"
    upstream_url: "{{ ml_survey_private_url }}/v1/entityTypes/list"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'mlApp'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateSolution
    uris: "{{ private_ml_core_prefix }}/api/v1/solutions/update"
    upstream_url: "{{ ml_core_private_url }}/v1/solutions/update"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateSolutionAddRoles
    uris: "{{ private_ml_core_prefix }}/api/v1/solutions/addRolesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/solutions/addRolesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateSolutionAddEntities
    uris: "{{ private_ml_core_prefix }}/api/v1/solutions/addEntitiesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/solutions/addEntitiesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateSolutionRemoveRoles
    uris: "{{ private_ml_core_prefix }}/api/v1/solutions/removeRolesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/solutions/removeRolesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateSolutionRemoveEntities
    uris: "{{ private_ml_core_prefix }}/api/v1/solutions/removeEntitiesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/solutions/removeEntitiesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateProgram
    uris: "{{ private_ml_core_prefix }}/api/v1/programs/update"
    upstream_url: "{{ ml_core_private_url }}/v1/programs/update"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateProgramAddRoles
    uris: "{{ private_ml_core_prefix }}/api/v1/programs/addRolesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/programs/addRolesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateProgramAddEntities
    uris: "{{ private_ml_core_prefix }}/api/v1/programs/addEntitiesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/programs/addEntitiesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateProgramRemoveRoles
    uris: "{{ private_ml_core_prefix }}/api/v1/programs/removeRolesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/programs/removeRolesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UpdateProgramRemoveEntities
    uris: "{{ private_ml_core_prefix }}/api/v1/programs/removeEntitiesInScope"
    upstream_url: "{{ ml_core_private_url }}/v1/programs/removeEntitiesInScope"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: ProgramSearch
    uris: "{{ private_ml_core_prefix }}/api/v1/programs/list"
    upstream_url: "{{ ml_core_private_url }}/v1/programs/list"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'programsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchRelatedEntities
    uris: "{{ private_ml_survey_prefix }}/api/v1/entities/relatedEntities"
    upstream_url: "{{ ml_survey_private_url }}/v1/entities/relatedEntities"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'registryAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchQuestionList
    uris: "{{ private_ml_survey_prefix }}/api/v1/solutions/questionList"
    upstream_url: "{{ ml_survey_private_url }}/v1/solutions/questionList"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchEntitiesList
    uris: "{{ private_ml_core_prefix }}/api/v1/entities/listByEntityType"
    upstream_url: "{{ ml_core_private_url }}/v1/entities/listByEntityType"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'registryAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: SearchForSolutions
    uris: "{{ private_ml_core_prefix }}/api/v1/solutions/list"
    upstream_url: "{{ ml_core_private_url }}/v1/solutions/list"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchCriteriaDetails
    uris: "{{ private_ml_survey_prefix }}/api/v1/solutionDetails/criteria"
    upstream_url: "{{ ml_survey_private_url }}/v1/solutionDetails/criteria"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FetchSolutionDocument
    uris: "{{ private_ml_core_prefix }}/api/v1/solutions/details"
    upstream_url: "{{ ml_core_private_url }}/v1/solutions/details"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: CriteriaUpload
    uris: "{{ private_ml_survey_prefix }}/api/v1/criteria/upload"
    upstream_url: "{{ ml_survey_private_url }}/v1/criteria/upload"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: FrameworkUpload
    uris: "{{ private_ml_survey_prefix }}/api/v1/frameworks/create"
    upstream_url: "{{ ml_survey_private_url }}/v1/frameworks/create"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'frameworkUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UploadThemesToFramewok
    uris: "{{ private_ml_survey_prefix }}/api/v1/frameworks/uploadThemes/"
    upstream_url: "{{ ml_survey_private_url }}/v1/frameworks/uploadThemes"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'frameworkUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: CreateSolutionFromFramework
    uris: "{{ private_ml_survey_prefix }}/api/v1/observations/importFromFramework"
    upstream_url: "{{ ml_survey_private_url }}/v1/observations/importFromFramework"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'observationAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UploadCriteriaRubricsForSolution
    uris: "{{ private_ml_survey_prefix }}/api/v1/solutions/uploadCriteriaRubricExpressions"
    upstream_url: "{{ ml_survey_private_url }}/v1/solutions/uploadCriteriaRubricExpressions"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: UploadThemeRubricToSolution
    uris: "{{ private_ml_survey_prefix }}/api/v1/solutions/uploadThemesRubricExpressions"
    upstream_url: "{{ ml_survey_private_url }}/v1/solutions/uploadThemesRubricExpressions"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: CreateSurveySolution
    uris: "{{ private_ml_survey_prefix }}/api/v1/surveys/createSolutionTemplate"
    upstream_url: "{{ ml_survey_private_url }}/v1/surveys/createSolutionTemplate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'surveyAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: ProjectsUpload
    uris: "{{ private_ml_project_prefix }}/api/v1/project/templates/bulkCreate"
    upstream_url: "{{ ml_project_private_url }}/v1/project/templates/bulkCreate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'projectUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: ProjectsUpdate
    uris: "{{ private_ml_project_prefix }}/api/v1/project/templates/bulkUpdate"
    upstream_url: "{{ ml_project_private_url }}/v1/project/templates/bulkUpdate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'projectUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: TasksUpload
    uris: "{{ private_ml_project_prefix }}/api/v1/project/templateTasks/bulkCreate"
    upstream_url: "{{ ml_project_private_url }}/v1/project/templateTasks/bulkCreate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'projectUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: TasksUpdate
    uris: "{{ private_ml_project_prefix }}/api/v1/project/templateTasks/bulkUpdate"
    upstream_url: "{{ ml_project_private_url }}/v1/project/templateTasks/bulkUpdate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'projectUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: SolutionCreationForProjects
    uris: "{{ private_ml_project_prefix }}/api/v1/solutions/create"
    upstream_url: "{{ ml_project_private_url }}/v1/solutions/create"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: MapSolutionToProject
    uris: "{{ private_ml_project_prefix }}/api/v1/project/templates/importProjectTemplate"
    upstream_url: "{{ ml_project_private_url }}/v1/project/templates/importProjectTemplate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsUpdate'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: SearchForCreatedProjects
    uris: "{{ private_ml_project_prefix }}/api/v1/library/categories/projects"
    upstream_url: "{{ ml_project_private_url }}/v1/library/categories/projects"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'solutionsAccess'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"

  - name: RolesUpdate
    uris: "{{ private_ml_survey_prefix }}/api/v1/userRoles/bulkUpdate"
    upstream_url: "{{ ml_survey_private_url }}/v1/userRoles/bulkUpdate"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'mlApp'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"    

  - name: ReadUserDetails
    uris: "{{ private_ml_project_prefix }}/api/user/v1/read"
    upstream_url: "{{ ml_project_private_url }}/user/v1/read"
    strip_uri: true
    plugins:
    - name: jwt
    - name: cors
    - "{{ statsd_pulgin }}"
    - name: acl
      config.whitelist:
        - 'mlApp'
    - name: rate-limiting
      config.policy: local
      config.hour: "{{ medium_rate_limit_per_hour }}"
      config.limit_by: credential
    - name: request-size-limiting
      config.allowed_payload_size: "{{ medium_request_size_limit }}"


```


*****

[[category.storage-team]] 
[[category.confluence]] 
