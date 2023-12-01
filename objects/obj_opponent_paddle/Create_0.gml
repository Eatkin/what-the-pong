event_inherited();

enum EnemyProperties {
	VerticalMovement,
	Gravity,
	Max
}

function apply_property(property)	{
	properties |= (1 << property)
}

function check_property(property)	{
	return (properties >> property & 1) == 1
}

function quint_out(t)	{
	return 1 - power(1 - t, 5);
}

properties = 0;

// Set the properties based on the roomm
switch (room)	{
	case rm_level3:
		apply_property(EnemyProperties.Gravity);
		apply_property(EnemyProperties.VerticalMovement);
		break;
	default:
		apply_property(EnemyProperties.VerticalMovement);
		break;
}

// Physics stuff
xspeed = 0;
yspeed = 0;
target_xspeed = 0;
target_yspeed = 0;

maxspeed = 10;
y_accel_timer = 0;
y_accel_step = 0.04;

// AI stuff
y_fuzz = 32;		// The AI's ability to detect the ball's y position
x_fuzz = 32;		// The AI's ability to detect the ball's x position
// Where the AI thinks the ball is
x_pred = obj_ball.x + 2 * irandom(x_fuzz) - x_fuzz;
y_pred = obj_ball.y + 2 * irandom(y_fuzz) - y_fuzz;
// How long the AI will wait before updating the ball's position
lag_timer_max = 0.25 * room_speed;
lag_timer = lag_timer_max;

// Opponent needs to be much smarter for with gravitas
if (room == rm_level3)	{
	lag_timer_max = 5;
	lag_timer = lag_timer_max;
}

// Make opponent stupider for speedball because it's way too hard
if (room == rm_level5)	{
	lag_timer_max = 0.8 * room_speed;
}