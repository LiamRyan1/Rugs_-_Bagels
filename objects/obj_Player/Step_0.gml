//store boolean checks for keyboard input
var _key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_up =   keyboard_check(vk_up)  ||keyboard_check(ord("W")) ;
var _key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));

//player angle and magnitude
var pDirection = point_direction(0,0,_key_right-_key_left,_key_down-_key_up);
var pMagnitude = (_key_right-_key_left !=0) || (_key_down-_key_up != 0);

hSpeed = lengthdir_x(pMagnitude * walksp,pDirection);
vSpeed = lengthdir_y(pMagnitude * walksp,pDirection);

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


