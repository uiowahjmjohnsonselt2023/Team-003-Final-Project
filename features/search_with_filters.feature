Feature: Search Products with Filters
  As a buyer
  I want to apply filters to my search
  So that I can narrow down the results to match my preferences

  Scenario: Searching for products with specific filters
    Given I am on the homepage ready to search
    Given a user exists
    And the following searchable products exist:
      | title             | description         | price | condition |
      | Amazing Widget    | An amazing widget   | 50    | New       |
      | Incredible Gadget | A gadget like no other | 75  | Used      |
    When I fill in the search field with "Widget"
    And I click the "Search" button on the home page
    And I select "New" from the "Condition" dropdown
    And I click the "Filter Results" button on the search page
    Then I should see "Amazing Widget" on the search page
    And I should not see "Incredible Gadget"