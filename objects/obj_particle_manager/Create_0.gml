function create_particles(xx, yy, dir, p_type)	{
	var emitter = part_emitter_create(system);
	var pos_jitter = 4;
	part_emitter_region(system, emitter, xx - pos_jitter, xx + pos_jitter, yy - pos_jitter, yy + pos_jitter, ps_shape_rectangle, ps_distr_linear);
	// Dir should be 0, 90, 180 or 270 as we will add variations ourselves
	// Pick a colour from the palette
	var min_particles = 5;
	var max_particles = 10;
	var num_particles = min_particles + irandom(max_particles - min_particles);
	
	// If we're on the with gravitas level we add gravity
	if (room == rm_level3)	{
		part_type_gravity(p_type, 1, -90);
	}
	repeat (num_particles)	{
		var _col = palette[irandom(array_length(palette) - 1)];
		part_type_color1(p_type, _col);
		// Set up particle parameters
		var _dir = dir - 45 + irandom(90);
		var _orientation = sign(_dir - dir);
		part_type_orientation(p_type, -10, 10, _orientation, 0, true);
		part_type_direction(p_type, _dir, _dir, 0, 0);
		// Emit a particle
		part_emitter_burst(system, emitter, p_type, 1);
	}
	
	// Reset gravity5
	if (room == rm_level3)	{
		part_type_gravity(p_type, 0, -90);
	}
	
	part_emitter_destroy(system, emitter);
}

// Define particle system
system = part_system_create();
part_system_automatic_draw(system, false);

// Define any particle types
pixel_part = part_type_create();
part_type_shape(pixel_part, pt_shape_square);
part_type_size(pixel_part, 0.01, 0.15, 0, 0);
part_type_speed(pixel_part, 1, 3, 0, 0);
part_type_life(pixel_part, room_speed * 0.2, room_speed * 0.3);
part_type_alpha3(pixel_part, 0.5, 0.75, 0.9);
palette = [];
palette[0] = $390099;
palette[1] = $9e0059;
palette[2] = $ff0054;
palette[3] = $ff5400;
palette[4] = $ffbd00;