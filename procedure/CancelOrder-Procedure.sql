CREATE PROCEDURE CancelOrder
	@OrderID INT
AS
	UPDATE ConferenceDays_OrderDetails
	SET IsCanceled = 1
	WHERE OrderID = @OrderID