
var _offset = 0;

room_goto(self.targetRoom);
for (var i = 0; i < instance_number(obj_Player); i++) {
    var _player = instance_find(obj_Player, i);
	_player.x = self.targetX+_offset;
	_player.y = self.targetY+_offset;
	_offset += 15;
}
