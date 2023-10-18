angle = max_angle * dsin(rot_counter);

rot_counter += rot_rate;
rot_counter %= 360;

if (keyboard_check_pressed(vk_space))	{
	instance_destroy();
	global.in_play = true;
}