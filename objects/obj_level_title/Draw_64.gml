// Draw in the centre of the screen, almost
var xx = room_width * 0.5;
var yy = room_height * 0.3 - yoffset;

// Draw the title
draw_set_font(fnt_press_start);
draw_set_halign(fa_center);
draw_set_colour(c_white);
draw_text_transformed(xx, yy, title, 1, 1, angle);

scr_reset_text_alignment();