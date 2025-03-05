/// Get New Tilemap
// This gets us the most recent tilemap from the room we've just entered
// If you put it in the create event you will get the tilemap from the first room only
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));