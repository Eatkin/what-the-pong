// Do stuff based on score
switch (room)	{
	case rm_level1:
		if (player_score > 0)
			level_end(true);
		if (opponent_score > 0)
			level_end(false);
		break;
	case rm_level2:
		if (player_score >= target_score)
			level_end(true);
		if (opponent_score > 0)
			level_end(false);
		break;
	case rm_level5:
		if (player_score > 15)
			level_end(true);
		if (opponent_score > 16)
			level_end(false);
		break;
	case rm_level6:
		if (player_score > 0)
			level_end(true);
		if (opponent_score > 0)
			level_end(false);
		break;
	case rm_level11:
		if (player_score > 4)
			level_end(true);
		if (opponent_score > 4)
			level_end(false);
		break;
	case rm_level12:
		if (player_score > 3 or opponent_score > 3)
			level_end(true);
		break;
	case rm_level13:
		if (player_score > 9 or opponent_score > 9)
			level_end(true);
		break;
	case rm_level14:
		if (player_score > 0 or opponent_score > 0)
			level_end(false);
		if (countdown_timer < 0)
			level_end(true);
		break;
	default:
		if (player_score > 3)
			level_end(true);
		if (opponent_score > 3)
			level_end(false);
		break;
}

// Lerp the scales
player_score_scale = lerp(player_score_scale, 1, 0.2);
opponent_score_scale = lerp(opponent_score_scale, 1, 0.2);

if (global.in_play)	{
	// Ease the scoreboard in
	timer -= timer_step;
	timer = max(0, timer);
	scoreboard_yoffset = scoreboard_yoffset_start * easeInElastic(timer);
	
	// Deal with the countdown timer
	if (scoreboard_style == ScoreboardStyle.Countdown)	{
		countdown_ticks -= 1;
		if (countdown_ticks == 0)	{
			countdown_ticks = room_speed;
			if (countdown_timer > 0)	{
				create_text_particle(x_centre, y_centre, string(countdown_timer));
				var pitch = 0.95 + random(0.1);
				audio_play_sound(snd_score, 0, false, 1, 0, pitch);
				player_score_scale = 2;			// Used to zoom the countdown number
			}
			countdown_timer--;
		}
	}
}