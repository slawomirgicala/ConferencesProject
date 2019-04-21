CREATE TRIGGER moreParticipantsThanReserved
ON ConferenceDays_Participants
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT NumberOfParticipants + NumberOfStudents
	    FROM inserted as i
		JOIN ConferenceDays_OrderDetails as od
		ON i.ConferenceDay_OrderDetailID = od.ConferenceDay_OrderDetailID)
		<
	   (SELECT COUNT(*)
	   FROM inserted as i
	   JOIN ConferenceDays_Participants as cp
	   ON i.ConferenceDay_OrderDetailID = cp.ConferenceDay_OrderDetailID)
	BEGIN
		;THROW 50000, 'Cannot register more participants than reserved in order',1
	END
END