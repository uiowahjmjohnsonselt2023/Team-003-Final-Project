Feature: Purchasing Orders
  As a registered user
  I want to purchase products in my cart
  So that they can be delivered to my address

  Background:
    Given I am a registered user
    And I have products in my cart

  Scenario: Completing an order with valid payment information
    When I proceed to checkout
    And I provide shipping and payment information
    And I confirm the order
    Then I should see a confirmation message
    And the order should be recorded in the system