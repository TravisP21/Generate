IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'APP' AND ROUTINE_NAME = 'GetRoleId') BEGIN
	DROP FUNCTION [App].[GetRoleId]
END

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'Staging' AND ROUTINE_NAME = 'GetRoleId') BEGIN
	DROP FUNCTION [Staging].[GetRoleId]
END