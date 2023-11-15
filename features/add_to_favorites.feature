Feature: Favorite Products
  As a buyer
  I want to save listings to my "Favorites"
  So that I can easily find them later

  Background:
    Given the following users exist:
      | username  | email                 | password | password_confirmation |
      | MaryAnee  | maryAnee@example.com  | password | password              |
    And the following products exist:
      | title             | price | description           |
      | Amazing Widget    | 19.99 | An amazing widget     |
      | Incredible Gadget | 29.99 | A gadget like no other|

  Scenario: Buyer adds a product to favorites from the product details page
    Given I am logged in as a buyer
    And I view the details for "Amazing Widget"
    When I click on "Add to Favorites"
    Then I should see "Product added to favorites."

  Scenario: Buyer views their favorites and removes a product
    Given I am logged in as a buyer
    And I have favorited "Amazing Widget"
    When I visit the "Favorites" page
    Then I should see "Amazing Widget" in my favorites
    When I click on "Remove from Favorites" for "Amazing Widget"
    Then I should not see "Amazing Widget" in my favorites
