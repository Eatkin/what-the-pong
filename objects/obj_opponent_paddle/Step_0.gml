if (!global.in_play)	{
	exit;
}

// Move up and down where possible
if (check_property(EnemyProperties.VerticalMovement))	{
	// Same as player input but simulated by AI instead of keyboard
	// little outline: move towards target y_pred
	// Once we're there we stop moving and wait for a new target
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
	if (abs(y_pred - y) < threshold)	{
		// We're close enough, stop moving
		y = y_pred;
		yspeed = 0;
		// Start ticking down the lag_timer
		lag_timer -= 1;

		// Update position predictions if lag_timer is 0
		if (lag_timer == 0)	{
			x_pred = obj_ball.x + 2 * irandom(x_fuzz) - x_fuzz + obj_ball.xspeed * lag_timer_max * 0.5;
			y_pred = obj_ball.y + 2 * irandom(y_fuzz) - y_fuzz + obj_ball.yspeed * lag_timer_max * 0.5;
			// Clamp y_pred to it doesn't exceed room boundaries
			y_pred = clamp(y_pred, sprite_height * 0.5, room_height - sprite_height * 0.5);
			// How long the AI will wait before updating the ball's position
			lag_timer = lag_timer_max;
		}
	}
}