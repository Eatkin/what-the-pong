function create_particles(xx, yy, dir, p_type)	{
	var emitter = part_emitter_create(system);
	part_emitter_region(system, emitter, xx, xx, yy, yy, ps_shape_rectangle, ps_distr_linear);
	// Dir should be 0, 90, 180 or 270 as we will add variations ourselves
	// Pick a colour from the palette
	var _col = palette[irandom(array_length(palette)) - 1];
	part_type_color1(p_type, _col);
	var min_particles = 5;
	var max_particles = 10;
	var num_particles = min_particles + irandom(max_particles - min_particles);
	repeat (num_particles)	{
		// Set up particle parameters
		var _dir = dir - 30 + irandom(60);
		var _orientation = sign(_dir - dir);
		part_type_orientation(p_type, -10, 10, _orientation, 0, true);
		part_type_direction(p_type, _dir, _dir, 0, 0);
		// Emit a particle
		part_emitter_burst(system, emitter, p_type, 1);
	}
	
	part_emitter_destroy(system, emitter);
}

// Define particle system
system = part_system_create();
part_system_automatic_draw(system, false);

// Define any particle types
pixel_part = part_type_create();
part_type_shape(pixel_part, pt_shape_square);
part_type_size(pixel_part, 1, 4, 0, 0);
part_type_speed(pixel_part, 1, 3, 0, 0);
part_type_gravity(pixel_part, 0.5, -90);
part_type_life(pixel_part, room_speed, room_speed * 2);
palette = [];
palette[0] = $390099;
palette[1] = $9e0059;
palette[2] = $ff0054;
palette[3] = $ff5400;
palette[4] = $ffbd00;