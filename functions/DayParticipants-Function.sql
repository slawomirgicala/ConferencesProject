CREATE FUNCTION DayParticipants
	(@ConferenceDayID INT)
	RETURNS @DayParticipants TABLE
	(FirstName VARCHAR(128),
	LastName VARCHAR(128),
	Email VARCHAR(128))
AS
	BEGIN
		INSERT INTO @DayParticipants
		SELECT p.FirstName, p.LastName, p.Email
		FROM Participants as p
		JOIN ConferenceDays_Participants as cp
		ON p.ParticipantID = cp.ParticipantID
		JOIN ConferenceDays_OrderDetails as od
		ON od.ConferenceDay_OrderDetailID = cp.ConferenceDay_OrderDetailID
		JOIN ConferenceDays as cd
		ON od.ConferenceDayID = cd.ConferenceDayID
		WHERE cd.ConferenceDayID = @ConferenceDayID AND od.IsCanceled = 0
		RETURN
	END
