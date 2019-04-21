CREATE PROCEDURE AddConferenceDays_OrderDetails
	@OrderID INT,
	@ConferenceDayID INT,
	@NumberOfParticipants SMALLINT,
	@NumberOfStudents SMALLINT,
	@IsCanceled BIT = 0
AS
	SET NOCOUNT ON
	BEGIN TRY
		IF NOT EXISTS
			(SELECT *
			FROM Orders
			WHERE OrderID = @OrderID)
		BEGIN
			;THROW 50001, 'There is no such Order', 1
		END
		IF NOT EXISTS
			(SELECT *
			FROM ConferenceDays
			WHERE ConferenceDayID = @ConferenceDayID)
		BEGIN
			;THROW 50001, 'There is no such conference day', 1
		END
		IF @NumberOfParticipants + @NumberOfStudents > (SELECT ParticipantsLimit
														FROM ConferenceDays
														WHERE ConferenceDayID = @ConferenceDayID)
		BEGIN
			;THROW 50001, 'Not enough places for that conference', 1
		END
		INSERT INTO ConferenceDays_OrderDetails
			(OrderID,
			ConferenceDayID,
			NumberOfParticipants,
			NumberOfStudents,
			IsCanceled)
		VALUES
			(@OrderID,
			@ConferenceDayID,
			@NumberOfParticipants,
			@NumberOfStudents,
			@IsCanceled)
	END TRY
	BEGIN CATCH
		SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
