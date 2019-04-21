CREATE FUNCTION WorkshopFreePlaces
	(@WorkshopID INT)
	RETURNS INT
AS
	BEGIN
		RETURN (SELECT ParticipantsLimit - dbo.WorkshopReservedPlaces(@WorkshopID)
				FROM Workshops
				WHERE WorkshopID = @WorkshopID)
	END
