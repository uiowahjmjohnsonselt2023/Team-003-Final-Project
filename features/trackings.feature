Feature: Tracking Information
  As a user
  I want to see tracking information for my orders
  So that I can know the status of my purchase

  Scenario: Viewing tracking information for an order
    Given I have an order with tracking information
    When I visit the tracking page for the order
    Then I should see the tracking information

  Scenario: No tracking information available
    Given I have an order without tracking information
    When I visit the tracking page for the order
    Then I should see a message indicating tracking information is not available