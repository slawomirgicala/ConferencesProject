CREATE TABLE ConferenceDays_OrderDetails (
	ConferenceDay_OrderDetailID	INT			NOT NULL IDENTITY,
	OrderID						INT			NOT NULL,
	ConferenceDayID				INT			NOT NULL,
	NumberOfParticipants		SMALLINT	NOT NULL CHECK (NumberOfParticipants > 0),
	NumberOfStudents			SMALLINT	NOT NULL CHECK (NumberOfStudents > 0),
	IsCanceled					BIT			NOT NULL DEFAULT 0,

	CONSTRAINT PK_ConferenceDays_OrderDetails PRIMARY KEY CLUSTERED (ConferenceDay_OrderDetailID ASC)
)

ALTER TABLE ConferenceDays_OrderDetails
ADD CONSTRAINT FK_ConferenceDays_OrderDetails_Orders
FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)

ALTER TABLE ConferenceDays_OrderDetails
ADD CONSTRAINT FK_ConferenceDays_OrderDetails_ConferenceDays
FOREIGN KEY (ConferenceDayID) REFERENCES ConferenceDays (ConferenceDayID)
