// obj_Qelline Step Event

// Choose which dialogue to use based on the flag
if (ds_map_find_value(global.dialogue_flags, "qellinePreFight_done") && !instance_exists(obj_Skeleton)) {
    dialog = global.qellinePostFight_dialogue;
} else {
    dialog = global.qellinePreFight_dialogue;
}

event_inherited();

// When dialogue ends and timer hasn't started, start it
if (can_talk && !instance_exists(obj_Dialogue) && warning_timer == -1) {
    warning_timer = room_speed * 5; // Start 5-second timer (room_speed = 1 second)
}

// If timer is active, count down
if (warning_timer > 0) {
    warning_timer--;
}
