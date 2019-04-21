CREATE FUNCTION OtherCollidingWithWorkshop
	(@WorkshopID INT)
	RETURNS @Colliders TABLE
	(WorkshopID INT)
AS
	BEGIN
		INSERT INTO @Colliders
		SELECT WorkshopID
		FROM Workshops
		WHERE dbo.WorkshopsCollides(@WorkshopID,WorkshopID) = 1
		RETURN
	END