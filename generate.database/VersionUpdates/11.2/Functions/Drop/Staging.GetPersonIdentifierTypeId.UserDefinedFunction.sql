IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'APP' AND ROUTINE_NAME = 'GetPersonIdentifierTypeId') BEGIN
	DROP FUNCTION [App].[GetPersonIdentifierTypeId]
END

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'Staging' AND ROUTINE_NAME = 'GetPersonIdentifierTypeId') BEGIN
	DROP FUNCTION [Staging].[GetPersonIdentifierTypeId]
END