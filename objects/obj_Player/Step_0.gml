if(instance_exists(obj_Dialogue)) exit;



//store boolean checks for keyboard input
var _key_left = 0;
var _key_right = 0;
var _key_up = 0;
var _key_down = 0;
if(controllerID == undefined)
{
	_key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
	_key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	_key_up =   keyboard_check(vk_up)  ||keyboard_check(ord("W")) ;
	_key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
}

//gamecontroller input
xAxis = 0;
yAxis = 0;

if(controllerID >= 0 )
{
	xAxis = gamepad_axis_value(controllerID,gp_axislh);
	yAxis = gamepad_axis_value(controllerID,gp_axislv);
	
}


xMove = round(xAxis + (_key_right-_key_left));
yMove = round(yAxis + (_key_down-_key_up));
//player angle and magnitude
var pDirection = point_direction(0,0,xMove,yMove);
var pMagnitude = (xMove != 0) || (yMove != 0);

hSpeed =  round(lengthdir_x(pMagnitude * walksp,pDirection));
vSpeed =  round(lengthdir_y(pMagnitude * walksp,pDirection));


// This will handle collision and movement - Check scripts
var collisionHappened = PlayerCollision();

//Animating Playersprite

//Update sprite index
var _oldSprite = sprite_index;
//when moving
if(pMagnitude != 0)
{
	//holds angle player is moving in
	direction = pDirection;
	sprite_index = spriteRun;
}
else sprite_index = spriteIdle;
//reset local frame on sprite switch to start on first frame
if(_oldSprite != sprite_index) localFrame = 0;

//update image index
PlayerAnimation();
var _nextX = x + hSpeed;
var _nextY = y + vSpeed;
if (place_meeting(_nextX,_nextY, obj_Player) || place_meeting(_nextX ,_nextY, obj_Npc_Parent))
{
    //Resolve collision by pushing the player away in the opposite direction
    while (place_meeting(x + sign(hSpeed), y + sign(vSpeed), obj_Player) ||  place_meeting(x + sign(hSpeed), y + sign(vSpeed), obj_Npc_Parent) )
    {
        x -= sign(hSpeed);
        y -= sign(vSpeed);
    }
	for (var i = 0; i < ds_grid_height(playerInv); ++i) {
        if (ds_grid_get(playerInv, 0, i) == "Axe") {
			var _tree = instance_place(_nextX, _nextY, obj_deadTrees);
            if (_tree != noone) {
                instance_destroy(_tree); // Destroy just that tree
            }
			break;
        }
    }
    
    //stop movement entirely if collision occurs
    hSpeed = 0;
    vSpeed = 0;
}

//Entering a building
var _entrance = instance_place(x, y, obj_EnterBuilding);
if (_entrance != noone && _entrance.linked_roof != noone) 
{
    // Only destroy the roof linked to this entrance
    with (_entrance.linked_roof) instance_destroy();
    
    // Debug
    show_debug_message("Destroyed roof for entrance at " + string(_entrance.x) + "," + string(_entrance.y));
}

//Exiting a building
var _exit = instance_place(x, y, obj_ExitBuilding);
if (_exit != noone && !instance_exists(_exit.linked_roof_type)) 
{
    // Recreate only THIS exit's specific roof
    instance_create_depth(
        _exit.roof_x, 
        _exit.roof_y,    
        _exit.roof_depth,  
        _exit.linked_roof_type  // obj_Roof, etc.
    );
    
    // Debug
    show_debug_message("Restored roof at " + string(_exit.roof_x) + "," + string(_exit.roof_y));
}