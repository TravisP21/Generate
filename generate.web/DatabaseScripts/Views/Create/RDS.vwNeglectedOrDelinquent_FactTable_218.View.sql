CREATE VIEW [RDS].[vwNeglectedOrDelinquent_FactTable_218] 
AS
	SELECT 	f.[FactK12StudentCountId]
			, f.[SchoolYear]
		  	, f.[K12StudentId]
		  	, f.[K12StudentStudentIdentifierState]
		  	, f.[BirthDate]
		  	, f.[FirstName]
		  	, f.[LastOrSurname]
		  	, f.[MiddleName]
		  	, f.[StateANSICode]
		  	, f.[StateAbbreviationCode]
		  	, f.[StateAbbreviationDescription]
		  	, f.[SeaOrganizationIdentifierSea]
		  	, f.[SeaOrganizationName]
		  	, f.[LeaIdentifierSea]
		  	, f.[LeaOrganizationName]
		  	, f.[SchoolIdentifierSea]
		  	, f.[DimK12SchoolId]
		  	, f.[NameOfInstitution]
		  	, f.[SchoolOperationalStatus]
		  	, f.[SchoolTypeCode]
			, f.[NeglectedOrDelinquentStatusCode]
			, f.[NeglectedOrDelinquentProgramEnrollmentSubpartCode]
			, f.[EdFactsAcademicOrCareerAndTechnicalOutcomeTypeEdFactsCode]
    FROM  [debug].[vwNeglectedOrDelinquent_FactTable] f
    WHERE f.NeglectedOrDelinquentStatusCode = 'Yes'
	    AND f.NeglectedOrDelinquentProgramEnrollmentSubpartCode = '1'
		AND ISNULL(f.EdFactsAcademicOrCareerAndTechnicalOutcomeTypeEdFactsCode, '') <> ''