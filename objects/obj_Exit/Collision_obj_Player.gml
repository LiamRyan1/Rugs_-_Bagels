


room_goto(self.targetRoom);
for (var i = 0; i < instance_number(obj_Player); i++) {
    var _player = instance_find(obj_Player, i);
	_player.x = self.targetX;
	_player.y = self.targetY;
}
