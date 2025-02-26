distanceFromPlayer = 80;
moveSpeed = 1;
hSpeed = 0;
vSpeed = 0;

targetX = x;
targetY = y;

//call after 60 frames
alarm[0] = 60;
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));


spriteRun = sSkeleton1;
spriteIdle = sSkeleton1;
localFrame = 0;