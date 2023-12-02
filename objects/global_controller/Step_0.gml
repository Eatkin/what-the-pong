/// @description Resolution changes

if (bWidth!=browser_width or bHeight!=browser_height)	{
	//Get the browser ratio
	bWidth = browser_width;
	bHeight = browser_height;
	var ratio = screenWidth / screenHeight;

	//sw/sh=bw/bh <=> sw=sh*bw/bh or sw=sh*ratio;
	//Make sure width doesn't get any smaller than 256 though
	screenWidth = max(960, screenHeight*ratio);
	screenWidth = floor(screenWidth);
	display_set_gui_size(screenWidth, screenHeight);

	surface_resize(application_surface, screenWidth, screenHeight);
}

scr_fullscreen(screenWidth, screenHeight);