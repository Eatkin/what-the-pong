// Add some angle based screen shake

function ease_out_circle(t)	{
	return 1 - sqrt(1 - power(t, 2));
}

// Just so other objeccts can call this
function shake()	{
	shake_timer = shake_timer_max;
}

shake_timer_max = room_speed * 0.25;
shake_timer = 0;
max_angle = 2;

// Enable the camera
view_camera[0] = camera_create_view(0, 0, room_width, room_height);
cam = view_camera[0];
view_visible[0] = true;
view_enabled = true;