draw_sprite_stretched(sScreen,0,x,y,widthFull,heightFull);
draw_set_color(c_white);
draw_set_font(Fnt_Battle_Screen);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _desc = (description != -1);
//how far past the top of the menu u are
var _scrollPush = max(0,hover -(visibleOptionsMax -1));
for(line = 0; line<(visibleOptionsMax + _desc); line++)
{
	if(line >= array_length(options)) break;
	draw_set_color(c_white);
	if(line == 0) && (_desc)
	{
		draw_text(x + xMargin, y + yMargin, description);
	}
	else
	{
		var _optionToShow = line - _desc + _scrollPush;
		var _string = options[_optionToShow][0];
		if(hover == _optionToShow - _desc)
		{
			draw_set_color(c_yellow);
		}
		if(options[_optionToShow][3] == false) draw_set_color(c_gray);
		draw_text(x + xMargin, y + yMargin + line * heightLine, _string);
	}
}
draw_sprite(sPointer, 0 , x + xMargin + 8, y + yMargin +((hover - _scrollPush) *heightLine)+7);
if(visibleOptionsMax < array_length(options)) && (hover < array_length(options)- 1)
{
	draw_sprite(sDownArrow,0,x+widthFull*0.5, y + heightFull - 7);
}
