CREATE TABLE PriceTresholds (
	PriceTresholdID		INT		NOT NULL IDENTITY,
	ConferenceDayID		INT		NOT NULL,
	Price				MONEY	NOT NULL,
	EndDate				DATE	NOT NULL,

	CONSTRAINT PK_PriceTresholds PRIMARY KEY CLUSTERED (PriceTresholdID ASC)
)

ALTER TABLE PriceTresholds
ADD CONSTRAINT FK_PriceTresholds_ConferenceDays
FOREIGN KEY (ConferenceDayID) REFERENCES ConferenceDays (ConferenceDayID)