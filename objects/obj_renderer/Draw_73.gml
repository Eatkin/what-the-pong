function render_obj(obj)	{
	for (var i = 0; i < instance_number(obj); i++)	{
		var inst = instance_find(obj, i);
		with (inst)	{
			image_blend = c_black;
			draw_self();
			image_blend = c_white;
		}
	}
}

// Draw a black rectangle which we'll cut shapes out of
if (!surface_exists(surf))
	surf = surface_create(room_width + extend_bounds * 2, room_height + extend_bounds * 2);
	
surface_set_target(surf);
draw_set_colour(c_black);
draw_rectangle(0, 0, room_width + extend_bounds * 2, room_height + extend_bounds * 2, false);

gpu_set_blendmode(bm_subtract);
var objs = [obj_ball, par_paddle];
array_foreach(objs, render_obj);
gpu_set_blendmode(bm_normal);

surface_reset_target();

draw_surface(surf, 0, 0);