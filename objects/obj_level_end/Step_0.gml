// Rotate and zoom the camera
// Fade in a rectangle

var _ease = easeInBack(timer);

var _angle_limit = (sign(_ease) == -1) ? 90 : 360;
var _angle = _angle_limit * _ease;
var _zoom = 1 - _ease;
// Default camera size
var _width = room_width;
var _height = room_height;

// Set the camera angle, position and zoom
camera_set_view_angle(cam, _angle);
camera_set_view_size(cam, _width / _zoom, _height / _zoom);
camera_set_view_pos(cam, 0.5 * _width * (1 - 1 / _zoom), 0.5 * _height * (1 - 1 / _zoom));

if (timer == 0)	{
	if (win)	{
		var snd = snd_win;
	}
	else	{
		var snd = snd_lose;
	}
	audio_play_sound(snd, 0, false);
}

timer += timer_step;

if (timer >= 1)	{
	timer = 1;
	alpha += timer_step;
	if (alpha >= 1)	{
		if (win)	{
			room_goto_next();
		}
		else	{
			room_restart();
		}
	}
}