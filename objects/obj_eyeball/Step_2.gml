if (!instance_exists(owner) or !instance_exists(obj_ball))	{
	instance_destroy();
	instance_destroy(pupil);
	exit;
}

// Attach to the paddle
var attachment_point = (owner.x < room_width * 0.5) ? owner.bbox_right - 10 : owner.bbox_left + 10;

x = attachment_point;
y = owner.y - 2 - owner.yoffset;

// Attach pupil to the correct point
var dir = point_direction(x, y, obj_ball.x, obj_ball.y);
pupil.x = x + sprite_width * 0.4 * dcos(dir);
pupil.y = y - sprite_height * 0.4 * dsin(dir);