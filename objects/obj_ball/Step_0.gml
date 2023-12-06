image_angle += rotation_speed * rotation_dir;

yoffset = lerp(yoffset, 0, lerp_strength);
var threshold = 2;
if (yoffset < threshold)	{
	yoffset = 0;
}

if (!global.in_play)	{
	exit;
}

// Save parameters and reset so collision checks work
var angle = image_angle;
var xs = image_xscale;
var ys = image_yscale;
image_angle = 0;
image_xscale = 1;
image_yscale = 1;
var paddle_collision = false;
var wall_collision = false;

// Basic pong movement
if (check_property(BallProperties.NormalMovement))	{
	// Movement with collision with paddles and also the room boundaries
	// First check the collision with the paddles because it's a bit more involved
	if (collision_line(x, y, x + xspeed, y, par_paddle, false, true) == noone)	{
		x += xspeed;
	}
	else	{
		paddle_collision = true;
		// Move to contact point
		while (!place_meeting(x + sign(xspeed), y, par_paddle))	{
			x += sign(xspeed);
		}
		// Also might be inside of the paddle so move out of it
		while (place_meeting(x, y, par_paddle))	{
			x -= sign(xspeed);
		}
		// Now get the paddle's yspeed and also our offset
		var paddle = instance_place(x + sign(xspeed), y, par_paddle);
		var paddle_ys = paddle.yspeed / paddle.maxspeed;
		var offset = 2 * (y - paddle.y) / paddle.sprite_height;
		// Determine how much the offset from centre should affect balls angle
		// I.e. if the offset is at maximum, it will add this angle onto the ball
		// Same with speed
		var offset_strength = 40;		
		var movement_strength = 40;
		var rebound_angle = 180 + offset_strength * offset + movement_strength * paddle_ys;
		
		// If xspeed is negative then we mirror the angle in the y-axis
		if (sign(xspeed) == -1)
			rebound_angle = 180 - rebound_angle;
		
		// What is our angle already? Xspeed will never be 0 (probably)
		// Also that isn't a problem because darctan2 accounts for that
		// We use negative because our rebound angle will be the opposite direction to this direction
		var _dir = darctan2(yspeed, -xspeed);
		
		// Just take a simple average 
		rebound_angle -= (rebound_angle - _dir) * 0.5;
		
		// Calculate our new speed components
		// Note to future Ed: cos(0) is NOT equal to cos(180)
		if (check_property(BallProperties.SpeedUp))	{
			maxspeed *= 1.2;
		}
		xspeed = -sign(xspeed) * maxspeed * abs(dcos(rebound_angle));
		yspeed -= dsin(rebound_angle) * maxspeed;
		xs = 2;
		
		// Check if the paddle is the player's paddle, and if so we do some property checks
		if (instance_exists(obj_player_paddle) and paddle.object_index == obj_player_paddle.object_index)	{
			if (paddle.check_property(PlayerProperties.Shrinkray))	{
				// Halve paddle size, don't go below 1 pixels
				paddle.target_yscale = max(1/sprite_get_height(paddle.sprite_index), paddle.image_yscale * 0.5);
				// Make opponent a little bit worse every halving
				obj_opponent_paddle.lag_timer_max = round(obj_opponent_paddle.lag_timer_max * 1.1);
			}
		}
	}

	// Collisions with top/bottom of paddle (it's basically the same as above but simpler)
	if (collision_line(x, y, x, y + yspeed, par_paddle, false, true) == noone)	{
		y += yspeed;
	}
	else	{
		paddle_collision = true;
		// Move to contact point	
		while (!place_meeting(x, y + sign(yspeed), par_paddle))	{
			y += sign(yspeed);
		}
		// We will not get stuck inside since that is accounted for in the x-movement
		// Simple physics - just rebound against the paddle
		yspeed *= -1;
		ys = 2;
	}

	// Contact with room_boundaries
	// Rebound left/right
	if (bbox_left < 0 or bbox_right > room_width)	{
		xspeed *= -1;
		x = clamp(x, sprite_width * 0.5, room_width - sprite_width * 0.5);
		xs = 2;
		
		// Trigger even with obj_level_manager
		var xx = x;
		with (obj_level_manager)	{
			if (xx < room_width * 0.5)
				hit_left();
			else
				hit_right();
		}
		
		// Destroy if the destroy property is on
		if (check_property(BallProperties.DestroyOnWall) and instance_number(obj_ball) > 1)	{
			instance_destroy();
		}
		
		wall_collision = true;
	}
	// Rebound top/bottom
	if (bbox_top < 0 or bbox_bottom > room_height)	{
		yspeed *= -1;
		rotation_dir *= -1;
		y = clamp(y, sprite_height * 0.5, room_height - sprite_height * 0.5);
		ys = 2;
		wall_collision = true;
	}
	
	// Collide with the breakout blocks - keep it simple
	if (place_meeting(x + xspeed, y, obj_breakout_block))	{
		var _block = instance_place(x + xspeed, y, obj_breakout_block);
		if (!_block.hit)	{
			xspeed *= -1;
		}
		with (_block)	{
			hit = true;
		}
		
		paddle_collision = true;
		
		xs = 2;
		ys = 2;
	}
}

// Pong movement with gravity
if (check_property(BallProperties.Gravity))	{
	yspeed += grav;
	// No max speed and we have a coefficient of restitution of 1
	// First deal with collisions with paddle - hitting side of paddle
	if (!place_meeting(x + xspeed, y, par_paddle))	{
		x += xspeed;
	}
	else	{
		paddle_collision = true;
		// Move to contact point
		while (!place_meeting(x + sign(xspeed), y, par_paddle))	{
			x += sign(xspeed);
		}
		// Also account for the case where we might be stuck inside the paddle
		while (place_meeting(x, y, par_paddle))	{
			x -= sign(xspeed);
		}
		// Now rebound
		xspeed *= -1;
		xs = 2;
	}

	// Now deal with collisions with top/bottom of paddle
	if (!place_meeting(x, y + yspeed, par_paddle))	{
		y += yspeed;
	}
	else	{
		paddle_collision = true;
		// Move to contact point
		while (!place_meeting(x, y + sign(yspeed), par_paddle))	{
			y += sign(yspeed);
		}
		// Now rebound
		yspeed *= -1;
		rotation_dir *= -1;
		ys = 2;
	}

	// Contact with room_boundaries
	// Rebound left/right
	if (bbox_left < 0 or bbox_right > room_width)	{
		wall_collision = true;
		xspeed *= -1;
		x = clamp(x, sprite_width * 0.5, room_width - sprite_width * 0.5);
		xs = 2;

		var xx = x;
		with (obj_level_manager)	{
			if (xx < room_width * 0.5)
				hit_left();
			else
				hit_right();
		}
	}
	// Finally bounce against the floor
	if (bbox_bottom > room_height)	{
		wall_collision = true;
		// Move to contact point
		while (bbox_bottom > room_height)	{
			y -= 1;
		}
		yspeed *= -1;
		ys = 2;
	}
}

// Slime Volleyball style movement
if (check_property(BallProperties.PongVolleyball))	{
	var speedcap = 20;
	yspeed += grav;
	
	// Collide with top/bottom of paddle
	if (!place_meeting(x, y + yspeed, par_paddle))	{
		y += yspeed;
	}
	else if (place_meeting(x, y + yspeed, obj_net))	{
		yspeed *= -1;
	}
	else	{
		paddle_collision = true;
		ys = 2;
		// Pop the ball out if we're actually inside the paddle
		while (place_meeting(x, y, par_paddle))	{
			y--;
			// Avoid infinite loop
			yspeed = 10;
		}
		
		// Move to contact point with the paddle
		while (!place_meeting(x, y + sign(yspeed), par_paddle))	{
			y += sign(yspeed);
		}
		
		// Now get the offset from the paddle
		var _paddle = instance_place(x, y + sign(yspeed), par_paddle);
		var _xoffset = x - _paddle.x;
		var paddle_ys = _paddle.yspeed;
		
		// Deal with the xspeed
		var x_strength = 4;			// Modifier to determine how fiercly to eject the ball to the side
		xspeed += x_strength * maxspeed * _xoffset / sprite_get_height(spr_paddle);
		
		// Deal with the yspeed
		yspeed *= -1;
		// Add on any additional yspeed
		if (sign(yspeed) == sign(paddle_ys))	{
			var ys_multiplyer = 5;
			yspeed = paddle_ys * ys_multiplyer;
		}
	}
	
	// Collide with the side of the paddle - we will just rebound with a little bit of impulse
	if (!place_meeting(x + xspeed, y, par_paddle) and !place_meeting(x + xspeed, y, obj_net))	{
		x += xspeed;
	}
	else	{
		paddle_collision = true;
		xspeed *= -1;
		xs = 2;
	}
	
	// Contact with room_boundaries
	// Rebound left/right
	if (bbox_left < 0 or bbox_right > room_width)	{
		wall_collision = true;
		xspeed *= -1;
		x = clamp(x, sprite_width * 0.5, room_width - sprite_width * 0.5);
		xs = 2;
	}
	
	// Finally bounce against the floor
	if (bbox_bottom > room_height)	{
		wall_collision = true;
		// Move to contact point
		while (bbox_bottom > room_height)	{
			y -= 1;
		}
		yspeed *= -1;
		ys = 2;
		
		// Minimum yspeed
		if (yspeed > -10)	{
			yspeed = -10;
		}
		
		var xx = x;
		with (obj_level_manager)	{
			if (xx < room_width * 0.5)
				hit_left();
			else
				hit_right();
		}
	}
	
	// Clamp speeds
	xspeed = clamp(xspeed, -speedcap, speedcap);
	yspeed = clamp(yspeed, -speedcap, speedcap);
}

// Restore parameters
image_angle = angle;
image_xscale = xs;
image_yscale = ys;

// Lerp xscale and yscale towards 1
image_xscale = lerp(image_xscale, 1, 0.1);
image_yscale = lerp(image_yscale, 1, 0.1);

if (wall_collision or paddle_collision)	{
	// Sounds
	var snd_selection = snd_ballhit3;
	var pitch = 0.95 + random(0.1);
	audio_play_sound(snd_selection, 0, false, 1, 0, pitch);
	with (obj_camera)	{
		shake();
	}
	var xx = x;
	var yy = y;
	var ball_xspeed = xspeed;
	var ball_yspeed = yspeed;
	with (obj_particle_manager)	{
		// We can use the fact that xs and ys change to 2 to decide which direction to emit particles
		// Which is pretty fucking jank I admit but w/e man
		var dir = -1;
		if (xs == 2)	{
			dir = (sign(ball_xspeed) == 1) ? 0 : 180;
		}
		if (ys == 2)	{
			dir = (sign(ball_yspeed) == 1) ? 270 : 90;
		}
		if (dir != -1)	{
			create_particles(xx, yy, dir, pixel_part);
		}
	}
}

if (paddle_collision)	{
	if (check_property(BallProperties.Multiplyer))	{
		var ball_cap = 100;
		if (instance_number(obj_ball) < ball_cap)	{
			var _ball = instance_create_layer(x, y, layer, obj_ball);
			_ball.xspeed = xspeed;
			_ball.yspeed = -yspeed;
			_ball.yoffset = 0;
		}
	}
}

// Create the trail effect
var _vars = {
	image_xscale: xs,
	image_angle: angle,
	image_yscale: ys,
};
instance_create_layer(x, y, layer, obj_ball_trail, _vars);

// Accelerate during boss fight
if (check_property(BallProperties.Accelerate))	{
	maxspeed *= acceleration_strength;
}

// Be attracted to the magnet in the y-plane
if (check_property(BallProperties.Magnet))	{
	var max_strength = 1;
	var effect_dist = 128;
	var actual_dist = distance_to_point(obj_magnet.x, obj_magnet.y);
	if (actual_dist < effect_dist)	{
		// Magnet affects yspeed only
		var strength = easeOutExpo(1 - effect_dist / actual_dist) * max_strength;
		yspeed += strength * sign(y - obj_magnet.y);
		
		// Resolve into components to make sure angle does not exceed 45 degrees
		var angle = darctan2(yspeed, xspeed);
		if (angle == clamp(angle, 45, 135))	{
			if (angle < 90)
				angle = 45;
			else
				angle = 135;
		}
		if (angle == clamp(angle, 225, 335))	{
			if (angle < 270)
				angle = 225;
			else
				angle = 335;
		}
		
		// Now make sure we aren't exceeding max speed
		xspeed = maxspeed * dcos(angle);
		yspeed = -maxspeed * dsin(angle);
	}
}

// Player controls for the You're Ball level
if (check_property(BallProperties.YoureBall))	{
	var hinput = max(keyboard_check(Input.Right), keyboard_check(Input.AltRight)) - max(keyboard_check(Input.Left), keyboard_check(Input.AltLeft));
	var vinput = max(keyboard_check(Input.Down), keyboard_check(Input.AltDown)) - max(keyboard_check(Input.Up), keyboard_check(Input.AltUp));
	
	if (hinput != 0)
		xspeed = hinput * abs(xspeed);
	if (vinput != 0)
		yspeed = vinput * abs(yspeed);
}