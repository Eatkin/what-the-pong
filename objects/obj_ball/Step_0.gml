image_angle += rotation_speed * rotation_dir;

// Movement with collision with paddles and also the room boundaries
// First check the collision with the paddles because it's a bit more involved
if (!place_meeting(x + xspeed, y, par_paddle))	{
	x += xspeed;
}
else	{
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
	var offset_strength = 20;		
	var movement_strength = 30;
	var rebound_angle = (1 + sign(xspeed)) * 90 + offset_strength * offset + movement_strength * paddle_ys;
	// Calculate our new speed components
	// Note to future Ed: cos(0) is NOT equal to cos(180)
	xspeed = -sign(xspeed) * maxspeed * abs(dcos(rebound_angle));
	yspeed = -dsin(rebound_angle) * maxspeed;
}

// Collisions with top/bottom of paddle (it's basically the same as above but simpler)
if (!place_meeting(x, y + yspeed, par_paddle))	{
	y += yspeed;
}
if (place_meeting(x, y + yspeed, par_paddle))	{
	// Move to contact point	
	while (!place_meeting(x, y + sign(yspeed), par_paddle))	{
		y += sign(yspeed);
	}
	// We will not get stuck inside since that is accounted for in the x-movement
	// Simple physics - just rebound against the paddle
	yspeed *= -1;
}

// Contact with room_boundaries
// Rebound left/right
if (bbox_left < 0 or bbox_right > room_width)	{
	xspeed *= -1;
	x = clamp(x, sprite_width * 0.5, room_width - sprite_width * 0.5);
}
// Rebound top/bottom
if (bbox_top < 0 or bbox_bottom > room_height)	{
	yspeed *= -1;
	rotation_dir *= -1;
	y = clamp(y, sprite_height * 0.5, room_height - sprite_height * 0.5);
}