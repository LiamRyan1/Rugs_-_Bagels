event_inherited()
spriteRun = sSkeleton1;
spriteIdle = sSkeleton1;
template = global.enemies.Skeleton;
if(room == rm_Village)
{
	Level = 1;
	show_debug_message("ran lvl 1");
}
else
{
	Level = round(random_range(2,3));
	show_debug_message("ran lvl " + string(Level));
	
}
enemy = scaleEnemyStats(template,Level);
