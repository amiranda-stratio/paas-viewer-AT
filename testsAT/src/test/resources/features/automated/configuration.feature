@rest
Feature: Configuration testing

  Background: Setup PaaS REST client
    Given I open remote ssh connection to host '${DCOS_CLI_HOST}' with user '${DCOS_USER}' and password '${DCOS_PASSWORD}'

  Scenario: Config-Spec-01 - Deploy a service with custom label
    When I add a new DCOS label with key 'TEST' and value 'TEST' to the service '${SERVICE}'
    Then in less than '60' seconds, checking each '20' seconds, the command output 'dcos task | grep ${SERVICE} | grep S | wc -l' contains '1'
    Then in less than '120' seconds, checking each '20' seconds, the command output 'dcos task | grep ${SERVICE} | grep R | wc -l' contains '2'
    Then in less than '300' seconds, checking each '20' seconds, the command output 'dcos task | grep ${SERVICE} | grep R | wc -l' contains '1'

    Then I wait '20' seconds
    Given I obtain mesos master in cluster '${DCOS_CLUSTER}' and store it in environment variable 'mesosMaster'
    And I send requests to '!{mesosMaster}:${MESOS_API_PORT}'
    When I send a 'GET' request to '/frameworks'
    Then the service response status must be '200'.
    And I save element in position '0' in '$.frameworks[?(@.name == "marathon")].tasks[?(@.name == "${SERVICE}")].labels' in environment variable 'labels'
    And value stored in 'labels' contains '"value":"TEST","key":"TEST"'