Feature: Director absences

  Scenario: I go to absences index when I have active classes
    Given I have example teachers with active classes
    And I am logged in as a director
    When I go to the director absences index page
    Then I should see classes table
