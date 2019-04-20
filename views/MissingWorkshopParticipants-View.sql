CREATE VIEW MissingWorkshopParticipants
AS
SELECT c.ClientName, c.Phone, (od.NumberOfParticipants + od.NumberOfStudents - (SELECT COUNT(*)
                                                       FROM Workshops_Participants
													   WHERE Workshop_OrderDetailID = od.Workshop_OrderDetailID))
													   as 'Number of Participants not registered',
	   w.WorkshopName, cd.Date
FROM Workshops_OrderDetails as od
JOIN Workshops as w
ON od.WorkshopID = w.WorkshopID
JOIN ConferenceDays_OrderDetails as cod
ON cod.ConferenceDay_OrderDetailID = od.ConferenceDay_OrderDetailID
JOIN Orders as o
ON cod.OrderID = o.OrderID
JOIN Clients as c
ON c.ClientID = o.ClientID
JOIN ConferenceDays as cd
ON cd.ConferenceDayID = w.ConferenceDayID
WHERE (od.NumberOfParticipants + od.NumberOfStudents > (SELECT COUNT(*)
                                                       FROM Workshops_Participants
													   WHERE Workshop_OrderDetailID = od.Workshop_OrderDetailID))
	  AND DATEADD(DAY, 14,GETDATE()) >= cd.Date
	  AND cd.Date <= GETDATE()
