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
	draw_set_color(c_gray);
	if(_enemyUnit.hp > 0)
	{
		_drawn++;
		if(_enemyUnit.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
		draw_text(x+COLUMN_ENEMY,y+137+(i*12),_enemyUnit.name);
	}
}

//draw party info
for(var i = 0; i < array_length(partyUnits); i++)
{
	var _partyUnit = partyUnits[i];
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_gray);
	if(_partyUnit.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
	if(_partyUnit.hp <= 0) draw_set_color(c_red);	
	draw_text(x+COLUMN_NAME,y+135+(i*12),_partyUnit.name);
	draw_set_halign(fa_right);

	//draw health
	draw_set_color(c_gray);
	if(_partyUnit.hp < (_partyUnit.hpMax * 0.5)) draw_set_color(c_orange) ;
	if(_partyUnit.hp <= 0) draw_set_color(c_red);	
	draw_text(x+COLUMN_HP+25,y+135+(i*12),string(_partyUnit.hp) + "/" + string(_partyUnit.hpMax));

	//draw mp
	draw_set_color(c_gray);
	if(_partyUnit.mp < (_partyUnit.mpMax * 0.5)) draw_set_color(c_orange) ;
	if(_partyUnit.mp <= 0) draw_set_color(c_red);	
	draw_text(x+COLUMN_MP+25,y+135+(i*12),string(_partyUnit.mp) + "/" + string(_partyUnit.mpMax));
}
//Reset draw 
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);