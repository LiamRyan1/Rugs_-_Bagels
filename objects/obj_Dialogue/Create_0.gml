messages = [];
// -1 means dialogue hasn't started yet
current_message = -1;
current_char = 0;
draw_message = "";

char_speed = 0.5;
// Speed up text and move to the next message
input_key = vk_space;

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
