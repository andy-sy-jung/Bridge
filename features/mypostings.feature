# user stories for viewing my own postings

Feature: User wants to view his own postings

    Background: Logged in as a registered user and created some posts, and there are other posts
        Given I am on the log-in page
        Given I have a registered user with the following credentials:
            | Email            | Password    |
            | user@example.com | password123 |
        And I fill in the log-in form correctly
        And I click the "Log in" button
        Then I should see "Welcome to Bridge"
        And I have the following posting by another user:
            | name          | description              | price | availability   | subject    | contact           | type_of           |
            | TestMan2      | Unexperienced Man        | 20.0  | Anytime        | CS         | 9699996080        | User              |
            | MathGod       | Unexperienced Mathguy    | 20.0  | Anytime        | Math       | 9699996080        | Professional      |
        When I click the "Add new posting" button
        Then I should see "Create New Posting"
        When I fill in the create form
        And I click the "Save Changes" button
        Then I should see a table row with the following fields:
        | User    |
        | TestMan |
        | CS      |
        | 1000    |
    
    Scenario: User clicks on the my postings link on top
        When I click the "My Postings" button
        Then I should see a table row with the following fields:
        | User    |
        | TestMan |
        | CS      |
        | 1000    |
        And I should not see a table row with the following fields:
        | User     |
        | TestMan2 |
        | CS       |
        | 20       |
        And I should not see a table row with the following fields:
        | Professional |
        | MathGod      |
        | Math         |
        | 20           |