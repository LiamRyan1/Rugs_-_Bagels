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
    // This will crash the game
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
