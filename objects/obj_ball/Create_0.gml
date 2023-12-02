enum BallProperties {
	NormalMovement,
	Gravity,
	SpeedUp,
	Accelerate,
	Max
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

properties = 0;

yoffset = room_height * (0.5 + random(0.5));

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
	default:
		apply_property(BallProperties.NormalMovement);
		break;
}

if (room == rm_level6)	{
	xspeed *= -1;
}

scale = 1;