Feature: PrintDossierByIntervention

    Scenario: Print my dossier in a project

        Given The following organisations exist:
            | id  | country | fullName       | registrationNumber | depositor |
            | 13  | GERMANY | Organisation 1 | 123456             | true      |

        And The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 13                  |

        And The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath |
            | 42 | 42        | 13             | CLIENT | 13               |

        And I am authenticated with organisation id 13

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype      | dossier               | depositDate              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 13             | VALID               | REG_TRADE    | legal                 | 2018-03-01T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6422 | 13             | AWAITING_VALIDATION | REG_BUSINESS | business/construction | 2018-03-10T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6427 | 13             | VALID               | REG_BUSINESS | projects              | 2018-04-25T08:33:32.947Z | true    |


        When I print the dossier for the intervention 42

        Then I get a response with the status code 200

    Scenario: Do not print dossier of organisation that has no documents for the intervention

        Given The following organisations exist:
            | id  | country | fullName       | registrationNumber | depositor |
            | 15  | GERMANY | Organisation 1 | 123456             | true      |

        And The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 15                  |

        And The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath |
            | 42 | 42        | 15             | CLIENT | 13               |

        And I am authenticated with organisation id 15

        When I print the dossier for the intervention 42

        Then I get a response with the status code 404

    Scenario: Print my subcontractor's dossier in a project

        Given The following organisations exist:
            | id  | country | fullName       | registrationNumber | depositor |
            | 13  | GERMANY | Organisation 1 | 123456             | true      |
            | 14  | GERMANY | Organisation 3 | 123450             | true      |

        And The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 13                  |

        And The following interventions exist:
            | id | projectId | organisationId | role               | organisationPath |
            | 42 | 42        | 13             | CLIENT             | 13               |
            | 43 | 42        | 14             | GENERAL_CONTRACTOR | 13/14            |

        And I am authenticated with organisation id 13

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype      | dossier               | depositDate              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 14             | VALID               | REG_TRADE    | legal                 | 2018-03-01T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6422 | 14             | AWAITING_VALIDATION | REG_BUSINESS | business/construction | 2018-03-10T08:41:32.957Z | true    |
            | f81d4fae-7dec-11d0-a765-00a0c91e6427 | 14             | VALID               | REG_BUSINESS | projects              | 2018-04-25T08:33:32.947Z | true    |


        When I print the dossier of subcontractor 14 of intervention 43

        Then I get a response with the status code 200
