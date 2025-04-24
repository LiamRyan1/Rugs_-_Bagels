if(ds_map_find_value(global.dialogue_flags, "welcome_dialogue") && !ds_map_find_value(global.dialogue_flags, "forestEntrance2"))
{
	dialog = global.forestEntrance1_dialogue;
}
else if(!ds_map_find_value(global.dialogue_flags, "welcome_dialogue") && !ds_map_find_value(global.dialogue_flags, "forestEntrance2"))
{
	dialog = global.forestEntrance2_dialogue;
}
else if (!ds_map_find_value(global.dialogue_flags, "welcome_dialogue") && ds_map_find_value(global.dialogue_flags, "forestEntrance2"))
{
	dialog = global.forestEntranceTalkToSildar_dialogue;
}
else
{
	dialog = global.forestEntranceTalkToSildarRepeat_dialogue;
}
event_inherited();