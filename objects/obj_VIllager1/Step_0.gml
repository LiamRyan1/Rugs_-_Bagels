if(!ds_map_find_value(global.dialogue_flags, "welcome_dialogue")
&& !ds_map_find_value(global.dialogue_flags, "forestEntrance1") 
&& !ds_map_find_value(global.dialogue_flags, "forestEntrance2"))
{
	
	
	dialog = global.welcome_dialogue;
}
else if(!ds_map_find_value(global.dialogue_flags, "welcome_dialogue") 
&& ds_map_find_value(global.dialogue_flags, "forestEntrance2") 
&& !ds_map_find_value(global.dialogue_flags, "welcome2_dialogue"))
{
	dialog = global.welcome2_dialogue;
}
else if(ds_map_find_value(global.dialogue_flags, "welcome_dialogue")  
&& !ds_map_find_value(global.dialogue_flags, "forestEntrance1"))
{
	dialog = global.welcomeNotFoundSildar_dialogue;
}
else
{
	dialog = global.welcomeFoundSildar_dialogue;
}
//show_debug_message(string(dialouge));
event_inherited()