-- Drop all tables to reset the database
DROP TABLE APPOINTMENTS;
DROP TABLE OFFERS;
DROP TABLE LISTINGS;
DROP TABLE HOUSES;
DROP TABLE TOWNHOUSES;
DROP TABLE CONDOS;
DROP TABLE APARTMENTS;
DROP TABLE AMENITIES;
DROP TABLE PROPERTIES;
DROP TABLE USERS;
DROP TABLE REALTORS;



-- Create all tables for the DB

CREATE TABLE REALTORS (
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


CREATE TABLE USERS (
                       Name VARCHAR(255) NOT NULL,
                       Email VARCHAR(255) NOT NULL,
                       Phone INTEGER NOT NULL,
                       UserType VARCHAR2(20),
                       RealtorID INTEGER NOT NULL,
                       PRIMARY KEY (Email),
                       FOREIGN KEY (RealtorID) REFERENCES REALTORS(RealtorID)
                           ON DELETE CASCADE,
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

CREATE TABLE HOUSES (
                        Address VARCHAR(255) NOT NULL,
                        PostalCode CHAR(6) NOT NULL,
                        YardSize INTEGER NOT NULL,
                        NumGarage INTEGER,
                        NumFloors INTEGER NOT NULL,
                        HasBasement CHAR(3) NOT NULL,
                        PRIMARY KEY (Address, PostalCode),
                        FOREIGN KEY (Address, PostalCode) REFERENCES PROPERTIES(Address, PostalCode)
                            ON DELETE CASCADE
);

CREATE TABLE TOWNHOUSES (
                            Address VARCHAR(255) NOT NULL,
                            PostalCode CHAR(6) NOT NULL,
                            NumGarage INTEGER,
                            NumFloors INTEGER NOT NULL,
                            HOAFee INTEGER NOT NULL,
                            PRIMARY KEY (Address, PostalCode),
                            FOREIGN KEY (Address, PostalCode) REFERENCES PROPERTIES(Address, PostalCode)
                                ON DELETE CASCADE
);

CREATE TABLE CONDOS (
                        Address VARCHAR(255) NOT NULL,
                        PostalCode CHAR(6) NOT NULL,
                        HOAFee INTEGER NOT NULL,
                        UnitNumber INTEGER NOT NULL,
                        PRIMARY KEY (Address, PostalCode),
                        FOREIGN KEY (Address, PostalCode) REFERENCES PROPERTIES(Address, PostalCode)
                            ON DELETE CASCADE
);

CREATE TABLE APARTMENTS (
                            Address VARCHAR(255) NOT NULL,
                            PostalCode CHAR(6) NOT NULL,
                            UnitNumber INTEGER NOT NULL,
                            PRIMARY KEY (Address, PostalCode),
                            FOREIGN KEY (Address, PostalCode) REFERENCES PROPERTIES(Address, PostalCode)
                                ON DELETE CASCADE
);

CREATE TABLE AMENITIES (
                           Name VARCHAR(255) NOT NULL,
                           Type VARCHAR(20),
                           Distance INTEGER,
                           Rating INTEGER,
                           PropertyPostalCode CHAR(6),
                           PropertyAddress VARCHAR(255),
                           PRIMARY KEY (Name),
                           FOREIGN KEY (PropertyAddress, PropertyPostalCode) REFERENCES PROPERTIES(Address, PostalCode)
                               ON DELETE CASCADE
);


CREATE TABLE LISTINGS (
                          ListingID INTEGER NOT NULL,
                          Address VARCHAR(255) NOT NULL,
                          PostalCode CHAR(6) NOT NULL,
                          ListingStatus CHAR(9) NOT NULL,
                          SellerEmail VARCHAR(255) NOT NULL,
                          ListingPrice INTEGER NOT NULL,
                          ExpirationDate CHAR(10),
                          ListingDate CHAR(10) NOT NULL,
                          PRIMARY KEY (ListingID, Address, PostalCode),
                          FOREIGN KEY (SellerEmail) REFERENCES USERS
                              ON DELETE CASCADE,
                          FOREIGN KEY (Address, PostalCode) REFERENCES PROPERTIES(Address, PostalCode)
                              ON DELETE CASCADE
);

CREATE TABLE OFFERS (
                        OfferID INTEGER NOT NULL,
                        OfferStatus CHAR(8) NOT NULL,
                        OfferDate CHAR(10) NOT NULL,
                        OfferAmount INTEGER NOT NULL,
                        BuyerEmail VARCHAR(255) NOT NULL,
                        OfferExpiryDate CHAR(10) NOT NULL,
                        ListingID INTEGER NOT NULL,
                        Address VARCHAR(255) NOT NULL,
                        PostalCode CHAR(6) NOT NULL,
                        PRIMARY KEY (OfferID),
                        UNIQUE (OfferDate, OfferAmount, BuyerEmail, ListingID),
                        FOREIGN KEY (BuyerEmail) REFERENCES USERS
                            ON DELETE CASCADE,
                        FOREIGN KEY (ListingID, Address, PostalCode) REFERENCES LISTINGS(ListingID, Address, PostalCode)
                            ON DELETE CASCADE
);

-- Creating the Appointments table
CREATE TABLE APPOINTMENTS (
                              AppointmentID INTEGER NOT NULL,
                              AppointmentStatus CHAR(9) NOT NULL,
                              AppointmentDate CHAR(10) NOT NULL,
                              AppointmentTime CHAR(5) NOT NULL,
                              BuyerEmail VARCHAR(255) NOT NULL,
                              MeetingPlace VARCHAR(255) Not NULL,
                              ListingID INTEGER NOT NULL,
                              Address VARCHAR(255) NOT NULL,
                              PostalCode CHAR(6) NOT NULL,
                              PRIMARY KEY (AppointmentID),
                              UNIQUE (AppointmentDate, AppointmentTime, BuyerEmail),
                              FOREIGN KEY (BuyerEmail) REFERENCES USERS
                                  ON DELETE CASCADE,
                              FOREIGN KEY (ListingID, Address, PostalCode) REFERENCES LISTINGS
                                  ON DELETE CASCADE
);


-- INSERT values into the database tables


INSERT INTO REALTORS (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (1, 'Emily Brown', 'emilybrown@gmail.com', 3456789012, 5, 'Dream Homes Realty');
INSERT INTO REALTORS (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (2, 'Michael Johnson', 'michaeljohnson@gmail.com', 4567890123, 8, 'Premium Estates');
INSERT INTO REALTORS (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (3, 'Sarah Green', 'sarahgreen@gmail.com', 5678901234, 4, 'Top Choice Realty');
INSERT INTO REALTORS (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (4, 'David Wilson', 'davidwilson@gmail.com', 6789012345, 10, 'Elite Realty Group');
INSERT INTO REALTORS (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (5, 'Jessica Taylor', 'jessicataylor@gmail.com', 7890123456, 7, 'Star Real Estate');
INSERT INTO REALTORS (RealtorID, Name, Email, Phone, YearsOfExperience, RealEstateFirm)
VALUES
    (6, 'Daniel White', 'danielwhite@gmail.com', 8901234567, 6, 'Prime Properties');





INSERT INTO USERS(Name, Email, Phone, UserType, RealtorID) VALUES ('Rehnoor', 'rehnoorsaini@outlook.com', 4316885656, 'buyer', 1);
INSERT INTO USERS(Name, Email, Phone, UserType, RealtorID) VALUES ('Sam Jane', 'samjane@hotmail.com', 1234567890, 'seller', 1);
INSERT INTO USERS(Name, Email, Phone, UserType, RealtorID)  VALUES ('George Washington', 'georgewash@laundry.com', 2234567990, 'buyer', 2);
INSERT INTO USERS(Name, Email, Phone, UserType, RealtorID)  VALUES ('Will Smith', 'willsmith@alaadin.com', 1237867893, 'seller', 3);
INSERT INTO USERS(Name, Email, Phone, UserType, RealtorID)  VALUES ('Sundar Pichai', 'sundarpichai@gmail.com', 2354557899, 'buyer', 4);
INSERT INTO USERS(Name, Email, Phone, UserType, RealtorID)  VALUES ('Brett Lee', 'brettlee@rediffmail.com', 5154447890, 'seller', 5);
INSERT INTO USERS(Name, Email, Phone, UserType, RealtorID)  VALUES ('Steve Smith', 'stevesmith@google.com', 2345678901, 'buyer', 6);



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



INSERT INTO HOUSES(Address, PostalCode, YardSize, NumGarage, NumFloors, HasBasement)
VALUES
    ('123 Maple St', 'V5K0A1', 1000, 2, 2, 'Yes');
INSERT INTO HOUSES(Address, PostalCode, YardSize, NumGarage, NumFloors, HasBasement)
VALUES
    ('321 Birch St', 'H3Z2Y7', 800, 1, 2, 'Yes');
INSERT INTO HOUSES(Address, PostalCode, YardSize, NumGarage, NumFloors, HasBasement)
VALUES
    ('987 Elm St', 'K1P5G1', 200, 1, 2, 'No');


INSERT INTO TOWNHOUSES(address, postalcode, numgarage, numfloors, hoafee)
VALUES
    ('789 Pine St', 'T2P1B3', 1, 3, 100);
INSERT INTO TOWNHOUSES(address, postalcode, numgarage, numfloors, hoafee)
VALUES
    ('159 Spruce St', 'R3C4G6', 0, 2, 150);


INSERT INTO CONDOS(address, postalcode, hoafee, unitnumber)
VALUES
    ('456 Oak St', 'M5H2N2', 500, 4);


INSERT INTO APARTMENTS(address, postalcode, unitnumber)
VALUES
    ('753 Willow St', 'B3J3M8', 502);
INSERT INTO APARTMENTS(address, postalcode, unitnumber)
VALUES
    ('654 Cedar St', 'T5J1B7', 601);




INSERT INTO AMENITIES(Name, Type, Distance, Rating, PropertyPostalCode, PropertyAddress)
VALUES
    ('Central Park', 'Park', 0.5, 4.5, 'B3J3M8', '753 Willow St');
INSERT INTO AMENITIES(Name, Type, Distance, Rating, PropertyPostalCode, PropertyAddress)
VALUES
    ('Vancouver Library', 'Library', 1.0, 4.8, 'V5K0A1', '123 Maple St');
INSERT INTO AMENITIES(Name, Type, Distance, Rating, PropertyPostalCode, PropertyAddress)
VALUES
    ('Community Pool', 'Pool', 0.8, 4.2, 'T2P1B3', '789 Pine St');
INSERT INTO AMENITIES(Name, Type, Distance, Rating, PropertyPostalCode, PropertyAddress)
VALUES
    ('Fitness Center', 'Gym', 1.5, 4.7, 'R3C4G6', '159 Spruce St');
INSERT INTO AMENITIES(Name, Type, Distance, Rating, PropertyPostalCode, PropertyAddress)
VALUES
    ('Shopping Mall', 'Mall', 2.0, 4.3, 'B3J3M8', '753 Willow St');
INSERT INTO AMENITIES(Name, Type, Distance, Rating, PropertyPostalCode, PropertyAddress)
VALUES
    ('City Theater', 'Theater', 1.2, 4.6, 'T2P1B3', '789 Pine St');



INSERT INTO LISTINGS (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (1, '123 Maple St', 'V5K0A1', 'Active', 'rehnoorsaini@outlook.com', 550000, '2024-12-31', '2024-01-01');

INSERT INTO LISTINGS (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (2, '456 Oak St', 'M5H2N2', 'Pending', 'samjane@hotmail.com', 350000, '2024-11-30', '2024-02-15');

INSERT INTO LISTINGS (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (3, '789 Pine St', 'T2P1B3', 'Active', 'georgewash@laundry.com', 450000, '2024-10-15', '2024-03-10');

INSERT INTO LISTINGS (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (4, '321 Birch St', 'H3Z2Y7', 'Active', 'willsmith@alaadin.com', 500000, '2024-09-30', '2024-04-20');

INSERT INTO LISTINGS (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (5, '654 Cedar St', 'T5J1B7', 'Pending', 'sundarpichai@gmail.com', 400000, '2024-08-30', '2024-05-25');

INSERT INTO LISTINGS (ListingID, Address, PostalCode, ListingStatus, SellerEmail, ListingPrice, ExpirationDate, ListingDate)
VALUES
    (6, '987 Elm St', 'K1P5G1', 'Active', 'brettlee@rediffmail.com', 600000, '2024-07-31', '2024-06-15');



INSERT INTO APPOINTMENTS (AppointmentID, AppointmentDate, AppointmentTime, MeetingPlace, BuyerEmail, ListingID, Address, PostalCode, AppointmentStatus)
VALUES
    (1, '2024-03-05', '10:00', '123 Elm St', 'samjane@hotmail.com', 1, '123 Maple St', 'V5K0A1', 'Scheduled');
INSERT INTO APPOINTMENTS (AppointmentID, AppointmentDate, AppointmentTime, MeetingPlace, BuyerEmail, ListingID, Address, PostalCode, AppointmentStatus)
VALUES
    (2, '2024-04-05', '14:00', '456 Oak St', 'georgewash@laundry.com', 2, '456 Oak St', 'M5H2N2', 'Completed');
INSERT INTO APPOINTMENTS (AppointmentID, AppointmentDate, AppointmentTime, MeetingPlace, BuyerEmail, ListingID, Address, PostalCode, AppointmentStatus)
VALUES
    (3, '2024-05-10', '11:00', '789 Pine St', 'willsmith@alaadin.com', 3, '789 Pine St', 'T2P1B3', 'Scheduled');
INSERT INTO APPOINTMENTS (AppointmentID, AppointmentDate, AppointmentTime, MeetingPlace, BuyerEmail, ListingID, Address, PostalCode, AppointmentStatus)
VALUES
    (4, '2024-06-10', '15:00', '321 Maple St', 'sundarpichai@gmail.com', 4,'321 Birch St', 'H3Z2Y7', 'Cancelled');
INSERT INTO APPOINTMENTS (AppointmentID, AppointmentDate, AppointmentTime, MeetingPlace, BuyerEmail, ListingID, Address, PostalCode, AppointmentStatus)
VALUES
    (5, '2024-07-15', '09:00', '654 Birch St', 'brettlee@rediffmail.com', 5, '654 Cedar St', 'T5J1B7', 'Scheduled');
INSERT INTO APPOINTMENTS (AppointmentID, AppointmentDate, AppointmentTime, MeetingPlace, BuyerEmail, ListingID, Address, PostalCode, AppointmentStatus)
VALUES
    (6, '2024-08-20', '13:00', '987 Cedar St', 'stevesmith@google.com', 6, '987 Elm St', 'K1P5G1', 'Completed');





INSERT INTO OFFERS (OfferID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, ListingID, Address, PostalCode)
VALUES (1, 'Pending', '2024-03-01', '2024-03-15', 510000, 'samjane@hotmail.com', 1, '123 Maple St', 'V5K0A1');
INSERT INTO OFFERS (OfferID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, ListingID, Address, PostalCode)
VALUES (2, 'Accepted', '2024-04-01', '2024-04-10', 310000, 'georgewash@laundry.com', 2, '456 Oak St', 'M5H2N2');
INSERT INTO OFFERS (OfferID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, ListingID, Address, PostalCode)
VALUES (3, 'Pending', '2024-05-01', '2024-05-15', 460000, 'willsmith@alaadin.com', 3, '789 Pine St', 'T2P1B3');
INSERT INTO OFFERS (OfferID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, ListingID, Address, PostalCode)
VALUES (4, 'Rejected', '2024-06-01', '2024-06-15', 360000, 'sundarpichai@gmail.com', 4, '321 Birch St', 'H3Z2Y7');
INSERT INTO OFFERS (OfferID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, ListingID, Address, PostalCode)
VALUES (5, 'Pending', '2024-07-01', '2024-07-10', 560000, 'brettlee@rediffmail.com', 5, '654 Cedar St', 'T5J1B7');
INSERT INTO OFFERS (OfferID, OfferStatus, OfferDate, OfferExpiryDate, OfferAmount, BuyerEmail, ListingID, Address, PostalCode)
VALUES (6, 'Accepted', '2024-08-01', '2024-08-10', 410000, 'stevesmith@google.com', 6, '987 Elm St', 'K1P5G1');

