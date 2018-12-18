Feature: UpdateOrganisation

    Scenario: Create legal and business documents when receiving a organisation updated message with depositor equals true

    		Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 2  | FRANCE  | Bouygues       | 12347584936485     | false		 |

        When I publish an organisation updated event with the following data:
	        """
	        {
            "organisationId" : 2,
            "fullName" : "Bouygues",
            "country" : "FRANCE",
            "registrationNumber" : "12347584936485",
            "depositor" : true
          }
	        """
        Then The "legal" folder now exists for organisation 2
        Then The "business/construction" folder now exists for organisation 2
        Then The following documents now exist for organisation 2 :
            | subtype                | folder                |
            | REG_BUSINESS           | legal                 |
            | DE_REG                 | legal                 |
            | INS_LIABILITY          | legal                 |
            | TAX_OFFICE             | legal                 |
            | PE_HEALTH              | legal                 |
            | INS_ASSOCIATION        | legal                 |
            | COV_WAGE               | legal                 |
            | DE_SOKA                | business/construction |
            | TAX_EXEMPTION          | business/construction |
            | TAX_LIABILITY          | business/construction |
        Then The following organisations have been persisted:
            | id | country | fullName | registrationNumber | depositor |
            | 2  | FRANCE  | Bouygues | 12347584936485     | true      |

        And A message "depositorService" is "activated" is published with the following data:
		      """
		      {
					  "organisation": {
					    "organisationId": 2,
					    "fullName": "Bouygues",
					    "country": "FRANCE",
					    "registrationNumber": "12347584936485",
					    "depositor": true
					  },
					  "documentTypes": [
					    {
			                "documentTypeId": 9,
			                "name": "Qualifizierter Haftpflichtversicherungsnachweis",
			                "code": "INS_LIABILITY",
			                "multiOccurrence": true
			            },
					    {
					        "documentTypeId": 23,
					        "name": "Eintragung IHK / HW-Rolle",
					        "code": "DE_REG",
					        "multiOccurrence": false
					    },
					    {
					        "documentTypeId": 25,
					        "name": "SOKA Bau ULAK / Negativbescheinigung",
					        "code": "DE_SOKA",
					        "multiOccurrence": false
					    },
					    {
					        "documentTypeId": 11,
					        "name": "Berufsgenossenschaft (Qualifizierte Unbedenklichkeitsbescheinigung)",
					        "code": "INS_ASSOCIATION",
					        "multiOccurrence": true
					    },
					    {
					        "documentTypeId": 7,
					        "name": "Krankenkassen (Unbedenklichkeitsbescheinigung)",
					        "code": "PE_HEALTH",
					        "multiOccurrence": true
					    },
					    {
					        "documentTypeId": 2,
					        "name": "Freistellungsbescheinigung zum Steuerabzug bei Bauleistungen",
					        "code": "TAX_EXEMPTION",
					        "multiOccurrence": false
					    },
					    {
					        "documentTypeId": 1,
					        "name": "Bescheinigung in Steuersachen",
					        "code": "TAX_OFFICE",
					        "multiOccurrence": false
					    },
					    {
					        "documentTypeId": 4,
					        "name": "Gewerbeanmeldung",
					        "code": "REG_BUSINESS",
					        "multiOccurrence": false
					    },
					    {
					        "documentTypeId": 3,
					        "name": "Handelsregisterauszug",
					        "code": "REG_TRADE",
					        "multiOccurrence": false
					    },
					    {
					        "documentTypeId": 20,
					        "name": "Mindestlohn- / Tariftreueerkl.",
					        "code": "COV_WAGE",
					        "multiOccurrence": false
					    },
					    {
					        "documentTypeId": 26,
					        "name": "Nachweis Steuerschuldnerschaft",
					        "code": "TAX_LIABILITY",
					        "multiOccurrence": false
					    }
					  ]
					}
		      """

    Scenario: Do not create legal and business documents when receiving a organisation updated message with depositor equals false

    		Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 2  | FRANCE  | Bouygues       | 12347584936485     | false		 |

        When I publish an organisation updated event with the following data:
	        """
	        {
            "organisationId" : 2,
            "fullName" : "Bouygues",
            "country" : "FRANCE",
            "registrationNumber" : "12347584936485",
            "depositor" : false
          }
	        """

        Then The "legal" folder does not exist for organisation 2
        Then The "business/construction" folder does not exist for organisation 2
        Then The following organisations have been persisted:
            | id | country | fullName | registrationNumber | depositor |
            | 2  | FRANCE  | Bouygues | 12347584936485     | false     |

    Scenario: Do not recreate legal and business documents when receiving a organisation updated message when already depositor

    		Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 2  | FRANCE  | Bouygues       | 12347584936485     | true 		 |

        Given The following documents exist:
            | uid                                  | organisationId | state   | subtype                | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 2              | MISSING | REG_BUSINESS           | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf3 | 2              | MISSING | DE_REG                 | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf4 | 2              | MISSING | INS_LIABILITY          | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf5 | 2              | MISSING | INS_LIA_POLICE         | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf6 | 2              | MISSING | TAX_OFFICE             | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf7 | 2              | MISSING | PE_HEALTH              | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf8 | 2              | MISSING | INS_ASSOCIATION        | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf9 | 2              | MISSING | COV_WAGE               | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf0 | 2              | MISSING | DE_SOKA                | 2018-03-01T08:41:32.957Z |
            | f81d4fae-7dec-11d0-a765-00a0c41e6bf1 | 2              | MISSING | TAX_EXEMPTION          | 2018-03-01T08:41:32.957Z |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder                |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf2 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf3 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf4 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf5 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf6 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf7 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf8 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf9 | 2              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf0 | 2              | business/construction |
            | f81d4fae-7dec-11d0-a765-00a0c41e6bf1 | 2              | business/construction |

        When I publish an organisation updated event with the following data:
	        """
	        {
            "organisationId" : 2,
            "fullName" : "Bouygues",
            "country" : "FRANCE",
            "registrationNumber" : "12347584936485",
            "depositor" : true
          }
	        """

        Then Only the following documents now exist for organisation 2 :
            | subtype                | folder                |
            | REG_BUSINESS           | legal                 |
            | DE_REG                 | legal                 |
            | INS_LIABILITY          | legal                 |
            | INS_LIA_POLICE         | legal                 |
            | TAX_OFFICE             | legal                 |
            | PE_HEALTH              | legal                 |
            | INS_ASSOCIATION        | legal                 |
            | COV_WAGE               | legal                 |
            | DE_SOKA                | business/construction |
            | TAX_EXEMPTION          | business/construction |
