Feature: DownloadFile

    Scenario: Download my file

        Given I am authenticated with organisation id 1

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | PE_HEALTH | 2018-03-01T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |

        When I download the file of document id "f81d4fae-7dec-11d0-a765-00a0c91e6bf1"

        Then I get a response with the status code 200
        # The test does not check the response content but tests the security layer

    Scenario: Download my subcontractor file

        Given I am authenticated with organisation id 2

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |
            | 2  | GERMANY | Organisation 2 | 123457             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | PE_HEALTH | 2018-03-01T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 2                    | 1                    |

        When I download the file of document id "f81d4fae-7dec-11d0-a765-00a0c91e6bf1"

        Then I get a response with the status code 200
        # The test does not check the response content but tests the security layer

    Scenario: Download my subcontractor file in a project

        Given I am authenticated with organisation id 2

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |
            | 2  | GERMANY | Organisation 2 | 123457             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | PE_HEALTH | 2018-03-01T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder      |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | projects/42 |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 33 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role           | organisationPath |
            | 42 | 33        | 1              | SUB_CONTRACTOR | 2/1              |

        When I download the file of document id "f81d4fae-7dec-11d0-a765-00a0c91e6bf1"

        Then I get a response with the status code 200
        # The test does not check the response content but tests the security layer
