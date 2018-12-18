Feature: UpdateDocumentMetadata

    Scenario: Update document metadata

        Given I am authenticated with the roles "BackOffice" and user id "9231a32d-2e4f-444d-8587-e2680ee4a3aa"

        When I update the metadata of the document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" with the following information:
        """
        {
            "issueDate": "2018-03-01T00:00:00.000Z",
            "validityStart": "2018-03-12T00:00:00.000Z",
            "validityEnd": "2018-09-01T00:00:00.000Z",
            "certifyingThirdParty": "ALG",
            "issuingThirdParty": "RSI"
        }
        """

        Then The metadata of the document with uid "f81d4fae-7dec-11d0-a765-00a0c91e6bf1" is updated by the user with id "9231a32d-2e4f-444d-8587-e2680ee4a3aa" with the following information:
            | issueDate                     | validityStart                 | validityEnd                   | certifyingThirdParty | issuingThirdParty |
            | 2018-03-01T00:00:00.000Z[UTC] | 2018-03-12T00:00:00.000Z[UTC] | 2018-09-01T00:00:00.000Z[UTC] | ALG                  | RSI               |
