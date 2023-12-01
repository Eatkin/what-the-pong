if (!global.in_play)
	exit;
	

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);
draw_set_font(fnt_press_start_large);


if (scoreboard_style == ScoreboardStyle.PlayerOpponent)	{
	draw_text_transformed(x_centre - x_shift, y_centre, string(opponent_score), opponent_score_scale, opponent_score_scale, 0);
	draw_text(x_centre, y_centre, " - ");
	draw_text_transformed(x_centre + x_shift, y_centre, string(player_score), player_score_scale, player_score_scale, 0);
}
else if (scoreboard_style == ScoreboardStyle.PlayerOnly)	{
	score_text = string(player_score);
	draw_text_transformed(x_centre, y_centre, score_text, player_score_scale, player_score_scale, 0);
}
else if (scoreboard_style == ScoreboardStyle.PlayerCountdown)	{
	score_text = string(target_score - player_score);
	draw_text_transformed(x_centre, y_centre, score_text, player_score_scale, player_score_scale, 0);
}

scr_reset_text_alignment();