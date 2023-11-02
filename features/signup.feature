# user stories for user login
Feature: User Sign Up

  Scenario: Successful sign up
    Given I am on the sign-up page
    When I fill in the sign-up form correctly
    And I click the "Sign up" button
    Then I should see "Welcome to Bridge"

  Scenario: Unsuccessful sign up
    Given I am on the sign-up page
    When I fill in the sign-up form incorrectly
    And I click the "Sign up" button
    Then I should see "error"
