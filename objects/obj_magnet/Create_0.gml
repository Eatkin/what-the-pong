function easeOutBack(t) {
	// Ensure function is symmetrical
	t = abs(t - 0.5);
	var c1 = 1.70158;
	var c3 = c1 + 1;

	return 1 + c3 * power(t - 1, 3) + c1 * power(t - 1, 2);
}

pulse_max = room_speed * 3;
pulse = pulse_max;
pulsing = false;

timer = 0;
timer_step = 0.05;

yoffset = room_height * (0.5 + random(0.5));
lerp_strength = 0.1 - 0.05 + random(0.1);

movement_timer = 0;
movement_timer_step = 1 / (room_speed * 6);