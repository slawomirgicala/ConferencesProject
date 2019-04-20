CREATE TABLE Participants (
	ParticipantID		INT				NOT NULL IDENTITY,
	FirstName			VARCHAR(128)	NOT NULL CHECK(DATALENGTH(FirstName) > 0),
	LastName			VARCHAR(128)	NOT NULL CHECK(DATALENGTH(LastName) > 0),
	Email				VARCHAR(128)	NOT NULL CHECK(Email like '%_@_%'),

	CONSTRAINT PK_Participants PRIMARY KEY CLUSTERED (ParticipantID ASC),
)