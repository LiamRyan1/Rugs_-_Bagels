// x1,y1 is top left. x2, y2 bottom right
// Coordinates are screen relevant and not room relevant
// Draw line in middle of the screen and text box will grow out left and right
x1 = RESOLUTION_W/2;
y1 = RESOLUTION_H - 70;
x2 = RESOLUTION_W/2;
y2 = RESOLUTION_H/3;

//X1 Grows to 0 and x2 grows to our width
x1Target = 0;
x2Target = RESOLUTION_W;

// At 0 we have started and when it reaches 1 it finishes
lerpProgress = 0;
// At 0 text has not started at 1 it finishes and moves by textSpeed
textProgress = 0;