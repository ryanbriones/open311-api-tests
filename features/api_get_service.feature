Feature: API `GET` Service
  Scenario: API `GET` Service
    When I call the Service API via GET
    Then I should get back a list of service attributes
