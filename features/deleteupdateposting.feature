# user stories for deleting and updating a posting

Feature: User deleting and updating a posting that they own

    Background: Logged in as a registered user and created posting
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
        | Description   | Experienced tutor |
        | Availability  | Anytime           |
        | Price         | 1000.0            |
        | Info          | 0109919241        |
        When I click the "Back to full list" button
        Then I should see a table row with the following fields:
        | Professional |
        | OtherTestMan |
        | CS           |
        | 20           |


    Scenario: User wants to delete their own posting
        When I click the "More about this Professional" button
        Then I should not see the "Delete posting" link
        When I click the "Back to full list" button
        And I click the "More about this User" button
        Then I should see the "Delete posting" link
        When I click the "Delete posting" button
        Then I should see "Welcome to Bridge"
        And I should not see a table row with the following fields:
        | User    |
        | TestMan |
        | CS      |
        | 1000    |

    Scenario: User wants to update their own posting
        When I click the "More about this Professional" button
        Then I should not see the "Edit posting" link
        When I click the "Back to full list" button
        And I click the "More about this User" button
        Then I should see the "Edit posting" link
        When I click the "Edit posting" button
        And I fill in the edit form
        And I click the "Update Posting Info" button
        Then I should see the following details for the posting:
        | Type          | User              |
        | Subject       | CS                |
        | Description   | Master Tutor      |
        | Availability  | Never             |
        | Price         | 20000.0           |
        | Info          | 0109919241        |
        When I click the "Back to full list" button
        Then I should see a table row with the following fields:
        | User        |
        | TestingMan  |
        | CS          |
        | 20000       |
        
