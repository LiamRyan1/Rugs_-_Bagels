global.gamePaused = false;

// textSpeed for dialogue boxes
global.textSpeed = 0.75;

surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);

// Create obj_test_dialogue to run the tests
//instance_create_depth(0, 0, 0, obj_test_dialogue);



// Initialize Inventory if it doesn't exist
if (!variable_global_exists("myItems")) {
    myItems = ds_grid_create(5, 1); // 5 columns, 1 row
    ds_grid_set(myItems, 0, 0, 0);  // Mark first item slot as empty
}


// Initialize playerInv if it doesn't exist
if (!variable_global_exists("playerInv")) {
    playerInv = ds_grid_create(10, 10);  // Create a grid with 10 rows and 10 columns for inventory
    show_debug_message("playerInv initialized.");
}

// Ensure playerID exists and is properly initialized
if (!variable_global_exists("playerID")) {
    global.playerID = "undefined";  // Initialize playerID as "undefined" if not already set
}

// Start automatic saving every 30 seconds
alarm[0] = room_speed * 30;


var url = "https://rugsandbagels-default-rtdb.europe-west1.firebasedatabase.app/" + global.playerID + ".json";
global.loadRequestID = http_request(url, "GET", ds_map_create(), "http_request_callback");

show_debug_message("Request sent to: " + url);  // Debug to confirm the request was sent

