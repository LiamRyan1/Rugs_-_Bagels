//struct player data
global.player ={
	Name: "Player1",
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
		baseStats: { Vitality: 10, Strength: 10, Dexterity: 10, Magic:0,Spirit:0,},
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
var enemyTypes = variable_struct_get_names(global.enemies)
//show_debug_message("Enemy Types: " + string(enemyTypes));
for(var i = 0; i < array_length(enemyTypes); i++){
	var curEnemyType = enemyTypes[i];
	//show_debug_message("Current Enemy Type: " + string(curEnemyType));
	//access data of current enemy
	var enemy = struct_get(global.enemies,curEnemyType); 
	
	//enemy scaled stats 
	enemy.Vitality = enemy.baseStats.Vitality + (enemy.scaling.Vitality * (enemy.Level - 1));
	enemy.Strength = enemy.baseStats.Strength + (enemy.scaling.Strength * (enemy.Level - 1));
	enemy.Dexterity = enemy.baseStats.Dexterity + (enemy.scaling.Dexterity * (enemy.Level - 1));
	enemy.Magic = enemy.baseStats.Magic + (enemy.scaling.Magic * (enemy.Level - 1));
	enemy.Spirit = enemy.baseStats.Spirit + (enemy.scaling.Spirit * (enemy.Level - 1));
	
	//enemy derived stats
	enemy.hpMax = (enemy.Vitality + enemy.Strength + enemy.Dexterity) / 3;
    enemy.hp = enemy.hpMax;
	enemy.mpMax =(enemy.Magic+enemy.Spirit)/2;
	enemy.mp = enemy.mpMax;
    enemy.xpValue = enemy.xpMultiplier * enemy.Level;
}
