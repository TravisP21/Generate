IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'APP' AND TABLE_NAME = 'GenerateReport_GenerateStagingTablesXREF') BEGIN
	DROP TABLE [APP].[GenerateReport_GenerateStagingTablesXREF]
END