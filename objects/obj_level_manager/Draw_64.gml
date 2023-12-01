if (!global.in_play)
	exit;
	

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);
draw_set_font(fnt_press_start_large);

var yy = y_centre - scoreboard_yoffset

if (scoreboard_style == ScoreboardStyle.PlayerOpponent)	{
	draw_text_transformed(x_centre - x_shift, yy, string(opponent_score), opponent_score_scale, opponent_score_scale, 0);
	draw_text(x_centre, yy, " - ");
	draw_text_transformed(x_centre + x_shift, yy, string(player_score), player_score_scale, player_score_scale, 0);
}
else if (scoreboard_style == ScoreboardStyle.PlayerOnly)	{
	score_text = string(player_score);
	draw_text_transformed(x_centre, yy, score_text, player_score_scale, player_score_scale, 0);
}
else if (scoreboard_style == ScoreboardStyle.PlayerCountdown)	{
	score_text = string(target_score - player_score);
	draw_text_transformed(x_centre, yy, score_text, player_score_scale, player_score_scale, 0);
}

scr_reset_text_alignment();