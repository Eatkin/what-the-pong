x = mouse_x;
y = mouse_y;

image_angle += rot_speed;
image_angle %= 360;

if ((place_meeting(x, y, obj_menu_button) and !instance_exists(obj_menu_transition)) or place_meeting(x, y, obj_end_level_button))	{
	target_scale = 1;
	target_alpha = 1;
}
else	{
	target_scale = 0.5;
	target_alpha = 0.5;
}

scale = lerp(scale, target_scale, 0.5);
image_xscale = scale;
image_yscale = scale;
image_alpha = lerp(image_alpha, target_alpha, 0.5);