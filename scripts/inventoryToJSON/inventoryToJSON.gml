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

function saveInventoryToFirebase(playerID) {
    var url = "https://rugsandbagels-default-rtdb.europe-west1.firebasedatabase.app/" + playerID + ".json";
    var jsonData = inventoryToJSON();
    
    show_debug_message("Saving to Firebase: " + jsonData);  // Debug the final JSON before sending
    
    http_request(url, "PUT", 1, jsonData); // Sending JSON data with content type 1 (default)
}

