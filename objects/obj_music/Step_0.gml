// Try to play the song
if (!music_started)	{
	// Only attempt to play after the gap between songs
	if (pause == 0)	{
		if (!audio_is_playing(music_library[music_index]))	{
			audio_play_sound(music_library[music_index], 0, false);
		}
		else	{
			music_started = true;
		}
	}
}
else	{
	if (!audio_is_playing(music_library[music_index]))	{
		music_started = false;
		music_index += 1;
		music_index %= array_length(music_library);
		pause = pause_max;
		
		// Specific instructions for if music index is 0
		// Reshuffle without repeat
		if (music_index == 0)	{
			// Get the previously played song
			var prev = music_library[array_length(music_library) - 1];
			do	{
				array_shuffle_ext(music_library);
			} until (music_library[0] != prev);
		}
	}
}

pause = max(0, pause - 1);