/// @description Detect Controllers
//? indicates asynce load is a ds map
show_debug_message("bonjour");
if(async_load[? "event_type"] == "gamepad discovered")
{
show_debug_message("bonjour2");
	with(instance_create_layer(room_width/2, room_height/2,"Instances",obj_Player))
	{
		controllerID = async_load[? "pad_index"];
		gamepad_set_axis_deadzone(controllerID,0.25);
	}
	CreateCameras();
}

//controller removed
if(async_load[? "event_type"] == "gamepad discovered")
{
	var _controller = async_load[? "pad_Index"];
	for(var i = 0; i<instance_number(obj_Player); i++)
	{
		if(instance_find(obj_Player,i).controllerID == _controller)
		{
			instance_destroy(obj_Player,i);
			break;
		}
	}
	CreateCameras();
}