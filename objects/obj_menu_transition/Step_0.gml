timer += timer_step;
timer = clamp(timer, 0, 1);

var _coefficient = easeOutQuad(timer);
zoom = 1 + 2 * _coefficient * max(y, room_height - y) / sprite_get_height(sprite_index);

if (timer == 1)	{
	alpha += 0.05;
}

if (alpha >= 1)	{
	room_goto(target_room);
}