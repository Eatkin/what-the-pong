// Do stuff based on score
switch (room)	{
	case rm_level1:
		if (player_score > 0)
			room_goto_next()
		if (opponent_score > 0)
			room_restart();
		break;
	case rm_level2:
		if (player_score > 4)
			room_goto_next()
		if (opponent_score > 0)
			room_restart();
		break;
	case rm_level3:
		if (player_score > 3)
			room_goto_next()
		if (opponent_score > 3)
			room_restart();
		break;
}