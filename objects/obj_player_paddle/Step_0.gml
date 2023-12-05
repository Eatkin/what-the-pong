event_inherited();

if (!global.in_play)	{
	exit;
}

// Move up and down where possible
if (check_property(PlayerProperties.VerticalMovement))	{
	var vinput = max(keyboard_check(Input.Down), keyboard_check(Input.AltDown)) - max(keyboard_check(Input.Up), keyboard_check(Input.AltUp));
	if (check_property(PlayerProperties.ReverseControls))	{
		vinput *= -1;
	}
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
}
	
// This is the slime volleyball level physics
if (check_property(PlayerProperties.PongVolleyball))	{
	var hinput = max(keyboard_check(Input.Right), keyboard_check(Input.AltRight)) - max(keyboard_check(Input.Left), keyboard_check(Input.AltLeft));
	var jump = max(keyboard_check(Input.Up), keyboard_check(Input.AltUp));
	
	// Manage movement left right and jumping
	if (jump and grounded)	{
		yspeed = -jump_height;
		grounded = false;
	}
	
	var _hspeed = 10;
	x += hinput * _hspeed;
	
	// Clamp x
	while (bbox_right > room_width)	{
		x--;
	}
	while (bbox_left < room_width * 0.5 + 8)	{
		x++;
	}
	
	// Move y-position
	y += yspeed;
	// Make sure we don't fall off the level
	while (bbox_bottom > room_height)	{
		grounded = true;
		yspeed = 0;
		y--;
	}
	
	if (!grounded)	{
		yspeed += grav;
	}
}

var stretch_strength = 0.02;	// Vertical scaling
var squash_strength = 0.01;		// Horizontal scaling
var dy = abs(y - yprevious);
if (check_property(PlayerProperties.Shrinkray))	{
	// Deal with stretching from movement
	var _tys = target_yscale;
	_tys += stretch_strength * dy;
	image_yscale = lerp(image_yscale, _tys, 0.5);
	var _tyx = 1 - squash_strength * dy;
	image_xscale = lerp(image_xscale, _tyx, 0.5);
}
else	{
	// If we're not on the shrinkray level we set target yscale
	var _tys = 1 + stretch_strength * dy;
	image_yscale = lerp(image_yscale, _tys, 0.5);
	var _tyx = 1 - squash_strength * dy;
	image_xscale = lerp(image_xscale, _tyx, 0.5);
}