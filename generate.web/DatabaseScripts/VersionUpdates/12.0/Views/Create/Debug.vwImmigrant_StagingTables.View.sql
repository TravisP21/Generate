CREATE VIEW [debug].[vwImmigrant_StagingTables] 
AS
	SELECT	DISTINCT 
		enrollment.StudentIdentifierState
		, enrollment.LEAIdentifierSeaAccountability
		, enrollment.SchoolIdentifierSea
		, enrollment.FirstName
		, enrollment.LastOrSurname
		, enrollment.MiddleName

		, immigrant.ProgramType_Immigrant
		, immigrant.Immigrant_ProgramParticipationStartDate
		, immigrant.Immigrant_ProgramParticipationEndDate
		, immigrant.ISO_639_2_NativeLanguage

		, el.EnglishLearnerStatus
		, el.EnglishLearner_StatusStartDate
		, el.EnglishLearner_StatusEndDate
				
	FROM Staging.K12Enrollment								enrollment		

	INNER JOIN Staging.PersonStatus							immigrant
		ON		enrollment.StudentIdentifierState						=	immigrant.StudentIdentifierState
		AND		ISNULL(enrollment.LEAIdentifierSeaAccountability, '')	=	ISNULL(immigrant.LEAIdentifierSeaAccountability, '')
		AND		ISNULL(enrollment.SchoolIdentifierSea, '')				=	ISNULL(immigrant.SchoolIdentifierSea, '')
		AND		ISNULL(immigrant.Immigrant_ProgramParticipationEndDate, enrollment.EnrollmentExitDate) >= enrollment.EnrollmentEntryDate

	LEFT JOIN Staging.PersonStatus							el
		ON		enrollment.StudentIdentifierState						=	el.StudentIdentifierState
		AND		ISNULL(enrollment.LEAIdentifierSeaAccountability, '')	=	ISNULL(el.LEAIdentifierSeaAccountability, '')
		AND		ISNULL(enrollment.SchoolIdentifierSea, '')				=	ISNULL(el.SchoolIdentifierSea, '')
		AND		ISNULL(el.EnglishLearner_StatusEndDate, enrollment.EnrollmentExitDate) >= enrollment.EnrollmentEntryDate

	--uncomment/modify the where clause conditions as necessary for validation
	WHERE 1 = 1
	AND immigrant.ProgramType_Immigrant = 1
