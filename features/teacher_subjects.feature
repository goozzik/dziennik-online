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

# TODO - not working selenium with session variables
#  @selenium
#  Scenario: I add mark
#    Given I am logged in as a teacher
#    And I have class with: semester, subject, student, description
#    When I add mark
#    Then I should see that student have mark "5"
#
#  @selenium
#  Scenario: I update mark
#    Given I am logged in as a teacher
#    And I have class with: semester, subject, student, description, mark
#    When I update mark
#    Then I should see that student have mark "4"

  Scenario: I have two marks and I should see average mark
    Given I am logged in as a teacher
    And I have class with: semester, subject, student, description and two marks
    When I go to the teacher subject page
    Then I should see that student have average mark "2.50"

#  TODO
#  @selenium
#  Scenario: I add semestry mark
#
#  @selenium
#  Scenario: I update semestry mark
