CREATE PROCEDURE AddWorkshop
	@ConferenceDayID INT,
	@Price MONEY,
	@StudentDiscount REAL,
	@BeginningTime TIME,
	@EndTime TIME,
	@ParticipantsLimit INT,
	@Name VARCHAR(128)
AS
	SET NOCOUNT ON
	BEGIN TRY
		IF NOT EXISTS
			(SELECT ConferenceDayID
			FROM ConferenceDays
			WHERE ConferenceDayID = @ConferenceDayID)
		BEGIN 
			;THROW 50001, 'There is no such conference day in ConferenceDays table', 1
		END
		IF EXISTS
			(SELECT *
			FROM Workshops
			WHERE ConferenceDayID = @ConferenceDayID AND
			      BeginningTime = @BeginningTime AND
				  EndTime = @EndTime AND
				  Name = @Name)
		BEGIN
			;THROW 50001, 'Such workshop already exists', 1
		END
		IF @BeginningTime > @EndTime
		BEGIN
			;THROW 50001, 'EndTime cannot be earlier than BeginningTime', 1
		END
		INSERT INTO Workshops
			(ConferenceDayID,
			Price,
			StudentDiscount,
			BeginningTime,
			EndTime,
			ParticipantsLimit)
		VALUES
			(@ConferenceDayID,
			@Price,
			@StudentDiscount,
			@BeginningTime,
			@EndTime,
			@ParticipantsLimit)
	END TRY
	BEGIN CATCH
		SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
