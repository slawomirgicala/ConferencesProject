CREATE PROCEDURE ChangeOrderDayParticipants
	(@ConferenceDay_OrderDetailID INT,
	@NumberOfParticipants SMALLINT,
	@NumberOfStudents SMALLINT)
AS
	BEGIN
		IF @NumberOfParticipants < 0 OR @NumberOfStudents < 0
			BEGIN
				;THROW 50001, 'Number of participant cannot be below zero', 1
			END
		DECLARE @ConferenceDayID INT
		DECLARE @ActualParticipants SMALLINT
		DECLARE @ActualStudents SMALLINT
		SET @ConferenceDayID = (SELECT ConferenceDayID
								FROM ConferenceDays_OrderDetails
								WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID)
		SET @ActualParticipants = (SELECT NumberOfParticipants
								   FROM ConferenceDays_OrderDetails 
								   WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID)
		SET @ActualStudents = (SELECT NumberOfStudents
							   FROM ConferenceDays_OrderDetails 
							   WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID)
		IF dbo.DayReservedPlaces(@ConferenceDayID) 
		   - @ActualParticipants - @ActualStudents 
		   + @NumberOfParticipants + @NumberOfStudents > (SELECT ParticipantsLimit
														  FROM ConferenceDays_OrderDetails as od
														  JOIN ConferenceDays as c
														  ON c.ConferenceDayID = od.ConferenceDayID
														  WHERE od.ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID)
			BEGIN
				;THROW 50001, 'Not enough places to make a change', 1
			END
		UPDATE ConferenceDays_OrderDetails
		SET NumberOfParticipants = @NumberOfParticipants, NumberOfStudents = @NumberOfStudents
		WHERE ConferenceDay_OrderDetailID = @ConferenceDay_OrderDetailID
	END