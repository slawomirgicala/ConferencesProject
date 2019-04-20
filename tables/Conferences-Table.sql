CREATE TABLE Conferences (
	ConferenceID	INT				NOT NULL	IDENTITY,
	ConferenceName	VARCHAR(128)	NOT NULL	CHECK (DATALENGTH(ConferenceName) >= 1),
	Description		VARCHAR(4000)	NOT NULL	DEFAULT '',

	CONSTRAINT PK_Conferences PRIMARY KEY CLUSTERED (ConferenceID ASC)
)


