CREATE TABLE Clients (
	ClientID		INT             NOT NULL IDENTITY,
	ClientName		VARCHAR(256)	NOT NULL CHECK(DATALENGTH(ClientName) > 0),
	Phone			VARCHAR(64)		  NOT NULL CHECK(DATALENGTH(Phone) > 0),
	IsCompany		BIT		NOT NULL,
	Address			VARCHAR(256)	  NOT NULL,
	PostalCode		VARCHAR(256)	NOT NULL,
	City			VARCHAR(256)	    NOT NULL,
	Country			VARCHAR(256)	  NOT NULL,
	
	CONSTRAINT PK_Clients PRIMARY KEY CLUSTERED (ClientID ASC)	
)
