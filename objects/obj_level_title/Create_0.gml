title = global.level_titles[? room];

angle = 0;
max_angle = 10;
rot_counter = 0;
rot_rate = 2;

scale = 1;

global.in_play = false;

yoffset = room_height * (0.5 + random(0.5));
lerp_strength = 0.1 - 0.05 + random(0.1);