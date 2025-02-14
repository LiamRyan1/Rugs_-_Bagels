function NewEncounter(_enemies,_bg){
	//move view away from the room the player is in
	instance_create_depth
	(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-9999,
		obj_Battle,
		{enemies: _enemies,creator: id, battleBackground: _bg}
	);
		
}