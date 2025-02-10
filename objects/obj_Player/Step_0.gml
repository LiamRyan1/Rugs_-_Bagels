// Only update player if the game is NOT paused
if (!global.gamePaused) {
    // Store boolean checks for keyboard input
    var _key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
    var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    var _key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
    var _key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));

    // Player angle and magnitude
    var pDirection = point_direction(0, 0, _key_right - _key_left, _key_down - _key_up);
    var pMagnitude = (_key_right - _key_left != 0) || (_key_down - _key_up != 0);

    hSpeed = lengthdir_x(pMagnitude * walksp, pDirection);
    vSpeed = lengthdir_y(pMagnitude * walksp, pDirection);

    // Handle collision and movement
    var collisionHappened = PlayerCollision();

    // Update sprite index
    var _oldSprite = sprite_index;
    if (pMagnitude != 0) {
        direction = pDirection;
        sprite_index = spriteRun;
    } else {
        sprite_index = spriteIdle;
    }

    // Reset local frame on sprite switch
    if (_oldSprite != sprite_index) local_Frame = 0;

    // Update animation only if not paused
    PlayerAnimation();
} else {
    // Stop movement when paused
    hSpeed = 0;
    vSpeed = 0;
}
