Feature: Absence

  Scenario: I go to the may absences
    Given I am logged in as a teacher
    And I have abseneces for may
    When I go to the teacher absences may index page
    Then I should see may absences

  Scenario: I am on the may absences and I click link to go next month
    Given I am logged in as a teacher
    And I have abseneces for may
    When I go to the teacher absences may index page
    And I follow link for next month
    Then I should see june absences

  Scenario: I am on the may absences and I click link to go last month
    Given I am logged in as a teacher
    And I have abseneces for may
    When I go to the teacher absences may index page
    And I follow link for previous month
    Then I should see april absences

  Scenario: I dont have class and I go to may absences
    Given I am logged in as a teacher
    When I go to the teacher absences may index page
    Then I should see "Najpierw dodaj klasę"

  Scenario: I have class but no students and I go to may absences
    Given I am logged in as a teacher
    And I have class
    When I go to the teacher absences may index page
    Then I should see "Najpierw dodaj uczniów"

  # @wip
  # TODO Scenario: I add absecenes (required, justified, unexcused, late)
  # TODO Scenario: I update absecenes (required, justified, unexcused, late)
