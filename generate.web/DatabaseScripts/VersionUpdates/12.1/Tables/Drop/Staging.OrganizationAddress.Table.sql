IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Staging' AND TABLE_NAME = 'OrganizationAddress') BEGIN
	DROP TABLE [Staging].[OrganizationAddress]
END