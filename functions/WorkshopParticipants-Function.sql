CREATE FUNCTION WorkshopParticipants
	(@WorkshopID INT)
	RETURNS @WorkshopParticipants TABLE
	(FirstName VARCHAR(128),
	LastName VARCHAR(128),
	Email VARCHAR(128))
AS
	BEGIN
		INSERT INTO @WorkshopParticipants
		SELECT p.FirstName, p.LastName, p.Email
		FROM Participants as p
		JOIN ConferenceDays_Participants as cp
		ON p.ParticipantID = cp.ParticipantID
		JOIN Workshops_Participants as wp
		ON wp.ConferenceDay_ParticipantID = cp.ConferenceDay_ParticipantID
		JOIN Workshops_OrderDetails as wod
		ON wp.Workshop_OrderDeatilID = wod.Workshop_OrderDetailID
		JOIN Workshops as w
		ON wod.WorkshopID = w.WorkshopID
		WHERE w.WorkshopID = @WorkshopID AND wod.IsCanceled = 0
		RETURN
	END