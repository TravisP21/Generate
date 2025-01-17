CREATE PROCEDURE [Staging].[pre_DMC]
	@submissionYear int = NULL
AS
BEGIN

    SET NOCOUNT ON;

		PRINT 'Run any setup scripts prior to executing RUNDMC'

		--Reset the Membership date in toggle so it comes after the RecordStartDateTime of the Organizations
		update tr
		set ResponseValue = '10/21/' + CAST(@submissionYear - 1 AS VARCHAR)
		from App.ToggleResponses tr 
		inner join app.ToggleQuestions tq
			on tr.ToggleQuestionId = tq.ToggleQuestionId	
			and tq.EmapsQuestionAbbrv = 'MEMBERDTE'

		-- exec [App].[Rollover_Previous_Year_Metadata] 'c005', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c006', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c007', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c088', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c143', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c144', 2023, 2024

		-- exec [App].[Rollover_Previous_Year_Metadata] 'c070', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c099', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c112', 2023, 2024

		-- exec [App].[Rollover_Previous_Year_Metadata] 'c175', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c178', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c179', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c185', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c188', 2023, 2024
		-- exec [App].[Rollover_Previous_Year_Metadata] 'c189', 2023, 2024

	SET NOCOUNT OFF;

END



