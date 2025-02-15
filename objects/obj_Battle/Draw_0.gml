//background art
draw_sprite(battleBackground,0,x,y);

//Action Screen
draw_sprite_stretched(sScreen,0,x+75,y+120,245,60);
draw_sprite_stretched(sScreen,0,x,y+120,74,60);

//Units in depth order
var _unitWithCurrentTurn = unitTurnOrder[turn].id;
for(var i = 0; i< array_length(unitRenderOrder); i++)
{
	with(unitRenderOrder[i])
	{
		draw_self();
	}
}


//Heading
draw_set_font(Fnt_Battle_Screen);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(x+COLUMN_ENEMY,y+125,"Enemy");
draw_text(x+COLUMN_NAME,y+125,"Name");
draw_text(x+COLUMN_HP,y+125,"HP");
draw_text(x+COLUMN_MP,y+125,"MP");