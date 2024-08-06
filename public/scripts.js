 /*
 * These functions below are for various webpage functionalities. 
 * Each function serves to process data on the frontend:
 *      - Before sending requests to the backend.
 *      - After receiving responses from the backend.
 * 
 * To tailor them to your specific needs,
 * adjust or expand these functions to match both your 
 *   backend endpoints 
 * and 
 *   HTML structure.
 * 
 */


// This function checks the database connection and updates its status on the frontend.
async function checkDbConnection() {
    const statusElem = document.getElementById('dbStatus');
    const loadingGifElem = document.getElementById('loadingGif');

    const response = await fetch('/check-db-connection', {
        method: "GET"
    });

    // Hide the loading GIF once the response is received.
    loadingGifElem.style.display = 'none';
    // Display the statusElem's text in the placeholder.
    statusElem.style.display = 'inline';

    response.text()
    .then((text) => {
        statusElem.textContent = text;
    })
    .catch((error) => {
        statusElem.textContent = 'connection timed out';  // Adjust error handling if required.
    });
}

// Fetches data from the demotable and displays it.
async function fetchAndDisplayListings(minPrice, maxPrice, minBed, minBath, propType, minSpace, maxSpace, maxAge) {
    // const tableElement = document.getElementById('demotable');
    // const tableBody = tableElement.querySelector('tbody');
    const alllistingscontainer = document.getElementById('listings');

    const minBuiltYear = new Date().getFullYear() - maxAge;


    // window.location.href = `/ListingDetail?lid=${listingID}&address=${encodedAddr}&postalCode=${encodedPC}`;

    const response = await fetch(`/listings?minPrice=${minPrice}&maxPrice=${maxPrice}&minBed=${minBed}&minBath=${minBath}&propType=${propType}&minSpace=${minSpace}&maxSpace=${maxSpace}&minYear=${minBuiltYear}`, {
        method: 'GET'
    });

    const responseData = await response.json();
    const listingContent = responseData.data;

    if (listingContent.length <= 0) {
        alert("No listings match your criteria!");
    }

    listingContent.forEach(listing => {
        console.log(listing);
        const listingContainer = document.createElement('div');
        listingContainer.className = 'listing-container';
        const id = document.createElement('h3');
        const listingID = listing[0];
        id.textContent = "ListingID: " + listingID;
        const addrElt = document.createElement('h3');
        const addr = listing[1];
        addrElt.textContent = addr + ", " + listing[2] + ", " + listing[3];
        const price = document.createElement('h3');
        price.textContent = '$' + listing[4];
        const status = document.createElement('h3');
        status.textContent = listing[5];
        const baths = document.createElement('h3');
        baths.textContent = "Bath: " + listing[6];
        const beds = document.createElement('h3');
        beds.textContent = "Beds: " + listing[7];
        const detailsBtn = document.createElement("button");
        detailsBtn.textContent = "Details";
        const pc = listing[8];
        detailsBtn.onclick = function() {
            showListingDetails(listingID, addr, pc);
        };
        listingContainer.appendChild(id);
        listingContainer.appendChild(addrElt);
        listingContainer.appendChild(price);
        listingContainer.appendChild(beds);
        listingContainer.appendChild(baths);
        listingContainer.appendChild(status);
        listingContainer.appendChild(detailsBtn);
        alllistingscontainer.appendChild(listingContainer);
    })

}

function showListingDetails(listingID, addr, pc) {
    const encodedAddr = encodeURIComponent(addr);
    const encodedPC = encodeURIComponent(pc);
    window.location.href = `/ListingDetail?lid=${listingID}&address=${encodedAddr}&postalCode=${encodedPC}`;
}



function toggleFilters() {
    let filters = document.getElementById('filters');
    let btn = document.getElementById('showFilters');

    if (filters.style.display === 'none') {
        filters.style.display = 'block';
        btn.textContent = 'Hide Filters';
    } else {
        filters.style.display = 'none';
        btn.textContent = 'Show Filters';
    }
}

function handleFilters() {
    let listings = document.getElementById('listings');
    while (listings.firstChild) {
        listings.removeChild(listings.firstChild);
    }
    fetchListingData();
}

 async function checkUserType(){
     const response = await fetch(`/getUserType`, {
         method: 'GET'
     });

     const res = await response.json();
     const userType = res.uType;
     if (userType === 'buyer') {
         document.getElementById('create-listing-link').style.display = "none";
     } else {
         document.getElementById('create-listing-link').style.display = "block";
     }
 }


// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    checkDbConnection();
    checkUserType();
    fetchListingData();
    document.getElementById('filters').style.display = 'none';
    document.getElementById('showFilters').addEventListener("click", toggleFilters);
    document.getElementById('applyFiltersBtn').addEventListener("click", handleFilters);

    // document.getElementById("resetDemotable").addEventListener("click", resetDemotable);
    // document.getElementById("insertDemotable").addEventListener("submit", insertDemotable);
    // document.getElementById("updataNameDemotable").addEventListener("submit", updateNameDemotable);
    // document.getElementById("countDemotable").addEventListener("click", countDemotable);
};

// General function to refresh the displayed table data. 
// You can invoke this after any table-modifying operation to keep consistency.
function fetchListingData() {
    const minPrice = document.getElementById('minPrice').value;
    const maxPrice = document.getElementById('maxPrice').value;
    const minBed = document.getElementById('minBed').value;
    const minBath = document.getElementById('minBath').value;
    const propType = document.getElementById('propType').value;
    const minSpace = document.getElementById('minSpace').value;
    const maxSpace = document.getElementById('maxSpace').value;
    const maxAge = document.getElementById('maxAge').value;
    fetchAndDisplayListings(minPrice, maxPrice, minBed, minBath, propType, minSpace, maxSpace, maxAge);
}
