Feature: Teacher School Classes

  Scenario: Go to index page
    Given I am logged in as a teacher
    When I go to the teacher school classes index page
    Then I should see new class form

  Scenario: Create class
    Given I am logged in as a teacher
    When I create class
    Then I should have class and updated teacher class_id
    Then I should see "3 G 2013"
