CREATE FUNCTION	DayReservedPlaces
	(@ConferenceDayID INT)
	RETURNS INT
AS
	BEGIN
		RETURN ISNULL((SELECT SUM(NumberOfParticipants) + SUM(NumberOfStudents)
				       FROM ConferenceDays_OrderDetails
				       WHERE ConferenceDayID = @ConferenceDayID AND IsCanceled = 0
				       GROUP BY ConferenceDayID),0)
	END

select dbo.DayReservedPlaces(1)

SELECT *
FROM ConferenceDays_OrderDetails
WHERE ConferenceDayID = 1 and IsCanceled = 0

