Feature: GetObligationIntervention

    Scenario: Get obligation intervention required document type
        Given I am authenticated with organisation id 1
        Given The following obligation intervention exist:
            | interventionId | requiredDocumentType |
            | 1              | 1                    |
            | 1              | 2                    |
            | 1              | 3                    |
        When I get for the intervention id 1 the required document type:
        Then I get a response with the status code 200
        And The following document type have been defined for the intervention id 1:
            | 1                 |
            | 2                 |
            | 3                 |
