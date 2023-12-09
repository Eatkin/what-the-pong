function easeOutCubic(t) {
	return 1 - power(1 - t, 3);
}

active = true;

text = "undefined";

x = room_width * 1.5;
y = room_height * 0.25;

timer = 0;
timer_step = 2 / room_speed;