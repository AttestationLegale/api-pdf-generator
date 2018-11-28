Feature: GetDocumentTypesForProject

    Scenario: Get document types for a project return document types

        Given I am authenticated

        When I get document types for a project

        Then I get a response with the status code 200 and the following information:
        """
        [
            {
                "documentTypeId": 8,
                "name": "Fachbauleitererklärung nach LBO",
                "code": "INT_MANAGER",
                "parentCode": "INT_QUALIF",
                "parentName": "interner Qualifizierungsnachweis",
                "multiOccurrence": true
            },
            {
                "documentTypeId": 10,
                "name": "Haftpflichtversicherungspolice",
                "code": "INS_LIA_POLICE",
                "parentCode": "INSURANCE",
                "parentName": "Versicherungsbescheinigung",
                "multiOccurrence": false
			},
            {
                "documentTypeId": 12,
                "name": "PQ-Bescheinigung(en)",
                "code": "EXT_PRE_QUALIF",
                "parentCode": "EXT_CERTIF",
                "parentName": "externe Zertifizierung",
                "multiOccurrence": false
            },
            {
                "documentTypeId": 13,
                "name": "Zertifizierung nach DIN ISO 9001",
                "code": "ISO_9001",
                "parentCode": "EXT_CERTIF",
                "parentName": "externe Zertifizierung",
                "multiOccurrence": false
            },
            {
                "documentTypeId": 14,
                "name": "Fachbetriebsbescheinigungen",
                "code": "EXT_SPECIALIST",
                "parentCode": "EXT_CERTIF",
                "parentName": "externe Zertifizierung",
                "multiOccurrence": true
            },
            {
                "documentTypeId": 15,
                "name": "Auskunft Gewerbezentralregister",
                "code": "EXT_DEFECT",
                "parentCode": "EXT_CERTIF",
                "parentName": "externe Zertifizierung",
                "multiOccurrence": false
            },
            {
                "documentTypeId": 16,
                "name": "Negativbesch. Insolvenzverfahren",
                "code": "EXT_SOLVENCY",
                "parentCode": "EXT_CERTIF",
                "parentName": "externe Zertifizierung",
                "multiOccurrence": false
            },
            {
                "documentTypeId": 17,
                "name": "Zertifizierung Arbeitsschutz",
                "code": "EXT_SAFETY_CERTIF",
                "parentCode": "EXT_CERTIF",
                "parentName": "externe Zertifizierung",
                "multiOccurrence": true
            },
            {
                "documentTypeId": 18,
                "name": "Auskunft Arbeitssicherheit",
                "code": "EXT_SAFETY_INFO",
                "parentCode": "EXT_CERTIF",
                "parentName": "externe Zertifizierung",
                "multiOccurrence": false
            },
            {
                "documentTypeId": 19,
                "name": "Liste der eingesetzten Arbeitnehmer",
                "code": "EMPLOYEES",
                "parentCode": "EMPLOYEES_LIST",
                "parentName": "Arbeitnehmerliste",
                "multiOccurrence": false
            },
            {
                "documentTypeId": 22,
                "name": "Formular A1 (Arbeitnehmer aus EU-Ausland)",
                "code": "A1",
                "parentCode": "POSTED_WORK",
                "parentName": "Arbeitnehmer-Entsende-Dokument",
                "multiOccurrence": true
            }
        ]
	    """
