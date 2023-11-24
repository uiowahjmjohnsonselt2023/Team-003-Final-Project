# features/view_product_details.feature

Feature: Viewing Product Details

  As a visitor
  I want to view products' details
  So that I can learn more about the products and make informed purchasing decisions

  Background:
    Given a product is listed in the marketplace with a review
    And I am logged in as the reviewing user

  Scenario: Visitor views a product details page
    When I visit the product details page
    Then I should see the product details
    And I should see an "Add to Cart" button
    And I should see a "Write a Review" section

  Scenario: User deletes a review
    When I visit the product details page
    And I click on the "Delete Review" button for the review
    Then I should not see the review content
    And I should be on the product details page