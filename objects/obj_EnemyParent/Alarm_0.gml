if(instance_exists(obj_Player) && distance_to_object(obj_Player) < distanceFromPlayer)
{
	targetX = obj_Player.x;
	targetY = obj_Player.y;
}
else
{
	targetX = random_range(xstart - 50, xstart + 50);
	targetY = random_range(ystart - 50, ystart + 50);
}
//reset timer
alarm[0] = 60;