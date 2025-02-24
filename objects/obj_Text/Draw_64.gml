/// @desc Draw Textbox

// Draw the 9-slice box
draw_sprite_stretched(sTextboxes,0,0,120,x2,y2);

// Set our font
draw_set_font(Fnt_Textboxes);

// Horizontal alignment
draw_set_halign(fa_center);

// Vertical alignment
draw_set_valign(fa_top);

// Font color
draw_set_color(c_black);

// Extract part of the message to display
var _print = string_copy(message, 1, textProgress);

// Draw text twice to give a shadow effect
draw_text((x1 + x2) / 2, y + 30, _print);
draw_set_color(c_white);
draw_text((x1 + x2) / 2, y + 30, _print);