if (!global.in_play)	{
	exit;
}

// Move up and down where possible
if (check_property(EnemyProperties.VerticalMovement))	{
	// Same as player input but simulated by AI instead of keyboard
	var vinput = sign(y_pred - y);
	
	// If we're already close enough then stop moving
	var threshold = maxspeed * 0.5;
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
		// Increase fuzz
		x_fuzz++;
		y_fuzz++;
		
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
		// How long the AI will wait before updating the ball's position
		lag_timer = lag_timer_max;
	}
	
}

var stretch_strength = 0.02;	// Vertical scaling
var squash_strength = 0.01;		// Horizontal scaling
var dy = abs(y - yprevious);
// Squash / stretch
var _tys = 1 + stretch_strength * dy;
image_yscale = lerp(image_yscale, _tys, 0.5);
var _tyx = 1 - squash_strength * dy;
image_xscale = lerp(image_xscale, _tyx, 0.5);