// @description set up players cameras

view_visible = true;
global.Cameras = undefined;
persistent = true;
for (var i = 0; i < 11; i++) {
	if (gamepad_is_connected(i)) {
		addPlayer(i);
	}
}