Feature: TakeDocumentsOfSubtypeOutOfStandardDossier

    Scenario: Take several documents of one subtype out of standard dossier

        Given I am authenticated with the roles "BackOffice" and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        And The following documents exist:
            | uid                                  | organisationId | state                 | subtype           | depositDate              | validityEnd              |
            | a11d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING               | INS_LIA_POLICE    | 2018-03-01T08:41:32.957Z | 2019-03-01T08:41:32.957Z |
            | b21d4fae-7dec-11d0-a765-00a0c91e6bf1 | 2              | VALID                 | INS_LIA_POLICE    | 2018-03-02T08:41:32.957Z | 2019-03-02T08:41:32.957Z |
            | c31d4fae-7dec-11d0-a765-00a0c91e6bf1 | 3              | AWAITING_VALIDATION   | INS_LIA_POLICE    | 2018-03-03T08:41:32.957Z | 2019-03-03T08:41:32.957Z |
            | d41d4fae-7dec-11d0-a765-00a0c91e6bf1 | 4              | AWAITING_COMPLETION   | INS_LIA_POLICE    | 2018-03-04T08:41:32.957Z | 2019-03-04T08:41:32.957Z |
            | e51d4fae-7dec-11d0-a765-00a0c91e6bf1 | 5              | AWAITING_SIGNATURE    | INS_LIA_POLICE    | 2018-03-05T08:41:32.957Z | 2019-03-05T08:41:32.957Z |
            | f61d4fae-7dec-11d0-a765-00a0c91e6bf1 | 6              | AWAITING_GATHERING    | INS_LIA_POLICE    | 2018-03-06T08:41:32.957Z | 2019-03-06T08:41:32.957Z |
            | 171d4fae-7dec-11d0-a765-00a0c91e6bf1 | 7              | NOT_APPLICABLE        | INS_LIA_POLICE    | 2018-03-07T08:41:32.957Z | 2019-03-07T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder    |
            | a11d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal     |
            | b21d4fae-7dec-11d0-a765-00a0c91e6bf1 | 2              | legal     |
            | c31d4fae-7dec-11d0-a765-00a0c91e6bf1 | 3              | legal     |
            | d41d4fae-7dec-11d0-a765-00a0c91e6bf1 | 4              | legal     |
            | e51d4fae-7dec-11d0-a765-00a0c91e6bf1 | 5              | legal     |
            | f61d4fae-7dec-11d0-a765-00a0c91e6bf1 | 6              | legal     |
            | 171d4fae-7dec-11d0-a765-00a0c91e6bf1 | 7              |           |

        When I take documents of subtype "INS_LIA_POLICE" out of standard dossier

        Then The documents are taken out of workflow
            | documentId                           | userId                               |
            | a11d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | b21d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | c31d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | d41d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | e51d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | f61d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |

        And The documents aren't taken out of workflow
            | documentId                           | userId                               |
            | 171d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |

        And The document with uid "a11d4fae-7dec-11d0-a765-00a0c91e6bf1" is in additional dossier

    Scenario: Take no document of one subtype out of standard dossier

        Given I am authenticated with the roles "BackOffice" and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        And The following documents exist:
            | uid                                  | organisationId | state                 | subtype           | depositDate              | validityEnd              |
            | a11d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING               | REG_TRADE         | 2018-03-01T08:41:32.957Z | 2019-03-01T08:41:32.957Z |
            | b21d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID                 | REG_BUSINESS      | 2018-03-02T08:41:32.957Z | 2019-03-02T08:41:32.957Z |
            | c31d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | AWAITING_VALIDATION   | REG_COMPANY       | 2018-03-03T08:41:32.957Z | 2019-03-03T08:41:32.957Z |
            | d41d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | AWAITING_COMPLETION   | REG_ARTISAN       | 2018-03-04T08:41:32.957Z | 2019-03-04T08:41:32.957Z |
            | e51d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | AWAITING_SIGNATURE    | INS_LIABILITY     | 2018-03-05T08:41:32.957Z | 2019-03-05T08:41:32.957Z |
            | f61d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | NOT_APPLICABLE        | TAX_LIABILITY     | 2018-03-06T08:41:32.957Z | 2019-03-06T08:41:32.957Z |
            | 171d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | AWAITING_GATHERING    | COV_CONSTRUCTION  | 2018-03-07T08:41:32.957Z | 2019-03-07T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder    |
            | a11d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal     |
            | b21d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal     |
            | c31d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal     |
            | d41d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal     |
            | e51d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal     |
            | f61d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | business  |
            | 171d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | business  |

        When I take documents of subtype "INS_LIA_POLICE" out of standard dossier

        Then The documents aren't taken out of workflow
            | documentId                           | userId                               |
            | a11d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | b21d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | c31d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | d41d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | e51d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | f61d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
            | 171d4fae-7dec-11d0-a765-00a0c91e6bf1 | 9231a32d-2e4f-444d-8587-e2680ee4a3aa |
