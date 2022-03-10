
CREATE TABLE STORE (
    StoreID INT AUTO_INCREMENT UNIQUE NOT NULL,
    Location VARCHAR(255) NOT NULL,
    StoreName VARCHAR(255) NOT NULL,
    PRIMARY KEY (StoreID)
);

CREATE TABLE TERMINATION(
	TermID int UNIQUE AUTO_INCREMENT NOT NULL, 
    TermDate Date NOT NULL,
    Reason varchar(255) NOT NULL, 
    TermCode int NOT NULL, 
    PRIMARY KEY (TermID)
); 

CREATE TABLE EMPLOYEE(
	EmpID int AUTO_INCREMENT UNIQUE NOT NULL, 
    StartDate date NOT NULL,
    FirstName varchar(255) NOT NULL,  
    LastName varchar(255) NOT NULL, 
    DateOfBirth date NOT NULL,
    Position varchar(255) NOT NULL, 
    Wage decimal(10,2)NOT NULL,
    HoursWorked int NOT NULL,
    StoreID int NOT NULL, 
    TermID int NULL,
    PRIMARY KEY (EmpID),
    FOREIGN KEY (StoreID) REFERENCES STORE (StoreID),
    FOREIGN KEY (TermID) REFERENCES TERMINATION (TermID)
); 

CREATE TABLE EMERGENCYCONTACT(
	ContactID int UNIQUE AUTO_INCREMENT NOT NULL, 
    FirstName varchar(255) NOT NULL, 
    LastName varchar(255) NOT NULL, 
    Phone varchar(11),
    Email varchar(255), 
    Relationship varchar(255) NOT NULL, 
    Employee int,
    PRIMARY KEY (ContactID),
    FOREIGN KEY (Employee) REFERENCES EMPLOYEE (EmpID)

);



CREATE TABLE EMPINFO(
	EmpID int, 
    StreetAddress varchar(255) NULL, 
    City varchar(255) NULL, 
    State varchar(255) NULL, 
    Zip varchar(12) NULL, 
    Email varchar(255) NULL, 
    Phone varchar(11) NOT NULL,
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE (EmpID), 
	CHECK ((StreetAddress IS NULL AND City IS NULL AND State IS NULL AND Zip IS NULL)
		OR (StreetAddress IS NOT NULL AND City IS NOT NULL AND State IS NOT NULL AND Zip IS NOT NULL))
);

CREATE TABLE AREA(
	AreaID int NOT NULL,
	AreaName varchar(255) NOT NULL, 
    StoreID int NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES STORE (StoreID),
    PRIMARY KEY (AreaID, StoreID)
); 

CREATE TABLE LOCATION(
	LocID int NOT NULL UNIQUE AUTO_INCREMENT, 
	Aisle int NOT NULL, 
    Shelf int NOT NULL, 
    AreaID int, 
    StoreID int,
    PRIMARY KEY(LocID),
    FOREIGN KEY (AreaID, StoreID) REFERENCES AREA (AreaID, StoreID) 
); 

CREATE TABLE CUSTOMER(
	CustID int UNIQUE AUTO_INCREMENT NOT NULL, 
    FirstName varchar(255) NULL, 
    LastName varchar(255) NULL, 
    Phone varchar(11) NULL, 
    Email varchar(255) NULL, 
    StreetAddress varchar(255) NULL, 
    City varchar(255) NULL, 
    State varchar(255) NULL, 
    Zip varchar(12) NULL, 
    PRIMARY KEY (CustID),
	CHECK ((StreetAddress IS NULL AND City IS NULL AND State IS NULL AND Zip IS NULL)
		OR (StreetAddress IS NOT NULL AND City IS NOT NULL AND State IS NOT NULL AND Zip IS NOT NULL))
); 

CREATE TABLE PRODUCT(
	PID int UNIQUE AUTO_INCREMENT NOT NULL, 
    Name varchar(255) NOT NULL,
    Descript varchar(255) NOT NULL,
    Cost decimal(10, 2)NOT NULL,
    Price decimal(10,2) NOT NULL,
    Color varchar(255) NOT NULL, 
    Length float NOT NULL,
    Width float NOT NULL, 
    Height float NOT NULL, 
    Weight float NOT NULL, 
    Stock int NOT NULL, 
    ReorderPoint int NOT NULL, 
	Location int,
    StockedBy int NOT NULL, 
    PRIMARY KEY (PID), 
    FOREIGN KEY (Location) REFERENCES LOCATION (LocID),
    FOREIGN KEY (StockedBy) REFERENCES EMPLOYEE (EmpID)

);

CREATE TABLE PAYMENTMETHODS(
	PaymentID int UNIQUE AUTO_INCREMENT NOT NULL, 
    Cash bool NULL, 
    CardNum varchar(16) NULL, 
    CSC int NULL,
    CardHolderName varchar(255) NULL,
	ExprMonth int NULL,
    ExprYear int NULL, 
    CustID int,
    PRIMARY KEY (PaymentID), 
    FOREIGN KEY (CustID) REFERENCES CUSTOMER (CustID),
    CHECK(ExprMonth >= 1),
    CHECK(ExprMonth <= 12), 
    CHECK(ExprYear >= 21),
    CONSTRAINT fullcardinfo CHECK ((CardNum IS NULL AND CSC IS NULL AND CardHolderName IS NULL AND ExprMonth IS NULL AND ExprYear IS NULL)
		OR (CardNum IS NOT NULL AND CSC IS NOT NULL AND CardHolderName IS NOT NULL AND ExprMonth IS NOT NULL AND ExprYear IS NOT NULL))
);  

CREATE TABLE SALES(
	TransactionID int UNIQUE AUTO_INCREMENT NOT NULL, 
    SaleDate date NOT NULL,
    EmpID int NOT NULL,
    CustID int NOT NULL,
    ProductID int NOT NULL, 
    PaymentID int NOT NULL,
    PRIMARY KEY (TransactionID),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE (EmpID), 
    FOREIGN KEY (CustID) REFERENCES CUSTOMER (CustID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT (PID), 
    FOREIGN KEY (PaymentID) REFERENCES PAYMENTMETHODS(PaymentID)
);

