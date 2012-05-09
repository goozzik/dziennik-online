Feature: Students

  Scenario: I dont have class and I go to index page
    Given I am logged in as a teacher
    When I go to the teacher students index page
    Then I should see "Najpierw dodaj klasę."

  Scenario: I have class and I go to subjects
    Given I am logged in as a teacher
    When I create class
    And I go to the teacher students index page
    Then I should see "Nie masz żadnych uczniów. Możesz dodać ucznia poprzez poniższy formularz."

  Scenario: I add student
    Given I am logged in as a teacher
    When I create class
    And I add student
    Then I should have student

  Scenario: I delete Student
    Given I am logged in as a teacher
    And I have class with student
    When I delete student
    Then I should not see student
