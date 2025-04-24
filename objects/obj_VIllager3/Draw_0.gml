event_inherited(); // Keep inherited drawing behavior, if needed

// Draw the potion sprite if timer is active
if (potion_timer > 0) {
    draw_sprite(sWarning, 0, x, y - 16);
}
