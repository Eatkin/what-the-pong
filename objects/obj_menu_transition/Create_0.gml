function easeOutQuad(t) {
	return 1 - (1 - t) * (1 - t);
}

timer = 0;
timer_step = 2 / room_speed;

zoom = 1;

alpha = 0;

target_room = rm_menu;