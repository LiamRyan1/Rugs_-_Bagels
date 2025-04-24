//might move into game manager objects create event later
randomize();

function addPlayer(pad_index)
{
	if(instance_number(obj_Player) < 3)
	{
		show_debug_message("Entered add new platwe");
		with(instance_create_layer(room_width/2, room_height/2,"Instances",obj_Player))
		{
			controllerID = pad_index;
			
			array_push(global.party,{
				name:"Player"+string(instance_number(obj_Player)),
				Level: 1,
				playerId: controllerID,
				baseStats: { Vitality: 10, Strength: 10, Dexterity: 20, Magic: 10,Spirit: 10},
				scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 1,Spirit: 1},
				xpRequiredMultiplier:4,
				currentXp:0,
				Sprites : {idle: sPlayerIdle,down: sPlayerDead},
				actions: [global.actionLibrary.lightning,global.actionLibrary.attack]
			},);
			for(var i = 0; i < array_length(global.party); i++)
			{
				if(global.party[i].playerId ==  controllerID)
				{
					var _curPartyMember = global.party[i];
	
					//player true scaled stats
					_curPartyMember.Vitality =  _curPartyMember.baseStats.Vitality + ( _curPartyMember.scaling.Vitality * ( _curPartyMember.Level - 1));
					_curPartyMember.Strength =  _curPartyMember.baseStats.Strength + ( _curPartyMember.scaling.Strength * ( _curPartyMember.Level - 1));
					_curPartyMember.Dexterity =  _curPartyMember.baseStats.Dexterity + ( _curPartyMember.scaling.Dexterity * ( _curPartyMember.Level - 1));
					_curPartyMember.Magic =  _curPartyMember.baseStats.Magic + ( _curPartyMember.scaling.Magic * ( _curPartyMember.Level - 1));
					_curPartyMember.Spirit = _curPartyMember.baseStats.Spirit + ( _curPartyMember.scaling.Spirit * ( _curPartyMember.Level - 1));
	 
					//player derived stats
					_curPartyMember.hpMax = round(( _curPartyMember.Vitality+ _curPartyMember.Strength+ _curPartyMember.Dexterity)/3*10);
					_curPartyMember.mpMax =round(( _curPartyMember.Magic+ _curPartyMember.Spirit)/2);
					_curPartyMember.mp =  _curPartyMember.mpMax;
					_curPartyMember.hp =  _curPartyMember.hpMax;
					//xp
					_curPartyMember.xpRequired = _curPartyMember.xpRequiredMultiplier*_curPartyMember.Level
				}
			}
			gamepad_set_axis_deadzone(controllerID,0.2);
		}
		CreateCameras();
	}
}