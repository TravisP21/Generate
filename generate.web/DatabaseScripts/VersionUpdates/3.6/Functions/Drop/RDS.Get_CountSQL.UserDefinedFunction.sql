IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RDS].[Get_CountSQL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [RDS].[Get_CountSQL]