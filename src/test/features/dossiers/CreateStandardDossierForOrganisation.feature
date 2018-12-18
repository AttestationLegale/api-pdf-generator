Feature: CreateStandardDossierForOrganisation

    Scenario: create standard dossier for organisation

        Given I am authenticated with the roles "BackOffice"

        Given The following organisations exist:
            | id | country | fullName        | registrationNumber | depositor |
            | 60 | GERMANY | Organisation 60 | 123456             | true      |

        When I create standard dossier for organisation 60

        Then The "legal" folder now exists for organisation 60

        And The "business/construction" folder now exists for organisation 60

        And The following documents now exist for organisation 60 :
            | subtype                | folder                |
            | REG_TRADE              | legal                 |
            | REG_BUSINESS           | legal                 |
            | DE_REG                 | legal                 |
            | INS_LIABILITY          | legal                 |
            | TAX_OFFICE             | legal                 |
            | PE_HEALTH              | legal                 |
            | INS_ASSOCIATION        | legal                 |
            | COV_WAGE               | legal                 |
            | DE_SOKA                | business/construction |
            | TAX_EXEMPTION          | business/construction |
