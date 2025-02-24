global.actionLibrary =
{
	attack:
	{
		name: "Physical Attack",
		description: "{0} attacks!",
		subMenu: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "idle",
		effectSprite : sAttackSlash,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user,_targets)
		{
			var _damage = ceil(_user.Strength + random_range(-_user.Dexterity * 0.25, _user.Dexterity  * 0.25));
			BattleChangeHp(_targets[0],-_damage,0)
			show_debug_message("Getting called?");
		}
	},
	lightning:
	{
		name: "Lightning",
		description: "{0} casts Lightning!",
		subMenu: "Magic",
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation: "idle",
		effectSprite: sAttackLightning,
		effectOnTarget: MODE.ALWAYS,
		mpCost: 5,
		func: function(_user,_targets)
		{
			for(var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(45,60);
				BattleChangeHp(_targets[i],-_damage,0)
			}
		}
	}
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}



//struct party data
global.party =
[
	{
	name: "Player1",
	Level: 1,
	baseStats: { Vitality: 10, Strength: 10, Dexterity: 20, Magic: 10,Spirit: 10},
	scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 1,Spirit: 1},
	xpRequiredMultiplier:4,
	currentXp:0,
	Sprites : {idle: sPlayerIdle,down: sPlayerDead},
	actions: [global.actionLibrary.lightning,global.actionLibrary.attack]
	},
	
	
];
//player true scaled stats
for(var i = 0; i < array_length(global.party); i++)
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
	 _curPartyMember.hp =  _curPartyMember.hpMax;
	 _curPartyMember.mpMax =round(( _curPartyMember.Magic+ _curPartyMember.Spirit)/2);
	 _curPartyMember.mp =  _curPartyMember.mpMax;
	 //xp
	_curPartyMember.xpRequired = _curPartyMember.xpRequiredMultiplier*_curPartyMember.Level
}


//enemy data
global.enemies =
{
	Skeleton:
	{
		//May change these variables to be a range rather then set 
		name: "Skeleton",
		Level: 1,
		baseStats: { Vitality: 10, Strength: 10, Dexterity: 15, Magic:0,Spirit:0,},
		scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 0,Spirit:0 },
		Sprites : {idle: sSkeletonIdle},
		actions: [global.actionLibrary.attack],
		xpMultiplier: 1,
		AIscript : function()
		{
			//enemy  turn ai
			//attack random party memeber
			var _action = actions[0];
			//remove dead charcters from possible targets
			var _possibleTargets = array_filter(obj_Battle.partyUnits,function(_unit,_index)
			{
				return(_unit.hp > 0);
			});
			//choose target at random from the list
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action,_target];
		}
	}
}

//calcultate enemy scaled stats and derived stats

//get an array of all enemy types in the game
var _enemyTypes = variable_struct_get_names(global.enemies)
//show_debug_message("Enemy Types: " + string(enemyTypes));
for(var i = 0; i < array_length(_enemyTypes); i++){
	var _curEnemyType = _enemyTypes[i];
	//show_debug_message("Current Enemy Type: " + string(curEnemyType));
	//access data of current enemy
	var _enemy = struct_get(global.enemies,_curEnemyType); 
	
	//enemy scaled stats 
	_enemy.Vitality = _enemy.baseStats.Vitality + (_enemy.scaling.Vitality * (_enemy.Level - 1));
	_enemy.Strength = _enemy.baseStats.Strength + (_enemy.scaling.Strength * (_enemy.Level - 1));
	_enemy.Dexterity = _enemy.baseStats.Dexterity + (_enemy.scaling.Dexterity * (_enemy.Level - 1));
	_enemy.Magic = _enemy.baseStats.Magic + (_enemy.scaling.Magic * (_enemy.Level - 1));
	_enemy.Spirit = _enemy.baseStats.Spirit + (_enemy.scaling.Spirit * (_enemy.Level - 1));
	
	//enemy derived stats
	_enemy.hpMax = ((_enemy.Vitality + _enemy.Strength + _enemy.Dexterity) / 3)*5;
    _enemy.hp = _enemy.hpMax;
	_enemy.mpMax =((_enemy.Magic+_enemy.Spirit)/2)*5;
	_enemy.mp = _enemy.mpMax;
    _enemy.xpValue = _enemy.xpMultiplier * _enemy.Level;
}
