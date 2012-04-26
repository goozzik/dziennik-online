Feature: Subjects

  Scenario: I dont have class and I go to subjects
    Given I am logged in as a teacher
    When I go to the teacher subjects index page
    Then I should see "Najpierw dodaj klasę."

  Scenario: I have class but no semester and I go to subjects
    Given I am logged in as a teacher
    When I create class
    And I delete semester
    And I go to the teacher subjects index page
    Then I should see "Najpierw dodaj semestr."

  Scenario: I have class and semester and no subjects and I go to subjects
    Given I am logged in as a teacher
    When I create class
    And I go to the teacher subjects index page
    Then I should see "Nie masz żadnych przedmiotów. Możesz dodać przedmiot poprzez poniższy formularz."

  Scenario: I create subject
    Given I am logged in as a teacher
    When I create class
    And I create subject
    Then I should have subject

  Scenario: I go to the subject
    Given I am logged in as a teacher
    When I create class
    And I add student
    And I create subject
    And I go to the teacher subject page
    Then I should see "Oceny - Matematyka"

  Scenario: I create new description
    Given I am logged in as a teacher
    When I create class
    And I create subject
    And I create description
    Then I should see new description
