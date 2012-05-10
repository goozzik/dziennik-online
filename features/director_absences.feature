Feature: Director absences

  Scenario: I go to absences index when there is active class in school
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a director exists with school: the school
    And I am logged in as a director
    When I go to the director absences index page
    Then I should see classes absences table

  Scenario: I go to absences index when there is no active class in school
    Given a school exists
    And a director exists with school: the school
    And I am logged in as a director
    When I go to the director absences index page
    Then I should see "Szkoła nie ma żadnych aktywnych klas."

  Scenario: I go to may absences
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a absence exists with student: the student
    And a absence exists with student: the student, date: "2012-05-14"
    And a absence exists with student: the student, date: "2012-05-21"
    And a absence exists with student: the student, date: "2012-05-28"
    And a director exists with school: the school
    And I am logged in as a director
    When I go to the director may absences page
    Then I should see may absences

  Scenario: I go to general absences
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And a absence exists with student: the student
    And a absence exists with student: the student, date: "2012-05-14"
    And a absence exists with student: the student, date: "2012-05-21"
    And a absence exists with student: the student, date: "2012-05-28"
    And a absence exists with student: the student, date: "2012-04-02"
    And a absence exists with student: the student, date: "2012-04-09"
    And a absence exists with student: the student, date: "2012-04-16"
    And a absence exists with student: the student, date: "2012-04-23"
    And a absence exists with student: the student, date: "2012-04-30"
    And a director exists with school: the school
    And I am logged in as a director
    When I go to the director general absences page
    Then I should see general absences
    And I should see semesters navigation
