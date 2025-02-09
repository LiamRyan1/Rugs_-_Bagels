function PlayerAnimation(){
//convert degrees to number(0-3) where each number is a cardinal direction
var _cardinalDirection = round(direction/90);
//find total number of frames per direction,  where 4 is the number of directions
var _totalFrames = sprite_get_number(sprite_index) /4;
//find current frame
image_index = local_Frame + (_cardinalDirection * _totalFrames);
//game updates local frame every 4 frames
local_Frame += sprite_get_speed(sprite_index) / FRAME_RATE;

//looping animations
if(local_Frame >= _totalFrames)
{
	animationEnd = true;
	//go back to start of animation
	local_Frame -= _totalFrames;
}
else animationEnd = false;

}