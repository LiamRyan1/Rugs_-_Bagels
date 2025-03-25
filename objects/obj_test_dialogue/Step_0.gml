// Dialogue appears once the room is opened. Spacebar ends the dialogue
// Check if spacebar is pressed and progress dialogue
if (keyboard_check_pressed(vk_space)) {
	// Check to see if we have an instance of obj_Dialogue in the room
    if (instance_exists(obj_Dialogue)) {
        obj_Dialogue.current_message++;
        show_debug_message("Current message: " + string(obj_Dialogue.current_message));
    }
}

// Declare a global variable to track if dialogue has ended
if (!variable_global_exists("dialogue_ended")) {
    global.dialogue_ended = false;
}

// Check if dialogue has finished and show the message only once
if (!instance_exists(obj_Dialogue) && !global.dialogue_ended) {
    show_debug_message("Dialogue ended.");
	// Set the flag to true to prevent further messages
    global.dialogue_ended = true; 
}
