if(active)
{
	for (var i = 0; i < 11; i++) {
    if (gamepad_is_connected(i)) {
        show_debug_message("Gamepad " + string(i) + " is connected.");
    } else {
        show_debug_message("Gamepad " + string(i) + " is NOT connected.");
    }
}

	//control with keyboard
	if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(4,gp_padd)) {
        hover++;
    }
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(4,gp_padu)) {
        hover--;
    }
	if(hover > array_length(options)-1) hover = 0;
	if(hover < 0 ) hover = array_length(options)-1;
	
	//Execute selected option
	if(keyboard_check_pressed(vk_enter)|| gamepad_button_check_pressed(4,gp_face3))
	{
		if(array_length(options[hover]) > 1) && (options[hover][3] == true)
		{
			if(options[hover][1] != -1)
			{
				var _func = options[hover][1];
				if(options[hover][2] != -1) script_execute_ext(_func,options[hover][2]); else _func();
			}
		}
		
	}
	if(keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(4,gp_face2) )
	{
		if(subMenuLevel > 0) MenuGoBack();
	}
}