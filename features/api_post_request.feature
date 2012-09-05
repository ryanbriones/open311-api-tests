Feature: API `POST` Request
  Scenario: Creating a request and retrieving it
    When I create a new request
    And I retrieve the Service ID using the request token
    Then I should be able to retrieve the request

  Scenario: Creating a request with missing required attributes
    When I create a new request with missing required attributes
    Then the response should be a failure
    And the message should include a validation error