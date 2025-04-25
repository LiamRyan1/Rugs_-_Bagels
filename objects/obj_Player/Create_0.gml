s// Set the player's initial state
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

//idle sprites for 3 player
mySprites[0] = sPlayer;
mySprites[1] = sPlayer;
mySprites[2] = sPlayer2;


//running spites
mySpriteRun[0] = sPlayerRunning; 
mySpriteRun[1] = sPlayerRunning; 
mySpriteRun[2] = sPlayerRunning2; 


mySprite = irandom_range(0,2);

spriteRun = mySpriteRun[mySprite];
spriteIdle = mySprites[mySprite];
localFrame = 0;





