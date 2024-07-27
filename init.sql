DROP TABLE USERS;
DROP TABLE PROPERTIES;

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



