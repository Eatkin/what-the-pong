if (active)	{
	if (mouse_x == clamp(mouse_x, bbox_left, bbox_right) and mouse_y == clamp(mouse_y, bbox_top, bbox_bottom) and !clicked)	{
		timer[1] += timer_step[1];
		if (ticker == noone)	{
			ticker = instance_create_layer(0, 0, layer, obj_level_ticker);
			ticker.text = level_name;
		}
		
		if (mouse_check_button_released(mb_left))	{
			clicked = true;
		}
	}
	else	{
		timer[1] -= timer_step[1];
		if (ticker != noone)	{
			ticker.active = false;
			ticker = noone;
		}
		
		if (timer[1] <= 0 and clicked and !instance_exists(obj_menu_transition))	{
			var _trans = instance_create_layer(x, y, layer, obj_menu_transition);
			_trans.target_room = level_id;
		}
	}
}
else	{
	delay--;
	var _coefficient = easeOutBack(timer[0]);
	if (delay <= 0)
		timer[0] += timer_step[0];
	y = ystart - room_height * (1 - _coefficient);
	timer[0] = clamp(timer[0], 0, 1);
	if (timer[0] == 1)
		active = true;
}

var _coefficient = easeOutCubic(timer[1]);
zoom = 1 + (max_zoom - 1) * _coefficient;
angle = max_angle * _coefficient;

timer[1] = clamp(timer[1], 0, 1);

image_angle = angle;
image_xscale = zoom;
image_yscale = zoom;