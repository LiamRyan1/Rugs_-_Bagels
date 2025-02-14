instance_deactivate_all(true);
//contains all units
units = [];

//ememies units
for(var i = 0; i<array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+250+(i*10),y+68+(i*20),depth-10,obj_BattleUnitEnemy,enemies[i]);
	
	array_push(units,enemyUnits[i]);
}
//player units
player = instance_create_depth(x+70+(i*10),y+68+(i*15),depth-10,obj_BattleUnitPlayer,global.player);
array_push(units,player);
