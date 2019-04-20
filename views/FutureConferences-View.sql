CREATE VIEW FutureConferences
AS
SELECT c.ConferenceName, cd.Date,
       dbo.ConferenceDayFreePlaces(cd.ConferenceDayID) AS 'FREE PLACES',
	   dbo.DayReservedPlaces(cd.ConferenceDayID) AS 'RESERVED PLACES'
FROM ConferenceDays as cd
JOIN Conferences as c
ON cd.ConferenceID = c.ConferenceID
WHERE cd.Date >= GETDATE()
