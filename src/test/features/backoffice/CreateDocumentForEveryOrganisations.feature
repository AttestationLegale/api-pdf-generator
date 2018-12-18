Feature: CreateDocumentForEveryOrganisations

    Scenario: Create document if doesn't exist for every organisation having a dossier

        Given I am authenticated with the roles "BackOffice"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        Given The "legal" folder exists for organisation 1

        When I create document for depositors with the following data:
        """
        {
            "subtypeCode" : "REG_TRADE"
        }
        """

        Then The following documents now exist for organisation 1 :
            | subtype                | folder                |
            | REG_TRADE              | legal                 |
