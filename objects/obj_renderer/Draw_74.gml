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

var mixed_colours;
for (var i = 0; i < array_length(colours); i++)	{
	mixed_colours[i] = make_colour_hsv(colours[i], 255, 255);
}

var x1 = -extend_bounds;
var x2 = extend_bounds + room_width;
var y1 = -extend_bounds;
var y2 = extend_bounds + room_height;

draw_rectangle_color(x1, y1, x2, y2, mixed_colours[0], mixed_colours[1], mixed_colours[2], mixed_colours[3], false)

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

var _cam = view_camera[0];
var view_ang = camera_get_view_angle(_cam);
var vw = camera_get_view_width(_cam);
var vh = camera_get_view_height(_cam);
var _scale = vw / room_width;

// Translate the surface
// What the fuck am I doing
var xoffset, yoffset, xx, yy, xtrans, ytrans;
// Coordinates
xx = 0.5 * (room_width - vw);
yy = 0.5 * (room_height - vh);
// Translate coordinates such that the surface is centred on (0, 0)
// (There is some redundancy here but who tf cares fight me)
xtrans = xx - room_width * 0.5;
ytrans = yy - room_height * 0.5;
// Translate coordinates
xoffset = xtrans * dcos(view_ang) + ytrans * dsin(view_ang);
yoffset = ytrans * dcos(view_ang) - xtrans * dsin(view_ang);
draw_surface_ext(surf, xx + xoffset + 0.5 * room_width, yy + yoffset + 0.5 * room_height, _scale, _scale, view_ang, c_white, 1);