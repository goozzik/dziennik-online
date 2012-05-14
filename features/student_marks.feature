Feature: Student marks

  Scenario: I am going to marks index page and I see my marks
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a subject exists with school_class: the school class
    And a subject exists with school_class: the school class, name: "Biologia"
    And a student exists with school_class: the school class
    And a description exists with subject: the subject
    And created semester is loaded
    And a mark exists with semester: the semester, description: the description, student: the student, subject: the subject
    And another description exists with subject: the subject
    And another mark exists with semester: the semester, description: the description, student: the student, subject: the subject, mark: 4
    And I am logged in as a student
    When I go to the student marks index page
    Then I should see my marks
