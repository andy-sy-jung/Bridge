# user stories for filtering

Feature: User wanting to filter the postings to be limited to what they want to look for

    Background: Logged in as registered user, and more posts.
        Given I am on the log-in page
        Given I have a registered user with the following credentials:
            | Email            | Password    |
            | user@example.com | password123 |
        And I fill in the log-in form correctly
        And I click the "Log in" button
        Then I should see "Welcome to Bridge"
        And I have the following posting by another user:
            | name          | description              | price | availability   | subject    | contact           | type_of           |
            | OtherTestMan  | Unexperienced Tutor      | 20.0  | Anytime        | CS         | 9699996080        | Professional      |
            | TestMan       | Unexperienced Analyst    | 20.0  | Anytime        | Math       | 9699996080        | Professional      |
            | TestMan2      | Unexperienced Man        | 20.0  | Anytime        | CS         | 9699996080        | User              |
            | MathGod       | Unexperienced Mathguy    | 20.0  | Anytime        | Math       | 9699996080        | Professional      |

    
    Scenario: User wants to see only CS people
        When I uncheck all other boxes except "CS"
        And I click the "Refresh" button
        Then I should see a table row with the following fields:
        | User     |
        | TestMan2 |
        | CS       |
        | 20       | 
        And I should see a table row with the following fields:
        | Professional |
        | OtherTestMan |
        | CS           |
        | 20           |
    
    Scenario: User wants to see only professionals in math 
        When I uncheck all other boxes except "Math"
        And I click the "Refresh" button
        Then I should see a table row with the following fields:
        | Professional |
        | TestMan      |
        | Math         |
        | 20           |
        And I should see a table row with the following fields:
        | Professional |
        | MathGod      |
        | Math         |
        | 20           |  