instance_deactivate_all(true);
//contains all units
units = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

//ememies units
for(var i = 0; i<array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+250+(i*10),y+68+(i*20),depth-10,obj_BattleUnitEnemy,enemies[i]);
	array_push(units,enemyUnits[i]);
}
//party units
for(var i = 0; i< array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+70+(i*10),y+68+(i*15),depth-10,obj_BattleUnitPlayer,global.party[i]);
	array_push(units,partyUnits[i]);
}

//sort turn order
//copy units to unitTurnOrder
array_copy(unitTurnOrder,0,units,0,array_length(units))
if(array_length(unitTurnOrder) > 0){
	//sort temp array
	//with array_sort neg
	array_sort(unitTurnOrder, function(unit1, unit2) {
        return unit2.Dexterity - unit1.Dexterity;
    });	
}


//render order
RefreshRenderOrder = function(){
	//Get render order
	unitRenderOrder = [];
	//copies array into new array rather then memory address
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder,function(unit1,unit2){
		return unit1.y - unit2.y;
	});
}
RefreshRenderOrder();
