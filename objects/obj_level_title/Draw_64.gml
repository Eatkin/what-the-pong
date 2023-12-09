// Draw in the centre of the screen, almost
var xx = room_width * 0.5;
var yy = room_height * 0.3 - yoffset;
if (room == rm_menu)
	yy -= room_height * 0.2;

// Draw the title
draw_set_font(fnt_press_start);
draw_set_halign(fa_center);
draw_set_colour(c_white);
draw_text_transformed(xx, yy, title, scale, scale, angle);

scr_reset_text_alignment();