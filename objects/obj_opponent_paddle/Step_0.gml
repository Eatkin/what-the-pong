event_inherited();

if (!global.in_play)	{
	exit;
}

// Move up and down where possible
if (check_property(EnemyProperties.VerticalMovement) or check_property(EnemyProperties.HorizontalMovement))	{
	// Same as player input but simulated by AI instead of keyboard
	var vinput = sign(y_pred - y);
	var hinput = sign(x_pred - x);
	
	if (!check_property(EnemyProperties.VerticalMovement))	{
		vinput = 0;
	}
	if (!check_property(EnemyProperties.HorizontalMovement))	{
		hinput = 0;
	}
	
	// If we're already close enough then stop moving
	var threshold = maxspeed * 0.5;
	if (abs(x_pred - x) < threshold)
		hinput = 0;
	var target_xs = hinput * maxspeed;
	if (target_xs != target_xspeed)
		x_accel_timer = 0;
	
	target_xspeed = target_xs
	
	x_accel_timer += x_accel_step;
	x_accel_timer = clamp(x_accel_timer, 0, 1);
	xspeed = target_xspeed * quint_out(x_accel_timer);
	
	if (abs(y_pred - y) < threshold)
		vinput = 0;
	var target_ys = vinput * maxspeed;
	// Check if target_ys has changed because if it has we need to change our easing timer
	if (target_ys != target_yspeed)
		y_accel_timer = 0;
		
	target_yspeed = target_ys;
	
	// Now we begin the easing towards our target speed
	y_accel_timer += y_accel_step;
	y_accel_timer = clamp(y_accel_timer, 0, 1);
	yspeed = target_yspeed * quint_out(y_accel_timer);
	
	// Move with collisions and whatever, account for room boundaries
	// No collision at the moment so just make sure we don't exceed room boundaries
	x += xspeed;
	if (bbox_left < 0 or bbox_right > room_width)
		x = clamp(x, sprite_width * 0.5, room_width - sprite_width * 0.5);
		
	if (abs(x_pred - x) < threshold)
		x = x_pred;
		xspeed = 0;
	
	y += yspeed;
	if (bbox_bottom > room_height or bbox_top < 0)
		y = clamp(y, sprite_height * 0.5, room_height - sprite_height * 0.5);

	// We need to check if we're close enough to y_pred
	if (abs(y_pred - y) < threshold and !check_property(EnemyProperties.Gravity))	{
		// We're close enough, stop moving
		y = y_pred;
		yspeed = 0;
	}

	// Start ticking down the lag_timer
	lag_timer -= 1;

	// Update position predictions if lag_timer is 0
	if (lag_timer == 0)	{
		// How long the AI will wait before updating the ball's position
		lag_timer = lag_timer_max;
		// Ball won't necessarily exist for certain levels
		if (instance_exists(obj_ball))	{
			// Increase fuzz
			if (!check_property(EnemyProperties.DontBecomeStupider))	{
				x_fuzz++;
				y_fuzz++;
			}
		
			// Find the nearest ball that is moving towards us otherwise just default to the nearest ball
			var _ball = instance_nearest(x, y, obj_ball);
			var _closest_dist = room_width;
			// We find a ball, if it's moving towards us we measure the distance, if it's the closest seen update _ball
			for (var i = 0; i < instance_number(obj_ball); i++)	{
				var _inst = instance_find(obj_ball, i);
				if (sign(_inst.xspeed) == sign(x - room_width * 0.5))	{
					var _dist = abs(x - _inst.x);
					if (_dist < _closest_dist)	{
						_closest_dist = _dist;
						_ball = _inst;
					}
				}
			}
			
			// Predictions will be different based on what sort of game we're playing
			if (check_property(EnemyProperties.Gravity))	{
				// Update prediction if ball is coming towards us
				if (_ball.xspeed < 0 and _ball.x < room_width * 0.75)	{
					x_pred = _ball.x + 2 * irandom(x_fuzz) - x_fuzz + _ball.xspeed * lag_timer_max * 0.5;
					// y_pred needs to account for the ball's gravity so we can get a better prediction of where it'll be
					// The prediction will still be a "dumb" prediction that doesn't account for the change of direction
					var _grav = _ball.grav;
					var _ball_ys = _ball.yspeed;
					// Ball yspeed after lag_timer_max * 0.5 steps is ys + grav + ys + grav * 2 + ... + ys + grav * lag_timer_max * 0.5
					// So lag_timer_max * 0.5 * ys + grav * sum of natural numbers from 1 to lag_timer_max * 0.5
					y_pred = _ball.y + lag_timer_max * 0.5 * _ball_ys + _grav * (power(lag_timer_max * 0.5, 2) + lag_timer_max * 0.5) * 0.5 + 2 * irandom(y_fuzz)  - y_fuzz;
				}
			}
			else	{
				x_pred = _ball.x + 2 * irandom(x_fuzz) - x_fuzz + _ball.xspeed * lag_timer_max * 0.5;
				y_pred = _ball.y + 2 * irandom(y_fuzz) - y_fuzz + _ball.yspeed * lag_timer_max * 0.5;
			
			}
			
			// Clamp y_pred to it doesn't exceed room boundaries
			y_pred = clamp(y_pred, sprite_height * 0.5, room_height - sprite_height * 0.5);
		}
	}
	
}

// Slime Volleyball level
if (check_property(EnemyProperties.PongVolleyball))	{
	lag_timer--;
	
	if (lag_timer == 0)	{
		lag_timer = lag_timer_max;
		x_pred = obj_ball.x + obj_ball.xspeed * lag_timer + irandom(x_fuzz) - x_fuzz * 0.5;
	}
	
	// Move towards x_pred
	var _hspeed = 10;
	var threshold = _hspeed * 2;
	if (abs(x - x_pred) < threshold)	{
		xspeed = 0;
	}
	else	{
		xspeed = _hspeed * sign(x_pred - x);
	}
	
	// Now deal with jumping if the ball is above us
	if (grounded and obj_ball.yspeed > 0 and abs(y - obj_ball.y) < 256 and obj_ball.x == clamp(obj_ball.x, bbox_left, bbox_right))	{
		var roll = irandom(15);
		if (roll == 0)	{
			grounded = false;
			yspeed = -jump_height;
		}
	}
	
	// Now deal with the movement itself
	x += xspeed;
	y += yspeed;
	if (!grounded)
		yspeed += grav;
	
	// Clamping
	while (bbox_left < 0)	{
		x++;
	}
	while (bbox_right > room_width * 0.5 - 8)	{
		x--;
	}
	while (bbox_bottom > room_height)	{
		y--;
		grounded = true;
	}
}

var stretch_strength = 0.02;	// Vertical scaling
var squash_strength = 0.01;		// Horizontal scaling
var dy = abs(y - yprevious);
// Squash / stretch
var _tys = y_scale * (1 + stretch_strength * dy);
image_yscale = lerp(image_yscale, _tys, 0.5);
var _tyx = x_scale * (1 - squash_strength * dy);
image_xscale = lerp(image_xscale, _tyx, 0.5);

if (check_property(EnemyProperties.HardToSee))	{
	image_alpha = 1 - abs(yspeed)/maxspeed;
}