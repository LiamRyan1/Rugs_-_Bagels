// obj_Qelline Step Event
// Choose which dialogue to use based on the flag
var _preDone = ds_map_find_value(global.dialogue_flags, "qellinePreFight_done");
var _postDone = ds_map_find_value(global.dialogue_flags, "qellinePostFight_done");
var _postNeverTalkedDone = ds_map_find_value(global.dialogue_flags, "qellinePostFightClearedNeverTalked_done");
var _postForestClearedDone = ds_map_find_value(global.dialogue_flags, "qellinePostForestCleared_done");
var _postNeverTalkedForestClearedDone = ds_map_find_value(global.dialogue_flags, "qellinePostFightNeverTalkedForestCleared_done");
var _skeletonExists = instance_exists(obj_Skeleton);
var _forestCleared = global.forestcleared;

//talk before fighting in the village
if(!_preDone && _skeletonExists) {
    dialog = global.qellinePreFight_dialogue;
}
//talk after fight in the village having talked before
else if (_preDone && !_skeletonExists && !_forestCleared)
{
	show_debug_message("running post fight");
    dialog = global.qellinePostFight_dialogue;
}
//talk after having fought in the village having never talked before
else if(!_preDone && !_skeletonExists  && !_forestCleared)
{
	dialog = global.qellinePostFightNeverTalked_dialogue;
}
//talked to before killing the skele in the village then killed all skeletons in village and forest before talking again
else if((_postDone || _postNeverTalkedDone) && !_postForestClearedDone  && !_postNeverTalkedForestClearedDone  && _forestCleared)
{
	show_debug_message("Forset is Cleared: " + string(global.forestcleared))
	dialog = global.qellinePostForestCleared_dialogue;
}
//talk after clearing the forest having never talked
else if( !_postNeverTalkedDone && !_postNeverTalkedForestClearedDone && !_postForestClearedDone  &&  _forestCleared && !_skeletonExists  )
{
	show_debug_message("cleared never talked post fight");
	dialog = global.qellinePostFightNeverTalkedForestCleared_dialogue;
	
}

else if(_postForestClearedDone || _postNeverTalkedForestClearedDone)
{
	dialog = global.qellineKillTheNecromancer_dialogue
}


if(global.NecromancerDead == true)
{
	dialog = global.qellineTheNecromancerKilled_dialogue;
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
