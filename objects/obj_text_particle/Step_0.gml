x += xspeed;
y += yspeed;
yspeed += grav;
alpha -= alpha_decay;
angle += rot_speed;
scale -= shrinkage;

if (alpha <= 0)	{
	instance_destroy();
}