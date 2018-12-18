Feature: TakeDocumentOutOfStandardDossier

    Scenario: Take a document out of standard dossier

        Given I am authenticated with the roles "BackOffice" and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following documents exist:
            | uid                                  | organisationId | state               | subtype         | depositDate              | validityEnd              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE       | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal           |

        When I take out of standard dossier the document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1"

        Then The document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" is taken out of workflow by the user with id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Then The document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" is in additional dossier
