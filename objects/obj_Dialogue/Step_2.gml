// Below 0 dialogue has not started yet
if(current_message < 0) exit;

var _str = messages[current_message].msg;

if (current_char < string_length(_str))
{
	current_char += char_speed * (1 + keyboard_check(input_key));
	draw_message = string_copy(_str, 0, current_char);
}
else if (keyboard_check_pressed(input_key))
{
	if (variable_instance_exists(messages[current_message], "addSpellToParty")) {
		var _addSpell = messages[current_message].addSpellToParty;
		if (is_callable(_addSpell)) {
			_addSpell();
		}
	}
	current_message++;
	if (current_message >= array_length(messages))
	{
		instance_destroy();
	}
	else
	{
		current_char = 0;
	}
}