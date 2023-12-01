angle = max_angle * dsin(rot_counter);

rot_counter += rot_rate;
rot_counter %= 360;

if (keyboard_check_pressed(vk_anykey) and yoffset == 0)	{
	instance_destroy();
	global.in_play = true;
}

yoffset = lerp(yoffset, 0, 0.1);
var threshold = 0.1;
if (yoffset < threshold)	{
	yoffset = 0;
}