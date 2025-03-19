// In your Draw GUI
if (instance_exists(obj_Dialogue)) {
    var gui_h = display_get_gui_height(); 
    var _dx = 0;
    var _dy = gui_h * 0.7;
    var _boxw = display_get_gui_width();
    var _boxh = gui_h - _dy;

    // Draw the stretched text box sprite
    draw_sprite_stretched(sTextboxes, 0, _dx, _dy, _boxw, _boxh);
    
    // Get the current message from obj_Dialogue
    var _msg = obj_Dialogue.messages[obj_Dialogue.current_message].msg;

    // Set the font and color for drawing text
    draw_set_font(Fnt_Textboxes);
    draw_set_color(c_white); 

    // Draw the text on top of the sprite
    var _text_x = _dx + 16; 
    var _text_y = _dy + 16; 
    draw_text_ext(_text_x, _text_y, _msg, -1, 150);
}
