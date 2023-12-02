// Initialise music library
music_library = [_8_bit_air_fight_158813, _8_bit_game_158815, chiptune_grooving_142242, kim_lightyear_legends_109307];

// Shuffle
array_shuffle_ext(music_library);

// Select the music index to play
music_index = 0;

// This is flipped to false whenever we roll over to a new song so we don't skip songs in the array
music_started = false;

// Gap between songs
pause_max = room_speed;
pause = 0;