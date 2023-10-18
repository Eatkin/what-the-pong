// draw_rectangle(-extend_bounds, -extend_bounds, room_width + extend_bounds, room_height + extend_bounds, false);
var mixed_colours;
for (var i = 0; i < array_length(colours); i++)	{
	mixed_colours[i] = make_colour_rgb(colours[i][0], colours[i][1], colours[i][2]);
}
draw_rectangle_color(-extend_bounds, -extend_bounds, room_width + extend_bounds, room_height + extend_bounds, mixed_colours[0], mixed_colours[1], mixed_colours[2], mixed_colours[3], false)