CREATE PROCEDURE AddConferenceDays_Participants
	@ParticipantID INT,
	@ConferenceDay_OrderDetailID INT,
	@StudentCardNo VARCHAR(64) = NULL
AS
	SET NOCOUNT ON
	BEGIN TRY
		IF NOT EXISTS
			(SELECT *
			FROM Participants
			WHERE ParticipantID = @ParticipantID)
		BEGIN
			;THROW 50001, 'There is no such participant in Participants table', 1
		END
		IF NOT EXISTS
			(SELECT *
			FROM ConferenceDays_OrderDetails
			WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID)
		BEGIN
			;THROW 50001, 'There is no such element in ConferenceDay_OrderDetail table', 1
		END
		INSERT INTO ConferenceDays_Participants
			(ParticipantID,
			ConferenceDay_OrderDetailID,
			StudentCardNo)
		VALUES
			(@ParticipantID,
			@ConferenceDay_OrderDetailID,
			@StudentCardNo)
	END TRY
	BEGIN CATCH
		SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
