enum ScoreboardStyle {
	PlayerOpponent,
	PlayerOnly,
	PlayerCountdown,
	SlimeVolleyball,
	Countdown,
	None,
}

level_ended = false;

function level_end(_won)	{
	if (level_ended)	{
		return 0;
	}
	
	level_ended = true;
	var vars = {
		win: _won
	};
	instance_create_layer(0, 0, layer, obj_level_end, vars);
	
	if (_won)	{
		instance_destroy(obj_opponent_paddle);
	}
	else	{
		instance_destroy(obj_player_paddle);
	}
}

function create_text_particle(xx, yy, txt)	{
	var vars = {
		text: txt,
	};
	instance_create_layer(xx, yy, layer, obj_text_particle, vars);
}

function create_particle(xx, yy, sprite, img_index)	{
	var _part = instance_create_layer(xx, yy, layer, obj_sprite_particle);
	_part.sprite_index = sprite;
	_part.image_index = img_index;
}

function easeInElastic(t) {
	var c4 = (2 * pi) / 3;
	return (t == 0) ? 0 : ((t == 1) ? 1 :  -power(2, 10 * t - 10) * sin((t * 10 - 10.75) * c4));
}

x_centre = room_width * 0.5;
y_centre = room_height * 0.1;
x_shift = string_width(" - ");

// Functions that we'll trigger with various ball events
function hit_left()	{
	var snd = noone;
	
	switch (room)	{			
		case rm_level2:
		
			create_text_particle(x_centre, y_centre, string(target_score - player_score));
			player_score++;
			player_score_scale = 2;
			timer = 0.9;
			snd = snd_score;
			break;
			
		case rm_level11:
			player_score++;
			timer = 0.9;
			snd = snd_score;
			var xx = room_width * 0.75 + slime_x_offset + slime_spacing * (player_score - 1);
			create_particle(xx, y_centre, spr_slimevolley_score, 1);
			break;
			
		case rm_level14:
			opponent_score++;
			snd = snd_opponent_score;
			break;
			
		case rm_level18:
			// Do nothing
			break;
			
		default:
			create_text_particle(x_centre + x_shift, y_centre, string(player_score));
			player_score++;
			player_score_scale = 2;
			timer = 0.9;
			snd = snd_score;
			break;
	}
	
	if (snd != noone)	{
		var pitch = 0.95 + random(0.1);
		audio_play_sound(snd, 0, false, 1, 0, pitch);
	}
}
function hit_right()	{
	var snd = noone;
	
	switch (room)	{			
		case rm_level2:
			opponent_score++;
			snd = snd_opponent_score;
			break;
			
		case rm_level11:
			opponent_score++
			timer = 0.9;
			snd = snd_opponent_score;
			var xx = room_width * 0.25 + slime_x_offset + slime_spacing * (player_score - 1);
			create_particle(xx, y_centre, spr_slimevolley_score, 1);
			break;
			
		case rm_level14:
		case rm_level18:
			opponent_score++;
			snd = snd_opponent_score;
			break;
			
		default:
			create_text_particle(x_centre - x_shift, y_centre, string(opponent_score));
			opponent_score++;
			opponent_score_scale = 2;
			timer = 0.9;
			snd = snd_opponent_score;
			break;
	}
	
	if (snd != noone)	{
		var pitch = 0.95 + random(0.1);
		audio_play_sound(snd, 0, false, 1, 0, pitch);
	}
}

player_score = 0;
opponent_score = 0;
target_score = 0;
player_score_scale = 1;
opponent_score_scale = 1;

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
	case rm_level11:
		scoreboard_style = ScoreboardStyle.SlimeVolleyball;
		target_score = 5;
		break;
	case rm_level14:
		scoreboard_style = ScoreboardStyle.Countdown;
		break;
	case rm_level18:
		scoreboard_style = ScoreboardStyle.None;
		break;
	default:
		scoreboard_style = ScoreboardStyle.PlayerOpponent;
		break;
}

instance_create_layer(0, 0, layer, obj_camera);

scoreboard_yoffset_start = 2 * y_centre;
scoreboard_yoffset = scoreboard_yoffset_start;
timer = 1;
timer_step = 1 / room_speed;

// Define some coordinates for the slime volleyball style scoreboard
slime_spacing = 12 + sprite_get_width(spr_slimevolley_score);
slime_x_offset = -slime_spacing * 2;

// This is for survival levels
countdown_timer = 10;
countdown_ticks = room_speed;

// Make the exit level button
instance_create_layer(0, 0, layer, obj_end_level_button);