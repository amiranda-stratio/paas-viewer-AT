@rest
Feature: Multi-instance testing

  Background: Setup PaaS REST client
    Given I obtain mesos master in cluster '${DCOS_CLUSTER}' and store it in environment variable 'mesosMaster'
    And I send requests to '!{mesosMaster}:${MESOS_API_PORT}'
#
#  Scenario: Perf-Spec-01 - Performance should be the same in DC/OS.
#    Given a service in our universe
#    When the service queued X jobs (depending of the type of service)
#    Then the service process the information in values similars to a use case without DC/OS.
#    Given a service (of persistency) in our universe
#    When the service have to load X data
#    Then the service process the information in values similars to a use case without DC/OS.