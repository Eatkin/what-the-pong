if (!global.in_play)
	exit;
	
var xx = room_width * 0.5;
var yy = room_height * 0.1;

score_text = "";

if (scoreboard_style == ScoreboardStyle.PlayerOpponent)	{
	score_text = string(opponent_score) + " - " + string(player_score);
}
else if (scoreboard_style == ScoreboardStyle.PlayerOnly)	{
	score_text = string(player_score);
}
else if (scoreboard_style == ScoreboardStyle.PlayerCountdown)	{
	score_text = string(target_score - player_score);
}

draw_set_halign(fa_center);
draw_set_colour(c_white);
draw_set_font(fnt_press_start_large);
draw_text(xx, yy, score_text);
scr_reset_text_alignment();