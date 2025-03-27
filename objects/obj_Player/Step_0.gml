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

if (place_meeting(x + hSpeed, y + vSpeed, obj_Player)) 
{
    // Resolve collision by pushing the player away in the opposite direction
    while (place_meeting(x + sign(hSpeed), y + sign(vSpeed), obj_Player))
    {
        x -= sign(hSpeed);
        y -= sign(vSpeed);
    }
    
    // Optionally, stop movement entirely if collision occurs
    hSpeed = 0;
    vSpeed = 0;
}
