CREATE FUNCTION ConferenceDayFreePlaces
	(@ConferenceDayID INT)
	RETURNS INT
AS
	BEGIN
		RETURN (SELECT ParticipantsLimit - dbo.DayReservedPlaces(@ConferenceDayID)
				FROM ConferenceDays
				WHERE ConferenceDayID = @ConferenceDayID)
	END

select *
from ConferenceDays
where ConferenceDayID = 1
