yspeed = -random(4);
xspeed = -2 + random(4);
grav = 0.5;
alpha = 1;
alpha_decay = 1 / room_speed;
angle = -irandom(30) * sign(xspeed);
rot_speed = -random(1) * sign(xspeed);
scale = 2;
shrinkage = 0.05;