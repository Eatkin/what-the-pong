function easeOutCubic(t) {
	return 1 - power(1 - t, 3);
}

angle = 0;
max_angle = -10;
zoom = 1;
max_zoom = 1.5;

timer = 0;
timer_step = 2 / room_speed;