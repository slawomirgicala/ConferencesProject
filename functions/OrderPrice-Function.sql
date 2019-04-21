CREATE FUNCTION OrderPrice
	(@OrderID INT)
	RETURNS MONEY
AS
	BEGIN
		RETURN (SELECT od.NumberOfParticipants*dbo.PriceOnDay(od.ConferenceDayID,o.BookingDay)
						+ (1-c.StudentDiscount)*od.NumberOfStudents*dbo.PriceOnDay(od.ConferenceDayID,o.BookingDay)
				FROM ConferenceDays_OrderDetails as od
				JOIN Orders as o
				ON od.OrderID = o.OrderID
				JOIN ConferenceDays as c
				ON c.ConferenceDayID = od.ConferenceDayID
				WHERE od.OrderID = @OrderID)
	END
