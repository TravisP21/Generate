IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'Staging' AND ROUTINE_NAME = 'Staging-to-DimSeas') BEGIN
	DROP PROCEDURE [Staging].[Staging-to-DimSeas]
END