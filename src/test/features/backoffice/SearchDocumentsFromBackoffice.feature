Feature: SearchFromBackOffice

    Scenario: Search documents from backoffice

        Given I am authenticated with the roles "BackOffice"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following documents exist:
            | uid                                  | organisationId | state               | subtype         | depositDate              | validityEnd              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE       | 2018-03-01T08:41:32.957Z | 2018-06-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 2              | AWAITING_VALIDATION | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z | 2018-06-10T08:41:32.957Z |

        When I search documents from backoffice

        Then I get a response with the status code 200 and the following information:
			    """
			    [{
					  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
					  "state": "MISSING",
					  "type": {
					    "documentTypeId": 3,
					    "code": "REG_TRADE",
					    "name": "Handelsregisterauszug"
					  },
					  "validityEnd": "2018-06-01T08:41:32.957Z",
					  "depositDate": "2018-03-01T08:41:32.957Z",
					  "organisation": {
					    "organisationId": 1,
					    "country": "GERMANY",
					    "fullName": "Organisation 1",
					    "registrationNumber": "123456"
					  },
					  "additionalDesignation": "First certificate"
					}, {
						  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6421",
						  "state": "AWAITING_VALIDATION",
						  "type": {
						    "documentTypeId": 18,
						    "code": "EXT_SAFETY_INFO",
						    "name": "Auskunft Arbeitssicherheit"
						  },
						  "validityEnd": "2018-06-10T08:41:32.957Z",
						  "depositDate": "2018-03-10T08:41:32.957Z",
						  "organisation": {
						    "organisationId": 2,
						    "country": "GERMANY",
						    "fullName": "ALG",
						    "registrationNumber": "789012"
						  },
						  "additionalDesignation": "First certificate"
					}]
			    """
	    
	  
  	Scenario: Search documents from backoffice with custom order
        Given I am authenticated with the roles "BackOffice"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following documents exist:
            | uid                                  | organisationId | state               | subtype         | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING             | REG_TRADE       | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6421 | 2              | AWAITING_VALIDATION | EXT_SAFETY_INFO | 2018-03-10T08:41:32.957Z |

        When I search documents from backoffice with params:
        		| name             | value               | 
        		| direction        | DESC                |
        		| property         | depositDate         |
        		| subtypeQuery     | aus                 | 
        		| state            | MISSING             |
        		| state            | AWAITING_VALIDATION |
        		| startDepositDate | 2018-03-01          |
        		| endDepositDate   | 2018-04-30          |

				# The response data doesn't match query because sort and filter are not implemented in FakeNuxeoClient, but it is enough to test other layers
        Then I get a response with the status code 200 and the following information:
			    """
			    [{
					  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6bf1",
					  "state": "MISSING",
					  "type": {
					    "documentTypeId": 3,
					    "code": "REG_TRADE",
					    "name": "Handelsregisterauszug"
					  },
					  "depositDate": "2018-03-01T08:41:32.957Z",
					  "organisation": {
					    "organisationId": 1,
					    "country": "GERMANY",
					    "fullName": "Organisation 1",
					    "registrationNumber": "123456"
					  }
					}, {
						  "uid": "f81d4fae-7dec-11d0-a765-00a0c91e6421",
						  "state": "AWAITING_VALIDATION",
						  "type": {
						    "documentTypeId": 18,
						    "code": "EXT_SAFETY_INFO",
						    "name": "Auskunft Arbeitssicherheit"
						  },
						  "depositDate": "2018-03-10T08:41:32.957Z",
						  "organisation": {
						    "organisationId": 2,
						    "country": "GERMANY",
						    "fullName": "ALG",
						    "registrationNumber": "789012"
						  }
					}]
			    """
	    
