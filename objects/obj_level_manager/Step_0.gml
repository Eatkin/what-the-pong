// Do stuff based on score
switch (room)	{
	case rm_level1:
		if (player_score > 0 or opponent_score > 0)
			level_end();
		break;
	case rm_level2:
		if (player_score >= target_score or opponent_score > 0)
			level_end();
		break;
	case rm_level3:
	case rm_level4:
		if (player_score > 3 or opponent_score > 3)
			level_end();
		break;
	case rm_level5:
		if (player_score > 15 or opponent_score > 15)
			level_end();
		break;
	case rm_level6:
		if (player_score > 2 or opponent_score > 0)
			level_end();
}