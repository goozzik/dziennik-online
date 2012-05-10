Feature: Teacher School Classes

  Scenario: I go to index page
    Given a teacher exists
    And I am logged in as a teacher
    When I go to the teacher school classes index page
    Then I should see new class form

  Scenario: I create class
    Given a teacher exists
    And I am logged in as a teacher
    When I create class
    Then I should have active class and updated teacher class_id
    And I should have active semester and updated teacher semester_id
    And I should see "3 G 2013"
    And I should see "Semestr 1 - aktualnie wybrany"

  Scenario: I create semester when I have class with semester
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I create semester
    Then first semester should be unactive and new one should be active
    Then I should see "Semestr 2"

  Scenario: I delete active school class
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I delete class
    Then class and semester should be deleted
    And I should have not set up current semester and school class

  Scenario: I delete not active school class
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And another school class exists with teacher: the teacher
    When I delete class
    Then first class and semester should be deleted
    And I should have set up current semester and school class

  Scenario: I delete active semester
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I delete semester
    Then this semester should not exist
    And I should have not set up current semester

  Scenario: I delete not active semester
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a semester exists with school_class: the school class
    When I delete semester
    Then this first semester should not exist
    And I should have set up current semester

  Scenario: I set semester as active when other is active
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And a semester exists with school_class: the school class
    When I set first semester as active
    Then first semester should be active and second not active
