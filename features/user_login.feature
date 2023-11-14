Feature: User login

  As a registered user
  I want to log in with my username and password
  So that I can access the marketplace

  Scenario: Successful login with correct credentials
    Given I am a registered user for login
    And I am on the login page with the following credentials:
      | Username | john_doe    |
      | Password | password123 |
    When I press "Login"
    Then I should be on the home page of the marketplace
    And I should see "Welcome to Knockoff eBay"


  Scenario: Unsuccessful login with incorrect credentials
    Given I am on the login page
    When I fill in the login "Username" with "wrongusername"
    And I fill in the login "Password" with "wrongpassword"
    And I press "Login"
    Then I should be on the login page
    And I should see "Username or password is invalid"
