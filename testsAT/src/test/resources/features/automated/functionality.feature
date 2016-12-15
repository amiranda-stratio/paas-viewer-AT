@rest
Feature: Api basic testing

  Background: Connection to CLI
    Given I open remote ssh connection to host '${DCOS_CLI_HOST}' with user '${DCOS_USER}' and password '${DCOS_PASSWORD}'

  Scenario: [Viewer-Functional-Spec-01] Get petition must have a 303 status as response
    Given I execute command 'echo ${PUBLIC_AGENT} viewer.paas.stratio.com >> /etc/hosts' in remote ssh connection
    And I execute command 'echo ${PUBLIC_AGENT} viewer.paas.stratio.com >> /etc/hosts' locally
    And My app is running in 'viewer.paas.stratio.com:80'
    When I send a 'GET' request to '/'
    Then the service response status must be '303'.

  Scenario: [Viewer-Functional-Spec-02] Get petition to index must have a 200 status as response and known text
    Given My app is running in 'viewer.paas.stratio.com:80'
    When I send a 'GET' request to '/assets/web/index.html'
    Then the service response status must be '200' and its response must contain the text '<title>Stratio Viewer</title>'

  Scenario: [Viewer-Functional-Spec-03] Get petition to checkConnection must have a 200 status as response and the known message
    Given My app is running in 'viewer.paas.stratio.com:80'
    When I send a 'GET' request to '/api/wizard/checkConfiguration'
    Then the service response status must be '200' and its response must contain the text '{"status":"OK","configurationStatus":[{"adminUser":"No admin user found"},{"db.default.url":"jdbc:postgresql'

  Scenario: [Viewer-Functional-Spec-04] Get petition to market must have a 400 as response
    Given My app is running in 'viewer.paas.stratio.com:80'
    When I send a 'GET' request to '/api/market'
    Then the service response status must be '400'.