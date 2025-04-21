//run battle state
battleState();

//curser control
if(cursor.active)
{
	with(cursor)
	{
		var _keyLeft = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));
		var _keyRight = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
		var _keyUp =   keyboard_check_pressed(vk_up)  ||keyboard_check_pressed(ord("W"));
		var _keyDown = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
		
		 for (var i = 0; i <= 11; i++)
			 {
				if (gamepad_is_connected(i))
				{
					 _keyLeft = _keyLeft || gamepad_button_check_pressed(i,gp_padl);
					 _keyRight = _keyRight || gamepad_button_check_pressed(i,gp_padr);
					 _keyUp =   _keyUp || gamepad_button_check_pressed(i,gp_padd) 
					 _keyDown  = _keyDown || gamepad_button_check_pressed(i,gp_padu);
				 }
			 }
		
		var _keyToggle = false;
		var _keyConfirm = false;
		var _keyCancel = false;
		confirmDelay++;
		if(confirmDelay > 1)
		{
			_keyToggle = keyboard_check_pressed(vk_shift);
			_keyConfirm = keyboard_check_pressed(vk_enter);
			_keyCancel =  keyboard_check_pressed(vk_escape);
			 for (var i = 0; i <= 11; i++)
			 {
				if (gamepad_is_connected(i))
				{
					 _keyToggle = _keyToggle || gamepad_button_check_pressed(i, gp_face4);
					 _keyConfirm = _keyConfirm || gamepad_button_check_pressed(i, gp_face3);
					 _keyCancel = _keyCancel  || gamepad_button_check_pressed(i, gp_face2);
				 }
			 }
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

function battleStateBattleWon()
{
	if(!variable_global_exists("currentIndex"))
	{
		global.currentIndex = 0;
	}
	if(!variable_global_exists("xpReceived"))
	{
		global.xpReceived = false;
	}
	//show_debug_message("passed entered");
	if(battleWaitTimeRemaining > 0)
	{
		battleWaitTimeRemaining--;
		//show_debug_message("Time Remaining 1: " + string(battleWaitTimeRemaining));
	}
	else if(battleWaitTimeRemaining == 0 )
	{
		//show_debug_message("Now running");		
		battleText = "";
		if(global.currentIndex < array_length(partyUnits))
		{
			var i = global.currentIndex;
			var _partyUnit = partyUnits[i];
			if(global.xpReceived == false)
			{
				show_debug_message("only running once");
				global.party[i].currentXp += xpGained;
				show_debug_message(string(global.party[i].name) + " CURRENT Xp = " + string(global.party[i].currentXp ));
				global.xpReceived = true;
			}
			if(global.party[i].name == _partyUnit.name)
			{
				if(oldStatsSaved == false)
				{
					//save old stats
					oldLevel = global.party[i].Level;
					oldHp = global.party[i].hpMax;
					oldMp = global.party[i].mpMax;
					oldVitality = global.party[i].Vitality;
					oldStrength = global.party[i].Strength;
					oldDexterity = global.party[i].Dexterity;
					oldMagic = global.party[i].Magic;
					oldSpirit = global.party[i].Spirit;
				
					global.party[i].hp = _partyUnit.hp;
					global.party[i].mp = _partyUnit.mp;
					show_debug_message(string(global.party[i].name)  +  "New Hp " +  string(global.party[i].hp)  + "New Mp " + string(global.party[i].mp));
					
					oldStatsSaved = true;
				}
					
				while(global.party[i].currentXp >= global.party[i].xpRequired)
				{
					global.party[i].currentXp = global.party[i].currentXp - global.party[i].xpRequired;
					global.party[i].Level++;
					scalePartyStats();
					lvlup = true;	
				}
				if(lvlup)
				{
					battleText = string(global.party[i].name) + " leveled up!\n";
					battleText += "Level " + string(oldLevel) + " -> " + string(global.party[i].Level) + "\n";
					battleText += "HP " + string(oldHp) + " -> " + string(global.party[i].hpMax) + "\n";
					battleText += "MP " + string(oldMp) + " -> " + string(global.party[i].mpMax) + "\n";				
					battleText += "Vitality " + string(oldVitality) + " -> " + string(global.party[i].Vitality) + "\n";
					battleText += "Strength " + string(oldStrength) + " -> " + string(global.party[i].Strength) + "\n";
					battleText += "Dexterity " + string(oldDexterity) + " -> " + string(global.party[i].Dexterity) + "\n";     
					battleText += "Magic " + string(oldMagic) + " -> " + string(global.party[i].Magic) + "\n";
					battleText += "Spirit " + string(oldSpirit) + " -> " + string(global.party[i].Spirit) + "\n";
					show_debug_message("entered")
				}
				battleText +=  string(global.party[i].name) + " Experience: " + string(global.party[i].currentXp) + "/ " +  string(global.party[i].xpRequired)+ "\n";
				var _ConfirmBattleEnd = keyboard_check_pressed(vk_enter);
				for (var i = 0; i <= 11; i++)
				{
					if (gamepad_is_connected(i))
					{
						_ConfirmBattleEnd = _ConfirmBattleEnd || gamepad_button_check_pressed(i, gp_face3);
					}
				}
				if(_ConfirmBattleEnd)
				{
					global.xpReceived = false;
					lvlup = false;
					oldStatsSaved = false;
					global.currentIndex++;
					show_debug_message("Index :" + string(global.currentIndex) + "  XpStatus: " + string(global.xpReceived));
					
				}
			}
		}
		
		if(global.currentIndex >= array_length(partyUnits) )
		{
			//show_debug_message(string(global.party[0].name) + "CURRENT Xp " + string(global.party[0].currentXp) + " RequiredXp " +  string(global.party[0].xpRequired) + " Current Level " + string(global.party[0].Level));	
			show_debug_message(string(array_length(partyUnits)));
			xpGained = 0;
			battleText = "";
			global.currentIndex = 0;
			instance_activate_all();
			instance_destroy(creator);
			CreateCameras();
			instance_destroy();
			return
		}
	}
}

