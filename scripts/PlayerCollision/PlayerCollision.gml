function PlayerCollision()
{
    var _collision = false;

    // 1. (tilemap_get_at_pixel(collisionMap, x + hSpeed, y)) checks if there is a tile at player position
    // 2. x -= x mod TILE_SIZE This moves x back to the nearest tile boundary (so the player doesn't get stuck inside a wall)
    // 3. if(sign(hSpeed) == 1) x += TILE_SIZE - 1 If the player is moving right (hSpeed is positive), they are pushed to the left edge of the next tile.
    
    // Sign returns the direction of a number. Whether number is positive, negative or zero

    // Horizontal Tiles
    if (tilemap_get_at_pixel(collisionMap, x + hSpeed, y)) 
    {   
        x -= x mod TILE_SIZE; // Snap to tile grid
        if (sign(hSpeed) == 1) x += TILE_SIZE - 1; // Adjust if moving right
        hSpeed = 0; // Stop horizontal movement
        _collision = true;
    }

    // Horizontal Move Commit
    x += hSpeed;

    // Vertical Tiles
    if (tilemap_get_at_pixel(collisionMap, x, y + vSpeed)) 
    {   
        y -= y mod TILE_SIZE; // Snap to tile grid
        if (sign(vSpeed) == 1) y += TILE_SIZE - 1; // Adjust if moving down
        vSpeed = 0; // Stop vertical movement
        _collision = true;
    }

    // Vertical Move Commit
    y += vSpeed;

    return _collision;
}
