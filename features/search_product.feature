Feature: Search Products
  As a buyer
  I want to search for items using keywords
  So that I can find exactly what I'm looking for

  Background:
    Given the following users exist for search:
      | username | email            | password |
      | MaryAnn  | mary@example.com | password |
    And the following products exist for search:
      | title          | description       | category |
      | Amazing Widget | An amazing widget | Toys     |

  Scenario: Buyer searches for a product and sees clickable results
    Given I am on the homepage
    When I fill in "Search for products..." with "Widget"
    And I click the "Search" button on the home page
    Then I should see "Amazing Widget" as clickable
    When I click on the product titled "Amazing Widget"
    Then I should be on the details page for "Amazing Widget"
