const express = require('express');
const appService = require('./appService');
let currReq;

const router = express.Router();
// ----------------------------------------------------------
// API endpoints
// Modify or extend these routes based on your project's needs.
router.get('/check-db-connection', async (req, res) => {
    const isConnect = await appService.testOracleConnection();
    if (isConnect) {
        res.send('connected');
    } else {
        res.send('unable to connect');
    }});

router.get('/getLoggedUser', async (req, res) => {
    const loggedUser = await appService.getLoggedUser();
    return loggedUser;
});

router.get('/getUserType', async (req, res) => {
    const loggedUser = await appService.getLoggedUser();
    const userType = loggedUser[3];
    res.json({uType: userType});
});

router.get('/ListingDetail', async (req, res) => {
    const listingId = req.query.lid;
    const addr = req.query.address;
    const pc = req.query.postalCode;
    currReq = req;

    const propertyDetails = await appService.getPropertyDetails(listingId, addr, pc);
    const loggedUser = await appService.getLoggedUser();
    const propAmenities = await appService.getAmenities(addr, pc);
    res.render('ListingDetail', {
        property: propertyDetails,
        user: loggedUser,
        amenities: propAmenities});
});

router.delete('/delete-listing', async (req, res) => {
    const address = req.query.address;
    const postalCode = req.query.postalCode;

    const response = await appService.deleteListing(address, postalCode);

    if (response.success) {
        res.json({
            success: true,
            address: response.addr
        });
    } else {
        res.json({success: false});
    }
})

router.get('/offer-details', async (req, res) => {
    const listingId = currReq.query.lid;
    const addr = currReq.query.address;
    const pc = currReq.query.postalCode;

    try {
        const loggedUser = await appService.getLoggedUser();

        const offerDetails = {
            offerDate: new Date().toISOString().split('T')[0],
            offerExpiryDate: new Date(new Date().setDate(new Date().getDate() + 30)).toISOString().split('T')[0],
            offerStatus: 'Pending',
            buyerEmail: loggedUser[1],
            listingID: listingId,
            address: addr,
            postalCode: pc
        };

        res.json(offerDetails);
    } catch (error) {
        console.error('Error fetching offer details:', error);
        res.status(500).json({ message: 'An error occurred while fetching offer details.' });
    }
});

router.post('/create-offer', async (req, res) => {
    const { offerAmount, buyerEmail, offerDate, offerExpiryDate, listingID, address, postalCode } = req.body;

    try {
        const result = await appService.createOffer(offerAmount, buyerEmail, offerDate, offerExpiryDate, listingID, address, postalCode);

        if (result.success) {
            res.json({
                success: true,
                message: 'Offer created successfully'
            });
        } else {
            res.status(400).json({
                success: false,
                message: result.message
            });
        }
    } catch (error) {
        console.error('Offer creation error:', error);
        res.status(500).json({
            success: false,
            message: 'An error occurred while creating the offer'
        });
    }
});

router.get('/offers', async (req, res) => {
    try {
        const listingID = currReq.query.lid;
        const offers = await appService.fetchOffersForListing(listingID);

        const offerDetails = offers.map(offer => ({
            offerID: offer[0],
            offerStatus: offer[1],
            offerDate: offer[2],
            offerExpiryDate: offer[5],
            offerAmount: offer[3],
            buyerEmail: offer[4],
            listingID: offer[6],
            address: offer[7],
            postalCode: offer[8]
        }));

        res.json(offerDetails);
    } catch (error) {
        console.error('Error fetching offers:', error);
        res.status(500).send('An error occurred while fetching offers.');
    }
});

router.post('/update-offer-status', async (req, res) => {
    const { offerID, status } = req.body;
    try {
        const result = await appService.updateOfferStatus(offerID, status);
        if (result) {
            res.json({ success: true, message: 'Offer status updated successfully.' });
        } else {
            res.status(400).json({ success: false, message: 'Failed to update offer status.' });
        }
    } catch (error) {
        console.error('Error updating offer status:', error);
        res.status(500).send('An error occurred while updating offer status.');
    }
});

router.post('/login', async (req, res) => {
    const { email } = req.body;

    try {
        const loginResult = await appService.authenticateUser(email);
        if (loginResult.success) {
            res.json({
                success: true,
                message: 'Login successful',
                redirectUrl: '/index.html'
            });
        } else {
            res.status(401).json({
                success: false,
                message: loginResult.message
            });
        }
    } catch (error) {
        console.error('Login error:', error);
        res.status(500).json({
            success: false,
            message: 'An error occurred during login'
        });
    }
});

router.post('/register', async (req, res) => {
    const { email, name, phone, userType, realtorID } = req.body;

    try {
        const result = await appService.registerUser(email, name, phone, userType, realtorID);
        res.json({ success: true, message: 'Registration successful' });
    } catch (error) {
        console.error('Registration error:', error);
        res.status(400).json({ success: false, message: error.message });
    }
});

router.get('/listings', async (req, res) => {
    const propType = req.query.propType;
    const minYear = req.query.minYear;
    const minPrice = req.query.minPrice;
    const maxPrice = req.query.maxPrice;
    const minBed = req.query.minBed;
    const minBath = req.query.minBath;
    const minSpace = req.query.minSpace;
    const maxSpace = req.query.maxSpace;
    const tableContent = await appService.fetchListingsFromDb(minPrice, maxPrice, minBed, minBath, propType, minSpace, maxSpace, minYear);
    res.json({data: tableContent});
});




router.post('/insert-listing', async (req, res) => {
    const {addr, pCode, city, prov, price, propType, propCond, nBeds, nBaths, yBuilt, space, ySpace, hGarage, hFloors, basement, tGarage, tFloors, tFee, cFee, cNum, aNum} = req.body;
    const listingInsertResult = await appService.insertListing(addr, pCode, city, prov, price, propType, propCond, nBeds, nBaths, yBuilt, space, ySpace, hGarage, hFloors, basement, tGarage, tFloors, tFee, cFee, cNum, aNum);
    if (listingInsertResult) {
        res.json({success: true});
    } else {
        res.status(500).json({success: false});
    }
})

router.post('/update-listing', async (req, res) => {
    const {addr, pCode, lid, price, nBeds, nBaths, yBuilt, space, ySpace, hGarage, hFloors, basement, tGarage, tFloors, tFee, cFee, cNum, aNum, pType} = req.body;
    const listingUpdateResult = await appService.updatePropertyDetails(addr, pCode, lid, price, nBeds, nBaths, yBuilt, space, ySpace, hGarage, hFloors, basement, tGarage, tFloors, tFee, cFee, cNum, aNum, pType);
    if (listingUpdateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
})



router.post('/appointments', async (req, res) => {
    const { date, time, meetingPlace } = req.body;

    try {
        const result = await appService.createAppointment(date, time, meetingPlace);

        if (result.success) {
            res.json({
                success: true,
                message: 'Appointment booked successfully'
            });
        } else {
            res.status(400).json({
                success: false,
                message: result.message
            });
        }
    } catch (error) {
        console.error('Appointment booking error:', error);
        res.status(500).json({
            success: false,
            message: 'An error occurred while booking the appointment'
        });
    }
});



// Fetch appointments based on user type
router.get('/appointments', async (req, res) => {
    try {
        const appointments = await appService.getAppointments();
        res.json({ success: true, appointments });
    } catch (error) {
        console.error('Error fetching appointments:', error);
        res.status(500).json({ success: false, message: 'Failed to fetch appointments' });
    }
});

// Cancel an appointment
router.post('/cancel-appointment', async (req, res) => {
    const { appointmentID } = req.body;
    try {
        const result = await appService.cancelAppointment(appointmentID);
        if (result.success) {
            res.json({ success: true, message: 'Appointment canceled successfully' });
        } else {
            res.status(400).json({ success: false, message: result.message });
        }
    } catch (error) {
        console.error('Error canceling appointment:', error);
        res.status(500).json({ success: false, message: 'Failed to cancel appointment' });
    }
});

module.exports = router;