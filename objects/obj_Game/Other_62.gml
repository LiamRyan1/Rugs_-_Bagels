// Async HTTP Event in obj_Game

if (async_load[? "id"] == global.loadRequestID) {  // Check if this is the correct request ID
    var result = async_load[? "result"];  // Get the result of the HTTP request
    var status = async_load[? "status"];  // Get the status of the HTTP request

    // Check if the request was successful (status 200)
    if (status != 200) {
        show_debug_message("Error: HTTP request failed with status: " + string(status));
        return;  // Exit if the request failed
    }

    // Check if result is undefined or empty
    if (is_undefined(result) || result == "") {
        show_debug_message("Error: No data received from Firebase.");
        return;  // Exit if no data is received
    }

    // Debug the raw result from Firebase
    show_debug_message("Raw response from Firebase: " + result);

    var jsonMap = json_parse(result);  // Parse the result as JSON

    // Check if jsonMap is undefined after parsing
    if (is_undefined(jsonMap)) {
        show_debug_message("Error: Failed to parse inventory data.");
        return;  // Stop further execution if jsonMap is undefined
    }

    // Debug the type of jsonMap (to check if it's a ds_map or struct)
    show_debug_message("Type of jsonMap: " + string(typeof(jsonMap)));

    // If jsonMap is a map (ds_map), proceed with loading inventory
    if (typeof(jsonMap) == type_ds_map) {
        if (ds_map_size(jsonMap) > 0) {
            ds_grid_clear(playerInv, 0);  // Clear the inventory grid

            var i = 0;
            var itemName, itemAmount;

            var keys = ds_map_keys(jsonMap);  // Get keys from the map
            var keyCount = ds_list_size(keys);  // Get the number of keys

            for (var j = 0; j < keyCount; j++) {
                itemName = ds_list_find_value(keys, j);  // Get item name
                itemAmount = jsonMap[? itemName];  // Get item amount for the current item

                // Ensure inventory grid is large enough
                if (i >= ds_grid_height(playerInv)) {
                    ds_grid_resize(playerInv, 10, i + 1);  // Resize grid if necessary (10 columns in this case)
                }

                // Add item to the inventory grid
                ds_grid_set(playerInv, 0, i, itemName);  // Set item name in column 0
                ds_grid_set(playerInv, 1, i, itemAmount);  // Set item amount in column 1

                i++;  // Move to the next row in the grid
            }

            ds_list_destroy(keys);  // Clean up list
            ds_map_destroy(jsonMap);  // Clean up map
            show_debug_message("Inventory loaded successfully!");  // Debug success
        } else {
            show_debug_message("Error: jsonMap is empty.");
        }
    } else {
        // Handle the case where jsonMap is not a ds_map (could be an array, string, etc.)
        show_debug_message("Error: jsonMap is not a ds_map. It is of type " + string(typeof(jsonMap)));
    }
}
