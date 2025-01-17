/**********************************************************************
Author: AEM Corp
Date:	2/17/2023
Description: Migrates Membership Data from Staging to RDS.FactK12StudentCounts

NOTE: This Stored Procedure processes files: 033, 052
************************************************************************/
CREATE PROCEDURE [Staging].[Staging-to-FactK12StudentCounts_Membership]
	@SchoolYear SMALLINT
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

	-- Drop temp tables.  This allows for running the procedure as a script while debugging
		IF OBJECT_ID(N'tempdb..#vwGradeLevels') IS NOT NULL DROP TABLE #vwGradeLevels
		IF OBJECT_ID(N'tempdb..#vwRaces') IS NOT NULL DROP TABLE #vwRaces
		IF OBJECT_ID(N'tempdb..#vwUnduplicatedRaceMap') IS NOT NULL DROP TABLE #vwUnduplicatedRaceMap
		IF OBJECT_ID(N'tempdb..#vwEconomicallyDisadvantagedStatuses') IS NOT NULL DROP TABLE #vwEconomicallyDisadvantagedStatuses

		DECLARE 
		@FactTypeId INT,
		@SchoolYearId int,
		@SYStartDate date,
		@SYEndDate date
		
		SET @SYStartDate = staging.GetFiscalYearStartDate(@SchoolYear)

	--Get the Membership date from Toggle (if set)
		SELECT @SchoolYearId = DimSchoolYearId 
		FROM RDS.DimSchoolYears
		WHERE SchoolYear = @SchoolYear

	--Check if Grade 13, Ungraded, and/or Adult Education should be included based on Toggle responses
		DECLARE @toggleGrade13 AS BIT
		DECLARE @toggleUngraded AS BIT
		DECLARE @toggleAdultEd AS BIT

		SELECT  @toggleGrade13 = ISNULL( CASE WHEN r.ResponseValue = 'true' THEN 1 ELSE 0 END, 0 ) 
		FROM app.ToggleQuestions q 
		LEFT OUTER JOIN app.ToggleResponses r 
			ON r.ToggleQuestionId = q.ToggleQuestionId
		WHERE q.EmapsQuestionAbbrv = 'CCDGRADE13'

		SELECT @toggleUngraded = ISNULL( CASE WHEN r.ResponseValue = 'true' THEN 1 ELSE 0 END, 0 ) 
		FROM app.ToggleQuestions q 
		LEFT OUTER JOIN app.ToggleResponses r 
			ON r.ToggleQuestionId = q.ToggleQuestionId
		WHERE q.EmapsQuestionAbbrv = 'CCDUNGRADED'

		SELECT @toggleAdultEd = ISNULL( CASE WHEN r.ResponseValue = 'true' THEN 1 ELSE 0 END, 0 )  
		FROM app.ToggleQuestions q 
		LEFT OUTER JOIN app.ToggleResponses r 
			ON r.ToggleQuestionId = q.ToggleQuestionId
		WHERE q.EmapsQuestionAbbrv = 'ADULTEDU'

		--temp table to hold valid grades to be included 
		DECLARE @GradesList TABLE (GradeLevel varchar(3)) 
		INSERT INTO @GradesList VALUES ('PK'),('KG'),('01'),('02'),('03'),('04'),('05'),('06'),('07'),('08'),('09'),('10'),('11'),('12')

		--Add the 3 additional grade levels if they should be included
		IF @toggleGrade13 = 1
		INSERT INTO @GradesList VALUES ('13')

		IF @toggleUngraded = 1
		INSERT INTO @GradesList VALUES ('UG')

		IF @toggleAdultEd = 1
		INSERT INTO @GradesList VALUES ('ABE')

	--Create the temp tables (and any relevant indexes) needed for this domain
		SELECT *
		INTO #vwGradeLevels
		FROM RDS.vwDimGradeLevels
		WHERE SchoolYear = @SchoolYear

		CREATE CLUSTERED INDEX ix_tempvwGradeLevels 
			ON #vwGradeLevels (GradeLevelTypeDescription, GradeLevelMap);

		SELECT *
		INTO #vwRaces
		FROM RDS.vwDimRaces
		WHERE SchoolYear = @SchoolYear

		CREATE CLUSTERED INDEX ix_tempvwRaces 
			ON #vwRaces (RaceMap);

		SELECT * 
		INTO #vwUnduplicatedRaceMap 
		FROM RDS.vwUnduplicatedRaceMap
		WHERE SchoolYear = @SchoolYear

		CREATE CLUSTERED INDEX ix_tempvwUnduplicatedRaceMap ON #vwUnduplicatedRaceMap (StudentIdentifierState, LeaIdentifierSeaAccountability, SchoolIdentifierSea, RaceMap);

		SELECT * 
		INTO #vwEconomicallyDisadvantagedStatuses
		FROM RDS.vwDimEconomicallyDisadvantagedStatuses
		WHERE SchoolYear = @SchoolYear

		CREATE CLUSTERED INDEX ix_tempvwEconomicallyDisadvantagedStatuses
			ON #vwEconomicallyDisadvantagedStatuses (EconomicDisadvantageStatusCode, EligibilityStatusForSchoolFoodServiceProgramsCode);

		--Set the correct Fact Type
		SELECT @FactTypeId = DimFactTypeId 
		FROM rds.DimFactTypes
		WHERE FactTypeCode = 'membership' --FactTypeId = 6

		--Clear the Fact table of the data about to be migrated  
		DELETE RDS.FactK12StudentCounts
		WHERE SchoolYearId = @SchoolYearId 
			AND FactTypeId = @FactTypeId

		IF OBJECT_ID('tempdb..#Facts') IS NOT NULL 
			DROP TABLE #Facts
		
	--Create and load #Facts temp table
		CREATE TABLE #Facts (
			  SchoolYearId							int null
			, FactTypeId							int null
			, GradeLevelId							int null
			, AgeId									int null
			, RaceId								int null
			, K12DemographicId						int null
			, StudentCount							int null
			, SEAId									int null
			, IEUId									int null
			, LEAId									int null
			, K12SchoolId							int null
			, K12StudentId							int null
			, IdeaStatusId							int null
			, LanguageId							int null
			, MigrantStatusId						int null
			, TitleIStatusId						int null
			, TitleIIIStatusId						int null
			, AttendanceId							int null
			, CohortStatusId						int null
			, NOrDStatusId							int null
			, CTEStatusId							int null
			, K12EnrollmentStatusId					int null
			, EnglishLearnerStatusId				int null
			, HomelessnessStatusId					int null
			, EconomicallyDisadvantagedStatusId		int null
			, FosterCareStatusId					int null
			, ImmigrantStatusId						int null
			, PrimaryDisabilityTypeId				int null
			, SpecialEducationServicesExitDateId	int null
			, MigrantStudentQualifyingArrivalDateId	int null
			, LastQualifyingMoveDateId				int null
		)


		INSERT INTO #Facts
		SELECT DISTINCT
			  @SchoolYearId 											SchoolYearId
			, @FactTypeId												FactTypeId
			, ISNULL(rgls.DimGradeLevelId, -1)							GradeLevelId
			, rda.DimAgeId												AgeId
			, ISNULL(rdr.DimRaceId, -1)									RaceId
			, ISNULL(rdkd.DimK12DemographicId, -1)						K12DemographicId
			, 1															StudentCount
			, ISNULL(rds.DimSeaId, -1)									SEAId
			, -1														IEUId
			, ISNULL(rdl.DimLeaID, -1)									LEAId
			, ISNULL(rdpch.DimK12SchoolId, -1)							K12SchoolId
			, ISNULL(rdp.DimPersonId, -1)								K12StudentId
			, -1														IdeaStatusId
			, -1														LanguageId
			, -1														MigrantStatusId
			, ISNULL(rdtis.DimTitleIStatusId, -1)						TitleIStatusId
			, -1														TitleIIIStatusId
			, -1														AttendanceId
			, -1														CohortStatusId
			, -1														NOrDStatusId 
			, -1														CTEStatusId
			, -1														K12EnrollmentStatusId
			, -1														EnglishLearnerStatusId
			, -1														HomelessnessStatusId
			, ISNULL(rdeds.DimEconomicallyDisadvantagedStatusId, -1)	EconomicallyDisadvantagedStatusId
			, -1 														FosterCareStatusId
			, -1														ImmigrantStatusId
			, -1														PrimaryDisabilityTypeId
			, -1														SpecialEducationServicesExitDateId 
			, -1														MigrantStudentQualifyingArrivalDateId
			, -1														LastQualifyingMoveDateId

		FROM Debug.vwMembership_StagingTables stage
	--student info	
		JOIN RDS.DimPeople rdp
			ON stage.StudentIdentifierState = rdp.K12StudentStudentIdentifierState
			AND rdp.IsActiveK12Student = 1
			AND ISNULL(stage.FirstName, '') = ISNULL(rdp.FirstName, '')
--			AND ISNULL(stage.MiddleName, '') = ISNULL(rdp.MiddleName, '')
			AND ISNULL(stage.LastOrSurname, 'MISSING') = ISNULL(rdp.LastOrSurname, 'MISSING')
			AND ISNULL(stage.Birthdate, '1/1/1900') = ISNULL(rdp.BirthDate, '1/1/1900')
			AND stage.MembershipDate BETWEEN rdp.RecordStartDateTime AND ISNULL(rdp.RecordEndDateTime, '1/1/9999')
	--economically disadvantaged
		LEFT JOIN #vwEconomicallyDisadvantagedStatuses rdeds
			ON rdeds.SchoolYear = stage.SchoolYear
			AND ISNULL(stage.EligibilityStatusForSchoolFoodServicePrograms, 'MISSING') = ISNULL(rdeds.EligibilityStatusForSchoolFoodServiceProgramsMap, 'MISSING')
			AND ISNULL(CAST(stage.NationalSchoolLunchProgramDirectCertificationIndicator AS SMALLINT), -1)  = isnull(rdeds.NationalSchoolLunchProgramDirectCertificationIndicatorMap, -1)
			AND ISNULL(CAST(stage.EconomicDisadvantageStatus as SMALLINT), -1) = ISNULL(rdeds.EconomicDisadvantageStatusMap, -1)
	--sea
		JOIN RDS.DimSeas rds
			ON stage.MembershipDate BETWEEN rds.RecordStartDateTime AND ISNULL(rds.RecordEndDateTime, '1/1/9999')
	--age
		JOIN RDS.DimAges rda
			ON RDS.Get_Age(stage.Birthdate, stage.MembershipDate) = rda.AgeValue
	--demographics			
		JOIN RDS.vwDimK12Demographics rdkd
			ON stage.SchoolYear = rdkd.SchoolYear
			AND ISNULL(stage.Sex, 'MISSING') = ISNULL(rdkd.SexMap, rdkd.SexCode)	
	--race	
		LEFT JOIN #vwUnduplicatedRaceMap spr 
			ON stage.StudentIdentifierState = spr.StudentIdentifierState
			AND (stage.SchoolIdentifierSea = spr.SchoolIdentifierSea
				OR stage.LEAIdentifierSeaAccountability = spr.LeaIdentifierSeaAccountability)
		LEFT JOIN #vwRaces rdr
			ON ISNULL(rdr.RaceMap, rdr.RaceCode) =
				CASE
					when stage.HispanicLatinoEthnicity = 1 then 'HispanicorLatinoEthnicity'
					WHEN spr.RaceMap IS NOT NULL THEN spr.RaceMap
					ELSE 'Missing'
				END
	--grade
		LEFT JOIN #vwGradeLevels rgls
			ON rgls.SchoolYear = stage.SchoolYear
			AND stage.GradeLevel = rgls.GradeLevelMap
			AND rgls.GradeLevelTypeDescription = 'Entry Grade Level'
	--lea
		LEFT JOIN RDS.DimLeas rdl
			ON stage.LeaIdentifierSeaAccountability = rdl.LeaIdentifierSea
			AND stage.MembershipDate BETWEEN rdl.RecordStartDateTime AND ISNULL(rdl.RecordEndDateTime, '1/1/9999')
	--school
		LEFT JOIN RDS.DimK12Schools rdpch
			ON stage.SchoolIdentifierSea = rdpch.SchoolIdentifierSea
			AND stage.MembershipDate BETWEEN rdpch.RecordStartDateTime AND ISNULL(rdpch.RecordEndDateTime, '1/1/9999')

	-- Title I Status
		LEFT JOIN RDS.vwDimTitleIStatuses rdtis
			ON stage.SchoolYear = rdtis.SchoolYear
			AND ISNULL(stage.LEA_TitleIProgramType, 'MISSING') = ISNULL(rdtis.TitleIProgramTypeMap, rdtis.TitleIProgramTypeCode)
			AND rdtis.TitleISchoolStatusCode = 'MISSING'
			AND rdtis.TitleIInstructionalServicesCode = 'MISSING'
			AND rdtis.TitleISupportServicesCode = 'MISSING'

	WHERE stage.MembershipDate BETWEEN stage.EnrollmentEntryDate AND ISNULL(stage.EnrollmentExitDate, '1/1/9999')
		AND rgls.GradeLevelCode IN (SELECT GradeLevel FROM @GradesList)
		
	--Final insert into RDS.FactK12StudentCounts table
		INSERT INTO RDS.FactK12StudentCounts (
			SchoolYearId
			, FactTypeId
			, SeaId
			, IeuId
			, LeaId
			, K12SchoolId
			, K12StudentId
			, AgeId
			, AttendanceId
			, CohortStatusId
			, CteStatusId
			, EnglishLearnerStatusId
			, GradeLevelId
			, HomelessnessStatusId
			, EconomicallyDisadvantagedStatusId
			, FosterCareStatusId
			, IdeaStatusId
			, ImmigrantStatusId
			, K12DemographicId
			, K12EnrollmentStatusId
			, LanguageId
			, MigrantStatusId
			, NOrDStatusId
			, PrimaryDisabilityTypeId
			, RaceId
			, SpecialEducationServicesExitDateId
			, MigrantStudentQualifyingArrivalDateId
			, LastQualifyingMoveDateId
			, TitleIStatusId
			, TitleIIIStatusId
			, StudentCount
		)
		SELECT
			SchoolYearId
			, FactTypeId
			, SeaId
			, IeuId
			, LeaId
			, K12SchoolId
			, K12StudentId
			, AgeId
			, AttendanceId
			, CohortStatusId
			, CteStatusId
			, EnglishLearnerStatusId
			, GradeLevelId
			, HomelessnessStatusId
			, EconomicallyDisadvantagedStatusId
			, FosterCareStatusId
			, IdeaStatusId
			, ImmigrantStatusId
			, K12DemographicId
			, K12EnrollmentStatusId
			, LanguageId
			, MigrantStatusId
			, NOrDStatusId
			, PrimaryDisabilityTypeId
			, RaceId
			, SpecialEducationServicesExitDateId
			, MigrantStudentQualifyingArrivalDateId
			, LastQualifyingMoveDateId
			, TitleIStatusId
			, TitleIIIStatusId
			, StudentCount			
		FROM #Facts
	
		ALTER INDEX ALL ON RDS.FactK12StudentCounts REBUILD

	END TRY
	BEGIN CATCH
			insert into app.DataMigrationHistories
		(DataMigrationHistoryDate, DataMigrationTypeId, DataMigrationHistoryMessage) 
		values	(getutcdate(), 2, 'ERROR: ' + ERROR_MESSAGE())
	END CATCH

END