draw_set_alpha(alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);
draw_set_font(fnt_press_start_large);

draw_text_transformed(x, y, text, scale, scale, angle);

draw_set_alpha(1);
scr_reset_text_alignment();