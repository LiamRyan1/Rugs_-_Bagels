event_inherited();
//if enemy health is 0 chage there color to red and fade out
//dont destroy instance in case of revive
if(hp <= 0)
{
	image_blend = c_red;
	image_alpha -= 0.01;
}