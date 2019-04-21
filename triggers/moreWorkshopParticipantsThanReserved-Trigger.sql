CREATE TRIGGER moreWorkshopParticipantsThanReserved
ON Workshops_Participants
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT NumberOfParticipants + NumberOfStudents
	    FROM inserted as i
		JOIN Workshops_OrderDetails as od
		ON i.Workshop_OrderDetailID = od.Workshop_OrderDetailID)
		<
	   (SELECT COUNT(*)
	   FROM inserted as i
	   JOIN Workshops_Participants as wp
	   ON i.Workshop_OrderDetailID = wp.Workshop_OrderDetailID)
	BEGIN
		;THROW 50000, 'Cannot register more participants than reserved in order',1
	END
END