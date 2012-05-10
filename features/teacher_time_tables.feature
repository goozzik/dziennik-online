Feature: Time tables

  Scenario: I go to time tables
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I go to the teacher time tables index page
    Then I should see "Nie masz żadnych dni w planie lekcji."
    And I should see create new time table button

  Scenario: I go to time tables when I dont have have class
    Given a teacher exists
    And I am logged in as a teacher
    When I go to the teacher time tables index page
    Then I should see "Najpierw dodaj klasę."

#  Scenario: I create time table
#    Given I am logged in as a teacher
#    And I have class
#    When I create time table
#    Then I should see new time table

  Scenario: I go to time tables when I have monday time table
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a subject exists with school_class: the school class
    And a time table exists with school_class: the school class
    And a lesson exists with time_table: the time table, subject: the subject, number: 0
    And a lesson exists with time_table: the time table, subject: the subject, number: 1
    When I go to the teacher time tables index page
    Then I should see monday time table

  Scenario: I delete time table
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a subject exists with school_class: the school class
    And a time table exists with school_class: the school class
    And a lesson exists with time_table: the time table, subject: the subject, number: 0
    And a lesson exists with time_table: the time table, subject: the subject, number: 1
    When I delete time table
    Then I should not see monday time table

  Scenario: I go to time tables and I see ordered time tables
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a subject exists with school_class: the school class
    And a time table exists with school_class: the school class, week_day: 2
    And a lesson exists with time_table: the time table, subject: the subject, number: 0
    And a lesson exists with time_table: the time table, subject: the subject, number: 1
    And a time table exists with school_class: the school class, week_day: 1
    And a lesson exists with time_table: the time table, subject: the subject, number: 0
    And a lesson exists with time_table: the time table, subject: the subject, number: 1
    When I go to the teacher time tables index page
    Then I should see first monday and second tuesday time table
