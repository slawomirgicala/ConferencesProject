CREATE TABLE Workshops_OrderDetails(
	Workshop_OrderDetailID			INT				NOT NULL IDENTITY,
	WorkshopID						INT				NOT NULL,
	ConferenceDay_OrderDetailID		INT				NOT NULL,
	NumberOfParticipants			SMALLINT		NOT NULL CHECK(NumberOfParticipants > 0),
	NumberOfStudents				SMALLINT		NOT NULL CHECK(NumberOfStudents >= 0),
	IsCanceled						BIT				NOT NULL DEFAULT 0,
	
	CONSTRAINT PK_Workshops_OrderDetails PRIMARY KEY CLUSTERED (Workshop_OrderDetailID ASC),
)

ALTER TABLE Workshops_OrderDetails
ADD CONSTRAINT FK_Workshops_OrderDetails_Workshops
FOREIGN KEY (WorkshopID) REFERENCES Workshops (WorkshopID)

ALTER TABLE Workshops_OrderDetails
ADD CONSTRAINT FK_Workshops_OrderDetails_ConferenceDay_OrderDetail
FOREIGN KEY (ConferenceDay_OrderDetailID) REFERENCES ConferenceDays_OrderDetails (ConferenceDay_OrderDetailID)


