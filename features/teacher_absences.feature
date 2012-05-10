Feature: Absence

  Scenario: I go to the may absences
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a absence exists with student: the student
    And a absence exists with student: the student, date: "2012-05-14"
    And a absence exists with student: the student, date: "2012-05-21"
    And a absence exists with student: the student, date: "2012-05-28"
    When I go to the teacher absences may index page
    Then I should see may absences

  Scenario: I am on the may absences and I click link to go next month
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a absence exists with student: the student
    And a absence exists with student: the student, date: "2012-05-14"
    And a absence exists with student: the student, date: "2012-05-21"
    And a absence exists with student: the student, date: "2012-05-28"
    When I go to the teacher absences may index page
    And I follow link for next month
    Then I should see june absences

  Scenario: I am on the may absences and I click link to go last month
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a absence exists with student: the student
    And a absence exists with student: the student, date: "2012-05-14"
    And a absence exists with student: the student, date: "2012-05-21"
    And a absence exists with student: the student, date: "2012-05-28"
    When I go to the teacher absences may index page
    And I follow link for previous month
    Then I should see april absences

  Scenario: I dont have class and I go to may absences
    Given a teacher exists
    And I am logged in as a teacher
    When I go to the teacher absences may index page
    Then I should see "Najpierw dodaj klasę"

  Scenario: I have class but no students and I go to may absences
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I go to the teacher absences may index page
    Then I should see "Najpierw dodaj uczniów"

  # @wip
  # TODO Scenario: I add absecenes (required, justified, unexcused, late)
  # TODO Scenario: I update absecenes (required, justified, unexcused, late)
