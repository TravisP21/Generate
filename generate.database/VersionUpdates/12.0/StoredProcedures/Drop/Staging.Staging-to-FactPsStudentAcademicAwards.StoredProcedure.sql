IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'Staging' AND ROUTINE_NAME = 'Staging-to-FactPsStudentAcademicAwards') 
BEGIN
	DROP PROCEDURE [Staging].[Staging-to-FactPsStudentAcademicAwards]
END