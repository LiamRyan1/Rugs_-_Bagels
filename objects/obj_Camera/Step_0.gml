for (var i = 0; i < 4; i++) {
    if (gamepad_is_connected(i)) {
        show_debug_message("Gamepad " + string(i) + " is connected.");
    }
}