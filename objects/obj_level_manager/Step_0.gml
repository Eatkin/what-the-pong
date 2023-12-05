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

// Ease the scoreboard in
if (global.in_play)	{
	timer -= timer_step;
	timer = max(0, timer);
	scoreboard_yoffset = scoreboard_yoffset_start * easeInElastic(timer);
}