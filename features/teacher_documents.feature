Feature: Documents

  Scenario: I go to documents when I dont have any documents uploaded
    Given I am logged in as a teacher
    And I have class
    When I go to the teacher documents index page
    Then I should see that I dont have any documents

  Scenario: I upload document
    Given I am logged in as a teacher
    And I have class
    When I upload document
    Then I should see that I have uploaded documents

  Scenario: I delete file
    Given I am logged in as a teacher
    And I have document
    When I delete document
    Then I should see that I dont have any documents
