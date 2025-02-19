// @desc NineSliceBoxStretched(sprite, x1,y1,x2,y2)
// arg sprite
// arg x1 left
// arg y1 top
// arg x2 right
// arg y2 bottom
// arg index image index

// 9 pieces. 4 corner, 4 edges and middle

/*This code takes a sprite, divides it into a grid (with 3 equal parts for each dimension), 
Then draws it in a specified rectangular area, 
preserving the corners and stretching the edges and middle part. 
Creates scalable UI components like buttons, panels, or borders where the corners don't get distorted when resized.*/
function NineSliceBoxStretched(sprite, x1, y1, x2, y2, index) {
    if (!sprite_exists(sprite)) {
        show_error("NineSliceBoxStretched: Sprite does not exist!", true);
        return;
    }

    var _size = sprite_get_width(sprite) / 3;
    var _w = x2 - x1;
    var _h = y2 - y1;

    // MIDDLE - Stretches middle to cover the box
    draw_sprite_part_ext(sprite, index, _size, _size, 1, 1, x1 + _size, y1 + _size, _w - (_size * 2), _h - (_size * 2), c_white, 1);

    // CORNERS - Draw 4 corners
    draw_sprite_part(sprite, index, 0, 0, _size, _size, x1, y1);                          // Top Left
    draw_sprite_part(sprite, index, _size * 2, 0, _size, _size, x1 + _w - _size, y1);     // Top Right
    draw_sprite_part(sprite, index, 0, _size * 2, _size, _size, x1, y1 + _h - _size);     // Bottom Left
    draw_sprite_part(sprite, index, _size * 2, _size * 2, _size, _size, x1 + _w - _size, y1 + _h - _size); // Bottom Right

    // EDGES - Draw 4 edges stretched
    draw_sprite_part_ext(sprite, index, 0, _size, _size, 1, x1, y1 + _size, 1, _h - (_size * 2), c_white, 1); // Left Edge
    draw_sprite_part_ext(sprite, index, _size * 2, _size, _size, 1, x1 + _w - _size, y1 + _size, 1, _h - (_size * 2), c_white, 1); // Right Edge
    draw_sprite_part_ext(sprite, index, _size, 0, 1, _size, x1 + _size, y1, _w - (_size * 2), 1, c_white, 1); // Top Edge
    draw_sprite_part_ext(sprite, index, _size, _size * 2, 1, _size, x1 + _size, y1 + _h - _size, _w - (_size * 2), 1, c_white, 1); // Bottom Edge
}
;