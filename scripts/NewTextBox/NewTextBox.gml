function NewTextBox(_message, _background = 1) {
    var _obj;

    // Check if obj_Text exists, otherwise use obj_TextQueued
    if (instance_exists(obj_Text)) _obj = obj_TextQueued; 
    else _obj = obj_Text;

    // Ensure the layer exists
    var _layer = layer_get_id("Instances");
    if (_layer == -1) {
        show_debug_message("Error: Layer 'Instances' does not exist.");
        return; // Exit function if the layer is missing
    }

    // Create the text box instance
    with (instance_create_layer(x, y, _layer, _obj)) {
        message = _message; // Use function parameter instead of argument[0]

        if (instance_exists(other)) 
            originInstance = other.id; 
        else 
            originInstance = noone;

        background = _background; // Use default value if not provided
    }

    // Lock player movement while textbox is active
	with (obj_Player) {
		 if (state != PlayerStateLocked) {
			 lastState = state;  // Store current state before locking
			 state = PlayerStateLocked;
		 }
	}
}
