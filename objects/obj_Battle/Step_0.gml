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
function battleStateBattleWon()
{
	//show_debug_message("passed entered");
	if(battleWaitTimeRemaining > 0)
	{
		battleWaitTimeRemaining--;
		//show_debug_message("Time Remaining 1: " + string(battleWaitTimeRemaining));
	}
	else if(battleWaitTimeRemaining == 0 )
	{
		//show_debug_message("Now running");
		if(battleWon != true)
		{
		battleText = "";
		for(var i = 0; i < array_length(partyUnits); i++)
		{
			var _partyUnit = partyUnits[i];
			global.party[i].currentXp += xpGained;
			show_debug_message(string(global.party[i].name) + " CURRENT Xp = " + string(global.party[i].currentXp ));
			if(global.party[i].name == _partyUnit.name)
			{
				lvlup = false;
				//save old stats
				var _oldLevel = global.party[i].Level;
				var _oldHp = global.party[i].hpMax;
				var _oldMp = global.party[i].mpMax;
				var _oldVitality = global.party[i].Vitality;
				var _oldStrength = global.party[i].Strength;
				var _oldDexterity = global.party[i].Dexterity;
				var _oldMagic = global.party[i].Magic;
				var _oldSpirit = global.party[i].Spirit;
				
				global.party[i].hp = _partyUnit.hp;
				global.party[i].mp = _partyUnit.mp;
				while(global.party[i].currentXp >= global.party[i].xpRequired)
				{
					battleText = ""
					global.party[i].currentXp = global.party[i].currentXp - global.party[i].xpRequired;
					global.party[i].Level++;
					scalePartyStats();
					lvlup = true;
						
				}
				if(lvlup)
				{
					battleText += string(global.party[i].name) + " leveled up!\n";
					battleText += "Level " + string(_oldLevel) + " -> " + string(global.party[i].Level) + "\n";
					battleText += "HP " + string(_oldHp) + " -> " + string(global.party[i].hpMax) + "\n";
					battleText += "MP " + string(_oldMp) + " -> " + string(global.party[i].mpMax) + "\n";
					battleText += "Vitality " + string(_oldVitality) + " -> " + string(global.party[i].Vitality) + "\n";
					battleText += "Strength " + string(_oldStrength) + " -> " + string(global.party[i].Strength) + "\n";
					battleText += "Dexterity " + string(_oldDexterity) + " -> " + string(global.party[i].Dexterity) + "\n";     
					battleText += "Magic " + string(_oldMagic) + " -> " + string(global.party[i].Magic) + "\n";
					battleText += "Spirit " + string(_oldSpirit) + " -> " + string(global.party[i].Spirit) + "\n";
				}
				battleText += string(global.party[i].name) + " CURRENT Xp " + string(global.party[i].currentXp) + " RequiredXp " +  string(global.party[i].xpRequired) + " Current Level " + string(global.party[i].Level)  + "\n";
				battleText += "\n";  
			}
			}
		}
		if(lvlup && setWaitTime == false)
		{
			battleWaitTimeRemaining2 = 120;
			setWaitTime = true;
		}
		else if (setWaitTime == false)
		{
			battleWaitTimeRemaining2 = 60;
			setWaitTime = true;
		}
		if(battleWaitTimeRemaining2 > 0)
		{	battleWon = true;
			//show_debug_message("Entering battleWaitTimeRemaining == 0 block!");
			battleWaitTimeRemaining2--;
			//show_debug_message("Time Remaining 2: " + string(battleWaitTimeRemaining2));
		}
		else
		{
			//show_debug_message(string(global.party[0].name) + "CURRENT Xp " + string(global.party[0].currentXp) + " RequiredXp " +  string(global.party[0].xpRequired) + " Current Level " + string(global.party[0].Level));	
			setWaitTime = false;
			xpGained = 0;
			battleText = "";
			battleWon = false;
			instance_activate_all();
			instance_destroy(creator);
			instance_destroy();
			return
		}
	}
}

//draw battle text
/*
if(battleText != "")
{
	var _w = string_width(battleText)+5;
	draw_sprite_stretched(sScreen,0,x+160-round((_w*0.5)),y+15,_w,20);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_set_font(Fnt_Battle_Screen);
	draw_text(x+160,y+20,battleText);
}*/