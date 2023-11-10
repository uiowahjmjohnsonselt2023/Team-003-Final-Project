Feature: User profile

  As a registered user
  I want my profile to reflect my information
  So I can function as a vendor in the marketplace

  Scenario: Successful profile retrieval with correct credentials
    Given I am a registered user
    And I am on the login page with the following credentials:
      | Username | john_doe    |
      | Password | password123 |
    When I press "Login"
    Then I should see "john_doe"

  Scenario: Successful profile creation with valid information
    And I fill in the following:
      | Name     | John Doe        |
      | Username | john_doe        |
      | Email    | john@example.com|
      | Password | password123     |
      | Password confirmation | password123 |
      | Bio      | Just a regular John Doe. |
    And I click the "Sign up" button
    Then I should see "John Doe"
    Then I should see "john_doe"
    Then I should see "john@example.com"
    Then I should see "Just a regular John Doe."