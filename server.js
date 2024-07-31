const express = require('express');
const appService = require('./appService');
const appController = require('./appController');

// Load environment variables from .env file
// Ensure your .env file has the required database credentials.
const loadEnvFile = require('./utils/envUtil');
const envVariables = loadEnvFile('./.env');

const app = express();
const PORT = envVariables.PORT || 65534;  // Adjust the PORT if needed (e.g., if you encounter a "port already occupied" error)

// Middleware setup
app.use(express.json());            // Parse incoming JSON payloads
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded payloads

// Serve the login page as the entry point
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/login.html');
});

// Handle login form submission
app.post('/login.html', async (req, res) => {
    const { email } = req.body;
    console.log('Login Request Body:', req.body);

    try {
        const user = await appService.fetchUserByEmail(email);
        if (user) {
            res.send(`Logged in with email: ${email}`);
        } else {
            res.status(401).send('Invalid email');
        }
    } catch (error) {
        console.error('Error logging in:', error);
        res.status(500).send('An error occurred during login.');
    }
});

// Handle registration form submission
app.post('/register', async (req, res) => {
    const { email, name, phone, userType } = req.body;
    console.log('Registration Request Body:', req.body);

    try {
        const createUserResult = await appService.createUser(email, name, phone, userType);
        if (createUserResult) {
            res.json({ success: true, message: "User registered successfully." });
        } else {
            res.json({ success: false, message: "Failed to register user." });
        }
    } catch (error) {
        console.error('Error creating user:', error);
        res.json({ success: false, message: "An error occurred during registration." });
    }
});

// Mount the router
app.use('/', appController);

// ----------------------------------------------------------
// Starting the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});