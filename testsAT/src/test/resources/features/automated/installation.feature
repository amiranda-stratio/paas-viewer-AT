@rest
Feature: Viewer installation tests

  Background: Setup PaaS REST client
    Given I open remote ssh connection to host '${DCOS_CLI_HOST}' with user '${DCOS_USER}' and password '${DCOS_PASSWORD}'

  Scenario: InstallUninstall-Spec-01. A service CAN be installed from the CLI
    Given I open remote ssh connection to host '${DCOS_CLI_HOST}' with user '${DCOS_USER}' and password '${DCOS_PASSWORD}'
    And I send requests to '${DCOS_CLUSTER}:80'
    When I send a 'POST' request to '/marathon/v2/apps' based on 'schemas/viewer.json' as 'json' with:
      | $.env.VIEWERDB      | UPDATE | postgresql://hakama:hakama@${PSQL_HOST}:${PSQL_PORT}/${PSQL_DB}  |
      | $.env.HAPROXY_0_IP  | UPDATE | 10.200.1.220                                                     |
    Then the service response status must be '201'.

    Then in less than '300' seconds, checking each '20' seconds, the command output 'dcos task | grep ${SERVICE} | grep R | wc -l' contains '1'