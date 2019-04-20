CREATE TABLE ConferenceDays_Participants (
	ConferenceDay_ParticipantID		INT				NOT NULL IDENTITY,
	ParticipantID					INT				NOT NULL,
	ConferenceDay_OrderDetailID		INT				NOT NULL,
	StudentCardNo					VARCHAR(64)		DEFAULT NULL,

	CONSTRAINT PK_ConferenceDay_ParticipantID PRIMARY KEY CLUSTERED (ConferenceDay_ParticipantID ASC),
)

ALTER TABLE ConferenceDays_Participants
ADD CONSTRAINT FK_ConferenceDays_Participants_Participants
FOREIGN KEY (ParticipantID) REFERENCES Participants (ParticipantID)

ALTER TABLE ConferenceDays_Participants
ADD CONSTRAINT FK_ConferenceDays_Participants_ConferenceDays_OrderDetails
FOREIGN KEY (ConferenceDay_OrderDetailID) REFERENCES ConferenceDays_OrderDetails (ConferenceDay_OrderDetailID)