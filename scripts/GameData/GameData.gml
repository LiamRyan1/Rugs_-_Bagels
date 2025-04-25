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
		mpCost: 0,
		func: function(_user,_targets)
		{
			var _damage = ceil(_user.Strength + random_range(-_user.Dexterity * 0.25, _user.Dexterity  * 0.25));
			BattleChangeHp(_targets[0],-_damage,0)
			show_debug_message("Getting called?");
		}
	},
	DeathGrasp:
	{
		name: "Death Grasp",
		description: "{0} casts Death Grasp!",
		subMenu: "Magic",
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "idle",
		effectSprite: sAttackDeathGrasp,
		effectOnTarget: MODE.ALWAYS,
		mpCost: 5,
		func: function(_user,_targets)
		{
			for(var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(25,32);
				BattleChangeHp(_targets[i],-_damage,0)
			}
			BattleChangeMp(-global.actionLibrary.lightning.mpCost,_user);
		}
	},
	DragonSlayer:
	{
		name: "Dragon Slayer",
		description: "{0} attacks with Dragon Slayer!",
		subMenu: "Inventory",
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "idle",
		effectSprite : sAttackSlash,
		effectOnTarget: MODE.ALWAYS,
		mpCost: 2,
		func: function(_user,_targets)
		{
			var _damage = ceil(_user.Strength + random_range(-_user.Dexterity * 0.25, _user.Dexterity  * 0.25)*2);
		
			BattleChangeHp(_targets[0],-_damage,0)
			BattleChangeMp(-global.actionLibrary.DragonSlayer.mpCost,_user);
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
			BattleChangeMp(-global.actionLibrary.lightning.mpCost,_user);
		}
	},
	HealthPotion:
	{
		name: "Health Potion",
		description: "{0} drank a health potion!",
		subMenu: "Inventory",
		targetRequired: true,
		targetEnemyByDefault: false,
		targetAll: MODE.NEVER,
		userAnimation : "idle",
		effectSprite : sHealing,
		effectOnTarget: MODE.ALWAYS,
		mpCost: 0,
		func: function(_user,_targets)
		{
			BattleChangeHp(_targets[0],30,0)
			show_debug_message("Getting called?");
		}
	},
	
	ManaPotion:
	{
		name: "Mana Potion",
		description: "{0} drank a mana potion!",
		subMenu: "Inventory",
		targetRequired: true,
		targetEnemyByDefault: false,
		targetAll: MODE.NEVER,
		userAnimation : "idle",
		effectSprite : sManaRegen,
		effectOnTarget: MODE.ALWAYS,
		mpCost: 0,
		func: function(_user,_targets)
		{
			BattleChangeMp(10, _targets[0])
			show_debug_message("Getting called?");
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
	name:"Player1",
	Level: 1,
	playerId: undefined,
	baseStats: { Vitality: 10, Strength: 10, Dexterity: 20, Magic: 10,Spirit: 10},
	scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 1,Spirit: 1},
	xpRequiredMultiplier:4,
	currentXp:0,
	Sprites : {idle: sPlayerIdle,down: sPlayerDead},
	actions: [global.actionLibrary.attack]
},
];
function scalePartyStats()
{
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
		 _curPartyMember.mpMax =round(( _curPartyMember.Magic+ _curPartyMember.Spirit)/2);
		 _curPartyMember.mp =  _curPartyMember.mpMax;
		 _curPartyMember.hp =  _curPartyMember.hpMax;
		 //xp
		_curPartyMember.xpRequired = _curPartyMember.xpRequiredMultiplier*_curPartyMember.Level
	}
}
scalePartyStats();

//enemy data
global.enemies =
{
	Skeleton:
	{
		//May change these variables to be a range rather then set 
		name: "Skeleton",
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
	},
	Necromancer:
	{
		//May change these variables to be a range rather then set 
		name: "Necromancer",
		baseStats: { Vitality: 5, Strength: 10, Dexterity: 15, Magic:20,Spirit:20,},
		scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 3,Spirit:3 },
		Sprites : {idle: sNecromancerIdle},
		actions: [global.actionLibrary.attack,global.actionLibrary.DeathGrasp],
		xpMultiplier: 1,
		AIscript : function()
		{
			//enemy  turn ai
			//attack random party memeber
			var _actions = actions;
			var _action = _actions[irandom(array_length(_actions) - 1)]
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
function scaleEnemyStats(_enemy,Level)
{
		//enemy scaled stats 
		_enemy.Vitality = _enemy.baseStats.Vitality + (_enemy.scaling.Vitality * (Level - 1));
		_enemy.Strength = _enemy.baseStats.Strength + (_enemy.scaling.Strength * (Level - 1));
		_enemy.Dexterity = _enemy.baseStats.Dexterity + (_enemy.scaling.Dexterity * (Level - 1));
		_enemy.Magic = _enemy.baseStats.Magic + (_enemy.scaling.Magic * (Level - 1));
		_enemy.Spirit = _enemy.baseStats.Spirit + (_enemy.scaling.Spirit * (Level - 1));
		
		//enemy derived stats
		_enemy.hpMax = ((_enemy.Vitality + _enemy.Strength + _enemy.Dexterity) / 3)*5;
		_enemy.hp = _enemy.hpMax;
		_enemy.mpMax =((_enemy.Magic+_enemy.Spirit)/2)*5;
		_enemy.mp = _enemy.mpMax;
	    _enemy.xpValue = _enemy.xpMultiplier * Level;
		return _enemy;
}

