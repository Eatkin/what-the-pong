image_angle += 1;

// Pulse every so often to look cool
pulse--;
if (pulse == 0)	{
	pulsing = true;
	pulse = pulse_max;
}

if (pulsing)	{
	var _scale = 2 - easeOutBack(timer);
	image_xscale = _scale;
	image_yscale = _scale;
	timer += timer_step;
	if (timer >= 1)	{
		timer = 0;
		pulsing = false;
	}
}

// Lerp into level at level start
yoffset = lerp(yoffset, 0, lerp_strength);
var threshold = 2;
if (yoffset < threshold)	{
	yoffset = 0;
}

// Oscillate up and down
movement_timer += movement_timer_step;
movement_timer %= 1;

y = ystart + dsin(movement_timer * 360) * room_height * 0.4;