CREATE PROCEDURE CancelUnpaidWorkshops
AS
	UPDATE Workshops_OrderDetails
	SET IsCanceled = 1
	WHERE ConferenceDay_OrderDetailID IN (SELECT ConferenceDay_OrderDetailID
										  FROM ConferenceDays_OrderDetails
										  WHERE IsCanceled = 1)