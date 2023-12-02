image_angle += rotation_speed * rotation_dir;

yoffset = lerp(yoffset, 0, 0.1);
var threshold = 1;
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
	if (!place_meeting(x + xspeed, y, par_paddle))	{
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
		if (paddle.object_index == obj_player_paddle.object_index)	{
			if (paddle.check_property(PlayerProperties.Shrinkray))	{
				// Halve paddle size, don't go below 1 pixels
				paddle.target_yscale = max(1/sprite_get_height(paddle.sprite_index), paddle.image_yscale * 0.5);
				// Make opponent a little bit worse every halving
				obj_opponent_paddle.lag_timer_max = round(obj_opponent_paddle.lag_timer_max * 1.1);
			}
		}
	}

	// Collisions with top/bottom of paddle (it's basically the same as above but simpler)
	if (!place_meeting(x, y + yspeed, par_paddle))	{
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
	// Probbably want some particles or something
}

// Create the trail effect
var _vars = {
	image_xscale: xs,
	image_angle: angle,
	image_yscale: ys,
};
instance_create_layer(x, y, layer, obj_ball_trail, _vars);

if (check_property(BallProperties.Accelerate))	{
	maxspeed *= 1.0001;
}