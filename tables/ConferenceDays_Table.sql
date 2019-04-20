CREATE TABLE ConferenceDays (
	ConferenceDayID		INT		NOT NULL IDENTITY,
	ConferenceID		INT		NOT NULL,
	Date				DATE	NOT NULL,
	ParticipantsLimit	INT		NOT NULL CHECK(ParticipantsLimit > 0),
	StudentDiscount		REAL	NOT NULL DEFAULT 0.0 CHECK(StudentDiscount BETWEEN 0.0 AND 1.0),
	
	CONSTRAINT PK_ConferenceDays PRIMARY KEY CLUSTERED (ConferenceDayID ASC),
	CONSTRAINT UQ_Date_ConferenceDays UNIQUE (Date)
)

ALTER TABLE ConferenceDays
ADD CONSTRAINT FK_ConferenceDays_Conferences 
FOREIGN KEY (ConferenceID) REFERENCES Conferences (ConferenceID)