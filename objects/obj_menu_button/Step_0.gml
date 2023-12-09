if (mouse_x == clamp(mouse_x, bbox_left, bbox_right) and mouse_y == clamp(mouse_y, bbox_top, bbox_bottom))	{
	timer += timer_step;
}
else	{
	timer -= timer_step;
}

var _coefficient = easeOutCubic(timer);
zoom = 1 + (max_zoom - 1) * _coefficient;
angle = max_angle * _coefficient;

timer = clamp(timer, 0, 1);

image_angle = angle;
image_xscale = zoom;
image_yscale = zoom;