// We can construct level names since we know they go from 1 to 21
var lvl_first = 1;
var lvl_last = 21;

// Create all the buttons
// Co-ordinates
var items_per_column = 5;
var columns = 4;
var v_spacing = 16;
var h_spacing = 32;
var width = sprite_get_width(spr_menuButton) * 4 + 3 * h_spacing;
var top = room_height * 0.9 - 6 * sprite_get_height(spr_menuButton) - v_spacing * items_per_column;
var left = 0.5 * (room_width - width + sprite_get_width(spr_menuButton));

// Loop through each level
for (var i = lvl_first; i < lvl_last; i++)	{
	level_index = asset_get_index("rm_level" + string(i));
	var vars = {
		level_num: string(i),
		level_id: level_index,
		level_name: global.level_titles[? level_index],
	};
	var xx = left + (h_spacing + sprite_get_width(spr_menuButton)) * ((i - lvl_first) div items_per_column);
	var yy = top + (v_spacing + sprite_get_height(spr_menuButton)) * ((i - lvl_first) % items_per_column);
	
	
	instance_create_layer(xx, yy, layer, obj_menu_button, vars);
}

// Create the final button underneath everything else
var xx = room_width * 0.5;
var yy = top + (v_spacing + sprite_get_height(spr_menuButton)) * 5;
var vars = {
	level_num: "21",
	level_id: rm_level21,
	level_name: global.level_titles[? rm_level21],
};
instance_create_layer(xx, yy, layer, obj_menu_button, vars);