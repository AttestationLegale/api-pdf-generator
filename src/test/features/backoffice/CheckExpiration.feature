Feature: CheckExpiration

    Scenario: Manually trigger expiration check

        Given I am authenticated with the roles "BackOffice"

        When I manually trigger an expiration check

        Then The expiration check is triggered

