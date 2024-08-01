const express = require('express');
const appService = require('./appService');


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
    }
});

router.get('/ListingDetail', async (req, res) => {
    const listingId = req.query.lid;
    const addr = req.query.address;
    const pc = req.query.postalCode;
    // console.log(listingId);
    // console.log(addr);
    // console.log(pc);


    const propertyDetails = await appService.getPropertyDetails(listingId, addr, pc);
    res.render('ListingDetail', { property: propertyDetails });

    // res.render('ListingDetail', {
    //     property: propertyDetails,
    //     address: addr,
    //     postalCode: pc,
    //
    // });
});

// // GET route for the login page
// router.get('/login', (req, res) => {
//     res.sendFile('login.html', { root: './public' });
// });

// POST route for handling login
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
    const tableContent = await appService.fetchDemotableFromDb();
    res.json({data: tableContent});
});

router.post("/initiate-demotable", async (req, res) => {
    const initiateResult = await appService.initiateDemotable();
    if (initiateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.post("/insert-demotable", async (req, res) => {
    const { id, name } = req.body;
    const insertResult = await appService.insertDemotable(id, name);
    if (insertResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.post("/update-name-demotable", async (req, res) => {
    const { oldName, newName } = req.body;
    const updateResult = await appService.updateNameDemotable(oldName, newName);
    if (updateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.get('/count-demotable', async (req, res) => {
    const tableCount = await appService.countDemotable();
    if (tableCount >= 0) {
        res.json({ 
            success: true,  
            count: tableCount
        });
    } else {
        res.status(500).json({ 
            success: false, 
            count: tableCount
        });
    }
});

router.post('/appointments', async (req, res) => {
    const { status, realtorID, date, time, buyerEmail, meetingPlace } = req.body;

    try {
        const result = await appService.createAppointment(status, realtorID, date, time, buyerEmail, meetingPlace);

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


module.exports = router;