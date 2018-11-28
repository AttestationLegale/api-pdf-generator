Feature: RejectDocument

    Scenario: Reject a document with a reason

        Given I am authenticated with the roles "BackOffice" and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        When I reject the document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" for the reason "Just wrong."

        Then The document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" is rejected for the reason "Just wrong." by the user with id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"
