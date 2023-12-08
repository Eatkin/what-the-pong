if (!global.in_play)	{
	exit;
}

if (!spinning)	{
	// Ease in to full size
	timer += timer_step;
	timer = min(1, timer);
	scale = 0.1 + 0.9 * easeOutBack(timer);
	if (timer == 1)	{
		spinning = true;
		timer = 0;
	}
}
else if (!full_speed)	{
	// Start warming up to full speed
	timer += timer_step;
	timer = min(1, timer);
	rot_speed = rot_speed_max * easeInSine(timer);
	if (timer == 1)	{
		full_speed = true;
	}
}

if (full_speed)	{
	ball_timer--;
	if (ball_timer == 0)	{
		// Little pulse
		image_xscale = 1.5;
		image_yscale = 1.5;
		
		// Sound
		var snd = snd_ballhit2;
		var pitch = 0.95 + random(0.1);
		audio_play_sound(snd, 0, false, 1, 0, pitch);
		
		base_rate--;
		// Don't go below 1 or it can turn negative and break
		base_rate = max(1, base_rate);
		
		ball_timer = base_rate + irandom(room_speed);
		var _angle = image_angle;
		// Ensure angle is NOT 90 or 270 otherwise ball stuck forever lol
		if (_angle == 90 or _angle == 270)	{
			_angle += choose(-5, 5);
		}
		var xx = x + sprite_width * 0.5 * dcos(_angle);
		var yy = y - sprite_height * 0.5 * dsin(_angle);
		var _ball = instance_create_layer(xx, yy, layer, obj_ball);
		// Set the ball's trajectory
		with (_ball)	{
			xspeed = maxspeed * dcos(_angle);
			yspeed = -maxspeed * dsin(_angle);
			yoffset = 0;
		}
	}
}


image_xscale = lerp(image_xscale, scale, 0.1);
image_yscale = lerp(image_yscale, scale, 0.1);
image_angle += rot_speed;
image_angle %= 360;