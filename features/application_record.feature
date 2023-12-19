Feature: ApplicationRecord

  Scenario: ApplicationRecord is an abstract class
    Given I have an ApplicationRecord
    When I check if it is an abstract class
    Then it should be an abstract class
