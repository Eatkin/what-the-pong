function easeOutCubic(t) {
	return 1 - power(1 - t, 3);
}

function easeOutBack(t) {
	var c1 = 1.70158;
	var c3 = c1 + 1;

	return 1 + c3 * power(t - 1, 3) + c1 * power(t - 1, 2);
}

angle = 0;
max_angle = -8;
zoom = 1;
max_zoom = 1.5;

timer = [0, 0];
timer_step = [1 / room_speed, 2 / room_speed];

active = false;

ticker = noone;

clicked = false;