Feature: PrintDossierForClient

    Scenario: Print my dossier for a client

        Given The following organisations exist:
                | id  | country | fullName       | registrationNumber | depositor |
                | 12  | GERMANY | Organisation 1 | 123456             | true      |
                | 14  | GERMANY | Client 1       | 654321             | true      |
        And I am authenticated with organisation id 12

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 33 | CLIENT_OF        | ACCEPTED | 14                   | 12                   |

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype      | dossier               | depositDate              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 12             | VALID               | REG_TRADE    | legal                 | 2018-03-01T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6422 | 12             | AWAITING_VALIDATION | REG_BUSINESS | business/construction | 2018-03-10T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6425 | 12             | VALID               | REG_BUSINESS | projects              | 2018-04-25T08:33:32.947Z | true    |

        When I print the dossier of the organisation 12 for the client 14

        Then I get a response with the status code 200

    Scenario: Do not print Dossier of organisation for a client that has no documents

        Given The following organisations exist:
            | id  | country | fullName       | registrationNumber |  depositor |
            | 15  | GERMANY | Organisation 1 | 123456             |  true      |
            | 23  | GERMANY | Client 1       | 654321             |  true      |

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 35 | CLIENT_OF        | ACCEPTED | 23                   | 15                   |

        And I am authenticated with organisation id 15

        When I print the dossier of the organisation 15 for the client 23

        Then I get a response with the status code 404

    Scenario: Print my subcontractors dossier

        Given The following organisations exist:
            | id  | country | fullName       | registrationNumber | depositor |
            | 12  | GERMANY | Organisation 1 | 123456             | true      |
            | 14  | GERMANY | Client 1       | 654321             | true      |

        And I am authenticated with organisation id 12

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 33 | CLIENT_OF        | ACCEPTED | 12                   | 14                   |

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype      | dossier               | depositDate              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 14             | VALID               | REG_TRADE    | legal                 | 2018-03-01T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6422 | 14             | AWAITING_VALIDATION | REG_BUSINESS | business/construction | 2018-03-10T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6425 | 14             | VALID               | REG_BUSINESS | projects              | 2018-04-25T08:33:32.947Z | true    |

        When I print the dossier of the subcontractor 14 for the organisation 12

        Then I get a response with the status code 200
