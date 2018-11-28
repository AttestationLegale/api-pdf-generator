Feature: UpdateProject

    Scenario: Update project repository when receiving a project message
        When I publish a project event with the following data:
	        """
	        {
              "projectId" : 42,
              "name" : "Incity",
              "address" : {
                "addressLine" : "6 rue de la pie",
                "city" : "Jakarta",
                "postCode" : "97977",
                "department" : "Rhone",
                "region" : "PACA"
              },
              "ownerOrganisation" : {
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
              "clientOrganisation" : null,
              "openingDate" : "2018-02-20",
              "provisionalAcceptanceDate" : "2018-03-23",
              "additionalNotes" : "Ceci est véritablement un super projet",
              "creationDate" : "2018-02-26T08:30:07.174Z"
            }
	        """

        Then The following organisations have been persisted:
            | id | country | fullName | registrationNumber |
            | 2  | FRANCE  | Bouygues | 12347584936485     |

        Then The following projects has been persisted:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 2                   |

    Scenario: Update project repository when receiving a project message with existing project

        Given The following organisations exist:
            | id | country | fullName | registrationNumber |
            | 2  | FRANCE  | Bouygues | 12347584936485     |

        And The following projects exist:
            | id | name   | ownerOrganisationId |
            | 42 | Incity | 2                   |

        When I publish a project event with the following data:
            """
            {
                "projectId":42,
                "name":"SinCity",
                "address":{
                    "addressLine":"6ruedelapie",
                    "city":"Jakarta",
                    "postCode":"97977",
                    "department":"Rhone",
                    "region":"PACA"
                },
                "ownerOrganisation":{
                    "organisationId":2,
                    "fullName":"Bouygues",
                    "country":"FRANCE",
                    "address":{
                        "addressLine":"2ruedelapie",
                        "city":"Lyon",
                        "postCode":"69150",
                        "department":"69",
                        "region":"Rhone"
                    },
                    "registrationNumber":"12347584936485"
                },
                "clientOrganisation":null,
                "openingDate":"2018-02-20",
                "provisionalAcceptanceDate":"2018-03-23",
                "additionalNotes":"Ceciestvéritablementunsuperprojet",
                "creationDate":"2018-02-26T08:30:07.174Z"
            }
            """

        Then The following projects has been persisted:
            | id | name    | ownerOrganisationId |
            | 42 | SinCity | 2                   |
