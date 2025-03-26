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

// Ensure playerID exists
if (!variable_global_exists("playerID")) {
    playerID = "guest_" + string(irandom(999999)); // Generate a guest ID
}

// Start automatic saving every 30 seconds
alarm[0] = room_speed * 30;

