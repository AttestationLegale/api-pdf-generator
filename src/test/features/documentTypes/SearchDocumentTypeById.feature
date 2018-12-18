Feature: SearchDocumentTypeById

    Scenario: Search document type by id

        Given I am authenticated

        When I search document type with the id 1

        Then I get a response with the status code 200 and the following information:
	    """
	    {
	      "documentTypeId": 1,
	      "code": "TAX_OFFICE",
	      "name": "Bescheinigung in Steuersachen"
	    }
	    """

    Scenario: Error if the document is not found

        Given I am authenticated

        When I search document type with the id 421

        Then I get a response with the status code 404
