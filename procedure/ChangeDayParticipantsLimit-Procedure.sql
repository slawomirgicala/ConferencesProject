CREATE PROCEDURE ChangeDayParticipantsLimit
	(@ConferenceDayID INT,
	@ParticipantsLimit INT)
AS
	BEGIN
		IF @ParticipantsLimit < dbo.DayReservedPlaces(@ConferenceDayID)
			BEGIN
				;THROW 50001, 'Too many reservations has been already made', 1
			END
		UPDATE ConferenceDays
		SET ParticipantsLimit = @ParticipantsLimit
		WHERE ConferenceDayID = @ConferenceDayID
	END
