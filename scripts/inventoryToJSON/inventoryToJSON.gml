function inventoryToJSON() {
    if (!variable_global_exists("playerInv") || playerInv == undefined) {
        show_debug_message("No items found in inventory, returning empty JSON.");
        return "{}"; // Return an empty JSON object if `playerInv` isn't initialized
    }

    var jsonString = "{";
    
    for (var i = 0; i < ds_grid_height(playerInv); i++) {
        var itemName = ds_grid_get(playerInv, 0, i);
        var itemAmount = ds_grid_get(playerInv, 1, i);
        
        if (itemName != 0) { // Ignore empty slots
            // Add itemName and itemAmount as a JSON pair
            jsonString += "\"" + itemName + "\": " + string(itemAmount);
            
            // Add a comma separator if it's not the last item
            if (i < ds_grid_height(playerInv) - 1) {
                jsonString += ", ";
            }
        }
    }
    
    jsonString += "}";  // Close the JSON object
    return jsonString;
}

function saveInventoryToFirebase() {
    var playerID = global.party[0].playerId;

    // Convert undefined to a string so Firebase can accept it
    if (playerID == undefined) {
        playerID = "undefined"; // Store under "/undefined.json" in Firebase
    }

    var url = "https://rugsandbagels-default-rtdb.europe-west1.firebasedatabase.app/" + playerID + ".json";
    var jsonData = inventoryToJSON();

    show_debug_message("Saving to Firebase under Player ID: " + playerID);
    show_debug_message("Data being sent: " + jsonData);
    
    http_request(url, "PUT", 1, jsonData);
}


function loadInventoryFromFirebase(playerID) {
    if (playerID == undefined) {
        playerID = "undefined";  // Use "undefined" if playerID is not provided
    }

    var url = "https://rugsandbagels-default-rtdb.europe-west1.firebasedatabase.app/" + playerID + ".json";
    
    // Make the HTTP request, and store the request ID
    global.loadRequestID = http_request(url, "GET", ds_map_create(), "http_request_callback");  // Correct callback reference
    show_debug_message("Requesting inventory from URL: " + url);
}

function http_request_callback(status, response, request_id) {
    show_debug_message("Callback triggered with request ID: " + string(request_id));  // Debug to see if it's triggered

    if (status == 200) {
        show_debug_message("Response from Firebase: " + response);  // Print the raw response
        var loadedData = json_parse(response);
        show_debug_message("Loaded data: " + string(loadedData));  // Print parsed data

        loadInventoryFromJSON(loadedData);  // Load inventory data into the grid
    } else {
        show_debug_message("Error loading inventory from Firebase: " + string(status));
    }
}

function loadInventoryFromJSON(loadedData) {
    // Check if loaded data exists
    if (loadedData == undefined) {
        show_debug_message("Loaded data is undefined!");
        return;
    }

    // Clear the existing inventory grid before loading new data
    ds_grid_clear(playerInv, 0); // Reset the grid
    
    // Resize the grid to match the number of items in the loaded data
    var numItems = ds_map_size(loadedData);  // Get the number of items
    if (numItems > ds_grid_height(playerInv)) {
        ds_grid_resize(playerInv, playerInvWidth, numItems); // Resize grid if necessary
    }

    // Initialize iterator for the map
    var key = ds_map_find_first(loadedData);  // Get the first key from the map
    var i = 0;

    // Iterate through all items in the map
    while (key != undefined) {
        // Get the item amount for the current item
        var itemAmount = loadedData[| key];  // Retrieve value (item amount) for current key (item name)

        // Add the item to the grid
        ds_grid_set(playerInv, 0, i, key);  // Set item name in column 0
        ds_grid_set(playerInv, 1, i, itemAmount);  // Set item amount in column 1

        // Move to the next item in the map (pass a reference variable to store the next key)
        key = ds_map_find_next(loadedData, key);  // Get the next key
        i++;  // Move to the next row in the grid
    }
}