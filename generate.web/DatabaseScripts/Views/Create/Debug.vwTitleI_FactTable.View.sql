CREATE VIEW [debug].[vwTitleI_FactTable] 
AS
	SELECT	Fact.K12StudentId
			, Students.K12StudentStudentIdentifierState
			, Students.BirthDate
			, Students.FirstName
			, Students.LastOrSurname
			, Students.MiddleName
			, LEAs.LeaIdentifierSea
			, LEAs.LeaIdentifierNces
			, LEAs.LeaOrganizationName
			, Schools.SchoolIdentifierSea
			, Schools.NameOfInstitution

			, Races.RaceEdFactsCode

			--Homeless	
			, Home.HomelessnessStatusEdFactsCode
			--IDEA Indicator
			, Idea.IdeaIndicatorEdFactsCode
			--English Learner
			, EL.EnglishLearnerStatusEdFactsCode
			--Migrant 
			, Mig.MigrantStatusEdFactsCode
			--Foster
			, Foster.ProgramParticipationFosterCareEdFactsCode

 	FROM		RDS.FactK12StudentCounts					Fact
	JOIN		RDS.DimSchoolYears							SchoolYears	ON Fact.SchoolYearId				= SchoolYears.DimSchoolYearId	
	JOIN		RDS.DimSchoolYearDataMigrationTypes 		DMT			ON SchoolYears.dimschoolyearid		= DMT.dimschoolyearid		
    LEFT JOIN   RDS.DimPeople				              	Students	ON Fact.K12StudentId				= Students.DimPersonId	AND Students.IsActiveK12Student = 1
	LEFT JOIN	RDS.DimLeas									LEAs		ON Fact.LeaId						= LEAs.DimLeaId
	LEFT JOIN	RDS.DimK12Schools							Schools		ON Fact.K12SchoolId					= Schools.DimK12SchoolId
	LEFT JOIN	RDS.DimRaces								Races		ON Fact.RaceId						= Races.DimRaceId
	LEFT JOIN	RDS.DimIdeaStatuses							Idea		ON Fact.IdeaStatusId				= Idea.DimIdeaStatusId
	LEFT JOIN	RDS.DimEnglishLearnerStatuses				EL			ON Fact.EnglishLearnerStatusId		= EL.DimEnglishLearnerStatusId
	LEFT JOIN	RDS.DimHomelessnessStatuses					Home		ON Fact.HomelessnessStatusId		= Home.DimHomelessnessStatusId
	LEFT JOIN	RDS.DimMigrantStatuses						Mig			ON Fact.MigrantStatusId				= Mig.DimMigrantStatusId
	LEFT JOIN	RDS.DimTitleIStatuses						Title1		ON Fact.TitleIStatusId				= Title1.DimTitleIStatusId
	LEFT JOIN 	RDS.DimFosterCareStatuses					Foster		ON Fact.FosterCareStatusId			= Foster.DimFosterCareStatusId

	WHERE 1 = 1
	--2 ways to select by SchoolYear, use 1 or the other, not both
	--the next 2 conditions set the SchoolYear selected to the one from the most recent RDS migration
		AND DMT.IsSelected = 1
		AND DMT.DataMigrationTypeId = 2
	--or comment out the lines above and just set the SchoolYear
		--AND SchoolYears.SchoolYear = 2024
	AND Fact.FactTypeId = 12
	AND Title1.TitleISchoolStatusEdFactsCode in ('TGELGBTGPROG', 'SWELIGTGPROG', 'SWELIGSWPROG')
	AND LEAs.LeaOperationalStatus NOT IN ('Closed', 'Inactive', 'FutureAgency')
