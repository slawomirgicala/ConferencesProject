CREATE PROCEDURE CancelUnpaidOrders
AS
	UPDATE ConferenceDays_OrderDetails
	SET IsCanceled = 1
	WHERE dbo.OrderPrice(OrderID) > dbo.PaymentsWithin7Days(OrderID)

