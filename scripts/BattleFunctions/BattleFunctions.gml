function NewEncounter(_enemies,_bg,){
	//move view away from the room the player is in
	instance_create_depth
	(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-9999,
		obj_Battle,
		{enemies: _enemies, creator: id, battleBackground: _bg}
	);		
}

function BattleChangeHp(_target,_amount,_AliveDeadOrEither = 0)
{
	//_AliveDeadOrEither: 0= alive only, 1= dead only, 2= any
	var _failed = false;
	if(_AliveDeadOrEither == 0) && (_target.hp <= 0) _failed = true;
	if(_AliveDeadOrEither == 1) && (_target.hp > 0) _failed = true;
	
	var _colour = c_white;
	if(_amount > 0) _colour = make_color_rgb(207,181,59);
	if(_failed)
	{
		_colour = c_white;
		_amount = "Failed to Cast";
	}
	instance_create_depth
	(
		_target.x,
		_target.y,
		_target.depth-1,
		obj_BattlePopUpText,
		{font: Fnt_Battle_Screen, colour: _colour, text: string(_amount)}
	);
	//ensure healing is kept within range of 0-max health to prevent overheal
	if(!_failed)_target.hp = clamp(_target.hp + _amount,0,_target.hpMax);
}