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
Name = "Player"+string(instance_number(obj_Player));
array_push(global.party,
{
	name: Name,
	Level: 1,
	playerId: controllerID,
	baseStats: { Vitality: 10, Strength: 10, Dexterity: 20, Magic: 10,Spirit: 10},
	scaling: { Vitality: 2, Strength: 2, Dexterity: 2, Magic: 1,Spirit: 1},
	xpRequiredMultiplier:4,
	currentXp:0,
	Sprites : {idle: sPlayerIdle,down: sPlayerDead},
	actions: [global.actionLibrary.lightning,global.actionLibrary.attack]
},);
scalePartyStats();
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





