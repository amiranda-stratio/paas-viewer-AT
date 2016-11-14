@rest @ignore
Feature: Scalability testing

  Background: Resources should be increased when its manually re-scaled.
    Given I send requests to '${DCOS_CLUSTER}:${DCOS_CLUSTER_PORT}'

#  Scenario: Scalability-Spec-01 - Resources should be increased when threshold is hit
#    Given a running service
#    When threshold (memory, CPU, disk...) is hit
#    Then number of tasks will be increased
#
#  Scenario: Scalability-Spec-02 - Resources should be freed when back to normal
#    Given a running service
#    When we recover from threshold breach
#    Then number of tasks will be decreased back to normal
#
#  Scenario: Scalability-Spec-03 - Manually re-scale services
#    Given a running service
#    When we manually re-scale
#    Then more/less tasks will be running