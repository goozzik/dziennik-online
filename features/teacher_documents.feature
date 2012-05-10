Feature: Documents

  Scenario: I go to documents when I dont have class
    Given a teacher exists
    And I am logged in as a teacher
    When I go to the teacher documents index page
    Then I should see "Najpierw dodaj klasę."

  Scenario: I go to documents when I dont have any documents uploaded
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I go to the teacher documents index page
    Then I should see that I dont have any documents

  Scenario: I upload document
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    When I upload document
    Then I should see that I have uploaded documents

  Scenario: I delete file
    Given a teacher exists
    And I am logged in as a teacher
    And a school class exists with teacher: the teacher
    And I have document
    When I delete document
    Then I should see that I dont have any documents
