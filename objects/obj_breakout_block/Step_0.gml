y += yspeed;

// Destroy when exceeding room bounds
if (y != clamp(y, -2 * sprite_height, room_height + 2 * sprite_height))	{
	instance_destroy();
}

if (hit)	{
	var _scale = 0.5 - 0.5 * easeInBack(timer);
	timer += timer_step;
	
	image_xscale = _scale;
	image_yscale = _scale;
	
	if (timer >= 1)	{
		instance_destroy();
	}
}