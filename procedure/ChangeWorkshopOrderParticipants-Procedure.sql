CREATE PROCEDURE ChangeWorkshopOrderParticipants
	(@Workshop_OrderDetailID INT,
	@NumberOfParticipants SMALLINT,
	@NumberOfStudents SMALLINT)
AS
	BEGIN
		IF @NumberOfParticipants < 0 OR @NumberOfStudents < 0
			BEGIN
				;THROW 50001, 'Number of participant cannot be below zero', 1
			END
		DECLARE @WorkshopID INT
		DECLARE @ActualParticipants SMALLINT
		DECLARE @ActualStudents SMALLINT
		SET @WorkshopID = (SELECT WorkshopID
								FROM Workshops_OrderDetails
								WHERE Workshop_OrderDetailID = @Workshop_OrderDetailID)
		SET @ActualParticipants = (SELECT NumberOfParticipants
								   FROM Workshops_OrderDetails 
								   WHERE Workshop_OrderDetailID = @Workshop_OrderDetailID)
		SET @ActualStudents = (SELECT NumberOfStudents
							   FROM Workshops_OrderDetails 
							   WHERE Workshop_OrderDetailID = @Workshop_OrderDetailID)
		IF dbo.WorkshopReservedPlaces(@WorkshopID) 
		   - @ActualParticipants - @ActualStudents 
		   + @NumberOfParticipants + @NumberOfStudents > (SELECT ParticipantsLimit
														  FROM Workshops_OrderDetails as od
														  JOIN Workshops as w
														  ON w.WorkshopID = od.WorkshopID
														  WHERE od.Workshop_OrderDetailID = @Workshop_OrderDetailID)
			BEGIN
				;THROW 50001, 'Not enough places to make a change', 1
			END
		UPDATE Workshops_OrderDetails
		SET NumberOfParticipants = @NumberOfParticipants, NumberOfStudents = @NumberOfStudents
		WHERE Workshop_OrderDetailID = @Workshop_OrderDetailID
	END