function easeInBack(t) {
	var c1 = 1.70158;
	var c3 = c1 + 1;

	return c3 * t * t * t - c1 * t * t;
}

var _scale = 0.5;
image_xscale = _scale;
image_yscale = _scale;

yspeed = 2;

hit = false;

timer = 0;
timer_step = 4 / room_speed;