CREATE TABLE Payments (
	PaymentID	INT		NOT NULL IDENTITY,
	OrderID		INT		NOT NULL,
	MoneyPaidIn	INT		NOT NULL,
	PaymentDate	DATE	NOT NULL,

	CONSTRAINT PK_Payments PRIMARY KEY CLUSTERED (PaymentID ASC)
)

ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Orders
FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)