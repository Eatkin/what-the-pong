enum BallProperties {
	NormalMovement,
	Gravity,
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

switch (room)	{
	case rm_level1:
		apply_property(BallProperties.NormalMovement);
		break;
	case rm_level2:
		apply_property(BallProperties.Gravity);
		break;
}