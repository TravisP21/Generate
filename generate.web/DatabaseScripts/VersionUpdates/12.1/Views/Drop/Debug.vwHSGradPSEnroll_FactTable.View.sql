IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Debug].[vwHSGradPSEnroll_FactTable]'))
    DROP VIEW [Debug].[vwHSGradPSEnroll_FactTable]