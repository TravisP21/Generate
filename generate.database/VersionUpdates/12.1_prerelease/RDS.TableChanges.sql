IF COL_LENGTH('RDS.DimNOrDStatuses', 'NeglectedOrDelinquentProgramTypeCode') IS NOT NULL
BEGIN
	EXEC sp_rename 'RDS.DimNOrDStatuses.NeglectedOrDelinquentProgramTypeCode',  'NeglectedProgramTypeCode', 'COLUMN';
END

IF COL_LENGTH('RDS.DimNOrDStatuses', 'NeglectedOrDelinquentProgramTypeDescription') IS NOT NULL
BEGIN
	EXEC sp_rename 'RDS.DimNOrDStatuses.NeglectedOrDelinquentProgramTypeDescription',  'NeglectedProgramTypeDescription', 'COLUMN';
END

IF COL_LENGTH('RDS.DimNOrDStatuses', 'NeglectedOrDelinquentProgramTypeEdFactsCode') IS NOT NULL
BEGIN
	EXEC sp_rename 'RDS.DimNOrDStatuses.NeglectedOrDelinquentProgramTypeEdFactsCode',  'NeglectedProgramTypeEdFactsCode', 'COLUMN';
END

IF COL_LENGTH('RDS.DimNOrDStatuses', 'DelinquentProgramTypeCode') IS NULL
BEGIN
	ALTER TABLE RDS.DimNOrDStatuses ADD DelinquentProgramTypeCode nvarchar(50);
END

IF COL_LENGTH('RDS.DimNOrDStatuses', 'DelinquentProgramTypeDescription') IS NULL
BEGIN
	ALTER TABLE RDS.DimNOrDStatuses ADD DelinquentProgramTypeDescription nvarchar(100);
END

IF COL_LENGTH('RDS.DimNOrDStatuses', 'DelinquentProgramTypeEdFactsCode') IS NULL
BEGIN
	ALTER TABLE RDS.DimNOrDStatuses ADD DelinquentProgramTypeEdFactsCode nvarchar(50);
END

IF COL_LENGTH('Staging.ProgramParticipationNorD', 'NeglectedOrDelinquentProgramType') IS NOT NULL
BEGIN
	EXEC sp_rename 'Staging.ProgramParticipationNorD.NeglectedOrDelinquentProgramType',  'NeglectedProgramType', 'COLUMN';
END

IF COL_LENGTH('Staging.ProgramParticipationNorD', 'DelinquentProgramType') IS NULL
BEGIN
	ALTER TABLE Staging.ProgramParticipationNorD ADD DelinquentProgramType nvarchar(100);
END

IF COL_LENGTH('RDS.ReportEDFactsK12StudentCounts', 'NEGLECTEDORDELINQUENTPROGRAMTYPE') IS NOT NULL
BEGIN
	EXEC sp_rename 'RDS.ReportEDFactsK12StudentCounts.NEGLECTEDORDELINQUENTPROGRAMTYPE',  'NEGLECTEDPROGRAMTYPE', 'COLUMN';
END

IF COL_LENGTH('RDS.ReportEDFactsK12StudentCounts', 'DELINQUENTPROGRAMTYPE') IS NULL
BEGIN
	ALTER TABLE RDS.ReportEDFactsK12StudentCounts ADD DELINQUENTPROGRAMTYPE nvarchar(50);
END

IF COL_LENGTH('RDS.ReportEdFactsK12StudentAssessments', 'NEGLECTEDORDELINQUENTPROGRAMTYPE') IS NOT NULL
BEGIN
	EXEC sp_rename 'RDS.ReportEdFactsK12StudentAssessments.NEGLECTEDORDELINQUENTPROGRAMTYPE',  'NEGLECTEDPROGRAMTYPE', 'COLUMN';
END

IF COL_LENGTH('RDS.ReportEdFactsK12StudentAssessments', 'DELINQUENTPROGRAMTYPE') IS NULL
BEGIN
	ALTER TABLE RDS.ReportEdFactsK12StudentAssessments ADD DELINQUENTPROGRAMTYPE nvarchar(50);
END
