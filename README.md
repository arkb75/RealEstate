# Project Description

The domain of the application is Real Estate Management and Transactions, which encompasses activities related to buying, selling, and managing real estate properties. This includes property listings, viewings, appointments with realtors, making offers, and completing transactions, integrating service providers such as inspectors and contractors to enhance the process.

The database models several key aspects of this domain. Users, including buyers, sellers, and realtors, are differentiated by roles with attributes like UserID, Name, Email, Phone, and Role. Properties are detailed with attributes such as PropertyID, Address, City, Province, PostalCode, InteriorSpace, NumBeds, NumBaths, PropertyType, YearBuilt, and PropertyCondition. Listings manage the properties on the market with attributes like ListingID, ListingDate, ExpirationDate, Status, SellerID, and PropertyID.

Appointments facilitate scheduling property viewings, including attributes such as AppointmentID, Date, Time, Status, BuyerID, RealtorID, and MeetingPlace. Offers track the negotiation process with attributes like OfferID, Date, Amount, Status, BuyerID, SellerID, RealtorID, and OfferExpiryDate. Realtors manage property listings and facilitate transactions, with attributes such as RealtorID, Name, Email, Phone, RealEstateFirm, and YearsOfExperience. Amenities associated with properties are modeled with attributes like Name, Type, Distance, and Rating. The ISA relationships specialize property types into Houses, Townhouses, Apartments, and Condos, each with specific attributes relevant to their type.

For example, first-time home buyers can use the platform to search for properties based on their preferences, schedule viewings, make offers, and contact service providers for inspections. Property sellers can list their properties, manage viewings, and receive offers. Real estate agents can efficiently manage multiple listings, appointments, and transactions. Investors can find and manage investment properties, and landlords can list rental properties and manage applications.

This comprehensive modeling supports the entire lifecycle of real estate transactions, making the application robust and user-friendly for real-life scenarios in the real estate market.

# Acknowledgments

We acknowledge the support and resources provided by the University of British Columbia's CPSC 304 course team. Their [sample project](https://github.students.cs.ubc.ca/CPSC304/CPSC304_Node_Project) served as a valuable reference for structuring our application and understanding the integration between Node.js and Oracle databases. We appreciate the efforts of instructors and TAs who provided feedback and support throughout the project development process.