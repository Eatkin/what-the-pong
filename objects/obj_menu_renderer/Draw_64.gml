draw_sprite_tiled(spr_ink_background, 0, offset, offset);

if (!surface_exists(surf))	{
	surf = surface_create(room_width, room_height);
}

surface_set_target(surf);
draw_set_colour(c_black);
draw_rectangle(0, 0, room_width, room_height, false);
gpu_set_blendmode(bm_subtract);

// Cut out all the buttons
var num_buttons = instance_number(obj_menu_button);
for (var i = 0; i < num_buttons; i++)	{
	var _inst = instance_find(obj_menu_button, i);
	with (_inst)
		draw_sprite_ext(sprite_index, image_index, x, y, zoom, zoom, angle, c_white, 1);
}

// Also draw any menu transitions if they exist
if (instance_exists(obj_menu_transition))	{
	with (obj_menu_transition)
		draw_sprite_ext(sprite_index, image_index, x, y, zoom, zoom, 0, c_white, 1);
}

gpu_set_blendmode(bm_normal);

// Now we draw the button text over the top
// Can't do it in one pass because it'll involve constantly resetting the bm which is slow af
draw_set_halign(fa_middle);
draw_set_valign(fa_center);
draw_set_font(fnt_press_start);
draw_set_colour(c_white);
for (var i = 0; i < num_buttons; i++)	{
	var _inst = instance_find(obj_menu_button, i);
	with (_inst)
		draw_text_transformed(x, y, level_num, zoom, zoom, angle);
}
scr_reset_text_alignment();

surface_reset_target();

draw_surface(surf, 0, 0);