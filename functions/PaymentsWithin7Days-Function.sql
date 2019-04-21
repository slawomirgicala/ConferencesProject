CREATE FUNCTION PaymentsWithin7Days
	(@OrderID INT)
	RETURNS MONEY
AS
	BEGIN
		DECLARE @Date DATE
		SET @Date = (SELECT BookingDate FROM Orders WHERE OrderID = @OrderID)
		Declare @EarliestConferenceDay DATE 
		SET @EarliestConferenceDay = (SElect top 1 cd.Date
		                              fROM ConferenceDays as cd
									  join ConferenceDays_OrderDetails od
									  on cd.ConferenceDayID = od.ConferenceDayID
									  where od.OrderID = @OrderID
									  order by cd.Date asc)
		IF (@EarliestConferenceDay < DATEADD(DAY, @Date, 7))
			Begin
				set @date =  DATEADD(DAY, @EarliestConferenceDay, -1)
			end
		else
			begin
				set @Date = DATEADD(DAY, @Date, 7)
			end

		RETURN ISNULL((SELECT SUM(MoneyPaidIn)
				       FROM Payments
				       WHERE OrderID = @OrderID AND PaymentDate <= @Date), 0)
	END
