randomise();

hide_scrollbar_init();

// Insert resolution management here
screenWidth = 960
screenHeight = 540;

// Global variables
global.in_play = false;

if (room == Room1)
	room_goto(rm_level1);
	
// Global data structures
global.level_titles = ds_map_create();
global.level_titles[? rm_level1] = "Score a point";
global.level_titles[? rm_level2] = "Squash court";
global.level_titles[? rm_level3] = "With gravitas";
global.level_titles[? rm_level4] = "A pair";
global.level_titles[? rm_level5] = "Speedball";
global.level_titles[? rm_level6] = "Shrinkray";
global.level_titles[? rm_level7] = "Boss Fight";
global.level_titles[? rm_level8] = "gnoP";
global.level_titles[? rm_level9] = "Befuddler";
global.level_titles[? rm_level10] = "Ponkanoid";
global.level_titles[? rm_level11] = "Pong Volleyball";
global.level_titles[? rm_level12] = "Autopong";
global.level_titles[? rm_level13] = "You're Ball";
global.level_titles[? rm_level14] = "No Intelligence";
global.level_titles[? rm_level15] = "Antiparticle";
global.level_titles[? rm_level16] = "Hard to See";