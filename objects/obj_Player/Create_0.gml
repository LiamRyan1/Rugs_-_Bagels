/// @description Insert description here
// You can write your code in this editor
//boolean variables storing checks for keyboard inputs
var _key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_jump = keyboard_check(vk_space) || keyboard_check(ord("W")) || keyboard_check(vk_up);