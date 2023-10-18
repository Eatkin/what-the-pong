// Insert resolution management here

// Global variables
global.in_play = false;

if (room == Room1)
	room_goto(rm_level1);
	
// Global data structures
global.level_titles = ds_map_create();
global.level_titles[? rm_level1] = "Score a point";
global.level_titles[? rm_level2] = "Squash court";
global.level_titles[? rm_level3] = "With gravitas";