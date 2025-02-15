//struct player data
global.player ={
	name: "Player1",
	Level: 1,
	baseStats: { Vitality: 10, Strength: 10, Dexterity: 10, Magic: 10,Spirit: 10},
	scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 1,Spirit: 1},
	Sprites : {idle: sPlayer},
	actions: []
};
//player true scaled stats
global.player.Vitality = global.player.baseStats.Vitality + (global.player.scaling.Vitality * (global.player.Level - 1));
global.player.Strength = global.player.baseStats.Strength + (global.player.scaling.Strength * (global.player.Level - 1));
global.player.Dexterity =global.player.baseStats.Dexterity + (global.player.scaling.Dexterity * (global.player.Level - 1));
global.player.Magic = global.player.baseStats.Magic + (global.player.scaling.Magic * (global.player.Level - 1));
global.player.Spirit =global.player.baseStats.Spirit + (global.player.scaling.Spirit * (global.player.Level - 1));
//player derived stats
global.player.hpMax = (global.player.Vitality+global.player.Strength+global.player.Dexterity)/3;
global.player.hp = global.player.hpMax;
global.player.mpMax =(global.player.Magic+global.player.Spirit)/2;
global.player.mp = global.player.mpMax;


//enemy data
global.enemies =
{
	Skeleton:
	{
		//May change these variables to be a range rather then set 
		name: "Skeleton",
		Level: 1,
		baseStats: { Vitality: 10, Strength: 10, Dexterity: 11, Magic:0,Spirit:0,},
		scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 0,Spirit:0 },
		Sprites : {idle: sSkeleton1},
		actions: [],
		xpMultiplier: 1,
		AIscript : function()
		{
			//enemy  turn ai
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
	_enemy.hpMax = (_enemy.Vitality + _enemy.Strength + _enemy.Dexterity) / 3;
    _enemy.hp = _enemy.hpMax;
	_enemy.mpMax =(_enemy.Magic+_enemy.Spirit)/2;
	_enemy.mp = _enemy.mpMax;
    _enemy.xpValue = _enemy.xpMultiplier * _enemy.Level;
}
