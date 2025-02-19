// Add 50th to lerp progress and number gets lower and lower until it hits 1 so it knows to finish
lerpProgress += (1 - lerpProgress) / 50;
// Adds 0.75 to itself every frame
textProgress += global.textSpeed;

// simple animation. lerpProgress starts at x1 and moves until x1Target
x1 = lerp(x1, x1Target, lerpProgress);
x2 = lerp(x2, x2Target, lerpProgress);

// Spacebar destroys message and Spacebar speeds up message to match _messageLength
if (keyboard_check_pressed(vk_space))
{
	var _messagelength = string_length(message);
	if (textProgress >= _messagelength)
	{
		instance_destroy();
	}
	else
	{
		if(textProgress > 2)
		{
			textProgress = _messagelength
		}
	}
}
