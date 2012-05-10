Feature: Marks 

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

  Scenario: I create subject
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I create subject
    Then I should have subject

  Scenario: I go to the subject
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a subject exists with school_class: the school class
    When I go to the teacher marks page
    Then I should see "Oceny - Matematyka"

  Scenario: I create new description
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a subject exists with school_class: the school class
    When I create description
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
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a subject exists with school_class: the school class
    And a description exists with subject: the subject
    And created semester is loaded
    And a mark exists with semester: the semester, description: the description, student: the student, subject: the subject
    And another mark exists with semester: the semester, description: the description, student: the student, subject: the subject, mark: 4
    When I go to the teacher marks page
    Then I should see that student have average mark "2.50"

#  TODO
#  @selenium
#  Scenario: I add semestry mark
#
#  @selenium
#  Scenario: I update semestry mark
#

  Scenario: I dont have students and I want go to subject show
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a subject exists with school_class: the school class
    When I go to the teacher marks page
    Then I should see "Najpierw dodaj uczniów"
