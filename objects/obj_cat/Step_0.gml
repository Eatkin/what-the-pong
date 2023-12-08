if (!instance_exists(obj_ball))	{
	image_speed = 1;
	exit;
}

if (!global.in_play)	{
	exit;
}

image_angle = point_direction(x, y, obj_ball.x, obj_ball.y);
speed = lerp(speed, 0, 0.1);

// Count down the timers
timer[0]--;

if (timer[0] <= 0)	{
	image_speed = 0;
	timer[1]--;
}
if (timer[1] <= 0)	{
	var max_speed = min(launch_speed, distance_to_object(obj_ball) + obj_ball.sprite_width * 0.5);
	move_towards_point(obj_ball.x, obj_ball.y, max_speed);
	if (place_meeting(x, y, obj_ball))	{
		set_timers();
		image_speed = 1;
		obj_ball.xspeed *= -1;
		obj_ball.yspeed *= -1;
		var snd = snd_ballhit3;
		var pitch = 0.95 + random(0.1);
		audio_play_sound(snd, 0, false, 1, 0, pitch);
	}
}