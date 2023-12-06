enum BallProperties {
	NormalMovement,
	Gravity,
	SpeedUp,
	Accelerate,
	Magnet,
	PongVolleyball,
	YoureBall,
	Max
}

function easeOutExpo(t) {
	return t == 1 ? 1 : 1 - power(2, -10 * t);
}

function apply_property(property)	{
	properties |= (1 << property)
}

function check_property(property)	{
	return (properties >> property & 1) == 1
}

// Physics
rotation_speed = 10;
rotation_dir = -1

maxspeed = 10;
xspeed = maxspeed;
yspeed = 0;
grav = 0.5;

acceleration_strength = 1;

properties = 0;

yoffset = room_height * (0.5 + random(0.5));
lerp_strength = 0.1 - 0.05 + random(0.1);

switch (room)	{
	case rm_level2:
		apply_property(BallProperties.NormalMovement);
		var _dir = 10 + irandom(10);
		_dir *= choose(1, -1)
		xspeed = -dcos(_dir) * maxspeed;
		yspeed = dsin(_dir) * maxspeed;
		break;
	case rm_level3:
		apply_property(BallProperties.Gravity);
		break;
	case rm_level5:
		apply_property(BallProperties.NormalMovement);
		apply_property(BallProperties.SpeedUp);
		break;
	case rm_level7:
		apply_property(BallProperties.NormalMovement);
		apply_property(BallProperties.Accelerate);
		acceleration_strength = 1.0002;
		break;
	case rm_level9:
		apply_property(BallProperties.NormalMovement);
		apply_property(BallProperties.Magnet);
		break;
	case rm_level11:
		apply_property(BallProperties.PongVolleyball);
		break;
	case rm_level13:
		apply_property(BallProperties.NormalMovement);
		apply_property(BallProperties.YoureBall);
		break;
	case rm_level14:
		apply_property(BallProperties.NormalMovement);
		apply_property(BallProperties.Accelerate);
		acceleration_strength = 1.0011;
		break;
	default:
		apply_property(BallProperties.NormalMovement);
		break;
}

if (room == rm_level6)	{
	xspeed *= -1;
}

if (room == rm_level11)	{
	xspeed = 0;
}

// Make sure we can't just not move on this level
if (room == rm_level14)	{
	yspeed = choose(1, -1);
}

scale = 1;