// obj_Qelline Step Event

// Choose which dialogue to use based on the flag
if(!ds_map_find_value(global.dialogue_flags, "qellinePreFight_done") && instance_exists(obj_Skeleton)) {
    dialog = global.qellinePreFight_dialogue;
}
else if (ds_map_find_value(global.dialogue_flags, "qellinePreFight_done")
&& !instance_exists(obj_Skeleton) 
&& !ds_map_find_value(global.dialogue_flags,"qellinePostFight_done"))
&& global.forestcleared == false{
    dialog = global.qellinePostFight_dialogue;
}
else if(!ds_map_find_value(global.dialogue_flags, "qellinePreFight_done") 
&& !instance_exists(obj_Skeleton) 
&& !ds_map_find_value(global.dialogue_flags, "qellinePostFightClearedNeverTalked_done")
&& global.forestcleared == false)
{
	dialog = global.qellinePostFightNeverTalked_dialogue;
}
else if( !instance_exists(obj_Skeleton) 
&& !ds_map_find_value(global.dialogue_flags, "qellinePostFightClearedNeverTalked_done")
&& !ds_map_find_value(global.dialogue_flags,"qellinePostFight_done")
&& global.forestcleared == true
&& !instance_exists(obj_Skeleton)
&& !ds_map_find_value(global.dialogue_flags, "qellinePreFight_done"))
{
	dialog = global.qellinePostFightNeverTalkedForestCleared_dialogue;
}
else if((ds_map_find_value(global.dialogue_flags, "qellinePostFight_done") 
|| ds_map_find_value(global.dialogue_flags, "qellinePostFightClearedNeverTalked_done")) 
&& !ds_map_find_value(global.dialogue_flags, "qellinePostForestCleared_done") 
&& global.forestcleared == true 
&& !ds_map_find_value(global.dialogue_flags, "qellinePostFightNeverTalkedForestCleared_done")
&& !instance_exists(obj_Skeleton))
{
	show_debug_message("Forset is Cleared: " + string(global.forestcleared))
	dialog = global.qellinePostForestCleared_dialogue;
}
show_debug_message("Forset is Cleared: " + string(global.forestcleared))
show_debug_message("Forset is Cleared dialouge: " + string(ds_map_find_value(global.dialogue_flags, "qellinePostForestCleared_done")))

event_inherited();

// When dialogue ends and timer hasn't started, start it
if (can_talk && !instance_exists(obj_Dialogue) && warning_timer == -1) {
    warning_timer = room_speed * 5; // Start 5-second timer (room_speed = 1 second)
}

// If timer is active, count down
if (warning_timer > 0) {
    warning_timer--;
}
