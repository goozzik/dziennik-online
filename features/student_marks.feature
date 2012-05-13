Feature: Student marks

  Scenario: I am going to marks index page when class have subjects
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a subject exists with school_class: the school class
    And a subject exists with school_class: the school class, name: "Biologia"
    And a student exists with school_class: the school class
    And I am logged in as a student
    When I go to the student marks index page
    Then I should see my marks
