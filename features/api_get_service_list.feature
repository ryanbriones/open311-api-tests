Feature: API `GET` Service List
  Scenario: API `GET` Service List
    When I call the Service List API via GET
    Then I should get back a list of services and service codes available for use
