IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Staging' AND TABLE_NAME = 'OrganizationSchoolIndicatorStatus') BEGIN
	DROP TABLE [Staging].[OrganizationSchoolIndicatorStatus]
END