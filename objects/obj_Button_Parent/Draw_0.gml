//draw button with text aligned center 
draw_self();
draw_set_font(Fnt_Menu);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//draw text at position of button
draw_text(x,y,buttonText);

//reset draw values to defaults
draw_set_halign(fa_center);
draw_set_valign(fa_middle);