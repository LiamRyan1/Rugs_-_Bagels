// Set the player's initial state
state = PlayerStateFree;

// Ensure lastState is initialized properly
lastState = PlayerStateFree;

// Add collision map. Layer is Called "Col" in our tile layer
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
//h = horizontal  v = vertical  grv = gravity  sp = speed
hSpeed = 0;
vSpeed = 0;
walksp = 2;//4px

controllerID = undefined;

//idle sprites for 4 player
mySprites[0] = sPlayer;
mySprites[1] = sPlayer;
mySprites[2] = sPlayer;
mySprites[3] = sPlayer;

//running spites
mySpriteRun[0] = sPlayerRunning; 
mySpriteRun[1] = sPlayerRunning; 
mySpriteRun[2] = sPlayerRunning; 
mySpriteRun[3] = sPlayerRunning; 

mySprite = irandom_range(0,3);

spriteRun = mySpriteRun[mySprite];
spriteIdle = mySprites[mySprite];
localFrame = 0;





