Feature: A document type can have multiple equivalent types

    Scenario: Get all the equivalent types of a document type

        Given I am authenticated
        When I search document types equivalent to "5"
        Then I get a response with the status code 200 and the following information:
        """
        [{
	      "documentTypeId": 6,
	      "code": "REG_ARTISAN",
	      "name": "HW-Rolle"
	    }, {
	      "documentTypeId": 5,
	      "code": "REG_COMPANY",
	      "name": "Eintragung IHK"
	    }]
        """

    Scenario: Requalify and upload a file when submitting an equivalent document

        Given I am authenticated with the roles "BackOffice" and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber |
            | 1  | GERMANY | Organisation 1 | 123456             |

        Given The following documents exist:
            | uid                                  | organisationId | state   | subtype          |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | REG_COMPANY      |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | MISSING | DE_SOKA          |

        Given The documents are in the following folders:
            | documentId                           | organisationId | folder                |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal                 |
            | f81d4fae-7dec-11d0-a765-00a0c91e6c01 | 1              | business/construction |

        When I submit a content to the document "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" with the following information:
        """
        {
            "issueDate": "2018-04-17T22:00:00Z",
            "documentTypeId": 6,
            "additionalDesignation": "First certificate"
        }
        """

        Then I get a response with the status code 200

        Then The document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" is requalified to "REG_ARTISAN" by the user with id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        Then A file is uploaded for the document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" that was issued on "2018-04-17T22:00:00Z" by the user with id "9231a32d-2e4f-444d-8587-e2680ee4a3aa" with additional designation "First certificate"
