Feature: UpdateRelationship

    Scenario: Create relationship and standard dossier when receiving a relationship creation message

        When I publish a relationship "created" event with the following data:
            """
	        {
              "relationshipId" : 25,
              "relationshipType" : "SUB_CONTRACTOR_OF",
              "status" : "ACCEPTED",
              "organisationSource" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              },
              "organisationTarget" : {
                "organisationId" : 2,
                "fullName" : "Bouygues",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "2 rue de la pie",
                  "city" : "Lyon",
                  "postCode" : "69150",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "12347584936485"
              },
              "emitterOrganisation" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              }
            }
	        """

        Then The following organisations have been persisted:
            | id | country | fullName | registrationNumber |
            | 1  | FRANCE  | ALG      | 52773773800024     |
            | 2  | FRANCE  | Bouygues | 12347584936485     |

        Then The following relationships have been persisted:
            | id | relationshipType  | status   | organisationSourceId | organisationTargetId |
            | 25 | SUB_CONTRACTOR_OF | ACCEPTED | 1                    | 2                    |

        Then The "legal" folder now exists for organisation 1
        Then The "business/construction" folder now exists for organisation 1
        Then The following documents now exist for organisation 1 :
            | subtype                | folder                |
            | REG_TRADE              | legal                 |
            | REG_BUSINESS           | legal                 |
            | DE_REG                 | legal                 |
            | INS_LIABILITY          | legal                 |
            | TAX_OFFICE             | legal                 |
            | PE_HEALTH              | legal                 |
            | INS_ASSOCIATION        | legal                 |
            | COV_WAGE               | legal                 |
            | DE_SOKA                | business/construction |
            | TAX_EXEMPTION          | business/construction |

        Then The "legal" folder does not exist for organisation 2
        Then The "business/construction" folder does not exist for organisation 2

    Scenario: Update relationship when receiving a relationship creation message with existing relationship
        Given The following organisations exist:
            | id | country | fullName | registrationNumber |
            | 1  | FRANCE  | ALG      | 52773773800024     |
            | 2  | FRANCE  | Bouygues | 12347584936485     |

        Then The following relationships exist:
            | id | relationshipType  | status   | organisationSourceId | organisationTargetId |
            | 25 | SUB_CONTRACTOR_OF | ACCEPTED | 1                    | 2                    |

        When I publish a relationship "created" event with the following data:
            """
	        {
              "relationshipId" : 25,
              "relationshipType" : "CLIENT_OF",
              "status" : "ACCEPTED",
              "organisationSource" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              },
              "organisationTarget" : {
                "organisationId" : 2,
                "fullName" : "Bouygues",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "2 rue de la pie",
                  "city" : "Lyon",
                  "postCode" : "69150",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "12347584936485"
              },
              "emitterOrganisation" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              }
            }
	        """

        Then The following relationships have been persisted:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 1                    | 2                    |

        Then The "legal" folder does not exist for organisation 1
        Then The "business/construction" folder does not exist for organisation 1

        Then The "legal" folder now exists for organisation 2
        Then The "business/construction" folder now exists for organisation 2
        Then The following documents now exist for organisation 2 :
            | subtype                | folder                |
            | REG_TRADE              | legal                 |
            | REG_BUSINESS           | legal                 |
            | DE_REG                 | legal                 |
            | INS_LIABILITY          | legal                 |
            | TAX_OFFICE             | legal                 |
            | PE_HEALTH              | legal                 |
            | INS_ASSOCIATION        | legal                 |
            | COV_WAGE               | legal                 |
            | DE_SOKA                | business/construction |
            | TAX_EXEMPTION          | business/construction |

    Scenario: Do nothing when receiving a pending relationship creation message

        When I publish a relationship "created" event with the following data:
            """
	        {
              "relationshipId" : 25,
              "relationshipType" : "SUB_CONTRACTOR_OF",
              "status" : "PENDING",
              "organisationSource" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              },
              "organisationTarget" : {
                "organisationId" : 2,
                "fullName" : "Bouygues",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "2 rue de la pie",
                  "city" : "Lyon",
                  "postCode" : "69150",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "12347584936485"
              },
              "emitterOrganisation" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              }
            }
	        """

        Then No organisation have been persisted
        Then No relationship have been persisted
        Then The "legal" folder does not exist for organisation 1
        Then The "business/construction" folder does not exist for organisation 1
        Then The "legal" folder does not exist for organisation 2
        Then The "business/construction" folder does not exist for organisation 2

    Scenario: Create missing relationship and standard dossier when receiving a relationship update message
        When I publish a relationship "updated" event with the following data:
            """
	        {
              "relationshipId" : 25,
              "relationshipType" : "CLIENT_OF",
              "status" : "ACCEPTED",
              "organisationSource" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              },
              "organisationTarget" : {
                "organisationId" : 2,
                "fullName" : "Bouygues",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "2 rue de la pie",
                  "city" : "Lyon",
                  "postCode" : "69150",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "12347584936485"
              },
              "emitterOrganisation" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              }
            }
	        """
        Then The following relationships have been persisted:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 1                    | 2                    |

        Then The following organisations have been persisted:
            | id | country | fullName | registrationNumber |
            | 1  | FRANCE  | ALG      | 52773773800024     |
            | 2  | FRANCE  | Bouygues | 12347584936485     |

        Then The "legal" folder now exists for organisation 2
        Then The "business/construction" folder now exists for organisation 2
        Then The following documents now exist for organisation 2 :
            | subtype                | folder                |
            | REG_TRADE              | legal                 |
            | REG_BUSINESS           | legal                 |
            | DE_REG                 | legal                 |
            | INS_LIABILITY          | legal                 |
            | TAX_OFFICE             | legal                 |
            | PE_HEALTH              | legal                 |
            | INS_ASSOCIATION        | legal                 |
            | COV_WAGE               | legal                 |
            | DE_SOKA                | business/construction |
            | TAX_EXEMPTION          | business/construction |

    Scenario: Update existing relationship when receiving a relationship update message
        Given The following organisations exist:
            | id | country | fullName | registrationNumber |
            | 1  | FRANCE  | ALG      | 52773773800024     |
            | 2  | FRANCE  | Bouygues | 12347584936485     |
        And The following relationships exist:
            | id | relationshipType  | status   | organisationSourceId | organisationTargetId |
            | 25 | SUB_CONTRACTOR_OF | ACCEPTED | 1                    | 2                    |
        When I publish a relationship "updated" event with the following data:
            """
	        {
              "relationshipId" : 25,
              "relationshipType" : "CLIENT_OF",
              "status" : "ACCEPTED",
              "organisationSource" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              },
              "organisationTarget" : {
                "organisationId" : 2,
                "fullName" : "Bouygues",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "2 rue de la pie",
                  "city" : "Lyon",
                  "postCode" : "69150",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "12347584936485"
              },
              "emitterOrganisation" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              }
            }
	        """
        Then The following relationships have been persisted:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 1                    | 2                    |

    Scenario: Create standard dossier when relationship is accepted

        When I publish a relationship "created" event with the following data:
            """
	        {
              "relationshipId" : 25,
              "relationshipType" : "SUB_CONTRACTOR_OF",
              "status" : "PENDING",
              "organisationSource" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              },
              "organisationTarget" : {
                "organisationId" : 2,
                "fullName" : "Bouygues",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "2 rue de la pie",
                  "city" : "Lyon",
                  "postCode" : "69150",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "12347584936485"
              },
              "emitterOrganisation" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              }
            }
	        """

        And I publish a relationship "updated" event with the following data:
            """
	        {
              "relationshipId" : 25,
              "relationshipType" : "SUB_CONTRACTOR_OF",
              "status" : "ACCEPTED",
              "organisationSource" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              },
              "organisationTarget" : {
                "organisationId" : 2,
                "fullName" : "Bouygues",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "2 rue de la pie",
                  "city" : "Lyon",
                  "postCode" : "69150",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "12347584936485"
              },
              "emitterOrganisation" : {
                "organisationId" : 1,
                "fullName" : "ALG",
                "country" : "FRANCE",
                "address" : {
                  "addressLine" : "Bd Eugene",
                  "city" : "Lyon",
                  "postCode" : "69003",
                  "department" : "69",
                  "region" : "Rhone"
                },
                "registrationNumber" : "52773773800024"
              }
            }
	        """

        Then The "legal" folder now exists for organisation 1
        Then The "business/construction" folder now exists for organisation 1
        Then The following documents now exist for organisation 1 :
            | subtype                | folder                |
            | REG_TRADE              | legal                 |
            | REG_BUSINESS           | legal                 |
            | DE_REG                 | legal                 |
            | INS_LIABILITY          | legal                 |
            | TAX_OFFICE             | legal                 |
            | PE_HEALTH              | legal                 |
            | INS_ASSOCIATION        | legal                 |
            | COV_WAGE               | legal                 |
            | DE_SOKA                | business/construction |
            | TAX_EXEMPTION          | business/construction |

    Scenario: Delete relationship when receiving a relationship deleted message

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |
            | 2  | GERMANY | ALG            | 789012             |

        Given The following relationships exist:
            | id | relationshipType | status   | organisationSourceId | organisationTargetId |
            | 25 | CLIENT_OF        | ACCEPTED | 2                    | 1                    |

        When I publish a relationship "deleted" event with the following data:
            """
	        {
              "relationshipId" : 25
            }
	        """

        Then The relationship with id 25 is deleted

