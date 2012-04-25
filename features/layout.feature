Feature: Layout

  Scenario: Go to index page when i am not logged in
    When I go to the home page
    Then I should see login box

  Scenario: Go to index page when i am logged in as a teacher
    Given I am logged in as a teacher
    When I go to the home page
    Then I should see teacher navigation
