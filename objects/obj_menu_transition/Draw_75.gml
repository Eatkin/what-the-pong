if (alpha > 0)	{
	draw_set_colour(c_black);
	draw_set_alpha(alpha);
	draw_rectangle(-10, -10, room_width + 10, room_height + 10, false);
	draw_set_alpha(1);
}