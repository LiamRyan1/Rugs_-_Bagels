


if(instance_exists(obj_Dialogue)) exit;

if(instance_exists(obj_Player) && distance_to_object(obj_Player) < 8)
{
	can_talk = true;
	if(keyboard_check_pressed(input_key))
	{
		create_dialogue(dialog);
	}
}
else
{
	can_talk = false;
}