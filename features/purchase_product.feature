Feature: Product Purchase
  As a buyer
  I want to purchase products from the marketplace
  So that I can receive the items I want

  Scenario: Buyer purchases a product successfully
    Given I am a logged-in user
    And I have a product in my cart
    When I proceed to checkout
    And I provide my shipping and payment information
    And I confirm the order
    Then I should see a confirmation that my order has been placed