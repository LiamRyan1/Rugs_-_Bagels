//run battle state
battleState();

//curser control
if(cursor.active)
{
	with(cursor)
	{
		
		var _keyLeft = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));
		var _keyRight = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
		var _keyUp =   keyboard_check_pressed(vk_up)  ||keyboard_check_pressed(ord("W")) ;
		var _keyDown = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
		var _keyToggle = false;
		var _keyConfirm = false;
		var _keyCancel = false;
		confirmDelay++;
		if(confirmDelay > 1)
		{
			_keyToggle = keyboard_check_pressed(vk_shift);
			_keyConfirm = keyboard_check_pressed(vk_enter);
			_keyCancel =  keyboard_check_pressed(vk_escape);
		}
		var _moveH = _keyRight - _keyLeft;
		var _moveV = _keyDown - _keyUp;
		
		if(_moveH == -1) targetSide = obj_Battle.partyUnits;
		if(_moveH == 1) targetSide = obj_Battle.enemyUnits;
		
		//check targets are valid(not dead)
		if(targetSide == obj_Battle.enemyUnits)
		{
			targetSide = array_filter(targetSide,function(_element,_index)
			{
				return _element.hp > 0;
			});
		}
		//move between targets
		if(targetAll == false)
		{
			if(_moveV == 1) targetIndex++;
			if(_moveV == -1) targetIndex--;
			
			//wrap back to top
			var _targets = array_length(targetSide);
			if(targetIndex < 0) targetIndex = _targets -1;
			if(targetIndex > (_targets -1)) targetIndex = 0;
			
			//identify target at index and make them active 
			activeTarget = targetSide[targetIndex];
			
			//toggle all mode
			if(activeAction.targetAll == MODE.VARIES) && (_keyToggle)//switch to all mode
			{
				targetALL = true;
			}
		}
		else//target all mode
		{
			activeTarget = targetSide;
			if(activeAction.targetAll == MODE.VARIES) && (_keyToggle)//switch to single mode
			{
				targetAll = false;
			}
		}
		//confirm action
		if(_keyConfirm)
		{
			with(obj_Battle)BeginAction(cursor.activeUser,cursor.activeAction,cursor.activeTarget);
			with (obj_Menu) instance_destroy();
			active = false;
			confirmDelay = 0;
		}
		//cancel & return
		if(_keyCancel) && (!_keyConfirm)
		{
			with(obj_Menu) active = true;
			active = false;
			confirmDelay = 0;
		}
	}
}
