if (x > room_width * 0.5)	{
	timer += timer_step;
	var _coefficient = easeOutCubic(timer);
	x = room_width * 1.5 - room_width * _coefficient;
}
else if (!active)	{
	timer -= timer_step;
	var _coefficient = easeOutCubic(timer);
	x = _coefficient * room_width - room_width * 0.5;
}