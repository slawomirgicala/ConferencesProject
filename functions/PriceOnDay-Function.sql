CREATE FUNCTION PriceOnDay
	(@ConferenceDayID INT,
	@Date DATE)
	RETURNS MONEY
AS
	BEGIN
		RETURN (SELECT TOP 1 Price
				FROM PriceThresholds
				WHERE ConferenceDayID = @ConferenceDayID AND EndDate >= @Date
				ORDER BY EndDate ASC)
	END
