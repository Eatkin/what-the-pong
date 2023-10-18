// Functions that we'll trigger with various ball events
function hit_left()	{
	switch (room)	{
		case rm_level1:
		case rm_level3:
			player_score++;
			break;
			
		case rm_level2:
			opponent_score++;
			break;
	}
}
function hit_right()	{
	switch (room)	{
		case rm_level1:
		case rm_level3:
			opponent_score++;
			break;
			
		case rm_level2:
			player_score++;
			break;
	}
}

player_score = 0;
opponent_score = 0;

instance_create_layer(x, y, layer_get_id("UI"), obj_level_title);