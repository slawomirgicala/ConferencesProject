CREATE FUNCTION WorkshopOrderPrice
	(@Workshop_OrderDetailID INT)
	RETURNS MONEY
AS
	BEGIN
		RETURN (SELECT od.NumberOfParticipants*w.Price + od.NumberOfStudents*(1-w.StudentDiscount)*w.Price
				FROM Workshops_OrderDetails as od
				JOIN Workshops as w
				ON od.WorkshopID = w.WorkshopID
				WHERE od.Workshop_OrderDetailID = @Workshop_OrderDetailID)
	END