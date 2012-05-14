Feature: Time tables student

  Scenario: Show me time tables
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a subject exists with school_class: the school class, name: "Biologia"
    And a student exists with school_class: the school class
    And a time table exists with school_class: the school class, week_day: 2
    And a lesson exists with time_table: the time table, subject: the subject, number: 0
    And a lesson exists with time_table: the time table, subject: the subject, number: 1
    And a time table exists with school_class: the school class, week_day: 1
    And a lesson exists with time_table: the time table, subject: the subject, number: 0
    And a lesson exists with time_table: the time table, subject: the subject, number: 1
    And I am logged in as a student
    When I go to the student time tables index page
    Then I should see my time tables

  Scenario: Show me notice when there is no time tables for class
    Given a school exists
    And a teacher exists with school: the school
    And a school class exists with teacher: the teacher
    And a student exists with school_class: the school class
    And I am logged in as a student
    When I go to the student time tables index page
    Then I should see information that there is no time tables now
