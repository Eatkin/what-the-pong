if (!global.in_play)	{
	exit;
}

// Count down spawn timer
spawn_rate--;

if (spawn_rate <= 0)	{
	spawn_rate = spawn_rate_max;
	var _rows = array_length(spawn_pos);
	var yy = [-48, room_height + 48];
	// Create blocks
	for (var i = 0; i < _rows; i++)	{
		var _block = instance_create_layer(spawn_pos[i], yy[i % 2], layer, obj_breakout_block);
		// Set the appropriate y direction
		_block.yspeed *= spawn_dir[i];
	}
}