instance_deactivate_all(true);
//contains all units
units = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 60;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;

//ememies units
for(var i = 0; i<array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+250+(i*10),y+68+(i*20),depth-10,obj_BattleUnitEnemy,enemies[i]);
	array_push(units,enemyUnits[i]);
}
//party units
for(var i = 0; i< array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+70+(i*10),y+68+(i*15),depth-10,obj_BattleUnitPartyMembers,global.party[i]);
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



//Combat States
function BattleStateSelectAction()
{
	//get current unit
	var _unit = unitTurnOrder[turn];
	//check unit status
	if(!instance_exists(_unit) || (_unit.hp <=0))
	{
		battleState = BattleStateVictoryCheck;
		exit;
	}
	BeginAction(_unit.id,global.actionLibrary.attack,_unit.id);
}
function BeginAction(_user,_action,_targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	if(!is_array(currentTargets))currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with(_user)
	{
		acting = true;
		//play animation for the action
		if(!is_undefined(_action[$"userAnimation"])) && (!is_undefined(_user.Sprites[$ _action.userAnimation]))
		{
			sprite_index = Sprites[$ _action.userAnimation];
			image_index = 0;
			image_speed = 1;
		}
	}
	show_debug_message("Current frame: " + string(currentUser.image_index) + " / " + string(currentUser.image_number));
	battleState = BattleStatePerformAction;
}
function BattleStatePerformAction()
{
	
	//check if animation is still playing
	if(currentUser.acting)
	{
		show_debug_message("Current frame: " + string(currentUser.image_index) + " / " + string(currentUser.image_number));
		//on animation end perform action effect
		if(currentUser.image_index >= currentUser.image_number-1)
		{
			show_debug_message("Debug2");
			with(currentUser)
			{
				sprite_index = Sprites.idle;
				image_index = 0;
				acting = false;
			}
		
			if(variable_struct_exists(currentAction,"effectSprite"))
			{
				if(currentAction.effectOnTarget == MODE.ALWAYS) || ((currentAction.efffectOnTarget == MODE.VARIES) && (array_length(currentTargets) <=1))
				{
					for(var i =0; i<array_length(currentTargets); i++)
					{
						//draws effects ontop of targets
						instance_create_depth(currentTargets[i].x,currentTargets[i].y,currentTargets[i].depth-1,obj_BattleEffect,{sprite_index : currentAction.effectSprite});
					}
				}
				else //play at 0,0
				{
					//if theres no target specific effect play a room covering effect
					var _effectSprite = currentAction.effectSprite;
					if(variable_struct_exists(currentAction,"effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
					instance_create_depth(x,y,depth-100,obj_BattleEffect,{sprite_index: _effectSprite});
				}
			}
			currentAction.func(currentUser,currentTargets);
		}
	}
	else //wait for delay and end turn
	{
		if(!instance_exists(obj_BattleEffect))
		{
			battleWaitTimeRemaining--;
			if(battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck;
			}
		}
	}
}
function BattleStateVictoryCheck()
{
	battleState = BattleStateTurnProgression;
}
function BattleStateTurnProgression()
{
	turnCount++;
	turn++;
	//loop turns
	if(turn > array_length(unitTurnOrder)-1)
	{
		turn = 0;
		roundCount++;
	}
	battleState = BattleStateSelectAction;
}

battleState = BattleStateSelectAction;
