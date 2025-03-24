/// @description Create/update cameras when player joins
function CreateCameras(){
	playerCount = instance_number(obj_Player);
	var _width =320 ,_height =180, _scale = 1
	
	//destroy previous cameras
	if !is_undefined(global.Cameras)
	{
		for(var i = 0; i < array_length(global.Cameras); i++)
		{
			camera_destroy(global.Cameras[i]);
		}
	}
	
	global.Cameras = undefined;
	view_visible[0] = false;
	view_visible[1] = false;
	view_visible[2] = false;
	show_debug_message("The player count is " + string(playerCount));
	
	for(var i = 0; i < playerCount; i++)
	{
		player = instance_find(obj_Player,i);
		
		view_visible[i] = true;
		
		global.Cameras[i] = camera_create_view(0,0, _width, _height,0,player,-1,-1,_width,_height);
		view_set_camera(i,global.Cameras[i]);
		
		//4 player
		if(i == 0)
		{
			view_set_xport(0,0);
			view_set_yport(0,0);
			//width and height of whats shown
			view_set_wport(0,_width);
			view_set_hport(0,_height);
			camera_set_view_size(global.Cameras[0],_width,_height);
		}
		if(i == 1)
		{
			//player 1
			//where the port shows up
			view_set_xport(0,0);
			view_set_yport(0,0);
			//width and height of whats shown
			view_set_wport(0,_width);
			view_set_hport(0,_height/2);
			camera_set_view_size(global.Cameras[0],_width,_height/2);
			show_debug_message("2 players")
			//player 2
			view_set_xport(1,0);
			view_set_yport(1,_height/2);
			view_set_wport(1,_width);
			view_set_hport(1,_height/2);
			camera_set_view_size(global.Cameras[1],_width,_height/2);
		}	
		if(i == 2)
		{
			//player 1
			//where the port shows up
			view_set_xport(0,0);
			view_set_yport(0,0);
			//width and height of whats shown
			view_set_wport(0,_width);
			view_set_hport(0,_height/2);
			camera_set_view_size(global.Cameras[0],_width,_height/2);
			
			//player 2
			view_set_xport(1,0);
			view_set_yport(1,_height/2);
			view_set_wport(1,_width/2);
			view_set_hport(1,_height/2);
			camera_set_view_size(global.Cameras[1],_width/2,_height/2);
			
			//player 3
			view_set_xport(2,_width/2);
			view_set_yport(2,_height/2);
			view_set_wport(2,_width/2);
			view_set_hport(2,_height/2);
			camera_set_view_size(global.Cameras[2],_width/2,_height/2);
		}
	}
	
	window_set_size(_width *_scale,_height * _scale);
	surface_resize(application_surface,_width*_scale,_height*_scale);
	
	
}