Feature: API `POST` Request
  Scenario: Creating a request and retrieving it
    When I create a new request
    And I retrieve the Service ID using the request token
    Then I should be able to retrieve the request
