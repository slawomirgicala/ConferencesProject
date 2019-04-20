CREATE TABLE Workshops_Participants (
	Workshop_ParticipantID			INT		NOT NULL IDENTITY,
	ConferenceDay_ParticipantID		INT		NOT NULL,
	Workshop_OrderDetailID			INT		NOT NULL,

	CONSTRAINT PK_Workshop_ParticipantID PRIMARY KEY CLUSTERED (Workshop_ParticipantID ASC)
)

ALTER TABLE Workshops_Participants
ADD CONSTRAINT FK_Workshops_Participants_ConferenceDays_Participants
FOREIGN KEY (ConferenceDay_ParticipantID) REFERENCES ConferenceDays_Participants (ConferenceDay_ParticipantID)

ALTER TABLE Workshops_Participants
ADD CONSTRAINT FK_Workshops_Participants_Workshops_OrderDetails
FOREIGN KEY (Workshop_OrderDetailID) REFERENCES Workshops_OrderDetails (Workshop_OrderDetailID)