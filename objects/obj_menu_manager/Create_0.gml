// We can construct level names since we know they go from 1 to 21
var lvl_first = 1;
var lvl_last = 21;

// Create all the buttons
// Co-ordinates
var items_per_column = 5;
var columns = 4;
var v_spacing = 20;
var h_spacing = 32;
var width = sprite_get_width(spr_menuButton) * 4 + 3 * h_spacing;
var top = room_height * 0.9 - 6 * sprite_get_height(spr_menuButton) - v_spacing * items_per_column;
var left = 0.5 * (room_width - width + sprite_get_width(spr_menuButton));
var delay_multiplyer = 2;

var final_level_locked = false;

// Loop through each level
for (var i = lvl_first; i < lvl_last; i++)	{
	level_index = asset_get_index("rm_level" + string(i));
	var i_div = (i - lvl_first) div items_per_column;
	var i_mod = (i - lvl_first) % items_per_column;
	
	// Determine if this level has been completed and lock the final level if any level isn't
	var comp_status = (global.completion_status >> i) & 1;
	if (!comp_status)
		final_level_locked = true;
		
	var vars = {
		delay: (i_div + i_mod) * delay_multiplyer,
		level_num: string(i),
		level_id: level_index,
		level_name: global.level_titles[? level_index],
		completion_status: comp_status,
		locked: false,
	};
	var xx = left + (h_spacing + sprite_get_width(spr_menuButton)) * i_div;
	var yy = top + (v_spacing + sprite_get_height(spr_menuButton)) * i_mod;
	
	
	instance_create_layer(xx, yy, layer, obj_menu_button, vars);
}

// Create the final button underneath everything else
var xx = room_width * 0.5;
var yy = top + (v_spacing + sprite_get_height(spr_menuButton)) * 5;
var lvl_title = final_level_locked ? "Locked" : global.level_titles[? rm_level21];
var vars = {
	delay: 9 * delay_multiplyer,
	level_num: "21",
	level_id: rm_level21,
	level_name: lvl_title,
	completion_status: (global.completion_status >> 21) & 1,
	locked: final_level_locked,
};
instance_create_layer(xx, yy, layer, obj_menu_button, vars);