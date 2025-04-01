// Initialize the test start time if it's not already set
if (!variable_global_exists("testStartTime")) {
    global.testStartTime = current_time; // Store the start time of the test
}

// Track elapsed time since the test started
var elapsedTime = current_time - global.testStartTime;

// Check if the 'I' key was pressed
if (!variable_global_exists("iKeyPressed")) {
    global.iKeyPressed = false; // Initialize as not pressed
}

// Check for the 'I' key press
if (keyboard_check_pressed(ord("I"))) {
    global.iKeyPressed = true;
}

// If the timer runs out, crash the game and log success
if (elapsedTime >= 20000) { // 20000 milliseconds = 20 seconds
    // Log the success message to the file
    var file = file_text_open_append(working_directory + "\\my_save.sav"); // Open the file in append mode
    
    // Add a separator line
    file_text_write_string(file, "--------------------------------------------");
    file_text_writeln(file);  
    
    // Write the success message
    file_text_write_string(file, "Timer successfully reached. No Collision errors found."); 
    // Write a new line
    file_text_writeln(file);  
    
    // Get the current date and time
    var datetime = date_current_datetime();
    
    // Get the year, month and day
    var year = string(date_get_year(datetime));
    var month = string(date_get_month(datetime));
    var day = string(date_get_day(datetime));
    
    // Ensure the month and day are two digits
    if (string_length(month) == 1) {
        month = "0" + month;
    }
    if (string_length(day) == 1) {
        day = "0" + day;
    }

    // Get the hour, minute and seconds
    var hour = string(date_get_hour(datetime));
    var minute = string(date_get_minute(datetime));
    var second = string(date_get_second(datetime));
    
    // Ensure hour, minute and seconds are two digits 
    if (string_length(hour) == 1) {
        hour = "0" + hour;
    }
    if (string_length(minute) == 1) {
        minute = "0" + minute;
    }
    if (string_length(second) == 1) {
        second = "0" + second;
    }

    // Format the date and time as YYYY-MM-DD HH:MM:SS
    var crash_datetime = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
    
    // Write the formatted date and time into the file
    file_text_write_string(file, "Crash date and time: " + crash_datetime);
    // Write a new line
    file_text_writeln(file);  
    
    // Write the player's coordinates into the file
    file_text_write_string(file, "Player position: (" + string(x) + ", " + string(y) + ")");
	// Write a new line
    file_text_writeln(file);  
    
    // Write whether the 'I' key was pressed or not
    if (global.iKeyPressed) {
        file_text_write_string(file, "The inventory was opened successfully.");
    } else {
        file_text_write_string(file, "The inventory failed to open.");
    }
	// Write a new line
    file_text_writeln(file);
    
    // Close the file after writing
    file_text_close(file);
    
    // Optionally show the error message and crash the game
    show_error("All tests passed! The game is crashing after 20 seconds.", true);
}

// Ensure the player moves automatically

// Store time to change direction
if (!variable_global_exists("changeTime")) {
    global.changeTime = current_time + irandom_range(1000, 3000); // Random time between 1-3 sec
}

// If it's time to change direction, pick a new one
if (current_time >= global.changeTime) {
    global.changeTime = current_time + irandom_range(1000, 3000);
    direction = irandom(359); // Picks a random direction
}

// Move the player automatically
hSpeed = lengthdir_x(walksp, direction);
vSpeed = lengthdir_y(walksp, direction);

// Handle collision
var collisionHappened = PlayerCollision();

// If collision happens, change direction
if (collisionHappened) {
    direction += 180; // Turn around
}

// Check if player is outside room bounds
if (x < 0 || x > 640 || y < 0 || y > 320) {
    // Log the crash details into a file (append mode)
    var file = file_text_open_append(working_directory + "\\my_save.sav"); // Open my_save.sav in append mode
    
    // Add a separator line for readability
    file_text_write_string(file, "--------------------------------------------");
    file_text_writeln(file);  
    
    // Write the crash message into the file
    file_text_write_string(file, "Player has left the room bounds! Crashing the game..."); 
    // Write a new line
    file_text_writeln(file);  
    
    // Get the current date and time
    var datetime = date_current_datetime();
    
    // Get the year, month and day
    var year = string(date_get_year(datetime));
    var month = string(date_get_month(datetime));
    var day = string(date_get_day(datetime));
    
    // Ensure the month and day are two digits
    if (string_length(month) == 1) {
        month = "0" + month;
    }
    if (string_length(day) == 1) {
        day = "0" + day;
    }

    // Get the hour, minute and seconds
    var hour = string(date_get_hour(datetime));
    var minute = string(date_get_minute(datetime));
    var second = string(date_get_second(datetime));
    
    // Ensure hour, minute and seconds are two digits 
    if (string_length(hour) == 1) {
        hour = "0" + hour;
    }
    if (string_length(minute) == 1) {
        minute = "0" + minute;
    }
    if (string_length(second) == 1) {
        second = "0" + second;
    }

    // Format the date and time as YYYY-MM-DD HH:MM:SS
    var crash_datetime = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
    
    // Write the formatted date and time into the file
    file_text_write_string(file, "Crash date and time: " + crash_datetime);
    // Write a new line
    file_text_writeln(file);  
    
    // Write the player's coordinates into the file
    file_text_write_string(file, "Player position: (" + string(x) + ", " + string(y) + ")");
	// Write a new line
    file_text_writeln(file);
    
    // Write whether the 'I' key was pressed or not
    if (global.iKeyPressed) {
        file_text_write_string(file, "The inventory was opened successfully.");
    } else {
        file_text_write_string(file, "The inventory failed to open.");
    }
	// Write a new line
    file_text_writeln(file);
    
    // Close the file after writing
    file_text_close(file);
    
    // Optionally show the error message
    show_error("Player has left the room bounds! Crashing the game...", true); 
}

// Animate player
var _oldSprite = sprite_index;
sprite_index = spriteRun;
if (_oldSprite != sprite_index) localFrame = 0;
PlayerAnimation();

// Have player alternate between Spacebar, Enter, and I key

// Initialize key toggle
if (!variable_global_exists("keyToggle")) {
    global.keyToggle = 0; // 0 = Space, 1 = Enter, 2 = I
    global.keyTimer = current_time + 1000; // Switch every second (adjust as needed)
}

// Check if it's time to switch keys
if (current_time >= global.keyTimer) {
    global.keyToggle = (global.keyToggle + 1) mod 3; 
	// Reset timer
    global.keyTimer = current_time + 1000; 
}

// Simulate key press
if (global.keyToggle == 0) {
   //keyboard_key_press(vk_space); // Simulate Spacebar
} else if (global.keyToggle == 1) {
    //keyboard_key_press(vk_enter); // Simulate Enter
} else {
    keyboard_key_press(ord("I")); // Simulate I key
}