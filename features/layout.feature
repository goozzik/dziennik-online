Feature: Layout

  Scenario: Go to index page when i am not logged in
    When I go to the home page
    Then I should see login box

  Scenario: Go to index page when i am logged in as a teacher
    Given I am logged in as a teacher
    When I go to the home page
    Then I should see teacher navigation
    And I should see teacher icon navigation

  Scenario: Go to index page when i am logged in as a director
    Given I am logged in as a director
    When I go to the home page
    Then I should see director navigation
    # TODO And I should see teacher icon navigation
