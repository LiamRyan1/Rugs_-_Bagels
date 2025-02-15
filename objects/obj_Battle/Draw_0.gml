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

//draw enemy names
var _drawn = 0;
draw_set_font(Fnt_Battle_Screen);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
for(var i = 0; (i < array_length(enemyUnits)) && (_drawn < 3); i++)
{
	var _enemyUnit = enemyUnits[i];
	if(_enemyUnit.hp > 0)
	{
		_drawn++;
		if(_enemyUnit.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
		draw_text(x+COLUMN_ENEMY,y+137+(i*12),_enemyUnit.name);
	}
}

//draw player name
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
if(player.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
if(player.hp <= 0) draw_set_color(c_red);	
draw_text(x+COLUMN_NAME,y+127+(i*12),player.name);
draw_set_halign(fa_right);

//draw health
draw_set_color(c_gray);
if(player.hp < (player.hpMax * 0.5)) draw_set_color(c_orange) ;
if(player.hp <= 0) draw_set_color(c_red);	
draw_text(x+COLUMN_HP+20,y+127+(i*12),string(player.hp) + "/" + string(player.hpMax));

//draw mp
draw_set_color(c_gray);
if(player.mp < (player.mpMax * 0.5)) draw_set_color(c_orange) ;
if(player.mp <= 0) draw_set_color(c_red);	
draw_text(x+COLUMN_MP+20,y+127+(i*12),string(player.mp) + "/" + string(player.mpMax));

//Reset draw 
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);