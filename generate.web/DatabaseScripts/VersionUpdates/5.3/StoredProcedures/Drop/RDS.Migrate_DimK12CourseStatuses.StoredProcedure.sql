﻿IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RDS].[Migrate_DimK12CourseStatuses]') AND type in (N'P', N'PC'))
DROP PROCEDURE [RDS].[Migrate_DimK12CourseStatuses]