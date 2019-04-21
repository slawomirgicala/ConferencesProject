CREATE PROCEDURE AddParticipant
	@FirstName VARCHAR(128),
	@LastName VARCHAR(128),
	@Email VARCHAR(128)
AS
	BEGIN TRY
		INSERT INTO Participants
			(FirstName,
			LastName,
			Email)
		VALUES
			(@FirstName,
			@LastName,
			@Email)
	END TRY
	BEGIN CATCH
		SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
