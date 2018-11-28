Feature: SubmitAndValidateFile

    Scenario: Submit and validate a file

        Given I am authenticated with the roles "BackOffice"

        Given The following organisations exist:
            | id | country | fullName       | registrationNumber | depositor |
            | 1  | GERMANY | Organisation 1 | 123456             | true      |

        And The following documents exist:
            | uid                                  | organisationId | state   | subtype   | depositDate              |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | MISSING | REG_TRADE | 2018-03-01T08:41:32.957Z |

        And The documents are in the following folders:
            | documentId                           | organisationId | folder |
            | f81d4fae-7dec-11d0-a765-00a0c91e6bf1 | 1              | legal  |

        When I submit and validate a content to the document "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" with the following information:
        """
        {
            "issueDate": "2018-04-17T00:00:00Z",
            "validityStart": "2018-04-17T00:00:00Z",
            "validityEnd": "2019-04-17T00:00:00Z",
            "documentTypeId": 3,
            "additionalDesignation": null
        }
        """

        Then I get a response with the status code 200
        # The test does not check the response content but tests the security layer

