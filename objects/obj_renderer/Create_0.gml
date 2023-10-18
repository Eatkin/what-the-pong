extend_bounds = 10; // How far do we extend the rectangle beyond room boundary

surf = surface_create(room_width + extend_bounds * 2, room_height + extend_bounds * 2);

// Colours
c[0] = [irandom(255), irandom(255), irandom(255)];
c[1] = [irandom(255), irandom(255), irandom(255)];
c[2] = [irandom(255), irandom(255), irandom(255)];
c[3] = [irandom(255), irandom(255), irandom(255)];
colours = [c[0], c[1], c[2], c[3]];
