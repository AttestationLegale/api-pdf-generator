Feature: SearchDocumentTypeBySubtypeCode

    Scenario: Search document type by subtype code

        Given I am authenticated

        When I search document type with the subtype code "TAX_OFFICE"

        Then I get a response with the status code 200 and the following information:
	    """
	    {
	      "documentTypeId": 1,
	      "code": "TAX_OFFICE",
	      "name": "Bescheinigung in Steuersachen"
	    }
	    """

    Scenario: Error if the document type is not found

        Given I am authenticated

        When I search document type with the subtype code "NERF"

        Then I get a response with the status code 404
