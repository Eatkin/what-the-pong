event_inherited();

// Let's set up some enums
enum Input {
	Up = vk_up,
	Down = vk_down,
	Left = vk_left,
	Right = vk_right,
	AltUp = ord("W"),
	AltDown = ord("S"),
	AltLeft = ord("A"),
	AltRight = ord("D"),
	Action = vk_space
}

enum PlayerProperties {
	VerticalMovement,
	Shrinkray,
	ReverseControls,
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
	case rm_level6:
		apply_property(PlayerProperties.Shrinkray);
		apply_property(PlayerProperties.VerticalMovement);
		break;
	case rm_level8:
		apply_property(PlayerProperties.VerticalMovement);
		apply_property(PlayerProperties.ReverseControls);
		break;
	default:
		apply_property(PlayerProperties.VerticalMovement);
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

// Other shit
if (check_property(PlayerProperties.Shrinkray))	{
	image_yscale = room_height / sprite_height;
	y = room_height / 2;
}

target_yscale = image_yscale;