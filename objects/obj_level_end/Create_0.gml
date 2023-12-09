function easeInBack(t) {
	var c1 = 1.70158;
	var c3 = c1 + 1;

	return c3 * t * t * t - c1 * t * t;
}

timer = 0;
timer_step = 1 / room_speed;

instance_destroy(obj_ball);

cam = view_camera[0];
alpha = 0;

global.in_play = false;

exit_to_menu = false;