// Add collision map. Layer is Called "Col" in our tile layer
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
//h = horizontal  v = vertical  grv = gravity  sp = speed
hSpeed = 0;
vSpeed = 0;
walksp = 4;//4px

spriteRun = sPlayerRunning;
spriteIdle = sPlayer;
local_Frame = 0;