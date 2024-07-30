-- Drop all tables to reset the database
DROP TABLE Offers;
DROP TABLE Listings;
DROP TABLE Houses;
DROP TABLE TownHouses;
DROP TABLE Condos;
DROP TABLE Apartments;
DROP TABLE Properties;
DROP TABLE Realtors;
DROP TABLE Users;
DROP TABLE Amenities;

-- Create all tables for the DB

CREATE TABLE USERS (
                       Name VARCHAR(255) NOT NULL,
                       Email VARCHAR(255) NOT NULL,
                       Phone INTEGER NOT NULL,
                       PRIMARY KEY(Email),
                       UNIQUE(Phone)
);

CREATE TABLE Realtors (
                          RealtorID INTEGER NOT NULL,
                          Name VARCHAR(255) NOT NULL,
                          Email VARCHAR(255) NOT NULL,
                          Phone INTEGER NOT NULL,
                          YearsOfExperience INTEGER,
                          RealEstateFirm VARCHAR(255) NOT NULL,
                          PRIMARY KEY (RealtorID),
                          UNIQUE (Email),
                          UNIQUE (Phone)
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

CREATE TABLE Houses (
                        Address VARCHAR(255) NOT NULL,
                        City VARCHAR(255) NOT NULL,
                        Province VARCHAR(255) NOT NULL,
                        PostalCode CHAR(6) NOT NULL,
                        YardSize INTEGER NOT NULL,
                        NumGarage INTEGER,
                        NumFloors INTEGER NOT NULL,
                        HasBasement CHAR(3) NOT NULL,
                        PRIMARY KEY (Address, PostalCode),
                        FOREIGN KEY (Address, PostalCode) REFERENCES Properties(Address, PostalCode)
                            ON DELETE CASCADE,
                        UNIQUE (Address, City, Province)
);

CREATE TABLE TownHouses (
                            Address VARCHAR(255) NOT NULL,
                            City VARCHAR(255) NOT NULL,
                            Province VARCHAR(255) NOT NULL,
                            PostalCode CHAR(6) NOT NULL,
                            NumGarage INTEGER,
                            NumFloors INTEGER NOT NULL,
                            HOAFee INTEGER NOT NULL,
                            PRIMARY KEY (Address, PostalCode),
                            FOREIGN KEY (Address, PostalCode) REFERENCES Properties(Address, PostalCode)
                                ON DELETE CASCADE,
                            UNIQUE (Address, City, Province)
);

CREATE TABLE Condos (
                        Address VARCHAR(255) NOT NULL,
                        City VARCHAR(255) NOT NULL,
                        Province VARCHAR(255) NOT NULL,
                        PostalCode CHAR(6) NOT NULL,
                        HOAFee INTEGER NOT NULL,
                        UnitNumber INTEGER NOT NULL,
                        PRIMARY KEY (Address, PostalCode, UnitNumber),
                        FOREIGN KEY (Address, PostalCode) REFERENCES Properties(Address, PostalCode)
                            ON DELETE CASCADE,
                        UNIQUE (Address, City, Province)
);

CREATE TABLE Apartments (
                            Address VARCHAR(255) NOT NULL,
                            City VARCHAR(255) NOT NULL,
                            Province VARCHAR(255) NOT NULL,
                            PostalCode CHAR(6) NOT NULL,
                            UnitNumber INTEGER NOT NULL,
                            PRIMARY KEY (Address, PostalCode, UnitNumber),
                            FOREIGN KEY (Address, PostalCode) REFERENCES Properties(Address, PostalCode)
                                ON DELETE CASCADE,
                            UNIQUE (Address, City, Province, UnitNumber)
);

CREATE TABLE Amenities (
                           Name VARCHAR(255) NOT NULL,
                           Type VARCHAR(20),
                           Distance INTEGER,
                           Rating INTEGER,
                           PRIMARY KEY (Name)
);


CREATE TABLE Listings (
                          ListingID INTEGER NOT NULL,
                          Address VARCHAR(255) NOT NULL,
                          PostalCode CHAR(6) NOT NULL,
                          ListingStatus CHAR(9) NOT NULL,
                          SellerEmail VARCHAR(255) NOT NULL,
                          ListingPrice INTEGER NOT NULL,
                          ExpirationDate CHAR(10),
                          ListingDate CHAR(10) NOT NULL,
                          PRIMARY KEY (ListingID, Address, PostalCode),
                          UNIQUE (SellerEmail, ListingPrice, ListingDate),
                          FOREIGN KEY (SellerEmail) REFERENCES Users
                              ON DELETE CASCADE,
                          FOREIGN KEY (Address, PostalCode) REFERENCES Properties
                              ON DELETE CASCADE
);

CREATE TABLE Offers (
                        OfferID INTEGER NOT NULL,
                        RealtorID INTEGER NOT NULL,
                        OfferStatus CHAR(8) NOT NULL,
                        OfferDate CHAR(10) NOT NULL,
                        OfferAmount INTEGER NOT NULL,
                        BuyerEmail VARCHAR(255) NOT NULL,
                        SellerEmail VARCHAR(255) NOT NULL,
                        OfferExpiryDate CHAR(10) NOT NULL,
                        ListingID INTEGER NOT NULL,
                        Address VARCHAR(255) NOT NULL,
                        PostalCode CHAR(6) NOT NULL,
                        PRIMARY KEY (OfferID),
                        UNIQUE (RealtorID, OfferDate, OfferAmount, SellerEmail, BuyerEmail),
                        FOREIGN KEY (RealtorID) REFERENCES Realtors(RealtorID)
                            ON DELETE CASCADE,
                        FOREIGN KEY (BuyerEmail) REFERENCES USERS
                            ON DELETE CASCADE,
                        FOREIGN KEY (SellerEmail) REFERENCES USERS,
                        FOREIGN KEY (ListingID, Address, PostalCode) REFERENCES Listings(ListingID, Address, PostalCode)
                            ON DELETE CASCADE
);


-- INSERT values into the database tables
INSERT INTO USERS(Name, Email, Phone) VALUES ('Rehnoor', 'rehnoorsaini@outlook.com', 4316885656);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Sam Jane', 'samjane@hotmail.com', 1234567890);
INSERT INTO USERS(Name, Email, Phone) VALUES ('George Washington', 'georgewash@laundry.com', 2234567990);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Will Smith', 'willsmith@alaadin.com', 1237867893);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Sundar Pichai', 'sundarpichai@gmail.com', 2354557899);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Brett Lee', 'brettlee@rediffmail.com', 5154447890);
INSERT INTO USERS(Name, Email, Phone) VALUES ('Steve Smith', 'stevesmith@google.com', 2345678901);


INSERT INTO Realtors (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (1, 'Emily Brown', 'emilybrown@gmail.com', 3456789012, 5, 'Dream Homes Realty');
INSERT INTO Realtors (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (2, 'Michael Johnson', 'michaeljohnson@gmail.com', 4567890123, 8, 'Premium Estates');
INSERT INTO Realtors (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (3, 'Sarah Green', 'sarahgreen@gmail.com', 5678901234, 4, 'Top Choice Realty');
INSERT INTO Realtors (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (4, 'David Wilson', 'davidwilson@gmail.com', 6789012345, 10, 'Elite Realty Group');
INSERT INTO Realtors (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (5, 'Jessica Taylor', 'jessicataylor@gmail.com', 7890123456, 7, 'Star Real Estate');
INSERT INTO Realtors (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (6, 'Daniel White', 'danielwhite@gmail.com', 8901234567, 6, 'Prime Properties');





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




INSERT INTO Houses(Address, City, Province, PostalCode, YardSize, NumGarage, NumFloors, HasBasement)
VALUES
    ('123 Maple St', 'Vancouver', 'BC', 'V5K0A1', 1000, 2, 2, 'Yes');
INSERT INTO Houses(Address, City, Province, PostalCode, YardSize, NumGarage, NumFloors, HasBasement)
VALUES
    ('321 Birch St', 'Montreal', 'QC', 'H3Z2Y7', 800, 1, 2, 'Yes');
INSERT INTO Houses(Address, City, Province, PostalCode, YardSize, NumGarage, NumFloors, HasBasement)
VALUES
    ('987 Elm St', 'Ottawa', 'ON', 'K1P5G1', 200, 1, 2, 'No');


INSERT INTO TownHouses(address, city, province, postalcode, numgarage, numfloors, hoafee)
VALUES
    ('789 Pine St', 'Calgary', 'AB', 'T2P1B3', 1, 3, 100);
INSERT INTO TownHouses(address, city, province, postalcode, numgarage, numfloors, hoafee)
VALUES
    ('159 Spruce St', 'Winnipeg', 'MB', 'R3C4G6', 0, 2, 150);


INSERT INTO Condos(address, city, province, postalcode, hoafee, unitnumber)
VALUES
    ('456 Oak St', 'Toronto', 'ON', 'M5H2N2', 500, 4);


INSERT INTO Apartments(address, city, province, postalcode, unitnumber)
VALUES
    ('753 Willow St', 'Halifax', 'NS', 'B3J3M8', 502);
INSERT INTO Apartments(address, city, province, postalcode, unitnumber)
VALUES
    ('654 Cedar St', 'Edmonton', 'AB', 'T5J1B7', 601);


INSERT INTO Amenities (Name, Type, Distance, Rating)
VALUES
    ('Central Park', 'Park', 0.5, 4.5);
INSERT INTO Amenities (Name, Type, Distance, Rating)
VALUES
    ('Vancouver Library', 'Library', 1.0, 4.8);
INSERT INTO Amenities (Name, Type, Distance, Rating)
VALUES
    ('Community Pool', 'Pool', 0.8, 4.2);
INSERT INTO Amenities (Name, Type, Distance, Rating)
VALUES
    ('Fitness Center', 'Gym', 1.5, 4.7);
INSERT INTO Amenities (Name, Type, Distance, Rating)
VALUES
    ('Shopping Mall', 'Mall', 2.0, 4.3);
INSERT INTO Amenities (Name, Type, Distance, Rating)
VALUES
    ('City Theater', 'Theater', 1.2, 4.6);



INSERT INTO Listings (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (1, '123 Maple St', 'V5K0A1', 'Active', 'rehnoorsaini@outlook.com', 550000, '2024-12-31', '2024-01-01');

INSERT INTO Listings (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (2, '456 Oak St', 'M5H2N2', 'Pending', 'samjane@hotmail.com', 350000, '2024-11-30', '2024-02-15');

INSERT INTO Listings (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (3, '789 Pine St', 'T2P1B3', 'Active', 'georgewash@laundry.com', 450000, '2024-10-15', '2024-03-10');

INSERT INTO Listings (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (4, '321 Birch St', 'H3Z2Y7', 'Active', 'willsmith@alaadin.com', 500000, '2024-09-30', '2024-04-20');

INSERT INTO Listings (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (5, '654 Cedar St', 'T5J1B7', 'Pending', 'sundarpichai@gmail.com', 400000, '2024-08-30', '2024-05-25');

INSERT INTO Listings (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (6, '987 Elm St', 'K1P5G1', 'Active', 'brettlee@rediffmail.com', 600000, '2024-07-31', '2024-06-15');


INSERT INTO Offers (OfferID, RealtorID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, SellerEmail, ListingID, Address, PostalCode)
VALUES (1, 1, 'Pending', '2024-03-01', '2024-03-15', 510000, 'samjane@hotmail.com', 'georgewash@laundry.com', 1, '123 Maple St', 'V5K0A1');
INSERT INTO Offers (OfferID, RealtorID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, SellerEmail, ListingID, Address, PostalCode)
VALUES (2, 2, 'Accepted', '2024-04-01', '2024-04-10', 310000, 'georgewash@laundry.com', 'samjane@hotmail.com', 2, '456 Oak St', 'M5H2N2');
INSERT INTO Offers (OfferID, RealtorID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, SellerEmail, ListingID, Address, PostalCode)
VALUES (3, 3, 'Pending', '2024-05-01', '2024-05-15', 460000, 'willsmith@alaadin.com', 'sundarpichai@gmail.com', 3, '789 Pine St', 'T2P1B3');
INSERT INTO Offers (OfferID, RealtorID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, SellerEmail, ListingID, Address, PostalCode)
VALUES (4, 4, 'Rejected', '2024-06-01', '2024-06-15', 360000, 'sundarpichai@gmail.com', 'brettlee@rediffmail.com', 4, '321 Birch St', 'H3Z2Y7');
INSERT INTO Offers (OfferID, RealtorID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, SellerEmail, ListingID, Address, PostalCode)
VALUES (5, 5, 'Pending', '2024-07-01', '2024-07-10', 560000, 'brettlee@rediffmail.com', 'stevesmith@google.com', 5, '654 Cedar St', 'T5J1B7');
INSERT INTO Offers (OfferID, RealtorID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, SellerEmail, ListingID, Address, PostalCode)
VALUES (6, 6, 'Accepted', '2024-08-01', '2024-08-10', 410000, 'stevesmith@google.com', 'willsmith@alaadin.com', 6, '987 Elm St', 'K1P5G1');

