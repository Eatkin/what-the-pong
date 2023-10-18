// Advance colours
for (var i = 0; i < array_length(colours); i++)	{
	var col = colours[i];
	for (var j = 0; j < array_length(col); j++)	{
		var c = colours[i][j];
		c += 1;
		c %= 256;
		colours[i][j] = c;
	}
}