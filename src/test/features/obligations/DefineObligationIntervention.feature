Feature: DefineObligationIntervention

    Scenario: Define new obligation intervention
        Given I am authenticated with organisation id 1
        When I define for the intervention id 1 the following document type ids:
            """
            [1, 2, 3]
            """
        Then I get a response with the status code 200
        And The following document type have been defined for the intervention id 1:
            | 1                 |
            | 2                 |
            | 3                 |

    Scenario: Update obligation intervention
        Given I am authenticated with organisation id 1
        Given The following obligation intervention exist:
            | interventionId | requiredDocumentType |
            | 1              | 1                    |
            | 1              | 2                    |
            | 1              | 3                    |
        When I define for the intervention id 1 the following document type ids:
            """
            [2, 3, 4]
            """
        Then I get a response with the status code 200
        And The following document type have been defined for the intervention id 1:
            | 2 |
            | 3 |
            | 4 |
