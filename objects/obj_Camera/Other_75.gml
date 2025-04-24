/// @description Detect Controllers
//? indicates asynce load is a ds map
show_debug_message("bonjour");
if(async_load[? "event_type"] == "gamepad discovered")
{
	addPlayer(async_load[? "pad_index"])
}

//controller removed
if(async_load[? "event_type"] == "gamepad lost")
{
	show_debug_message("Deleting player?");
	var _controller = async_load[? "pad_index"];
	for(var i = 0; i < array_length(global.party); i++)
	{
		
		show_debug_message("looping");
		show_debug_message(string(global.party[i].playerId));
		show_debug_message(string(_controller))
		if(global.party[i].playerId == _controller)
		{
			
			show_debug_message("Entered the deletion of " + string(global.party[i].name));
			array_delete(global.party,i,1);
			break
		}
	}
	for(var i = 0; i<instance_number(obj_Player); i++)
	{
		if(instance_find(obj_Player,i).controllerID == _controller)
		{
			instance_destroy(instance_find(obj_Player,i));
			break;
		}
	}
for (var j = 0; j < array_length(global.party); j++)
{
    show_debug_message(string(global.party[j]));
}
	CreateCameras();
}