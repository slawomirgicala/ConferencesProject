CREATE VIEW ClientsStatistics
AS
	SELECT c.ClientID,c.ClientName,
	       IIF(c.IsCompany = 1, 'Company', 'Individual') AS 'IsCompany?',
		   c.Address,c.PostalCode, c.City, c.Country,
		   (SELECT COUNT(*)
		   FROM Orders
		   WHERE ClientID = c.ClientID) AS 'TotalOrders',
		   (SELECT COUNT(*)
		   FROM ConferenceDays_OrderDetails AS od
		   JOIN Orders AS o
		   ON o.OrderID = od.OrderID
		   WHERE o.ClientID = c.ClientID AND od.IsCanceled = 0) AS 'TotalDays',
		   (SELECT COUNT(*)
		   FROM ConferenceDays_Participants as cp
		   JOIN ConferenceDays_OrderDetails AS od
		   ON cp.ConferenceDay_OrderDetailID = od.ConferenceDay_OrderDetailID
		   JOIN Orders AS o
		   ON o.OrderID = od.OrderID
		   WHERE o.ClientID = c.ClientID AND od.IsCanceled = 0) AS 'TotalParticipants',
		   (SELECT ISNULL(SUM(p.MoneyPaidIn),0)
		   FROM Payments as p
		   JOIN Orders as o
		   ON p.OrderID = o.OrderID
		   WHERE o.ClientID = c.ClientID
		   GROUP BY o.ClientID) AS 'TotalMoneyPaid'
	FROM Clients AS c
