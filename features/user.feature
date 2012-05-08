Feature: User

  Scenario: I am logging in
    When I am logging in
    Then I should see "Zalogowano pomyślnie"

  Scenario: I am logging out
    When I am logging in
    And I am logging out
    Then I should see "Login"
