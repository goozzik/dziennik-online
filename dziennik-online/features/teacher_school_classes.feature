Feature: Teacher School Classes

  Scenario: Go to index page
    Given I am logged in as a teacher
    When I go to the teacher school classes index page
    Then I should see new class form
