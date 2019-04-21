CREATE PROCEDURE AddWorkshops_Participants
	@ConferenceDay_ParticipantID INT,
	@Workshop_OrderDetailID INT
AS
	SET NOCOUNT ON
	BEGIN TRY
		IF NOT EXISTS
			(SELECT *
			FROM ConferenceDays_Participants
			WHERE ConferenceDay_ParticipantID = @ConferenceDay_ParticipantID)
		BEGIN
			;THROW 50001, 'There is no such element in ConferenceDays_Participants table', 1
		END
		IF NOT EXISTS
			(SELECT *
			FROM Workshops_OrderDetails
			WHERE Workshop_OrderDetailID = @Workshop_OrderDetailID)
		BEGIN
			;THROW 50001, 'There is no such element in Workshops_OrderDetails table', 1
		END
		INSERT INTO Workshops_Participants
			(ConferenceDay_ParticipantID,
			Workshop_OrderDetailID)
		VALUES
			(@ConferenceDay_ParticipantID,
			@Workshop_OrderDetailID)
	END TRY
	BEGIN CATCH
		SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
