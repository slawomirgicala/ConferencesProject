CREATE PROCEDURE AddWorkshops_OrderDetails
	@WorkshopID INT,
	@ConferenceDay_OrderDetailID INT,
	@NumberOfParticipants SMALLINT,
	@NumberOfStudents SMALLINT,
	@IsCanceled BIT = 0
AS
	SET NOCOUNT ON
	BEGIN TRY
		IF NOT EXISTS
			(SELECT *
			FROM Workshops
			WHERE WorkshopID = @WorkshopID)
		BEGIN
			;THROW 50001, 'There is no such workshop', 1
		END
		IF NOT EXISTS
			(SELECT *
			FROM ConferenceDays_OrderDetails
			WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID)
			OR 
			(SELECT IsCanceled
			FROM ConferenceDays_OrderDetails
			WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID) = 1
		BEGIN
			;THROW 50001, 'There is no such order (or this order was caneled)', 1
		END
		IF (SELECT ConferenceDayID
			FROM Workshops
			WHERE WorkshopID = @WorkshopID) != (SELECT ConferenceDayID
												FROM ConferenceDays_OrderDetails
												WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID)
		BEGIN
			;THROW 50001, 'This order is not for the day when the workshop takes place', 1
		END
		IF (SELECT NumberOfParticipants
			FROM ConferenceDays_OrderDetails
			WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID) < @NumberOfParticipants
			OR
			(SELECT NumberOfStudents
			FROM ConferenceDays_OrderDetails
			WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID) < @NumberOfStudents
		BEGIN
			;THROW 50001, 'Not enough places for the day of workshop reserved', 1
		END
	END TRY
	BEGIN CATCH
		SELECT  
		ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
