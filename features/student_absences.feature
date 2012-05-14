Feature: Student absences

  Scenario: Show my absences
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a absence exists with student: the student
    And a absence exists with student: the student, date: "2012-05-14"
    And a absence exists with student: the student, date: "2012-05-21"
    And a absence exists with student: the student, date: "2012-05-28"
    And I am logged in as a student
    When I go to the student absences index page
    Then I should see my absences

  Scenario: Show me notice that I dont have any absences
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And I am logged in as a student
    When I go to the student absences index page
    Then I should see information that i don't have any absences
