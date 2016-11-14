@rest
Feature: Multi-instance testing

  Background: Setup PaaS REST client
    Given I obtain mesos master in cluster '${DCOS_CLUSTER}' and store it in environment variable 'mesosMaster'
    And I send requests to '!{mesosMaster}:${MESOS_API_PORT}'
#
#  Scenario: Stability-Spec-01 - Check recovering of persistent volumes
#    Given a running kafka
#    When an executor fails and it is rebooted
#    Then the brokers MUST recovered