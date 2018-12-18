Feature: DeleteDocuments

    Scenario: Can not delete a unique legal document

        Given I am authenticated with organisation id 1

        And The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype         | depositDate              | validityEnd              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE       | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal           |

        When I delete the document "f81d4fae-7dec-11d0-a765-00a0c91e6bf1"

        Then I get a response with the status code 400


    Scenario: Can delete an additional document

        Given I am authenticated with organisation id 1

        And The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state               | subtype         | depositDate              | validityEnd              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE       | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              |                 |

        When I delete the document "f81d4fae-7dec-11d0-a765-00a0c91e6bf1"

        Then I get a response with the status code 200

    Scenario: Can delete an empty multi occurrences document

        Given I am authenticated with organisation id 1

        And The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              | validityEnd              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | REG_TRADE | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z | false   |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 1              | VALID   | REG_TRADE | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z | true   |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 1              | legal  |

        When I delete the document "f81d4fae-7dec-11d0-a765-00a0c91e6bf1"

        Then I get a response with the status code 200

    Scenario: Can not delete a multi occurrences document which has a file

        Given I am authenticated with organisation id 1

        And The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              | validityEnd              | hasFile |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | REG_TRADE | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z | false   |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 1              | VALID   | REG_TRADE | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z | true    |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 1              | legal  |

        When I delete the document "f81d4fae-7dec-11d0-a765-00a0c91e6bf2"

        Then I get a response with the status code 400

