Feature: User Login

  Scenario: Successful login
    Given I am on the login page
    When I log in with valid credentials
    Then I should be logged in

  Scenario: Unsuccessful login
    Given I am on the login page
    When I log in with invalid credentials
    Then I should see an error message
