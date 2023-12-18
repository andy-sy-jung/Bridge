# user stories for adding a posting

Feature: User adding a posting

    Background: Logged in as a registered user
        Given I am on the log-in page
        Given I have a registered user with the following credentials:
        | Email            | Password    |
        | user@example.com | password123 |
        And I fill in the log-in form correctly
        And I click the "Log in" button
        Then I should see "Welcome to Bridge"

    Scenario: Successful posting
        When I click the "Add new posting" button
        Then I should see "Create New Posting"
        When I fill in the create form
        And I click the "Save Changes" button
        Then I should see a table row with the following fields:
        | User    |
        | TestMan |
        | CS      |
        | 1000    |
        When I click the "More about this User" button
        Then I should see the following details for the posting:
        | Type          | User              |
        | Subject       | CS                |
        | Availability  | Anytime           |
        | Price         | 1000.0            |
        | Info          | 0109919241        |
        

        
