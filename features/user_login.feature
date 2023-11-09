Feature: User Login

  Scenario: Successful login
    Given I am on the login page
    When I log in with valid credentials
    Then I should be logged in to the system

  Scenario: Unsuccessful login
    Given I am on the login page
    When I log in with invalid credentials
    Then I should see a login error message
