function easeOutBack(t) {
	var c1 = 1.70158;
	var c3 = c1 + 1;

	return 1 + c3 * power(t - 1, 3) + c1 * power(t - 1, 2);
}

timer = 0;
timer_step = 2 / room_speed;

x = room_width - sprite_width * 0.65;
y = sprite_height * 0.65;

clicked = false;