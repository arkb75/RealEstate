const express = require('express');
const appController = require('./appController');

// Load environment variables from .env file
// Ensure your .env file has the required database credentials.
const loadEnvFile = require('./utils/envUtil');
const envVariables = loadEnvFile('./.env');

const app = express();
const PORT = envVariables.PORT || 65534;  // Adjust the PORT if needed (e.g., if you encounter a "port already occupied" error)

// Middleware setup
app.use(express.static('public'));  // Serve static files from the 'public' directory
app.use(express.json());             // Parse incoming JSON payloads

// If you prefer some other file as default page other than 'index.html',
//      you can adjust and use the bellow line of code to
//      route to send 'DEFAULT_FILE_NAME.html' as default for root URL
// app.get('/', (req, res) => {
//     res.sendFile(__dirname + '/public/DEFAULT_FILE_NAME.html');
// });

// Serve the login page as the entry point
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/login.html');
});

// // Serve login and registration pages
// app.get('/login', (req, res) => {
//     res.sendFile(__dirname + '/public/login.html');
// });

// app.get('/register', (req, res) => {
//     res.sendFile(__dirname + '/public/register.html');
// });

// // Handle login form submission
// app.post('/login', (req, res) => {
//     const { email } = req.body;
//     // Implement login logic here (e.g., check database for user)
//     res.send(`Logged in with email: ${email}`);
// });

// // Handle registration form submission
// app.post('/register', (req, res) => {
//     const { email, name, phone, userType } = req.body;
//     // Implement registration logic here (e.g., save user to database)
//     res.send(`Registered with email: ${email}, name: ${name}, phone: ${phone}, user type: ${userType}`);
// });

// mount the router
app.use('/', appController);


// ----------------------------------------------------------
// Starting the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});

