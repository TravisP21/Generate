IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'Staging' AND ROUTINE_NAME = 'Staging-to-FactK12StudentCounts_Assessments') 
BEGIN
	DROP PROCEDURE [Staging].[Staging-to-FactK12StudentCounts_Assessments]
END