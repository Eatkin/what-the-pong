if (mouse_x == clamp(mouse_x, bbox_left, bbox_right) and mouse_y == clamp(mouse_y, bbox_top, bbox_bottom))	{
	timer += timer_step;
	if (mouse_check_button_released(mb_left) and !instance_exists(obj_level_end))	{
		var pitch = 0.95 + random(0.1);
		audio_play_sound(snd_score, 0, false, 1, 0, pitch);
		var _end = instance_create_layer(x, y, layer, obj_level_end, {win: false});
		_end.exit_to_menu = true;
		clicked = true;
	}
}
else	{
	timer -= timer_step;
}

timer = clamp(timer, 0, 1);

var _coefficient = easeOutBack(timer);
var scale = 1 + 0.2 * _coefficient;
image_xscale = scale;
image_yscale = scale;

if (clicked)	{
	image_alpha = lerp(image_alpha, 0, 0.1);
}