Feature: Teacher subjects

  Scenario: I dont have class and I go to subjects
    Given a teacher exists
    And I am logged in as a teacher
    When I go to the teacher subjects index page
    Then I should see "Najpierw dodaj klasę."

  Scenario: I have class but no semester and I go to subjects
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I delete semester
    And I go to the teacher subjects index page
    Then I should see "Najpierw dodaj semestr."

  Scenario: I have class and semester and no subjects and I go to subjects
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I go to the teacher subjects index page
    Then I should see "Nie masz żadnych przedmiotów. Możesz dodać przedmiot poprzez poniższy formularz."

