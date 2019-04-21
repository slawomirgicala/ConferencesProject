CREATE TRIGGER consistentConferenceDays
ON ConferenceDays
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS (SELECT *
	           FROM inserted as i
			   JOIN ConferenceDays as cd
			   ON i.ConferenceID = cd.ConferenceDayID)
	BEGIN
		IF NOT EXISTS (SELECT *
				       FROM inserted as i
			           JOIN ConferenceDays as cd
			           ON i.ConferenceID = cd.ConferenceID
			           WHERE DATEDIFF(DAY, i.Date,cd.Date) = 1 OR
				             DATEDIFF(DAY, i.Date,cd.Date) = -1)
		BEGIN
			;THROW 50000, 'Conference days within one conference must be consistent', 1
		END
	END
END