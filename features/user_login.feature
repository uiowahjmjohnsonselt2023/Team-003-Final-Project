Feature: User Login

  Scenario: Successful login with valid credentials
    Given I am on the login page
    When I fill in the login form correctly
    And I click the login button
    Then I should be redirected to the home page of the marketplace

  Scenario: Unsuccessful login with invalid credentials
    Given I am on the login page
    When I fill in the login form with invalid credentials
    And I click the login button
    Then I should see a login error message
    And I should be on the login page

