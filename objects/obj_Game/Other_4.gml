if(room == rm_Village)
{
	global.enemies.Skeleton.Level = random_range(1,1);
}
else
{
	global.enemies.Skeleton.Level =round(random_range(2,3));
	show_debug_message("ran enemy lvl now: " + string(global.enemies.Skeleton.Level));
}
scaleEnemyStats();