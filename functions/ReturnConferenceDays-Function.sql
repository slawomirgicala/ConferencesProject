CREATE FUNCTION ReturnConferenceDays
	(@ConferenceID INT)
	RETURNS @Days TABLE
	(ConferenceDayID INT,
	ConfDate DATE,
	ParticipantsLimit INT)
AS
	BEGIN
		INSERT INTO @Days
		SELECT ConferenceDayID, Date, ParticipantsLimit 
		FROM ConferenceDays
		WHERE ConferenceID = @ConferenceID
		ORDER BY Date ASC
		RETURN
	END