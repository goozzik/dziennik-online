Feature: Absence

  Scenario: I go to the may absences
    Given I am logged in as a teacher
    And I have abseneces for may
    When I go to the teacher absences may index page
    Then I should see may absences

  Scenario: I am on the may absences and i click link to go next month
    Given I am logged in as a teacher
    And I have abseneces for may
    When I go to the teacher absences may index page
    And I follow link for next month
    Then I should see june absences

  Scenario: I am on the may absences and i click link to go last month
    Given I am logged in as a teacher
    And I have abseneces for may
    When I go to the teacher absences may index page
    And I follow link for previous month
    Then I should see april absences

  # @wip
  # TODO Scenario: I add absecenes (required, justified, unexcused, late)
  # TODO Scenario: I update absecenes (required, justified, unexcused, late)
