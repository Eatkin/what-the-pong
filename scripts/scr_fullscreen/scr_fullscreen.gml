function scr_fullscreen(baseWidth,baseHeight){
	//As this is web based ONLY we don't need to bother with desktop fullscreening
	var displayWidth = browser_width;
	var displayHeight = browser_height;
		
	var _hscale = 1;
	var _vscale = 1;
		
	_hscale = displayWidth / baseWidth;
	_vscale = displayHeight / baseHeight;
		
	var _scale = min(_hscale, _vscale);
		
	window_set_size(baseWidth * _scale, baseHeight * _scale);
}