CREATE VIEW FutureWorkshops
AS
SELECT w.Name, c.ConferenceName, cd.Date,
       w.BeginningTime, w.EndTime, w.Price,
	   ISNULL((SELECT SUM(NumberOfParticipants) + SUM(NumberOfStudents)
		      FROM Workshops_OrderDetails
			  WHERE WorkshopID = w.WorkshopID AND IsCanceled = 0
			  GROUP BY WorkshopID),0) AS 'RESERVED PLACES',
       w.ParticipantsLimit - ISNULL((SELECT SUM(NumberOfParticipants) + SUM(NumberOfStudents)
		                            FROM Workshops_OrderDetails
			                        WHERE WorkshopID = w.WorkshopID AND IsCanceled = 0
			                        GROUP BY WorkshopID),0) AS 'FREE PLACES'
FROM Workshops AS w
JOIN ConferenceDays AS cd
ON cd.ConferenceDayID = w.ConferenceDayID
JOIN Conferences as c
ON c.ConferenceID = cd.ConferenceID
WHERE cd.Date >= GETDATE()

