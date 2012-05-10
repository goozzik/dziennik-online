Feature: User

  Scenario: I am logging in
    Given a teacher exists
    When I am logging in
    Then I should see "Zalogowano pomyślnie"

  Scenario: I am logging out
    Given a teacher exists
    When I am logging in
    And I am logging out
    Then I should see "Login"
