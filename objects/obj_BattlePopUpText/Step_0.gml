//image alpha = image opacity
image_alpha -= 0.02
if(vspeed < 0)  image_alpha = 1;
//stop moving when reaching the start position
if(y > ystart) vspeed = 0;
if(image_alpha <=0) instance_destroy();