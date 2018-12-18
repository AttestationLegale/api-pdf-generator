Feature: DownloadDossier

    Scenario: Download Dossier of organisation that has some documents

        Given The following organisations exist:
                | id  | country | fullName       | registrationNumber |  depositor |
                | 12  | GERMANY | Organisation 1 | 123456             |  true      |

        And I am authenticated with organisation id 12 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        And The following documents exist:
            | uid                                  | organisationId  | state               | subtype               | dossier               | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 12              | VALID               | REG_TRADE             | legal                 | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6422 | 12              | AWAITING_VALIDATION | REG_BUSINESS          | business/construction | 2018-03-10T08:41:32.957Z |

        When I download the dossier of the organisation 12 and utcOffset 60

        Then I get a response with the status code 200

    Scenario: Do not download Dossier of organisation that has no documents

        Given The following organisations exist:
                | id  | country | fullName       | registrationNumber |  depositor |
                | 15  | GERMANY | Organisation 1 | 123456             |  true      |

        And I am authenticated with organisation id 15 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        When I download the dossier of the organisation 15 and utcOffset 60

        Then I get a response with the status code 404
