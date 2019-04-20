CREATE VIEW MissingParticipantsData
AS
SELECT c.ClientName, c.Phone, (od.NumberOfParticipants + od.NumberOfStudents - (SELECT COUNT(*)
                                                       FROM ConferenceDays_Participants
													   WHERE ConferenceDay_OrderDetailID = od.ConferenceDay_OrderDetailID))
													   as 'Number of Participants not registered',
	   (SELECT ConferenceName FROM Conferences WHERE cd.ConferenceID = ConferenceID) AS 'Conference Name',
	   cd.Date
FROM ConferenceDays_OrderDetails as od
JOIN ConferenceDays as cd
ON od.ConferenceDayID = cd.ConferenceDayID
JOIN Orders as o
ON od.OrderID = o.OrderID
JOIN Clients as c
ON c.ClientID = o.ClientID

WHERE (od.NumberOfParticipants + od.NumberOfStudents > (SELECT COUNT(*)
                                                       FROM ConferenceDays_Participants
													   WHERE ConferenceDay_OrderDetailID = od.ConferenceDay_OrderDetailID))
	  AND DATEADD(DAY, 14,GETDATE()) >= cd.Date
	  AND cd.Date <= GETDATE()
