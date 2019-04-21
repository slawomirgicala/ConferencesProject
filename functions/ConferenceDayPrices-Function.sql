CREATE FUNCTION ConferenceDayPrices
	(@ConferenceDayID INT)
	RETURNS @Prices TABLE
	(PriceThresholdID INT,
	Price MONEY,
	EndDate DATE)
AS
	BEGIN
		INSERT INTO @Prices
		SELECT ProceThresholdID, Price, EndDate 
		FROM PriceThresholds
		WHERE ConferenceDayID = @ConferenceDayID
		ORDER BY EndDate ASC
		RETURN
	END