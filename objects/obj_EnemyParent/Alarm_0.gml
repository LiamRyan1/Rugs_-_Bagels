var _closestPlayer = 81;
var _TargetPlayer = false;
with (obj_Player) {
	var _dist = point_distance(other.x, other.y, x, y);
	if(_dist < _closestPlayer)
	{
		_closestPlayer = _dist;
		if(_dist < other.AggrodistanceFromPlayer) 
		{
			other.targetX = x;
			other.targetY =y;
			_TargetPlayer = true;
		}
		
	}
}
if(!_TargetPlayer)
{
	targetX = random_range(xstart - 50, xstart + 50);
	targetY = random_range(ystart - 50, ystart + 50);
}
//reset timer
alarm[0] = 60;