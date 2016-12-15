@rest
Feature: Viewer installation tests

  Background: Setup PaaS REST client
    Given I open remote ssh connection to host '${DCOS_CLI_HOST}' with user '${DCOS_USER}' and password '${DCOS_PASSWORD}'

  Scenario: InstallUninstall-Spec-01. A service CAN be installed from the CLI
    Given I open remote ssh connection to host '${DCOS_CLI_HOST}' with user '${DCOS_USER}' and password '${DCOS_PASSWORD}'
    When I copy 'src/test/resources/schemas/viewer.json' to remote ssh connection in '/dcos'
    And I execute command 'dcos marathon app add /dcos/viewer.json' in remote ssh connection
    Then in less than '300' seconds, checking each '20' seconds, the command output 'dcos task | grep ${SERVICE} | grep R | wc -l' contains '1'
