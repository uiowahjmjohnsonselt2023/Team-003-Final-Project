Feature: User Signup

  As a new user
  I want to sign up for an account
  So that I can use the market application and have my information stored in the Users database

  Background:
    Given the signup page is available

  Scenario: Successful signup with valid information
    And I fill in the following:
      | Name     | John Doe        |
      | Username | john_doe        |
      | Email    | john@example.com|
      | Password | password123     |
      | Password confirmation | password123 |
      | Bio      | Just a regular John Doe. |
    And I choose a file "profile_picture.jpg" to upload as my profile picture
    And I click the "Sign up" button
    Then I should be redirected to the marketplace home page
    And the new user should be stored in the database

  Scenario: Unsuccessful signup with a too short password
    And I fill in the following:
      | Name     | Jane Doe        |
      | Username | jane_doe        |
      | Email    | jane@example.com|
      | Password | pass   |
      | Password confirmation | pass |
    And I click the "Sign up" button
    Then I should not be redirected to the marketplace home page
    And I should see an error message "Password is too short (minimum is 6 characters)"
    And the new user should not be stored in the database

  Scenario: Unsuccessful signup with mismatched passwords
    And I fill in the following:
      | Name     | Bob Doe         |
      | Username | bob_doe         |
      | Email    | bob@example.com |
      | Password | password123     |
      | Password confirmation | password321 |
    And I click the "Sign up" button
    Then I should not be redirected to the marketplace home page
    And I should see an error message "Password confirmation doesn't match Password"
    And the new user should not be stored in the database