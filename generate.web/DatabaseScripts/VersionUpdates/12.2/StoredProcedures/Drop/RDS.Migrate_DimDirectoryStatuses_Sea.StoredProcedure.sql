IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RDS].[Migrate_DimDirectoryStatuses_Sea]') AND type in (N'P', N'PC'))
DROP PROCEDURE [RDS].[Migrate_DimDirectoryStatuses_Sea]
