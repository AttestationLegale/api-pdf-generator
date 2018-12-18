Feature: DownloadDossierForClient

    Scenario: Download my dossier for a client

        Given The following organisations exist:
                | id  | country | fullName       | registrationNumber | depositor |
                | 13  | GERMANY | Organisation 1 | 123456             | true      |
                | 21  | GERMANY | Client 1       | 654321             | true      |

        And I am authenticated with organisation id 13

        And The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 44 | CLIENT_OF        | ACCEPTED | 21                   | 13                   |

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype      | dossier               | depositDate              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 13             | VALID               | REG_TRADE    | legal                 | 2018-03-01T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6422 | 13             | AWAITING_VALIDATION | REG_BUSINESS | business/construction | 2018-03-10T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6427 | 13             | VALID               | REG_BUSINESS | projects              | 2018-04-25T08:33:32.947Z | true    |

        When I download the dossier of the organisation 13 for the client 21 and with utcOffset 120

        Then I get a response with the status code 200

    Scenario: Download my dossier for a client without files

        Given The following organisations exist:
                | id  | country | fullName       | registrationNumber | depositor |
                | 15  | GERMANY | Organisation 1 | 123456             | true      |
                | 23  | GERMANY | Client 1       | 654321             | true      |

        And I am authenticated with organisation id 15

        When I download the dossier of the organisation 15 for the client 23 and with utcOffset 120

        Then I get a response with the status code 404

    Scenario: Download my subcontractor's dossier

        Given The following organisations exist:
            | id  | country | fullName       | registrationNumber | depositor |
            | 13  | GERMANY | Organisation 1 | 123456             | true      |
            | 21  | GERMANY | Client 1       | 654321             | true      |

        And I am authenticated with organisation id 13

        And The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 44 | CLIENT_OF        | ACCEPTED | 13                   | 21                   |

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype      | dossier               | depositDate              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 21             | VALID               | REG_TRADE    | legal                 | 2018-03-01T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6422 | 21             | AWAITING_VALIDATION | REG_BUSINESS | business/construction | 2018-03-10T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6427 | 21             | VALID               | REG_BUSINESS | projects              | 2018-04-25T08:33:32.947Z | true    |

        When I download the dossier of the subcontractor 21 for the organisation 13 and with utcOffset 120

        Then I get a response with the status code 200
