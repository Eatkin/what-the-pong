enum ScoreboardStyle {
	PlayerOpponent,
	PlayerOnly,
	PlayerCountdown,
}

// Functions that we'll trigger with various ball events
function hit_left()	{
	switch (room)	{			
		case rm_level2:
			opponent_score++;
			break;
			
		default:
			player_score++;
			break;
	}
}
function hit_right()	{
	switch (room)	{			
		case rm_level2:
			player_score++;
			break;
			
		default:
			opponent_score++;
			break;
	}
}

player_score = 0;
opponent_score = 0;
target_score = 0;

instance_create_layer(x, y, layer_get_id("UI"), obj_level_title);


switch (room)	{
	case rm_level1:
		scoreboard_style = ScoreboardStyle.PlayerCountdown;
		target_score = 1;
		break;
	case rm_level2:
		scoreboard_style = ScoreboardStyle.PlayerCountdown;
		target_score = 5;
		break;
	default:
		scoreboard_style = ScoreboardStyle.PlayerOpponent;
		break;
}