Feature: UpdateAdditionalDesignation

    Scenario: Update additional designation

        Given I am authenticated with organisation id 1 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | REG_TRADE | 2018-03-01T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |

        When I update additional designation of the document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" with the following information:
        """
        {
            "additionalDesignation": "Great designation"
        }
        """

        Then The additional designation of the document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" is updated by the user with id "9231a32d-2e4f-444d-8587-e2680ee4a3aa" with the following designation "Great designation"
