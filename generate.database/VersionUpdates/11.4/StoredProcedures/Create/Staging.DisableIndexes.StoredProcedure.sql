﻿CREATE PROCEDURE [Staging].[DisableIndexes]
AS 
BEGIN

	ALTER INDEX ALL ON Staging.Assessment											  DISABLE;
	ALTER INDEX ALL ON Staging.AssessmentResult										  DISABLE;
	ALTER INDEX ALL ON Staging.CharterSchoolAuthorizer								  DISABLE;
	ALTER INDEX ALL ON Staging.CharterSchoolManagementOrganization					  DISABLE;
	ALTER INDEX ALL ON Staging.Discipline											  DISABLE;
	ALTER INDEX ALL ON Staging.IndicatorStatusCustomType							  DISABLE;
	ALTER INDEX ALL ON Staging.K12Enrollment										  DISABLE;
	ALTER INDEX ALL ON Staging.K12Organization										  DISABLE;
	ALTER INDEX ALL ON Staging.K12ProgramParticipation								  DISABLE;
	ALTER INDEX ALL ON Staging.K12SchoolComprehensiveSupportIdentificationType		  DISABLE;
	ALTER INDEX ALL ON Staging.K12SchoolTargetedSupportIdentificationType			  DISABLE;
	ALTER INDEX ALL ON Staging.K12StaffAssignment									  DISABLE;
	ALTER INDEX ALL ON Staging.K12StudentCourseSection								  DISABLE;
	ALTER INDEX ALL ON Staging.Migrant												  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationAddress									  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationCalendarSession							  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationCustomSchoolIndicatorStatusType			  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationFederalFunding							  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationGradeOffered								  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationPhone									  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationProgramType								  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationSchoolComprehensiveAndTargetedSupport	  DISABLE;
	ALTER INDEX ALL ON Staging.OrganizationSchoolIndicatorStatus					  DISABLE;
	ALTER INDEX ALL ON Staging.PersonRace											  DISABLE;
	ALTER INDEX ALL ON Staging.PersonStatus											  DISABLE;
	ALTER INDEX ALL ON Staging.ProgramParticipationCTE								  DISABLE;
	ALTER INDEX ALL ON Staging.ProgramParticipationNorD								  DISABLE;
	ALTER INDEX ALL ON Staging.ProgramParticipationSpecialEducation					  DISABLE;
	ALTER INDEX ALL ON Staging.ProgramParticipationTitleI							  DISABLE;
	ALTER INDEX ALL ON Staging.ProgramParticipationTitleIII							  DISABLE;
	ALTER INDEX ALL ON Staging.PsInstitution										  DISABLE;
	ALTER INDEX ALL ON Staging.PsStudentAcademicAward								  DISABLE;
	ALTER INDEX ALL ON Staging.PsStudentAcademicRecord								  DISABLE;
	ALTER INDEX ALL ON Staging.PsStudentEnrollment									  DISABLE;
	ALTER INDEX ALL ON Staging.SourceSystemReferenceData							  DISABLE;
	ALTER INDEX ALL ON Staging.StateDefinedCustomIndicator							  DISABLE;
	ALTER INDEX ALL ON Staging.StateDetail											  DISABLE;
	
END 