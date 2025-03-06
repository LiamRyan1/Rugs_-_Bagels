var _dx = 0;
var _dy = gui_h * 0.7;
var _boxw = gui_w;
var _boxh = gui_h - _dy;

draw_sprite_stretched(sTextboxes, 0, _dx, _dy, _boxw, _boxh);

_dx += 16;
_dy += 16;

draw_set_font(Fnt_Textboxes);

// NPC name
var _name = messages[current_message].name;
// $ grabs the name variable
draw_set_color(global.char_colors[$ _name]);
draw_text(27, 150, _name);
draw_set_color(c_white);

_dy += 40;

//  draw_text_ext Draws the dialogue box with word wrapping
draw_text_ext(140, 140, draw_message, -1, _boxw - _dx * 2);