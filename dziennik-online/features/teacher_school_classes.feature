Feature: Teacher School Classes

  Scenario: Go to index page
    Given I am logged in as a teacher
    When I go to the teacher school classes index page
    Then I should see new class form

  Scenario: Create class
    Given I am logged in as a teacher
    When I create class
    Then I should have active class and updated teacher class_id
    And I should have active semester and updated teacher semester_id
    And I should see "3 G 2013"
    And I should see "Semestr 1 - aktualnie wybrany"

  Scenario: Create semester when I have class with semester
    Given I am logged in as a teacher
    When I create class
    And I create semester
    Then first semester should be unactive and new one should be active
    Then I should see "Semestr 2"

  Scenario: Delete active school class
    Given I am logged in as a teacher
    When I create class
    And I delete class
    Then class and semester should be deleted
    And I should have not set up current semester and school class

  Scenario: Delete not active school class
    Given I am logged in as a teacher
    When I create two classes
    And I delete class
    Then first class and semester should be deleted
    And I should have set up current semester and school class

  Scenario: Delete active semester
    Given I am logged in as a teacher
    When I create class
    And I delete semester
    Then semester should be deleted
    And I should have not set up current semester

  Scenario: Delete not active semester
    Given I am logged in as a teacher
    When I create class
    And I create semester
    And I delete semester
    Then first semester should be deleted
    And I should have set up current semester

  Scenario: Set semester as active when other is active
    Given I am logged in as a teacher
    When I create class
    And I create semester
    And I set first semester as active
    Then first semester should be active and second not active
