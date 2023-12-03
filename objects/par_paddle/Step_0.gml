yoffset = lerp(yoffset, 0, lerp_strength);
var threshold = 2;
if (yoffset < threshold)	{
	yoffset = 0;
}