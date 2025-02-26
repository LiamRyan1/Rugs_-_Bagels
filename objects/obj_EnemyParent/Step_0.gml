var _collisionHappened = PlayerCollision();
var _hor = clamp(targetX-x,-1,1);
var _ver = clamp(targetY-y,-1,1);
move_and_collide(_hor*moveSpeed,_ver*moveSpeed,collisionMap);
//player angle and magnitude
var _eDirection = point_direction(0,0,_hor ,_ver);
var _eMagnitude = (_hor  !=0) || (_ver != 0);
//enemy moving animation 
//Update sprite index
var _oldSprite = sprite_index;
//when moving
if(_eMagnitude != 0)
{
	//holds angle player is moving in
	direction = _eDirection;
	sprite_index = spriteRun;
}
else sprite_index = spriteIdle;
//reset local frame on sprite switch to start on first frame
if(_oldSprite != sprite_index) localFrame = 0;
PlayerAnimation();