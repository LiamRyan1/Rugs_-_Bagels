//Quest kill skeletons
if(room == rm_Forest && !instance_exists(obj_Skeleton))
{
	global.forestcleared = true;
}
//QUEST kill necormancer
if(room == rm_Boss && !instance_exists(obj_Necormancer))
{
	global.NecromancerDead = true;
}