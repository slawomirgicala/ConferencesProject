CREATE TRIGGER conferencePricesAscWithDate
ON PriceTresholds
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT EndDate
	    FROM inserted) > (SELECT Date
	                      FROM ConferenceDays
						  JOIN inserted
						  ON inserted.ConferenceDayID = ConferenceDays.ConferenceDayID)
	BEGIN
		;THROW 50000, 'Cannot add price after conference ends',1
	END

	IF EXISTS (SELECT *
	           FROM inserted AS i
			   JOIN PriceTresholds as pt
			   ON pt.ConferenceDayID = i.ConferenceDayID
			   WHERE (i.EndDate > pt.EndDate AND i.Price < pt.Price) OR
			         (i.EndDate < pt.EndDate AND i.Price > pt.Price))
	BEGIN
		;THROW 50000, 'Prices should ascend with time',1
	END
END
			
