spawn_rate_max = 96;
spawn_rate = 0;

// Create arrays to determine spawn positions and directions
var _spacing = 36;
var _dir = 1;
var _rows = 5;
var _init_pos = room_width * 0.5 - (_rows div 2) * _spacing;

spawn_pos = [];
spawn_dir = [];

for (var i = 0; i < _rows; i++)	{
	spawn_pos[i] = _init_pos + _spacing * i;
	spawn_dir[i] = _dir;
	_dir *= -1;
}