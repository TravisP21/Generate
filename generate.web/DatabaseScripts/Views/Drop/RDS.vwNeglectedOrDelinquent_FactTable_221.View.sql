--Drop the old name of the file if it exists
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[RDS].[vwNeglectedOrDelinquent_FactTable_C221]'))
    DROP VIEW [RDS].[vwNeglectedOrDelinquent_FactTable_C221]

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[RDS].[vwNeglectedOrDelinquent_FactTable_221]'))
    DROP VIEW [RDS].[vwNeglectedOrDelinquent_FactTable_221]