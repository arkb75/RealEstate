const oracledb = require('oracledb');
const loadEnvFile = require('./utils/envUtil');
let loggedUser;

const envVariables = loadEnvFile('./.env');

// Database configuration setup. Ensure your .env file has the required database credentials.
const dbConfig = {
    user: envVariables.ORACLE_USER,
    password: envVariables.ORACLE_PASS,
    connectString: `${envVariables.ORACLE_HOST}:${envVariables.ORACLE_PORT}/${envVariables.ORACLE_DBNAME}`,
    poolMin: 1,
    poolMax: 3,
    poolIncrement: 1,
    poolTimeout: 60
};

// initialize connection pool
async function initializeConnectionPool() {
    try {
        await oracledb.createPool(dbConfig);
        console.log('Connection pool started');
    } catch (err) {
        console.error('Initialization error: ' + err.message);
    }
}

async function closePoolAndExit() {
    console.log('\nTerminating');
    try {
        await oracledb.getPool().close(10); // 10 seconds grace period for connections to finish
        console.log('Pool closed');
        process.exit(0);
    } catch (err) {
        console.error(err.message);
        process.exit(1);
    }
}

initializeConnectionPool();

process
    .once('SIGTERM', closePoolAndExit)
    .once('SIGINT', closePoolAndExit);


// ----------------------------------------------------------
// Wrapper to manage OracleDB actions, simplifying connection handling.
async function withOracleDB(action) {
    let connection;
    try {
        connection = await oracledb.getConnection(); // Gets a connection from the default pool 
        return await action(connection);
    } catch (err) {
        console.error(err);
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}

// ----------------------------------------------------------
// Core functions for database operations
// Modify these functions, especially the SQL queries, based on your project's requirements and design.
async function testOracleConnection() {
    return await withOracleDB(async (connection) => {
        return true;
    }).catch(() => {
        return false;
    });
}

async function fetchListingsFromDb() {
    return await withOracleDB(async (connection) => {
        if (loggedUser[3] === 'seller') {
            const sellerEmail = loggedUser[1];
            const query = `
            SELECT ListingID, Address, PostalCode, ListingPrice, ListingStatus
            FROM LISTINGS
            WHERE SellerEmail = :sellerEmail
        `;
            const result = await connection.execute(query, {
                sellerEmail: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: sellerEmail }
            });
            console.log(result.rows);
            return result.rows;
        } else {
            return await withOracleDB(async (connection) => {
                const result = await connection.execute('SELECT ListingID, Address, PostalCode, ListingPrice, ListingStatus FROM LISTINGS');
                return result.rows;
            }).catch(() => {
                return [];
            });
        }
    })
}

async function getPropertyDetails(listingId, addr, pc) {
    return await withOracleDB(async (connection) => {
        const propertyQuery = `
            SELECT *
            FROM PROPERTIES
            WHERE ADDRESS = :addr AND POSTALCODE = :pc
        `;
        const listingQuery = `
            SELECT ListingID, ListingStatus, SellerEmail, ListingPrice 
            FROM LISTINGS 
            WHERE Address = :addr AND PostalCode = :pc AND ListingID = :listingId
        `;

        const propertyResult = await connection.execute(propertyQuery, {
            addr: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: addr },
            pc: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: pc }
        });

        const listingResult = await connection.execute(listingQuery, {
            addr: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: addr },
            pc: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: pc },
            ListingID: { dir: oracledb.BIND_IN, type: oracledb.NUMBER, val: parseInt(listingId, 10) }
        });


        const LR = listingResult.rows[0];
        const PR = propertyResult.rows[0];

        const propertyInfo = LR.concat(PR);

        const sEmail = propertyInfo[2];

        const getRealtorInfo = `
        SELECT * 
        FROM REALTORS r
        WHERE r.RealtorID IN
            (SELECT RealtorID
            FROM USERS 
            WHERE Email = :sEmail)
        `;

        const realtorResult = await connection.execute(getRealtorInfo, {
            sEmail: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: sEmail }
        });

        const PI = propertyInfo.concat(realtorResult.rows[0]);
        let additionalInfo;
        const propertyType = PI[7];
        switch (propertyType) {
            case 'House':
                const Hquery = `
                    SELECT YardSize, NumGarage, NumFloors, HasBasement
                    FROM Houses 
                    WHERE Address = :addr AND PostalCode = :pc
                `;

                const Hresult = await connection.execute(Hquery, {
                    addr: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: addr },
                    pc: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: pc }
                });
                additionalInfo = Hresult.rows[0];
                break;
            case 'Apartment':
                const Aquery = `
                    SELECT unitnumber
                    FROM Apartments 
                    WHERE Address = :addr AND PostalCode = :pc
                `;

                const Aresult = await connection.execute(Aquery, {
                    addr: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: addr },
                    pc: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: pc }
                });
                additionalInfo = Aresult.rows[0];
                break;
            case 'Townhouse':
                const Tquery = `
                    SELECT numgarage, numfloors, hoafee
                    FROM Townhouses 
                    WHERE Address = :addr AND PostalCode = :pc
                `;

                const Tresult = await connection.execute(Tquery, {
                    addr: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: addr },
                    pc: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: pc }
                });
                additionalInfo = Tresult.rows[0];
                break;
            default: //This MUST be condo
                const Cquery = `
                    SELECT hoafee, unitnumber
                    FROM Condos 
                    WHERE Address = :addr AND PostalCode = :pc
                `;

                const Cresult = await connection.execute(Cquery, {
                    addr: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: addr },
                    pc: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: pc }
                });
                additionalInfo = Cresult.rows[0];
                break;
        }

        const result = PI.concat(additionalInfo);
        console.log(result);

        return result;
    }).catch(() => {
        console.log("uh oh stinky");
        return [];
    });
}


async function initiateDemotable() {
    return await withOracleDB(async (connection) => {
        try {
            await connection.execute(`DROP TABLE DEMOTABLE`);
        } catch(err) {
            console.log('Table might not exist, proceeding to create...');
        }

        const result = await connection.execute(`
            CREATE TABLE DEMOTABLE (
                id NUMBER PRIMARY KEY,
                name VARCHAR2(20)
            )
        `);
        return true;
    }).catch(() => {
        return false;
    });
}

async function insertDemotable(id, name) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `INSERT INTO DEMOTABLE (id, name) VALUES (:id, :name)`,
            [id, name],
            { autoCommit: true }
        );

        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

async function updateNameDemotable(oldName, newName) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `UPDATE DEMOTABLE SET name=:newName where name=:oldName`,
            [newName, oldName],
            { autoCommit: true }
        );

        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

async function countDemotable() {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute('SELECT Count(*) FROM DEMOTABLE');
        return result.rows[0][0];
    }).catch(() => {
        return -1;
    });
}
async function authenticateUser(email, password) {
    return await withOracleDB(async (connection) => {
        const query = 'SELECT * FROM USERS WHERE EMAIL = :email';

        const result = await connection.execute(query, {
            email: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: email },
        });

        if (result.rows.length > 0) {
            loggedUser = result.rows[0];
            return { success: true, user: result.rows[0] };
        } else {
            return { success: false, message: 'Invalid email' };
        }
    }).catch((error) => {
        console.error('Authentication error:', error);
        return { success: false, message: 'An error occurred during authentication' };
    });
}

async function registerUser(email, name, phone, userType, realtorID) {
    return await withOracleDB(async (connection) => {
        // First, check if the email already exists
        const checkUserQuery = `SELECT Email FROM USERS WHERE Email = :email`;
        const checkResult = await connection.execute(checkUserQuery, [email]);

        if (checkResult.rows.length > 0) {
            throw new Error('User with this email already exists');
        }

        // Check if the realtorID exists
        const checkRealtorQuery = `SELECT RealtorID FROM REALTORS WHERE RealtorID = :realtorID`;
        const realtorResult = await connection.execute(checkRealtorQuery, [realtorID]);

        if (realtorResult.rows.length === 0) {
            throw new Error('Invalid Realtor ID');
        }

        // Insert the new user
        const insertQuery = `
            INSERT INTO USERS (Name, Email, Phone, UserType, RealtorID)
            VALUES (:name, :email, :phone, :userType, :realtorID)
        `;

        const result = await connection.execute(
            insertQuery,
            [name, email, phone, userType, realtorID],
            { autoCommit: true }
        );

        if (result.rowsAffected && result.rowsAffected === 1) {
            return true;
        } else {
            throw new Error('Failed to register user');
        }
    }).catch((error) => {
        console.error('Error in registerUser:', error);
        throw error;
    });
}

async function createAppointment(status, realtorID, date, time, buyerEmail, meetingPlace) {
    return await withOracleDB(async (connection) => {
        const insertQuery = `
            INSERT INTO Appointments (Status, RealtorID, Date, Time, BuyerEmail, MeetingPlace)
            VALUES (:status, :realtorID, :date, :time, :buyerEmail, :meetingPlace)
        `;

        const result = await connection.execute(
            insertQuery,
            { status, realtorID, date, time, buyerEmail, meetingPlace },
            { autoCommit: true }
        );

        if (result.rowsAffected && result.rowsAffected > 0) {
            return { success: true };
        } else {
            throw new Error('Failed to create appointment');
        }
    }).catch((error) => {
        console.error('Error creating appointment:', error);
        return { success: false, message: 'Failed to create appointment' };
    });
}

async function getAmenities(addr, pc) {
    return await withOracleDB(async (connection) => {
        const query = `
            SELECT *
            FROM AMENITIES
            WHERE PropertyPostalCode = :pc AND PropertyAddress = :addr
        `;
        const result = await connection.execute(query, {
            addr: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: addr },
            pc: { dir: oracledb.BIND_IN, type: oracledb.STRING, val: pc }
        });
        return result.rows;
    })
}

function getLoggedUser() {
    return loggedUser;
}



module.exports = {
    getPropertyDetails,
    testOracleConnection,
    fetchListingsFromDb,
    initiateDemotable, 
    insertDemotable, 
    updateNameDemotable,
    authenticateUser,
    registerUser,
    countDemotable,
    createAppointment,
    getLoggedUser,
    getAmenities,
};