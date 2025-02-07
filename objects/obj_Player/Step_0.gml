//store boolean checks for keyboard input
var _key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_up =   keyboard_check(vk_up)  ||keyboard_check(ord("W")) ;
var _key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));

//player angle and magnitude
var pDirection = point_direction(0,0,_key_right-_key_left,_key_down-_key_up);
var pMagnitude = (_key_right-_key_left !=0) || (_key_down-_key_down);

hsp = lengthdir_x(pMagnitude * walksp,pDirection);
vsp = lengthdir_y(pMagnitude * walksp,pDirection);
x += hsp;
y += vsp;
