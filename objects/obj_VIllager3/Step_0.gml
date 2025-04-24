dialouge = global.welcome_dialogue;
event_inherited()

// When dialogue ends and timer hasn't started, start it
if (can_talk && !instance_exists(obj_Dialogue) && potion_timer == -1) {
    potion_timer = room_speed * 5; // Start 5-second timer (room_speed = 1 second)
}

// If timer is active, count down
if (potion_timer > 0) {
    potion_timer--;
}
