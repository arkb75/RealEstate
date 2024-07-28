DROP TABLE USERS;
DROP TABLE PROPERTIES;
DROP TABLE OFFERS;
DROP TABLE LISTINGS;

CREATE TABLE USERS (
                       Name VARCHAR(255) NOT NULL,
                       Email VARCHAR(255) NOT NULL,
                       Phone INTEGER NOT NULL,
                       PRIMARY KEY(Name),
                       UNIQUE(Phone)
);

CREATE TABLE PROPERTIES (
                            Address VARCHAR(255) NOT NULL,
                            City VARCHAR(255) NOT NULL,
                            Province VARCHAR(255) NOT NULL,
                            PropertyType VARCHAR(10) NOT NULL,
                            PostalCode CHAR(6) NOT NULL,
                            PropertyCondition VARCHAR(6),
                            NumBaths INTEGER NOT NULL,
                            NumBeds INTEGER NOT NULL,
                            YearBuilt INTEGER,
                            InteriorSpace INTEGER NOT NULL,
                            PRIMARY KEY (Address, PostalCode),
                            UNIQUE (Address, City, Province)
);

CREATE TABLE Offers (
                            OfferID INTEGER NOT NULL,
                            RealtorID INTEGER NOT NULL,
                            Status CHAR(8) NOT NULL,
                            Date CHAR(10) NOT NULL,
                            Amount INTEGER NOT NULL,
                            BuyerEmail VARCHAR(255) NOT NULL,
                            SellerEmail VARCHAR(255) NOT NULL,
                            OfferExpiryDate CHAR(10) NOT NULL,
                            ListingID INTEGER NOT NULL,
                            PRIMARY KEY (OfferID),
                            UNIQUE (RealtorID, Date, Amount, SellerEmail, BuyerEmail),
                            FOREIGN KEY (RealtorID) REFERENCES Realtors(RealtorID),
                            FOREIGN KEY (BuyerEmail, SellerEmail) REFERENCES Users(Email),
                            FOREIGN KEY (ListingID) REFERENCES Listings(ListingID)
);

CREATE TABLE Listings (
                            ListingID INTEGER NOT NULL,
                            Status CHAR(9) NOT NULL,
                            SellerEmail VARCHAR(255) NOT NULL,
                            ListingPrice INTEGER NOT NULL,
                            ExpirationDate CHAR(10),
                            ListingDate CHAR(10) NOT NULL,
                            PRIMARY KEY (ListingID),
                            UNIQUE (SellerEmail, ListingPrice, ListingDate),
                            FOREIGN KEY (SellerEmail) REFERENCES Users(Email)
);

INSERT INTO USERS(Name, Email, Phone) VALUES ('Rehnoor', 'rehnoorsaini@outlook.com', 4316885656);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Sam Jane', 'samjane@hotmail.com', 1234567890);
INSERT INTO USERS(Name, Email, Phone) VALUES ('George Washington', 'georgewash@laundry.com', 2234567990);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Will Smith', 'willsmith@alaadin.com', 1237867893);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Sundar Pichai', 'sundarpichai@gmail.com', 2354557899);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Brett Lee', 'brettlee@rediffmail.com', 5154447890);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Steve Smith', 'stevesmith@google.com', 2345678901);

INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('123 Maple St', 'Vancouver', 'BC', 'House', 'V5K0A1', 'Good', 2, 3, 1995, 2000);
INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('456 Oak St', 'Toronto', 'ON', 'Condo', 'M5H2N2', 'New', 1, 1, 2015, 800);
INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('789 Pine St', 'Calgary', 'AB', 'Townhouse', 'T2P1B3', 'Fair', 2, 2, 2005, 1500);
INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('321 Birch St', 'Montreal', 'QC', 'House', 'H3Z2Y7', 'Fair', 3, 4, 1980, 2500);
INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('654 Cedar St', 'Edmonton', 'AB', 'Apartment', 'T5J1B7', 'New', 1, 2, 2020, 900);
INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('987 Elm St', 'Ottawa', 'ON', 'House', 'K1P5G1', 'Good', 3, 5, 1975, 2300);
INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('159 Spruce St', 'Winnipeg', 'MB', 'Townhouse', 'R3C4G6', 'Fair', 2, 3, 1990, 1600);
INSERT INTO PROPERTIES(Address, City, Province, PropertyType, PostalCode, PropertyCondition, NumBaths, NumBeds, YearBuilt, InteriorSpace)
VALUES
    ('753 Willow St', 'Halifax', 'NS', 'Apartment', 'B3J3M8', 'New', 1, 1, 2022, 700);

INSERT INTO Offers (OfferID, ListingID, OfferDate, OfferExpiryDate, OfferAmount, OfferStatus, BuyerEmail, SellerEmail, RealtorID)
VALUES (1, 1, '2024-03-01', '2024-03-15', 510000, 'Pending', 'samjane@hotmail.com', 'georgewash@laundry.com', 1);
INSERT INTO Offers (OfferID, ListingID, OfferDate, OfferExpiryDate, OfferAmount, OfferStatus, BuyerEmail, SellerEmail, RealtorID)
VALUES (2, 2, '2024-04-01', '2024-04-10', 310000, 'Accepted', 'georgewash@laundry.com', 'samjane@hotmail.com', 2);
INSERT INTO Offers (OfferID, ListingID, OfferDate, OfferExpiryDate, OfferAmount, OfferStatus, BuyerEmail, SellerEmail, RealtorID)
VALUES (3, 3, '2024-05-01', '2024-05-15', 460000, 'Pending', 'willsmith@alaadin.com', 'sundarpichai@gmail.com', 3);
INSERT INTO Offers (OfferID, ListingID, OfferDate, OfferExpiryDate, OfferAmount, OfferStatus, BuyerEmail, SellerEmail, RealtorID)
VALUES (4, 4, '2024-06-01', '2024-06-15', 360000, 'Rejected', 'sundarpichai@gmail.com', 'brettlee@rediffmail.com', 4);
INSERT INTO Offers (OfferID, ListingID, OfferDate, OfferExpiryDate, OfferAmount, OfferStatus, BuyerEmail, SellerEmail, RealtorID)
VALUES (5, 5, '2024-07-01', '2024-07-10', 560000, 'Pending', 'brettlee@rediffmail.com', 'stevesmith@google.com', 5);
INSERT INTO Offers (OfferID, ListingID, OfferDate, OfferExpiryDate, OfferAmount, OfferStatus, BuyerEmail, SellerEmail, RealtorID)
VALUES (6, 6, '2024-08-01', '2024-08-10', 410000, 'Accepted', 'stevesmith@google.com', 'willsmith@alaadin.com', 6);

INSERT INTO Listings (ListingID, ListingDate, ExpirationDate, ListingPrice, YearBuilt, NumBeds, NumBaths, ListingStatus, SellerEmail, PropertyType)
VALUES (1, '2024-01-01', '2024-06-01', 500000, 2010, 4, 3, 'Active', 'samjane@hotmail.com', 'House');
INSERT INTO Listings (ListingID, ListingDate, ExpirationDate, ListingPrice, YearBuilt, NumBeds, NumBaths, ListingStatus, SellerEmail, PropertyType)
VALUES (2, '2024-02-01', '2024-07-01', 300000, 2015, 2, 1, 'Pending', 'georgewash@laundry.com', 'Condo');
INSERT INTO Listings (ListingID, ListingDate, ExpirationDate, ListingPrice, YearBuilt, NumBeds, NumBaths, ListingStatus, SellerEmail, PropertyType)
VALUES (3, '2024-03-01', '2024-08-01', 450000, 2012, 3, 2, 'Active', 'willsmith@alaadin.com', 'TownHouse');
INSERT INTO Listings (ListingID, ListingDate, ExpirationDate, ListingPrice, YearBuilt, NumBeds, NumBaths, ListingStatus, SellerEmail, PropertyType)
VALUES (4, '2024-04-01', '2024-09-01', 350000, 2018, 3, 2, 'Active', 'sundarpichai@gmail.com', 'Apartment');
INSERT INTO Listings (ListingID, ListingDate, ExpirationDate, ListingPrice, YearBuilt, NumBeds, NumBaths, ListingStatus, SellerEmail, PropertyType)
VALUES (5, '2024-05-01', '2024-10-01', 550000, 2020, 5, 4, 'Active', 'brettlee@rediffmail.com', 'House');
INSERT INTO Listings (ListingID, ListingDate, ExpirationDate, ListingPrice, YearBuilt, NumBeds, NumBaths, ListingStatus, SellerEmail, PropertyType)
VALUES (6, '2024-06-01', '2024-11-01', 400000, 2016, 3, 2, 'Pending', 'stevesmith@google.com', 'Condo');