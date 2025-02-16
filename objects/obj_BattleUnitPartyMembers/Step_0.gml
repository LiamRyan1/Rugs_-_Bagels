event_inherited();
if(hp <=  0)
{
	sprite_index = Sprites.down;
}
else
{
	if(sprite_index == Sprites.down)sprite_index = Sprites.idle;
}