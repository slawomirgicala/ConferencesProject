CREATE PROCEDURE ChangeWorkshopParticipantsLimit
	(@WorkshopID INT,
	@ParticipantsLimit INT)
AS
	BEGIN
		IF @ParticipantsLimit < dbo.WorkshopReservedPlaces(@WorkshopID)
			BEGIN
				;THROW 50001, 'Too many reservations has been already made', 1
			END
		UPDATE Workshops
		SET ParticipantsLimit = @ParticipantsLimit
		WHERE WorkshopID = @WorkshopID
	END
