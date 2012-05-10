Feature: Students

  Scenario: I dont have class and I go to index page
    Given a teacher exists
    And I am logged in as a teacher
    When I go to the teacher students index page
    Then I should see "Najpierw dodaj klasę."

  Scenario: I have class and I go to subjects
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I go to the teacher students index page
    Then I should see "Nie masz żadnych uczniów. Możesz dodać ucznia poprzez poniższy formularz."

  Scenario: I add student
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I add student
    Then I should have student

  Scenario: I delete Student
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    When I delete student
    Then I should not see student
