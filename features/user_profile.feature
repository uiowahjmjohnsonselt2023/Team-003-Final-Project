Feature: User profile

  As a registered user
  I want my profile to reflect my information
  So I can function as a vendor in the marketplace

  Scenario: Successful profile retrieval with correct credentials
    Given I am a registered user for user profile
    And I am on the login page with the following credentials for user profile:
      | Username | john_doe    |
      | Password | password123 |
    When I press "Login" for user profile
    Then I should see "About Us" for user profile

  Scenario: Successful profile creation with valid information
    Given I am on the signup page
    And I fill in the following for user profile:
      | Name     | John Doe        |
      | Username | john_doe        |
      | Email    | john@example.com|
      | Password | password123     |
      | Password confirmation | password123 |
      | Bio      | Just a regular John Doe. |
    When I click the "Sign up" button for user profile
    Then I should be redirected to the home page of the marketplace