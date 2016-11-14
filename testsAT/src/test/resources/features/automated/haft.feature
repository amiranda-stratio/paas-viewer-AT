@rest
@ignore @tillfixed(PAAS-1495)
Feature: High Availability and Fault Tolerance testing

  Background: Setup PaaS REST client
    Given I want to authenticate in DCOS cluster '${DCOS_CLUSTER}' with email '${DCOS_EMAIL}' with user '${DCOS_USER}' and password '${DCOS_PASSWORD}' using pem file '${DCOS_PEM}'
    Then I obtain mesos master in cluster '${DCOS_CLUSTER}' and store it in environment variable 'mesosMaster'
    And I send requests to '!{mesosMaster}:${MESOS_API_PORT}'

  Scenario: [HA-Spec-07] - Service MUST recover from lost executors and tasks.
  # Obtain hostname where task is running and id (using cli: dcos task)
    Given I obtain host and id from task '${SERVICE}' using '${DCOS_CLI_HOST}' and save them in 'appHost' and 'appId'
  # Kill service task in hostname
    Then I wait '5' seconds
    Then I kill '${SERVICE}' 'app' in hostname '!{appHost}'
  # Check task is back
    Given I obtain host and id from task '${SERVICE}' using '${DCOS_CLI_HOST}' and save them in 'appHost2' and 'appId2'
  # id should be different
    Then value stored in '!{appId}' is different from '!{appId2}'

