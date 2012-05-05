Feature: Time tables

  Scenario: I go to time tables
    Given I am logged in as a teacher
    And I have class
    When I go to the teacher time tables index page
    Then I should see "Nie masz żadnych dni w planie lekcji."
    And I should see create new time table button

  Scenario: I go to time tables when I dont have have class
    Given I am logged in as a teacher
    When I go to the teacher time tables index page
    Then I should see "Najpierw dodaj klasę."

#  Scenario: I create time table
#    Given I am logged in as a teacher
#    And I have class
#    When I create time table
#    Then I should see new time table

  Scenario: I go to time tables when I have monday time table
    Given I am logged in as a teacher
    And I have monday time table
    When I go to the teacher time tables index page
    Then I should see monday time table
