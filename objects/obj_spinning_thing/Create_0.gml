function easeOutBack(t) {
	var c1 = 1.70158;
	var c3 = c1 + 1;

	return 1 + c3 * power(t - 1, 3) + c1 * power(t - 1, 2);
}

function easeInSine(t) {
  return 1 - cos((t * pi) / 2);
}

scale = 0.1;
image_xscale = scale;
image_yscale = scale;

timer = 0;
timer_step = 1/room_speed;

spinning = false;
rot_speed = 0;
rot_speed_max = 30;

full_speed = false;
base_rate = 30;
ball_timer = base_rate + irandom(room_speed);