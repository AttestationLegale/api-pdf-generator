Feature: GetDossierState

    Scenario: Get my invalid standard dossier state

        Given I am authenticated with organisation id 1 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following documents exist:
            | uid                                  | organisationId | state               | subtype         | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID               | REG_TRADE       | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | AWAITING_VALIDATION | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | legal  |

        When I get for organisation 1 the standard dossier state

        Then I get a response with the status code 200 and the following information:
        """
	    {
	      "dossierState": "INVALID"
	    }
	    """

    Scenario: Get my valid standard dossier state

        Given I am authenticated with organisation id 1 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | VALID | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | legal  |

        When I get for organisation 1 the standard dossier state

        Then I get a response with the status code 200 and the following information:
        """
	    {
	      "dossierState": "VALID"
	    }
	    """

    Scenario: Get my warning standard dossier state

        Given I am authenticated with organisation id 1 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              | almostExpired |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z | false         |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | VALID | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z | true          |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | legal  |

        When I get for organisation 1 the standard dossier state

        Then I get a response with the status code 200 and the following information:
        """
	    {
	      "dossierState": "WARNING"
	    }
	    """

    Scenario: Get valid standard dossier state of my subcontractor

        Given I am authenticated with organisation id 2 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 2                    | 1                    |

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | VALID | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | legal  |

        When I get for organisation 1 the standard dossier state

        Then I get a response with the status code 200 and the following information:
        """
	    {
	      "dossierState": "VALID"
	    }
	    """

    Scenario: Get valid intervention dossier state of my subcontractor in intervention

        Given I am authenticated with organisation id 2 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 33 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath |
            | 42 | 33        | 1              | CLIENT | 2/1              |

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | VALID | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder      |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal       |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42 |

        When I get the project dossier state for intervention 42

        Then I get a response with the status code 200 and the following information:
        """
	    {
	      "dossierState": "VALID"
	    }
	    """

    Scenario: Get valid intervention dossier state of an organisation below mine

        Given I am authenticated with organisation id 2 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 33 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath   |
            | 42 | 33        | 1              | CLIENT | 2/4/1              |

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | VALID | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder      |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal       |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42 |

        When I get the project dossier state for intervention 42

        Then I get a response with the status code 200 and the following information:
        """
	    {
	      "dossierState": "VALID"
	    }
	    """

    Scenario: Get error when accessing intervention dossier state of an organisation in project that is not my subcontractor

        Given I am authenticated with organisation id 2 and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 33 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath   |
            | 42 | 33        | 1              | CLIENT | 1              |

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | VALID | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder      |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal       |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42 |

        When I get the project dossier state for intervention 42

        Then I get a response with the status code 403
