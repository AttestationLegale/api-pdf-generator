Feature: SearchDocuments

    Scenario: Search an organisation documents

        Given I am authenticated with organisation id 1

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath |
            | 42 | 42        | 2              | CLIENT | 42               |

        Given The following documents exist:
            | uid                                  | organisationId | state               | subtype         | depositDate              | validityEnd              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE       | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | AWAITING_VALIDATION | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6b21 | 1              | VALID               | EMPLOYEES       | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 1              | VALID               | INS_LIA_POLICE  | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal           |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 1              | legal           |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42     |
            | f81d4fae-7dec-11d0-a765-00a0c91e6b21 | 1              | relationships/2 |

        When I search documents for organisation 1

        Then I get a response with the status code 200 and the following information:
	    """
	    [{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
			  "state": "MISSING",
			  "type": {
			    "documentTypeId": 3,
			    "code": "REG_TRADE",
			    "name": "Handelsregisterauszug",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "LEGAL"
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6421",
			  "state": "AWAITING_VALIDATION",
			  "type": {
			    "documentTypeId": 18,
			    "code": "EXT_SAFETY_INFO",
			    "name": "Auskunft Arbeitssicherheit",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "PROJECT",
			    "project": {
			    	"projectId" : 42,
			    	"name" : "Incity",
			    	"ownerOrganisation": {
					    "organisationId": 2,
					    "country": "GERMANY",
					    "fullName": "ALG",
					    "registrationNumber": "789012"
				    }
			    }
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6b21",
			  "state": "VALID",
			  "type": {
			    "documentTypeId": 19,
			    "code": "EMPLOYEES",
			    "name": "Liste der eingesetzten Arbeitnehmer",
			    "multiOccurrence": false,
			    "validityPeriod": 1,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "RELATIONSHIP",
			    "client": {
				    "organisationId": 2,
				    "country": "GERMANY",
				    "fullName": "ALG",
				    "registrationNumber": "789012"
			    }
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf2",
			  "state": "VALID",
			  "type": {
			    "documentTypeId": 10,
			    "code": "INS_LIA_POLICE",
			    "name": "Haftpflichtversicherungspolice",
			    "multiOccurrence": false,
			    "validityPeriod": null,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "LEGAL"
			  }],
			  "additionalDesignation": "First certificate"
			}]
	    """

    Scenario: Search an organisation documents by status

        Given I am authenticated with organisation id 1

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath |
            | 42 | 42        | 2              | CLIENT | 42               |

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              | almostExpired |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z | true          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | VALID | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z | true          |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal           |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42     |

        When I search documents for organisation 1 with states "VALID" and almost expired

        Then I get a response with the status code 200 and the following information:
	    """
	    [{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
			  "state": "VALID",
			  "type": {
			    "documentTypeId": 3,
			    "code": "REG_TRADE",
			    "name": "Handelsregisterauszug",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "LEGAL"
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6421",
			  "state": "VALID",
			  "type": {
			    "documentTypeId": 18,
			    "code": "EXT_SAFETY_INFO",
			    "name": "Auskunft Arbeitssicherheit",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "PROJECT",
			    "project": {
			    	"projectId" : 42,
			    	"name" : "Incity",
			    	"ownerOrganisation": {
					    "organisationId": 2,
					    "country": "GERMANY",
					    "fullName": "ALG",
					    "registrationNumber": "789012"
				    }
			    }
			  }],
			  "additionalDesignation": "First certificate"
			}]
	    """

    Scenario: Search an organisation documents by status and subtypeCodes

        Given I am authenticated with organisation id 1

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role   | organisationPath |
            | 42 | 42        | 2              | CLIENT | 42               |

        Given The following documents exist:
            | uid                                  | organisationId | state | subtype         | depositDate              | almostExpired |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | VALID | REG_TRADE       | 2018-03-01T08:41:32.957Z | true          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | AWAITING_VALIDATION | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6b21 | 1              | VALID               | EMPLOYEES       | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal           |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42     |
            | f81d4fae-7dec-11d0-a765-00a0c91e6b21 | 1              | relationships/2 |

        When I search documents for organisation 1 with states "VALID,AWAITING_VALIDATION" almost expired AND subtypeCodes "REG_TRADE,EXT_SAFETY_INFO"

        Then I get a response with the status code 200 and the following information:
	    """
	    [{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
			  "state": "VALID",
			  "type": {
			    "documentTypeId": 3,
			    "code": "REG_TRADE",
			    "name": "Handelsregisterauszug",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "LEGAL"
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6421",
			  "state": "AWAITING_VALIDATION",
			  "type": {
			    "documentTypeId": 18,
			    "code": "EXT_SAFETY_INFO",
			    "name": "Auskunft Arbeitssicherheit",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "PROJECT",
			    "project": {
			    	"projectId" : 42,
			    	"name" : "Incity",
			    	"ownerOrganisation": {
					    "organisationId": 2,
					    "country": "GERMANY",
					    "fullName": "ALG",
					    "registrationNumber": "789012"
				    }
			    }
			  }],
			  "additionalDesignation": "First certificate"
			}]
	    """

    Scenario: Search for an organisation documents on self intervention

        Given I am authenticated with organisation id 1

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role               | organisationPath |
            | 41 | 42        | 2              | CLIENT             | 2                |
            | 42 | 42        | 1              | GENERAL_CONTRACTOR | 2/1              |

        Given The following documents exist:
            | uid                                  | organisationId | state               | subtype          | depositDate              | validityEnd              | rejected |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE        | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   false  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | AWAITING_VALIDATION | EXT_SAFETY_INFO  | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   false  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | MISSING             | COV_CONSTRUCTION | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   true   |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder                |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42           |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | business/construction |

        When I search documents for intervention 42

        Then I get a response with the status code 200 and the following information:
	    """
	    [{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
			  "state": "MISSING",
			  "type": {
			    "documentTypeId": 3,
			    "code": "REG_TRADE",
			    "name": "Handelsregisterauszug",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "LEGAL"
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6c01",
			  "state": "MISSING",
			  "type": {
			    "documentTypeId": 21,
			    "code": "COV_CONSTRUCTION",
			    "name": "SOKA Bau / ULAK",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "BUSINESS",
			    "business": "construction"
			  }],
			  "additionalDesignation": "First certificate",
			  "rejectionReason" : "Rejection reason"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6421",
			  "state": "AWAITING_VALIDATION",
			  "type": {
			    "documentTypeId": 18,
			    "code": "EXT_SAFETY_INFO",
			    "name": "Auskunft Arbeitssicherheit",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "PROJECT",
			    "project": {
			    	"projectId" : 42,
			    	"name" : "Incity",
			    	"ownerOrganisation": {
					    "organisationId": 2,
					    "country": "GERMANY",
					    "fullName": "ALG",
					    "registrationNumber": "789012"
				    }
			    }
			  }],
			  "additionalDesignation": "First certificate"
			}]
	    """

	Scenario: Search for an organisation documents on a subcontractor intervention

        Given I am authenticated with organisation id 2

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 2                   |

        Given The following interventions exist:
            | id | projectId | organisationId | role               | organisationPath |
            | 41 | 42        | 2              | CLIENT             | 2                |
            | 42 | 42        | 1              | GENERAL_CONTRACTOR | 2/1              |

        Given The following documents exist:
            | uid                                  | organisationId | state               | subtype          | depositDate              | validityEnd              | rejected |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE        | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   false  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | AWAITING_VALIDATION | EXT_SAFETY_INFO  | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   false  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | MISSING             | COV_CONSTRUCTION | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   true   |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder                |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 1              | projects/42           |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | business/construction |

        When I search documents for intervention 42 of subcontractor 1

        Then I get a response with the status code 200 and the following information:
	    """
	    [{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
			  "state": "MISSING",
			  "type": {
			    "documentTypeId": 3,
			    "code": "REG_TRADE",
			    "name": "Handelsregisterauszug",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "LEGAL"
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6c01",
			  "state": "AWAITING_VALIDATION",
			  "type": {
			    "documentTypeId": 21,
			    "code": "COV_CONSTRUCTION",
			    "name": "SOKA Bau / ULAK",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "BUSINESS",
			    "business": "construction"
			  }],
			  "additionalDesignation": "First certificate",
			  "rejectionReason" : null
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6421",
			  "state": "AWAITING_VALIDATION",
			  "type": {
			    "documentTypeId": 18,
			    "code": "EXT_SAFETY_INFO",
			    "name": "Auskunft Arbeitssicherheit",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "PROJECT",
			    "project": {
			    	"projectId" : 42,
			    	"name" : "Incity",
			    	"ownerOrganisation": {
					    "organisationId": 2,
					    "country": "GERMANY",
					    "fullName": "ALG",
					    "registrationNumber": "789012"
				    }
			    }
			  }],
			  "additionalDesignation": "First certificate"
			}]
	    """
	    
    Scenario: Search all organisation documents for client

        Given I am authenticated with organisation id 1

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 2                    | 1                    |

        Given The following documents exist:
            | uid                                  | organisationId | state   | subtype          | depositDate              | validityEnd              | rejected |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | REG_TRADE        | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   false  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | MISSING | COV_CONSTRUCTION | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   true   |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder                |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | business/construction |

        When I search documents for organisation 1 on relationship with client 2

        Then I get a response with the status code 200 and the following information:
	    """
	    [{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
			  "state": "MISSING",
			  "type": {
			    "documentTypeId": 3,
			    "code": "REG_TRADE",
			    "name": "Handelsregisterauszug",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "LEGAL"
			  }],
			  "additionalDesignation": "First certificate"
			},
			{
			  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6c01",
			  "state": "MISSING",
			  "type": {
			    "documentTypeId": 21,
			    "code": "COV_CONSTRUCTION",
			    "name": "SOKA Bau / ULAK",
			    "multiOccurrence": false,
			    "validityPeriod": 12,
			    "designationMandatory": false
			  },
			  "validityEnd": "2018-03-01T08:41:32.957Z",
			  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
			  "organisation": {
			    "organisationId": 1,
			    "country": "GERMANY",
			    "fullName": "Organisation 1",
			    "registrationNumber": "123456"
			  },
			  "dossiers": [{
			    "type": "BUSINESS",
			    "business": "construction"
			  }],
			  "additionalDesignation": "First certificate",
			  "rejectionReason" : "Rejection reason"
			}]
	    """
	    
    Scenario: Search all organisation documents of subcontractor

        Given I am authenticated with organisation id 2

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 2                    | 1                    |

        Given The following documents exist:
            | uid                                  | organisationId | state   | subtype          | depositDate              | validityEnd              | rejected |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | REG_TRADE        | 2018-03-01T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   false  |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | MISSING | COV_CONSTRUCTION | 2018-03-10T08:41:32.957Z | 2018-03-01T08:41:32.957Z |   true   |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder                |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | business/construction |

        When I search documents for subcontractor 1 on relationship with organisation 2

        Then I get a response with the status code 200 and the following information:
		    """
		    [{
				  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
				  "state": "MISSING",
				  "type": {
				    "documentTypeId": 3,
				    "code": "REG_TRADE",
				    "name": "Handelsregisterauszug",
				    "multiOccurrence": false,
				    "validityPeriod": 12,
				    "designationMandatory": false
				  },
				  "validityEnd": "2018-03-01T08:41:32.957Z",
				  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
				  "organisation": {
				    "organisationId": 1,
				    "country": "GERMANY",
				    "fullName": "Organisation 1",
				    "registrationNumber": "123456"
				  },
				  "dossiers": [{
				    "type": "LEGAL"
				  }],
				  "additionalDesignation": "First certificate"
				},
				{
				  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6c01",
				  "state": "AWAITING_VALIDATION",
				  "type": {
				    "documentTypeId": 21,
				    "code": "COV_CONSTRUCTION",
				    "name": "SOKA Bau / ULAK",
				    "multiOccurrence": false,
				    "validityPeriod": 12,
				    "designationMandatory": false
				  },
				  "validityEnd": "2018-03-01T08:41:32.957Z",
				  "userId": "9231a32d-2e4f-444d-8587-e2680ee4a3aa",
				  "organisation": {
				    "organisationId": 1,
				    "country": "GERMANY",
				    "fullName": "Organisation 1",
				    "registrationNumber": "123456"
				  },
				  "dossiers": [{
				    "type": "BUSINESS",
				    "business": "construction"
				  }],
				  "additionalDesignation": "First certificate",
				  "rejectionReason" : null
				}]
		    """
