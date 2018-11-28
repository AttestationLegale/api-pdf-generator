Feature: DuplicateDocument

    Scenario: Duplicate document

        Given I am authenticated with organisation id 1 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | PE_HEALTH | 2018-03-01T08:41:32.957Z |

        When I duplicate a document with the following information:
        """
        {
            "organisationId": 1,
            "type": "PE_HEALTH",
            "dossiers": [
                {
                    "type": "LEGAL"
                }
            ]
        }
        """

        Then Document "PE_HEALTH" for organisation 1 is multi occurrence
