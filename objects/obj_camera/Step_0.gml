if (shake_timer > 0)
	shake_timer--;
	
var proportion = shake_timer / shake_timer_max;
var ease = ease_out_circle(proportion);
var angle = random(ease * max_angle * 2) - max_angle * ease;
// Override because the level end object will move camera angle
if (!instance_exists(obj_level_end))	{
	camera_set_view_angle(cam, angle);
}