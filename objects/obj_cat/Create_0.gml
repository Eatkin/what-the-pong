function set_timers()	{
	timer[0] = room_speed * (1 + irandom(2));
	timer[1] = irandom(room_speed);
}

timer = [0, 0];
set_timers();

image_angle = point_direction(x, y, obj_ball.x, obj_ball.y);

launch_speed = 20;