# user stories for user log in and log out
Feature: User Log In and Log Out

  Background: Existing Users
    Given I am on the log-in page
    Given I have a registered user with the following credentials:
    | Email            | Password    |
    | user@example.com | password123 |

  Scenario: Successful Log In
    When I fill in the log-in form correctly
    And I click the "Log in" button
    Then I should see "Welcome to Bridge"

  Scenario: Unsuccessful Log In
    When I fill in the log-in form incorrectly
    And I click the "Log in" button
    Then I should see "Log in"
