# features/search_product.feature

Feature: Search for products

  As a user
  I want to search for products using keywords
  So that I can find exactly what I'm looking for

  Background:
    Given the following products exist:
      | title                | description         |
      | Amazing Widget       | An amazing widget   |
      | Incredible Gadget    | A gadget like no other |
      | Widget Extraordinaire | The best widget ever |

  Scenario: User successfully finds products by title
    When I search for "Widget"
    Then I should see products including:
      | title                |
      | Amazing Widget       |
      | Widget Extraordinaire |

  Scenario: User tries to search for a product that doesn't exist
    When I search for "Gizmo"
    Then I should not see any products

  Scenario: User searches without a keyword
    When I search with an empty keyword
    Then I should see all products
