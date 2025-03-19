// Check if the player exists
if (instance_exists(obj_Player)) {
    // Use 'with' to execute PlayerCollision() in the context of obj_Player
    var _collision = false;
    with (obj_Player) {
        _collision = PlayerCollision(); // Call PlayerCollision function in obj_Player
    }

    // Check if the collision occurred
    if (_collision) {
        test_passed = true; // Set the test as passed if collision was detected
        show_debug_message("Test Passed: Collision Detected with the environment.");
    } else {
        test_passed = false;
    }
} else {
    // If the player doesn't exist, mark the test as failed
    test_passed = false;
    show_debug_message("Test Failed: Player instance missing.");
}
