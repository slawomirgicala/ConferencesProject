CREATE TABLE Workshops(
	WorkshopID				INT			NOT NULL IDENTITY,
	ConferenceDayID			INT			NOT NULL,
	Price					MONEY		NOT NULL,
	StudentDiscount			REAL		NOT NULL DEFAULT 0.0 CHECK(StudentDiscount BETWEEN 0.0 AND 1.0),
	BeginningTime			TIME		NOT NULL,
	EndTime					TIME		NOT NULL,
	ParticipantsLimit		INT			NOT NULL CHECK(ParticipantsLimit > 0),

	CONSTRAINT PK_Workshops PRIMARY KEY CLUSTERED (WorkshopID ASC),
)

ALTER TABLE Workshops
ADD CONSTRAINT FK_Workshops_ConferenceDays
FOREIGN KEY (ConferenceDayID) REFERENCES ConferenceDays (ConferenceDayID)
